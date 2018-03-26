package com.zhimu.controller.manager.cms.foreground;

import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.vo.ArticleVo;
import com.zhimu.dao.vo.PageVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * 目录详情入口
 *
 * @author: yantz
 * @date: 2017年7月21日
 */
@Controller
@RequestMapping("/folder")
public class FolderController extends CmsBaseController {

  /**
   * 获取目录下所有文章
   *
   * @param ename
   * @param page
   * @return
   * @throws Exception
   */
  @RequestMapping("/{folderEname}")
  public ModelAndView getFolderArticle(@PathVariable(value = "folderEname") String ename, Page page) throws Exception {
    ModelAndView mv = this.getModelAndView();
    try {
      PageData pageData = folderService.getFolderByEname(ename);
      String folderId = pageData.getString("FOLDER_ID");
      String folderName = pageData.getString("NAME");
      PageData pd = new PageData();
      pd = this.getPageData();
      page.setPd(pd);
      // 获取目录列表
      PageVo<ArticleVo> pageVo = articleService.getArticlePageByFolderId(folderId, page);
      for (ArticleVo article : pageVo.getList()) {
        // 截取长度
        article.setTitle(100);
      }
      // 当前页
      mv.addObject("currentPage", page.getCurrentPage() == 0 ? 1 : page.getCurrentPage());
      // 总页数
      mv.addObject("totalPage", page.getTotalPage() == 0 ? 1 : page.getTotalPage());
      mv.addObject("pageList", pageList("1"));
      mv.addObject("pageVo", pageVo.getList());
      mv.addObject("ename", ename);
      mv.addObject("folderName", folderName);
      mv.setViewName("system/cms/foreground/folder");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "获取cms栏目下文章异常!"));
    }
    return mv;
  }

  /**
   * 根据搜索字段查询文章
   */
  @RequestMapping("/searchText")
  public ModelAndView getSearchTextArticle(Page page) throws Exception {
    ModelAndView mv = this.getModelAndView();
    try {
      PageData pd = new PageData();
      pd = this.getPageData();
      page.setPd(pd);
      List<PageData> pageData = articleService.listPages(page);
      mv.addObject("pageList", pageList("1"));
      mv.addObject("pageVo", pageData);
      mv.addObject("keywords", pd.get("keywords"));
      mv.addObject("currentPage", page.getCurrentPage() == 0 ? 1 : page.getCurrentPage());
      mv.addObject("totalPage", page.getTotalPage() == 0 ? 1 : page.getTotalPage());
      mv.setViewName("system/cms/foreground/searchArticle");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "搜索关键字文章异常!"));
    }
    return mv;
  }

}
