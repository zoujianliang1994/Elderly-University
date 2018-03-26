package com.zhimu.controller.manager.cms.foreground;

import java.text.SimpleDateFormat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.cms.Folder;
import com.zhimu.dao.vo.ArticleVo;

/**
 * 文章详情内容入口
 * 
 * @author: yantz
 * @date: 2017年7月21日
 * 
 */
@Controller
@RequestMapping("/article")
public class ArticleController extends CmsBaseController {

	// 文章详情
	@RequestMapping("/{folderEname}/{articleId}")
	public ModelAndView getContent(@PathVariable(value = "folderEname") String ename, @PathVariable(value = "articleId") String articleId) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData getPageData = getPageData();
		try {
			mv.addObject("keywords", getPageData.get("keywords"));
			PageData pd = folderService.getFolderByEname(ename);
			Folder folder = new Folder();
			folder.setTitle(pd.getString("TITLE"));
			folder.setContent(pd.getString("CONTENT"));
			folder.setEname(pd.getString("ENAME"));
			folder.setName(pd.getString("NAME"));
			// 获取文章内容
			PageData pageData = articleService.getArticleById(articleId);
			ArticleVo avo = new ArticleVo();
			avo.setTitle(pageData.getString("TITLE"));
			avo.setContent(pageData.getString("CONTENT"));
			avo.setSourceName(pageData.getString("SOURCE_NAME"));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			avo.setUpdateTime(sdf.parse(pageData.getString("UPDATE_TIME")));
			mv.addObject("pageList", pageList("1"));
			mv.addObject("folder", folder);
			mv.addObject("article", avo);
			mv.setViewName("system/cms/foreground/article");
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "查看cms文章详情异常!"));
		}
		return mv;
	}
}
