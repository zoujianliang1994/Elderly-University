package com.zhimu.controller.manager.cms.manage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.constant.Const;
import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.FileUpload;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.PathUtil;
import com.zhimu.dao.entity.cms.Article;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.cms.ArticleService;
import com.zhimu.service.manager.cms.FolderService;

/**
 * 文章管理入口
 * 
 * @author: taikoo
 * @date: 2017年7月11日 下午4:56:16
 */
@Controller
@RequestMapping("/manage/article")
public class ArticleManageAction extends BaseManageAction {

	@Resource(name = "folderService")
	FolderService folderService;
	@Resource(name = "articleService")
	ArticleService articleService;

	// 文章列表
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 检索条件
		try {
			if (null != keywords && !"".equals(keywords)) {
				pd.put("keywords", keywords.trim());
			}
			// 文章管理目前只对栏目
			pd.put("TYPE", "normal");
			page.setPd(pd);
			List<PageData> allFolderList = folderService.getAllFolderList(page);// 列出栏目
			mv.addObject("varLmList", allFolderList);
			List<PageData> varList = articleService.listPages(page); // 列出栏目文章列
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "获取cms首页文章列表异常！"));
		}
		mv.setViewName("system/cms/article_list");
		return mv;
	}

	// 去新增页面
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			// 文章管理目前只对栏目
			pd.put("TYPE", "normal");
			page.setPd(pd);
			List<PageData> allFolderList = folderService.getAllFolderList(page);
			mv.addObject("varList", allFolderList);
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "跳转cms文章新增界面异常！"));
		}
		mv.setViewName("system/cms/article_edit");
		mv.addObject("pd", pd);
		mv.addObject("msg", "save");
		return mv;
	}

	// 保存
	@RequestMapping(value = "/save")
	@ResponseBody
	public Object save(HttpServletRequest request, @RequestParam(required = false) MultipartFile files, Article article) {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "success";
		try {
			PageData pd = returnPageData(request);
			if (null != files && !files.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
				String photo_url = FileUpload.fileUp(files, filePath, get32UUID());
				pd.put("PICTURE", photo_url);
			}
			pd.put("CREATE_TIME", DateUtil.getTime());
			pd.put("UPDATE_TIME", DateUtil.getTime());
			pd.put("PATH", "1#" + pd.getString("FOLDER_ID") + "#");
			pd.put("ISCHECK", "yes");
			pd.put("ARTICLE_ID", this.get32UUID()); // 主键
			articleService.save(pd);
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "保存cms文章异常！"));
			msg = "error";
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	// 去修改页面
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String ARTICLE_ID = pd.getString("ARTICLE_ID");
		String type = pd.getString("type");
		try {
			// 文章管理目前只对栏目
			pd.put("TYPE", "normal");
			page.setPd(pd);
			List<PageData> allFolderList = folderService.getAllFolderList(page);
			mv.addObject("varList", allFolderList);
			pd = articleService.findById(pd); // 根据ID读取
			if (null != pd) {
				pd.put("filePath", PathUtil.getClasspath() + Const.FILEPATHFILE + pd.getString("PICTURE"));
			}
			pd.put("type", type);
			pd.put("ARTICLE_ID", ARTICLE_ID); // 复原本ID
			mv.addObject("pd", pd); // 放入视图容器
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "跳转cms文章修改界面异常！"));
		}
		mv.addObject("pd", pd);
		mv.setViewName("system/cms/article_edit");
		mv.addObject("msg", "edit");
		return mv;
	}

	// 修改
	@RequestMapping(value = "/edit")
	@ResponseBody
	public Object edit(HttpServletRequest request, @RequestParam(required = false) MultipartFile files, Article article) {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "success";
		try {
			PageData pd = returnPageData(request);
			if (null != files && !files.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
				String photo_url = FileUpload.fileUp(files, filePath, get32UUID());
				pd.put("PICTURE", photo_url);
			}
			pd.put("UPDATE_TIME", DateUtil.getTime());
			pd.put("PATH", "1#" + pd.getString("FOLDER_ID") + "#");
			articleService.edit(pd);
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "cms文章修改异常！"));
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	// 删除
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete(@RequestParam String ARTICLE_ID) {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd.put("ARTICLE_ID", ARTICLE_ID);
		try {
			articleService.delete(pd); // 执行删除
			map.put("result", "success");
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "删除cms文章异常！"));
			map.put("result", "error");
		}
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 返回流式数据
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	private PageData returnPageData(HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, String[]> multiMap = multipartRequest.getParameterMap();
		PageData pd = new PageData();
		for (Map.Entry<String, String[]> entry : multiMap.entrySet()) {
			pd.put(entry.getKey(), entry.getValue()[0].toString());
		}
		return pd;
	}

}
