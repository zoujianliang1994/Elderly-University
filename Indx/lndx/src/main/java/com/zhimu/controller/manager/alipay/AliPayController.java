package com.zhimu.controller.manager.alipay;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.PropertyUtils;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.service.manager.edu.alipay.AlipayConfigUtil;
import com.zhimu.service.manager.edu.alipay.AlipayNotify;
import com.zhimu.service.manager.edu.alipay.AlipaySubmit;
import com.zhimu.service.manager.edu.school.SchoolAptitudeService;
import com.zhimu.service.manager.edu.student.EnrollService;
import com.zhimu.service.manager.redis.RedisCacheUtil;

@Controller
@RequestMapping(value = "/alipay")
public class AliPayController extends BaseController {
	@Resource(name = "redisCacheUtil")
	private RedisCacheUtil redisCacheUtil;
	@Resource(name = "enrollService")
	private EnrollService enrollService;
	@Resource(name = "schoolAptitudeService")
	private SchoolAptitudeService schoolAptitudeService;

	/**
	 * 获取订单状态
	 */

	@RequestMapping(value = "/getOrderStatus")
	@ResponseBody
	public Object getOrderStatus() {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = this.getPageData();
		String result = redisCacheUtil.getCacheObject(pd.getString("orderNo")).toString();
		System.out.println(result + "==============");
		// String cacheObject =
		// redisCacheUtil.getCacheObject(pd.getString("orderNo")).toString();
		// if (null != cacheObject) {
		// result = cacheObject.toString();
		// }
		map.put("msg", redisCacheUtil.getCacheObject(pd.getString("orderNo")).toString());
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * @Description: pc支付宝支付
	 * @author wy
	 */
	@RequestMapping("/alipayInitPay")
	public void alipayInitPay(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		try {
			// 获取订单号
			String orderNo = request.getParameter("orderNo");
			// 通过订单号获取订单金额
			// String orderAmount =
			// redisCacheUtil.getCacheObject(orderNo).toString();
			String orderAmount = "0.01";
			PageData pd = new PageData();
			pd.put("userSchoolIds", request.getParameter("s_id").split(","));
			String partner = "";
			String seller_id = "";
			String md5Key = "";
			try {
				List<PageData> pda = schoolAptitudeService.findBySid(pd);
				partner = pda.get(0).getString("partner");
				seller_id = pda.get(0).getString("seller_id");
				md5Key = pda.get(0).getString("md5_key");
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 订单商品名称
			String productName = "报名费";
			// 把请求参数打包成数组
			Map<String, String> sParaTemp = new HashMap<>();
			sParaTemp.put("service", PropertyUtils.getValue("ALIPAY_SERVER"));
			sParaTemp.put("partner", partner);
			sParaTemp.put("seller_id", seller_id);
			sParaTemp.put("_input_charset", PropertyUtils.getValue("ALIPAY_INPUT_CHARSET"));
			sParaTemp.put("payment_type", PropertyUtils.getValue("ALIPAY_PAYMENT_TYPE"));
			sParaTemp.put("notify_url", PropertyUtils.getValue("ALIPAY_NOTIFY_URL"));
			sParaTemp.put("return_url", PropertyUtils.getValue("ALIPAY_RETURN_URL"));
			sParaTemp.put("anti_phishing_key", AlipayConfigUtil.anti_phishing_key);
			sParaTemp.put("exter_invoke_ip", AlipayConfigUtil.exter_invoke_ip);
			sParaTemp.put("out_trade_no", orderNo);
			sParaTemp.put("subject", productName);
			sParaTemp.put("total_fee", orderAmount);
			// sParaTemp.put("body", body);
			sParaTemp.put("qr_pay_mode", "2");
			// 建立支付请求
			String form = AlipaySubmit.buildRequest(sParaTemp, "get", "确认", md5Key);
			response.setContentType("text/html;charset=" + PropertyUtils.getValue("ALIPAY_INPUT_CHARSET"));
			// 直接将完整的表单html输出到页面
			response.getWriter().write(form);
			response.getWriter().flush();
			response.getWriter().close();
		} catch (IOException e) {
			logger.error(ErrorUtils.getErrorMessage(e, "生成订单失败(AliPay)：" + e.getMessage()));
			e.printStackTrace();
		}
	}

	/**
	 * pc支付宝同步通知
	 * 
	 * @param payWayCode
	 * @param httpServletRequest
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/result/{payWayCode}")
	public void result(@PathVariable("payWayCode") String payWayCode, HttpServletRequest httpServletRequest, Model model) throws Exception {
		ModelAndView mv = new ModelAndView();
		Map<String, String> resultMap = new HashMap<String, String>();
		Map requestParams = httpServletRequest.getParameterMap();
		String msg = "操作成功";
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
			}
			// 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
			// 支付宝账号
			valueStr = new String(valueStr);
			resultMap.put(name, valueStr);
		}
		if (AlipayNotify.verify(resultMap)) {
			String out_trade_no = resultMap.get("out_trade_no");
			redisCacheUtil.setCacheObject(resultMap.get("out_trade_no"), "1");
			// 暂时回写数据开始
			PageData pd = new PageData();
			pd.put("orderNo", resultMap.get("out_trade_no"));
			pd.put("money_status", "1");
			pd.put("tradeNo", resultMap.get("trade_no"));
			try {
				enrollService.editMoneyStatus(pd);
			} catch (Exception e) {
				logger.error(ErrorUtils.getErrorMessage(e, "订单号：" + resultMap.get("out_trade_no") + " 回写数据状态异常!"));
				e.printStackTrace();
			}
			// 暂时回写数据结束

			logger.debug("支付宝签名成功返回结果：" + resultMap);
		} else {
			redisCacheUtil.setCacheObject(resultMap.get("out_trade_no"), "2");
			logger.debug("支付宝签名失败返回结果：" + resultMap);
			msg = "支付宝签名失败,订单号：" + resultMap.get("out_trade_no");
		}
		mv.addObject("msg", msg);
		mv.setViewName("edu/student/alipay_result");
		// 页面成功提示
		//return mv;
	}

	/**
	 * pc支付宝支付异步通知
	 * 
	 * @param payWayCode
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @throws Exception
	 */
	@RequestMapping("/notify/{payWayCode}")
	public void notify(@PathVariable("payWayCode") String payWayCode, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
		Map<String, String[]> requestParams = httpServletRequest.getParameterMap();
		Map<String, String> notifyMap = this.parseNotifyMsg(requestParams);
		// 1、签名
		if (AlipayNotify.verify(notifyMap)) {
			// 异步通知业务操作,通过订单号修改业务数据
			PageData pd = new PageData();
			String outTradeNo = notifyMap.get("out_trade_no");
			pd.put("orderNo", outTradeNo);
			pd.put("money_status", "1");
			pd.put("tradeNo", notifyMap.get("trade_no"));
			try {
				enrollService.editMoneyStatus(pd);
			} catch (Exception e) {
				logger.error(ErrorUtils.getErrorMessage(e, "订单号：" + notifyMap.get("out_trade_no") + " 回写数据状态异常!"));
				e.printStackTrace();
			}
		} else {
			logger.debug("签名失败返回结果：" + notifyMap);
		}
	}

	/**
	 * @Description: 支付宝退款
	 * @author lc
	 * @param orderNo
	 *            订单号
	 * @param refundAmount
	 *            退款金额
	 * @param refundReason
	 *            退款原因
	 * @return
	 */
	@RequestMapping("/alipayTradeRefund")
	public void alipayTradeRefund() {
		try {
			PageData pd = this.getPageData();
			PageData stuGrades = this.enrollService.findById(pd);
			String refundAmount = stuGrades.getString("money");
			String timestamp = String.valueOf(System.currentTimeMillis());
			// 把请求参数打包成数组
			Map<String, String> sParaTemp = new HashMap<String, String>();
			sParaTemp.put("service", PropertyUtils.getValue("ALIPAY_REFUND_SERVER"));
			// sParaTemp.put("out_trade_no", orderNo);
			sParaTemp.put("partner", AlipayConfigUtil.partner);
			sParaTemp.put("_input_charset", PropertyUtils.getValue("ALIPAY_INPUT_CHARSET"));
			sParaTemp.put("notify_url", PropertyUtils.getValue("ALIPAY_REFUND_NOTIFY_URL"));// 异步通知地址
			// sParaTemp.put("dback_notify_url",
			// AlipayConfigUtil.dback_notify_url);// 充值通知地址
			sParaTemp.put("refund_date", timestamp);// 退款请求时间
			sParaTemp.put("refund_reason", "协商退款");// 退款原因
			// sParaTemp.put("trade_no", trade_no);
			// 退款批次号：回调的时候根据此字段修改退款申请的状态
			sParaTemp.put("batch_no", DateUtil.Getnum());
			sParaTemp.put("batch_num", "1");// 退款总笔数
			// 支付宝交易号 ^金额 ^协商退款
			String detail_data = stuGrades.getString("tradeNo") + "^" + refundAmount + "^" + "协商退款";
			sParaTemp.put("detail_data", detail_data);// 单笔数据集
			// 建立请求
			// String sHtmlText = AlipaySubmit.buildRequest("", "", sParaTemp);
			// System.out.println(sHtmlText);
		} catch (Exception e) {
			logger.error("alipayTradeRefund：支付宝退款异常！" + e.getMessage());
			e.printStackTrace();
		}
	}

	/**
	 * pc支付宝退款异步通知
	 * 
	 * @param payWayCode
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @throws Exception
	 */
	@RequestMapping("/refundNotify/{payWayCode}")
	public void refundNotify(@PathVariable("payWayCode") String payWayCode, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
		Map<String, String> notifyMap = new HashMap<String, String>();
		Map<String, String[]> requestParams = httpServletRequest.getParameterMap();
		notifyMap = this.parseNotifyMsg(requestParams);
		String str = "fail";
		// 签名
		if (AlipayNotify.verify(notifyMap)) {
			logger.debug("支付宝签名成功返回结果：" + notifyMap);
			// 异步通知业务操作,更新学员班级信息

			// 回馈信息
			str = "success";
		} else {
			logger.debug("签名失败返回结果：" + notifyMap);
		}
		httpServletResponse.getWriter().print(str);
	}

	/**
	 * @Description: 解析支付宝发来的请求
	 * @author wy
	 * @param requestParams
	 * @param
	 */
	public static Map<String, String> parseNotifyMsg(Map<String, String[]> requestParams) {
		Map<String, String> params = new HashMap<String, String>();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
			}
			params.put(name, valueStr);
		}
		return params;
	}
}
