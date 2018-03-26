package com.zhimu.controller.manager.edu.agreement;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.service.manager.edu.agreement.AgreeMentService;

@Controller
@RequestMapping(value = "/agreement")
public class AgreeMentController extends BaseController {

	@Resource(name = "agreeMentService")
	private AgreeMentService agreeMentService;

	/**
	 * 保存系别
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	@ResponseBody
	public Object save() {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = getPageData();
		String msg = "success";
		try {
			pd.put("id", this.get32UUID());
			// 执行保存
			agreeMentService.addData(pd);
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "保存协议信息异常!"));
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 去修改协议页面
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEditU() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			// 获取当前登录人的学校信息
			pd.put("schoolIds", getUserInfo().getSchoolId().split(","));
			pd = agreeMentService.findDataBySid(pd);
			if (null == pd) {
				pd = new PageData();
			}
			pd.put("editor_id", getUserInfo().getUSER_ID());
			pd.put("edit_date", DateUtil.getDay());
			mv.addObject("msg", StringUtils.isEmpty(pd.getString("id")) ? "save" : "edit");
			mv.addObject("pd", pd);
			mv.setViewName("edu/agreement/agreement_edit");
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "去修改协议页面异常!"));
		}
		return mv;
	}

	/**
	 * 修改协议
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	@ResponseBody
	public Object editU() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = getPageData();
		String msg = "success";
		try {
			agreeMentService.editData(pd);
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "修改协议异常!"));
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}
}
