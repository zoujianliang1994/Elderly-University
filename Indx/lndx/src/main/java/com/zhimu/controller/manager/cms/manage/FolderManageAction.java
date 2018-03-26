package com.zhimu.controller.manager.cms.manage;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.FileUpload;
import com.zhimu.commons.utils.GetPinyin;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.PathUtil;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.entity.system.Page;

/**
 * 目录管理入口
 * 
 * @author: ytz
 * @date: 2017年7月11日 下午4:56:32
 */
@Controller
@RequestMapping("/manage/folder")
public class FolderManageAction extends BaseManageAction {

	// 目录列表
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page, @RequestParam String type) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("TYPE", type);
		String keywords = pd.getString("keywords"); // 检索条件
		try {
			if (null != keywords && !"".equals(keywords)) {
				pd.put("keywords", keywords.trim());
			}
			page.setPd(pd);
			List<PageData> varList = folderService.listPages(page); // 列出列表
			mv.addObject("varList", varList);
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "获取cms栏目列表异常!"));
		}
		mv.addObject("pd", pd);
		mv.setViewName("system/cms/folder_list");
		return mv;
	}

	// 去新增页面
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {

		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "跳转cms栏目新增界面异常!"));
		}
		mv.addObject("msg", "save");
		mv.setViewName("system/cms/folder_edit");
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
			String get32uuid = UuidUtil.get32UUID();
			pd.put("CREATE_TIME", new Date());
			pd.put("FOLDER_ID", get32uuid); // 主键
			// String TYPE = pd.getString("TYPE");
			pd.put("PATH", "1#" + get32uuid + "#");
			// if ("normal".equals(TYPE)) {
			// pd.put("PATH", "1#" + get32uuid + "#");
			// } else {
			// String PATH = pd.getString("PATH");
			// if (null == PATH || "".equals(PATH)) {
			// pd.put("PATH", "#");
			// }
			// }
			if (null != files && !files.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
				String photo_url = FileUpload.fileUp(files, filePath, get32UUID());
				pd.put("PICTURES_PATH", photo_url);
			}
			pd.put("ENAME", GetPinyin.getPinYinHeadChar(pd.getString("NAME")));
			pd.put("files", files);
			folderService.save(pd);
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "保存cms栏目异常!"));
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	// 去修改页面
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit(Page page, @RequestParam String type) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			String FOLDER_ID = pd.getString("FOLDER_ID");
			pd = folderService.findById(pd); // 根据ID读取
			mv.addObject("pd", pd); // 放入视图容器
			mv.addObject("pds", folderService.findById(pd)); // 传入上级所有信息
			pd.put("FOLDER_ID", FOLDER_ID); // 复原本ID
		} catch (Exception e) {
			mv.setViewName("error");
			logger.error(ErrorUtils.getErrorMessage(e, "跳转cms栏目修改界面异常!"));
		}
		mv.setViewName("system/cms/folder_edit");
		mv.addObject("msg", "edit");
		mv.addObject("type", type);
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
			pd.put("ENAME", GetPinyin.getPinYinHeadChar(pd.getString("NAME")));
			pd.put("UPDATE_TIME", new Date());
			pd.put("files", files);

			// String TYPE = pd.getString("TYPE");
			pd.put("PATH", "1#" + pd.getString("FOLDER_ID") + "#");

			// if ("normal".equals(TYPE)) {
			// pd.put("PATH", "1#" + pd.getString("FOLDER_ID") + "#");
			// } else {
			// String PATH = pd.getString("PATH");
			// if (null == PATH || "".equals(PATH)) {
			// pd.put("PATH", "#");
			// }
			// }
			if (null != files && !files.isEmpty()) {
				String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
				String photo_url = FileUpload.fileUp(files, filePath, get32UUID());
				pd.put("PICTURES_PATH", photo_url);
			}
			folderService.edit(pd);
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "cms栏目修改异常!"));
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	// 删除
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete(@RequestParam String FOLDER_ID) {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd.put("FOLDER_ID", FOLDER_ID);
		try {
			folderService.delete(pd); // 执行删除
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "error");
			logger.error(ErrorUtils.getErrorMessage(e, "删除cms栏目异常!"));
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
