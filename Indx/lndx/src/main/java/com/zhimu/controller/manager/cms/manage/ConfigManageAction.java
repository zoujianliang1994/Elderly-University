package com.zhimu.controller.manager.cms.manage;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zhimu.dao.vo.JsonVo;

@Controller
@RequestMapping("/manage/config")
public class ConfigManageAction extends BaseManageAction{
	//@Autowired
	//private  SimpleCacheManager cacheManager;
	@RequestMapping("/index.htm")
	public String index(HttpServletRequest request,ModelMap modelMap) throws Exception{
		//获取网站配置
		/*String template = configService.getStringByKey("shamrock_template");
		String webId = configService.getIntKey("shamrock_webId");
		String ifstatic = configService.getStringByKey("shamrock_static");*/
		
		try {
			/*Folder folder = folderService.getFolderById(webId);
			List<FolderVo> webList = folderService.getFolderListByFatherId(0, null);
			
			modelMap.addAttribute("template", template);
			modelMap.addAttribute("webId", webId);
			modelMap.addAttribute("ifstatic", ifstatic);
			modelMap.addAttribute("folder", folder);
			modelMap.addAttribute("webList", webList);*/
			return manageTemplateService.getConfigTemplate("index");
		} catch (Exception e) {
			logger.fatal(e.getMessage());
			modelMap.addAttribute("g_folderId", 0);
			return manageTemplateService.get404();
		}
	}
	
	@ResponseBody
	@RequestMapping("/update.json")
	public JsonVo<String> update(@RequestParam(value="webId")String webId,
			@RequestParam(value="ifstatic")String ifstatic){
		JsonVo<String> json = new JsonVo<String>();
			try {
			/*	Folder folder = folderService.getFolderById(webId);
				//configService.updateConfigByKey("shamrock_static", ifstatic);
				configService.updateConfigByKey("shamrock_seo_title", folder.getTitle());
				if(webId.equals(configService.getIntKey("shamrock_webId"))){
					configService.updateConfigByKey("shamrock_webId", ""+webId);
				}
				
				json.setResult(true);*/
				
			} catch (Exception e) {
				json.setResult(false);
				json.setMsg(e.getMessage());
			}
			return json;
	}
	
	@RequestMapping("/edit.htm")
	public String edit(@RequestParam(value="folderId")String folderId,ModelMap modelMap,HttpServletRequest request) throws Exception{
		//Admin admin = this.getAdmin(request);
		try {
			/*FolderVo folder = folderService.getFolderById(folderId);
			modelMap.put("folder", folder);
			modelMap.put("JSESSIONID", request.getSession().getId());*/
			return manageTemplateService.getConfigTemplate("edit");
		} catch (Exception e) {
			modelMap.addAttribute("g_folderId", 0);
			return manageTemplateService.get404();
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/edit.json",method=RequestMethod.POST)
	public JsonVo<String> edit(@RequestParam("folderId")String folderId,
			@RequestParam("title")String title,
			@RequestParam("name")String name,
			@RequestParam("ename")String ename,
			@RequestParam("logo")MultipartFile logo,
			@RequestParam("width")int width,
			@RequestParam("height")int height,
			@RequestParam("content")String content){
		JsonVo<String> json = new JsonVo<String>();
		try {
		/*	Folder folder = folderService.getFolderByEname(ename);
			if(folder.getFolderId()!=folderId){
				json.getErrors().put("folderEname", "该英文名目录已存在");
				json.setResult(false);
				return json;
			}
			folder = folderService.getFolderById(folderId);
			folder.setContent(content);
			folder.setTitle(title);
			String logo_image = "";
			folder.setName(name);
			folder.setEname(ename);
			folderService.updateFolder(folder);
			configService.updateConfigByKey("shamrock_seo_title", title);
			configService.updateConfigByKey("shamrock_seo_description", content);
			json.setResult(true);*/
		} catch (Exception e) {
			json.setMsg(e.getMessage());
			json.setResult(false);
		}
		return json;
	}

}
