package com.zhimu.controller.manager.cms.manage;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.cms.CoverService;

/**
 * cms首页导航管理
 * 
 * @author: ytz
 * @date: 2017年8月29日
 */
@Controller
@RequestMapping("/manage/cover")
public class CoverAction extends BaseManageAction {

	@Autowired
	protected CoverService coverService;

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
			page.setPd(pd);
			List<PageData> varList = coverService.listPages(page); // 列出列表
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "获取封面图片列表异常!"));
		}
		mv.setViewName("system/cms/cover_list");
		return mv;
	}

	// 去新增页面
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			mv.addObject("pd", pd);
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "跳转封面图片新增界面异常!"));
		}
		mv.addObject("msg", "save");
		mv.setViewName("system/cms/cover_edit");
		return mv;
	}

	// 保存
	@RequestMapping(value = "/save")
	@ResponseBody
	public Object save(HttpServletRequest request, @RequestParam(required = false) MultipartFile files) {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "success";
		try {
			PageData pd = returnPageData(request);
			pd.put("ID", UuidUtil.get32UUID());
			pd.put("files", files);
			if (null != files && !files.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
				String photo_url = FileUpload.fileUp(files, filePath, get32UUID());
				pd.put("PICTURES_PATH", photo_url);
			}
			// pd.put("PICTURES_PATH", returnPicturePath(pd));
			coverService.addData(pd);
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "保存封面图片异常!"));
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	// 去修改页面
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			pd = coverService.getIdInfo(pd);
			mv.addObject("pd", pd); // 放入视图容器
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "跳转封面图片修改界面异常!"));
		}
		mv.setViewName("system/cms/cover_edit");
		mv.addObject("msg", "edit");
		return mv;
	}

	// 修改
	@RequestMapping(value = "/edit")
	@ResponseBody
	public Object edit(HttpServletRequest request, @RequestParam(required = false) MultipartFile files) {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "success";
		try {
			PageData pd = returnPageData(request);
			pd.put("files", files);
			if (null != files && !files.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
				String photo_url = FileUpload.fileUp(files, filePath, get32UUID());
				pd.put("PICTURES_PATH", photo_url);
			}
			coverService.updateData(pd);
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "修改封面图片异常!"));
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	// 删除
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete() {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = getPageData();
		try {
			coverService.delData(pd); // 执行删除
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			logger.error(ErrorUtils.getErrorMessage(e, "删除封面图片异常!"));
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

	private String returnPicturePath(PageData pd) throws Exception {
		// 保存图片信息
		MultipartFile files = (MultipartFile) pd.get("files");
		String PICTURES_FLAG = pd.getString("PICTURES_FLAG");
		String picturePath = "";
		if (files != null && "1".equals(PICTURES_FLAG)) {
			String fileDate = DateUtil.getDays();
			String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + fileDate; // 文件上传路径
			String fileName = FileUpload.fileUp(files, filePath, UuidUtil.get32UUID()); // 执行上传
			picturePath = Const.FILEPATHIMG + fileDate + File.separator + fileName;
		} else {
			picturePath = pd.getString("PICTURES_PATH");
		}
		return picturePath;
	}

}
