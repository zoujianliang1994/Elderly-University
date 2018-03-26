package com.zhimu.controller.manager.edu.student;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aliyuncs.exceptions.ClientException;
import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.PropertyUtils;
import com.zhimu.commons.utils.SmsUtil;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.User;
import com.zhimu.service.manager.edu.student.RegisterService;
import com.zhimu.service.manager.redis.RedisCacheUtil;
import com.zhimu.service.manager.system.user.impl.UserService;

/**
 * 说明：学员网上注册
 */
@Controller
@RequestMapping(value = "/studentRegister")
public class RegisterController extends BaseController {

	@Resource(name = "registerService")
	private RegisterService registerService;
	@Resource(name = "userService")
	private UserService userService;
	@Resource(name = "redisCacheUtil")
	private RedisCacheUtil redisCacheUtil;

	/**
	 * 学员注册列表
	 * 
	 * @param page
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList = new ArrayList<PageData>();
		try {
			varList = registerService.list(page);
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "学员注册列表信息异常!"));
			e.printStackTrace();
		} // 列表
		mv.setViewName("edu/student/student_list");
		mv.addObject("varList", varList);
		return mv;
	}

	/**
	 * 去注册页面
	 * 
	 * @param
	 */
	@RequestMapping(value = "/goRegister")
	public ModelAndView goRegister() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		mv.setViewName("edu/student/student_register_edit");
		return mv;
	}

	/**
	 * 保存学员注册信息
	 * 
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Object save() {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "success";
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("id", this.get32UUID()); // 主键
		pd.put("create_date", DateUtil.getDay());
		User userInfo = getUserInfo();
		if (null != userInfo) {
			pd.put("create_id", userInfo.getUSER_ID());
		} else {
			pd.put("create_id", "");
		}
		pd.put("xm", pd.getString("phone"));
		pd.put("checkin_date", DateUtil.getDay());
		pd.put("checkin_type", "1");
		try {
			String code = redisCacheUtil.getCacheObject(pd.getString("timestamp")).toString();
			Long s = (System.currentTimeMillis() - Long.valueOf(pd.getString("timestamp")).longValue()) / (1000 * 60);
			// 获取缓存验证码比对
			if (!pd.getString("code").equals(code)) {
				// 验证码不对
				msg = "codeError";
			} else if (s > 5) {
				// 验证码超过5分钟
				msg = "codeTimeOut";
			} else {
				registerService.save(pd);
			}
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "学员注册异常!"));
			e.printStackTrace();
		}
		map.put("msg", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 发送注册手机短信
	 * 
	 * @param
	 */
	@RequestMapping(value = "/sendSms")
	@ResponseBody
	public Object sendSms() {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "success";
		PageData pd = new PageData();
		pd = this.getPageData();
		String timestamp = String.valueOf(System.currentTimeMillis());
		try {
			int code = SmsUtil.sendSmsInfo(pd.getString("mobile"), PropertyUtils.getValue("SMS_TEMPLATE_01"), new HashMap<String, String>());
			if (code != 0) {
				// 将手机短信码放入缓存
				redisCacheUtil.setCacheObject(timestamp, code);
			}
		} catch (ClientException e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "发送注册短信异常!"));
		}
		map.put("timestamp", timestamp);
		map.put("msg", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
