package com.zhimu.service.manager.cms;

import java.io.File;

import org.springframework.stereotype.Service;

import com.zhimu.commons.Exception.TemplateNotFoundException;
import com.zhimu.commons.constant.SystemConstant;


@Service("manageTemplateService")
public class ManageTemplateService extends TemplateService{
	/**
	 * 后台文章列表
	 * @param template
	 * @return
	 * @throws Exception
	 */
	public String getArticleTemplate(String template) throws Exception{
			if(this.isExist("article",template)){
				return this.getTemplatePath("article",template);
			}
		throw new TemplateNotFoundException("模板文件:"+this.getTemplatePath("article",template)+" 【不存在】");
	}
	/**
	 * 后台目录模板
	 * @param template
	 * @return
	 * @throws Exception
	 */
	public String getFolderTemplate(String template) throws Exception{
		if(this.isExist("folder",template)){
			return this.getTemplatePath("folder",template);
		}
		throw new TemplateNotFoundException("模板文件:"+this.getTemplatePath("folder",template)+" 【不存在】");
	}
	
	public String getConfigTemplate(String template) throws Exception{
		if(this.isExist("config",template)){
			return this.getTemplatePath("config",template);
		}
		throw new TemplateNotFoundException("模板文件:"+this.getTemplatePath("config",template)+" 【不存在】");
	}
	
	/**
	 * 后台管理员模板
	 * @param template
	 * @return
	 * @throws Exception
	 */
	public String getAdminTemplate(String template) throws Exception{
		if(this.isExist("admin", template)){
			return this.getTemplatePath("admin", template);
		}
		throw new TemplateNotFoundException("模板文件:"+this.getTemplatePath("admin",template)+" 【不存在】");
	}
	/**
	 * 模板物理地址是否存在
	 * @param theme
	 * @return
	 */
	private boolean isExist(String theme,String template) {
		String themePath = "/WEB-INF/cms/template/manage/"+theme+"/"+template+".ftl";
		File file = new File(SystemConstant.SHAMROCK_CMS_ROOT+themePath);
		if(file.exists()){
			logger.info("尝试使用模板"+themePath+"【存在】");
			return true;
		}else{
			logger.info("尝试使用模板"+themePath+"【不存在】");
			return false;
		}
		
	}
	/**
	 * 得到当前请求需要渲染的模板相对路径
	 * @param template
	 * @return
	 */
	private String getTemplatePath(String theme,String template) {
		
		return "/template/manage/"+theme+"/"+template;
	}
}
