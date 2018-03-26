package com.zhimu.controller.manager.system.personalpanel;

/**
 * 个人面板
 */
import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.HttpUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.User;
import com.zhimu.service.manager.system.personalpanel.PersonalPanelService;

@Controller
@RequestMapping(value = "/personalpanel")
public class PersonalPanelController extends BaseController {
	@Resource(name = "personalPanelService")
	PersonalPanelService personalPanelService;

	/**
	 * 显示个人消息列表
	 */
	@RequestMapping(value = "/list")
	public ModelAndView listUsers(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}else{

		}
		User user = getUserInfo();
		try {
			pd.put("USER_NAME", user.getUSERNAME());
			pd.put("USER_ID", user.getUSER_ID());
			page.setPd(pd);
			mv.addObject("list", this.personalPanelService.list(page));
			mv.addObject("pd", pd);
			mv.setViewName("system/personalpanel/message_list");
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "个人消息列表异常"));
		}
		return mv;
	}

	/**
	 * 访问个人页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/to_personalpanel")
	@ResponseBody
	public ModelAndView toPersonalPanel() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		User userInfo = getUserInfo();
		String areaCode = pd.getString("areaCode");
		// 获取用户未读消息数
		int num = this.personalPanelService.getTotalMsgNum(userInfo);
		// 业务模块对应菜单
		mv.addObject("pd", pd);
		mv.addObject("num", num);
		mv.addObject("areaCode", areaCode);
		mv.addObject("user", getUserInfo());
		mv.setViewName("system/personalpanel/personal_info");
		mv.addObject("basePath", HttpUtils.getBasePath(this.getRequest()));
		return mv;
	}

}
