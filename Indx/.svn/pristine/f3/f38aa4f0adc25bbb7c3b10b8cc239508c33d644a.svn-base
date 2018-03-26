package com.zhimu.controller.manager.system.dictionaries;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.system.dictionaries.DictionariesManager;

/**
 * 说明：数据字典
 */
@Controller
@RequestMapping(value = "/dictionaries")
public class DictionariesController extends BaseController {

	String menuUrl = "dictionaries/list.do"; // 菜单地址(权限用)
	@Resource(name = "dictionariesService")
	private DictionariesManager dictionariesService;

	/**
	 * 显示列表ztree
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/listAllDict")
	public ModelAndView listAllDict(Model model, String DICTIONARIES_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDict("0"));
			String json = arr.toString();
			json = json.replaceAll("DICTIONARIES_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("NAME", "name").replaceAll("subDict", "nodes").replaceAll("hasDict", "checked")
					.replaceAll("treeurl", "url");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("DICTIONARIES_ID", DICTIONARIES_ID);
			mv.addObject("pd", pd);
			mv.setViewName("system/dictionaries/dictionaries_ztree");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		String DICTIONARIES_ID = pd.getString("DICTIONARIES_ID");

		if (null == DICTIONARIES_ID || "".equals(DICTIONARIES_ID)) {
			DICTIONARIES_ID = "0";
		}
		if (null != pd.get("id") && !"".equals(pd.get("id").toString())) {
			DICTIONARIES_ID = pd.get("id").toString();
		}
		pd.put("DICTIONARIES_ID", DICTIONARIES_ID); // 上级ID
		page.setPd(pd);
		List<PageData> varList = dictionariesService.list(page); // 列出Dictionaries列表
		mv.addObject("pd", dictionariesService.findById(pd)); // 传入上级所有信息
		mv.addObject("DICTIONARIES_ID", DICTIONARIES_ID); // 上级ID
		mv.setViewName("system/dictionaries/dictionaries_list");
		mv.addObject("varList", varList);
		return mv;
	}

	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String DICTIONARIES_ID = null == pd.get("DICTIONARIES_ID") ? "" : pd.get("DICTIONARIES_ID").toString();
		pd.put("DICTIONARIES_ID", DICTIONARIES_ID); // 上级ID
		mv.addObject("currentPage", pd.get("currentPage"));
		mv.addObject("pds", dictionariesService.findById(pd)); // 传入上级所有信息
		mv.addObject("DICTIONARIES_ID", DICTIONARIES_ID); // 传入ID，作为子级ID用
		mv.addObject("msg", "save");
		mv.setViewName("system/dictionaries/dictionaries_edit");
		return mv;
	}

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Object save() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "";
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("DICTIONARIES_ID", this.get32UUID()); // 主键
		dictionariesService.save(pd);
		msg = "success";
		map.put("msg", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();

		pd = this.getPageData();
		String currentPage = pd.getString("currentPage");
		String DICTIONARIES_ID = pd.getString("DICTIONARIES_ID");
		pd = dictionariesService.findById(pd); // 根据ID读取
		mv.addObject("pd", pd); // 放入视图容器
		mv.addObject("currentPage", currentPage);
		pd.put("DICTIONARIES_ID", pd.get("PARENT_ID").toString()); // 用作上级信息
		mv.addObject("pds", dictionariesService.findById(pd)); // 传入上级所有信息
		mv.addObject("DICTIONARIES_ID", pd.get("PARENT_ID").toString()); // 传入上级ID，作为子ID用
		pd.put("DICTIONARIES_ID", DICTIONARIES_ID); // 复原本ID
		mv.setViewName("system/dictionaries/dictionaries_edit");
		mv.addObject("msg", "edit");
		return mv;
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	@ResponseBody
	public Object edit() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "";
		PageData pd = new PageData();
		pd = this.getPageData();
		dictionariesService.edit(pd);
		msg = "success";
		map.put("msg", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 删除
	 * 
	 * @param DICTIONARIES_ID
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete(@RequestParam String DICTIONARIES_ID) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd.put("DICTIONARIES_ID", DICTIONARIES_ID);
		String errInfo = "success";
		if (dictionariesService.listSubDictByParentId(DICTIONARIES_ID).size() > 0) {// 判断是否有子级，是：不允许删除
			errInfo = "false";
		} else {
			pd = dictionariesService.findById(pd);// 根据ID读取
			if (null != pd.get("TBSNAME") && !"".equals(pd.getString("TBSNAME"))) {
				String[] table = pd.getString("TBSNAME").split(",");
				for (int i = 0; i < table.length; i++) {
					pd.put("thisTable", table[i]);
					try {
						if (Integer.parseInt(dictionariesService.findFromTbs(pd).get("zs").toString()) > 0) {// 判断是否被占用，是：不允许删除(去排查表检查字典表中的编码字段)
							errInfo = "false";
							break;
						}
					} catch (Exception e) {
						errInfo = "false2";
						break;
					}
				}
			}
		}
		if ("success".equals(errInfo)) {
			dictionariesService.delete(pd); // 执行删除
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/getDictionaries")
	@ResponseBody
	public Object getDictionaries() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		List<Map> Person_mz = dictionariesService.getOptions("Person_mz");
		Map<String, Object> Person_mzMap = new HashMap<String, Object>();
		Person_mzMap.put("name", "民族");
		Person_mzMap.put("value", Person_mz);
		map.put("Person_mz", Person_mzMap);

		List<Map> personnel_categories = dictionariesService.getOptions("personnel_categories");
		Map<String, Object> personnel_categoriesMap = new HashMap<String, Object>();
		personnel_categoriesMap.put("name", "人员类别");
		personnel_categoriesMap.put("value", personnel_categories);
		map.put("personnel_categories", personnel_categoriesMap);

		List<Map> economic_source = dictionariesService.getOptions("economic_source");
		Map<String, Object> economic_sourceMap = new HashMap<String, Object>();
		economic_sourceMap.put("name", "经济来源");
		economic_sourceMap.put("value", economic_source);
		map.put("economic_source", economic_sourceMap);

		List<Map> insured_situation = dictionariesService.getOptions("insured_situation");
		Map<String, Object> insured_situationMap = new HashMap<String, Object>();
		insured_situationMap.put("name", "参保情况");
		insured_situationMap.put("value", insured_situation);
		map.put("insured_situation", insured_situationMap);

		List<Map> self_care = dictionariesService.getOptions("self_care");
		Map<String, Object> self_careMap = new HashMap<String, Object>();
		self_careMap.put("name", "自理能力");
		self_careMap.put("value", self_care);
		map.put("self_care", self_careMap);

		List<Map> health_condition = dictionariesService.getOptions("health_condition");
		Map<String, Object> health_conditionMap = new HashMap<String, Object>();
		health_conditionMap.put("name", "健康状况");
		health_conditionMap.put("value", health_condition);
		map.put("health_condition", health_conditionMap);

		List<Map> living_condition = dictionariesService.getOptions("living_condition");
		Map<String, Object> living_conditionMap = new HashMap<String, Object>();
		living_conditionMap.put("name", "居住状况");
		living_conditionMap.put("value", living_condition);
		map.put("living_condition", living_conditionMap);

		List<Map> ywsh_type = dictionariesService.getOptions("ywsh_type");
		Map<String, Object> ywsh_typeMap = new HashMap<String, Object>();
		ywsh_typeMap.put("name", "购买意外伤害保险方式");
		ywsh_typeMap.put("value", ywsh_type);
		map.put("ywsh_type", ywsh_typeMap);

		List<Map> ylfs = dictionariesService.getOptions("ylfs");
		Map<String, Object> ylfsMap = new HashMap<String, Object>();
		ylfsMap.put("name", "养老方式");
		ylfsMap.put("value", ylfs);
		map.put("ylfs", ylfsMap);

		return AppUtil.returnObject(new PageData(), map);
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
