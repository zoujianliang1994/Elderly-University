package com.zhimu.controller.manager.cms.manage;

import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.constant.Const;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.User;
import com.zhimu.dao.utils.Jurisdiction;
import com.zhimu.service.manager.cms.HrefService;
import com.zhimu.service.manager.system.role.RoleManager;

@Controller
@RequestMapping("/manage/indexHref")
public class CmsHrefAction extends BaseManageAction {

	@Autowired
	protected HrefService hrefService;

	@Resource(name = "roleService")
	private RoleManager roleService;

	// 目录列表
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			String menuId = pd.getString("menuId");
			String keywords = pd.getString("keywords"); // 检索条件
			if (null != keywords && !"".equals(keywords)) {
				pd.put("keywords", keywords.trim());
			}
			page.setPd(pd);
			List<PageData> varList = hrefService.listPages(page); // 列出列表
			mv.addObject("menuId", menuId); // 菜单ID
			mv.addObject("varList", varList);
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "获取cms链接错误!"));
		}
		mv.setViewName("system/cms/href_list");
		return mv;
	}

	// 去新增页面
	@RequestMapping(value = "/addHref")
	public ModelAndView addHref() {
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "saveHref");
		mv.setViewName("system/cms/href_edit");
		return mv;
	}

	// 保存
	@RequestMapping(value = "/saveHref")
	public ModelAndView saveHref(@RequestParam String NAME, @RequestParam String URL, @RequestParam String FLAG) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd.put("NAME", NAME);
			pd.put("URL", URL);
			pd.put("FLAG", FLAG);
			hrefService.save(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "保存cms链接异常!"));
		}
		mv.setViewName("save_result");
		return mv;
	}

	// 去修改页面
	@RequestMapping(value = "/toUpdate")
	public ModelAndView toUpdate(@RequestParam String ID, @RequestParam String NAME, @RequestParam String URL, @RequestParam String FLAG) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("ID", ID);
		pd.put("NAME", NAME);
		pd.put("URL", URL);
		pd.put("FLAG", FLAG);
		mv.addObject("pd", pd);
		mv.addObject("msg", "updateHref");
		mv.setViewName("system/cms/href_edit");
		return mv;
	}

	// 修改
	@RequestMapping(value = "/updateHref")
	public ModelAndView updateHref(@RequestParam String ID, @RequestParam String NAME, @RequestParam String URL, @RequestParam String FLAG) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd.put("ID", ID);
			pd.put("NAME", NAME);
			pd.put("URL", URL);
			pd.put("FLAG", FLAG);
			hrefService.update(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "修改cms链接异常!"));
		}
		mv.setViewName("save_result");
		return mv;
	}

	// 删除
	@RequestMapping(value = "/delHref")
	public ModelAndView delHref(@RequestParam String ID) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd.put("ID", ID);
			hrefService.delete(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "删除cms链接异常!"));
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 获取角色Id
	 */
	private String returnRoleId() throws Exception {
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		String roleId = user.getROLE_ID();
		return roleId;
	}
}
