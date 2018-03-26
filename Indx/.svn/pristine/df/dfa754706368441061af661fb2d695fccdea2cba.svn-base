package com.zhimu.controller.manager.cms.manage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.GetPinyin;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.entity.system.Page;

/**
 * cms首页导航管理
 * 
 * @author: ytz
 * @date: 2017年8月29日
 */
@Controller
@RequestMapping("/manage/navigation")
public class NavigationAction extends BaseManageAction {

	// 目录列表
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			String keywords = pd.getString("keywords"); // 检索条件
			if (null != keywords && !"".equals(keywords)) {
				pd.put("keywords", keywords.trim());
			}
			String PARENT_ID = pd.getString("PARENT_ID");
			if (null == PARENT_ID || "".equals(PARENT_ID)) {
				PARENT_ID = "1";
				pd.put("PARENT_ID", PARENT_ID);
			}
			page.setPd(pd);
			List<PageData> varList = navigationService.listPages(page); // 列出列表
			mv.addObject("varList", varList);
			mv.addObject("pds", navigationService.getIdInfo(pd)); // 传入上级所有信息
			mv.addObject("pd", pd); // 传入上级所有信息
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "获取cms导航列表异常!"));
		}
		mv.setViewName("system/cms/navigation_list");
		return mv;
	}

	// 去新增页面
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			String PARENT_ID = pd.getString("PARENT_ID");
			if (!"".equals(PARENT_ID) && null != PARENT_ID) {
				PageData pdId = navigationService.getIdInfo(pd);
				if (null != pdId) {
					pd.put("FNAME", pdId.getString("NAME"));
				}
			}
			mv.addObject("pd", pd);
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "跳转cms导航新增界面异常!"));
		}
		mv.addObject("msg", "save");
		mv.setViewName("system/cms/navigation_edit");
		return mv;
	}

	// 保存
	@RequestMapping(value = "/save")
	public ModelAndView save() {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = getPageData();
			String PARENT_ID = pd.getString("PARENT_ID");
			if ("".equals(PARENT_ID) || null == PARENT_ID) {
				pd.put("PARENT_ID", "1");
			}
			pd.put("ID", UuidUtil.get32UUID());
			String PATH = pd.getString("PATH");
			if ("".equals(PATH) || null == PATH) {
				pd.put("PATH", "#");
			}
			pd.put("ENAME", GetPinyin.getPinYinHeadChar(pd.getString("NAME")));
			navigationService.addData(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "保存cms导航栏目异常!"));
		}
		mv.setViewName("save_result");
		return mv;
	}

	// 去修改页面
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			pd = navigationService.getIdInfo(pd);
			PageData fpd = new PageData();
			fpd.put("PARENT_ID", pd.getString("PARENT_ID"));
			PageData pd2 = navigationService.getIdInfo(fpd);
			pd.put("FNAME", pd2.getString("NAME"));
			mv.addObject("pd", pd); // 放入视图容器
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "跳转cms栏目修改界面异常!"));
		}
		mv.setViewName("system/cms/navigation_edit");
		mv.addObject("msg", "edit");
		return mv;
	}

	// 修改
	@RequestMapping(value = "/edit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			pd.put("ENAME", GetPinyin.getPinYinHeadChar(pd.getString("NAME")));
			String PATH = pd.getString("PATH");
			if ("".equals(PATH) || null == PATH) {
				pd.put("PATH", "#");
			}
			navigationService.updateData(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "修改cms导航栏目异常!"));
			mv.addObject("msg", "error");
		}
		mv.setViewName("save_result");
		return mv;
	}

	// 删除
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete() {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = getPageData();
		try {
			navigationService.delData(pd); // 执行删除
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			logger.error(ErrorUtils.getErrorMessage(e, "删除cms导航栏目异常!"));
		}
		return AppUtil.returnObject(new PageData(), map);
	}

}
