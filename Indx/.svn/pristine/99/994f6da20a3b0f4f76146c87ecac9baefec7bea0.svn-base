package com.zhimu.controller.manager.cms.foreground;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.vo.FolderVo;
import com.zhimu.dao.vo.PageVo;
import com.zhimu.service.manager.cms.CoverService;
import com.zhimu.service.manager.cms.HrefService;
import com.zhimu.service.manager.system.user.UserManager;

/**
 * cms首页入口
 * 
 * @author: yantz
 * @date: 2017年7月20日
 */
@Controller
@RequestMapping(value = "/cms")
public class IndexController extends CmsBaseController {

	@Autowired
	protected HrefService hrefService;
	@Autowired
	protected CoverService coverService;
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@Resource(name = "userService")
	private UserManager userService;

	/**
	 * 进入门户网站首页
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView indexPage(@RequestParam(value = "pages", defaultValue = "1") int pages) throws Exception {
		ModelAndView mv = this.getModelAndView();
		Page page = new Page();
		try {
			// 获取栏目管理
			String webId = configService.getIntKey("shamrock_webId");
			String path = folderService.getFolderById(webId).getPath();
			// 获取栏目文章
			PageVo<FolderVo> normalDataList = articleService.getArticlePage(path, pages, 6);
			// 获取快速通道信息
			List<FolderVo> quickDataList = this.folderService.getAllFolderListByType("quick");
			// 获取看板管理信息
			List<FolderVo> lookDataList = this.folderService.getAllFolderListByType("look");
			// 获取重点栏目信息
			List<FolderVo> pageDataList = this.folderService.getAllFolderListByType("keynote");
			// 获取底部链接
			List<PageData> urlList = hrefService.listPages(page);
			// 获取封面图片
			List<PageData> coverList = coverService.listPages(page);
			mv.addObject("pages", pages);
			mv.addObject("g_folderId", 0);
			mv.addObject("normalDataList", normalDataList.getList());
			mv.addObject("quickDataList", quickDataList);
			mv.addObject("lookDataList", lookDataList);
			mv.addObject("pageList", pageList("1"));
			mv.addObject("pageDataList", pageDataList);
			mv.addObject("urlList", urlList);
			mv.addObject("coverList", coverList);
			mv.setViewName("system/cms/foreground/index");
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "获取cms首页数据异常!"));
		}
		return mv;
	}

	@InitBinder
	public void initBinderMeeting(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("meeting.");
	}
}
