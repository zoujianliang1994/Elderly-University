package com.zhimu.controller.manager.system.officeedit;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.controller.manager.base.BaseController;
/**
 * 文档在线编辑控制
 * @author Weiyunchao
 *
 * 2017年7月3日下午2:14:35
 */
@Controller
@RequestMapping(value="/officeEdit")
public class OfficeEditController extends BaseController {

	/**
	 *  电子印章简易管理平台页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/adminseal")
	public ModelAndView adminseal()throws Exception
	{
		return new ModelAndView("system/office/adminseal");
	}
	/**
	 *   word、excel在线编辑
	 * @param openModeType
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/openOffice")
	public ModelAndView openOffice(String openModeType)throws Exception
	{
		ModelAndView model = new ModelAndView();
		if(openModeType.equals("0"))//word编辑
		{
			model.setViewName("system/office/open_office_word");
		}else if(openModeType.equals("1"))//Excel编辑
		{
			model.setViewName("system/office/open_office_excel");
		}
		return model;
	}
	
}
