package com.zhimu.service.manager.system.dictionaries.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Dictionaries;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.system.dictionaries.DictionariesManager;

/**
 * 说明： 数据字典
 * 
 * @version
 */
@Service("dictionariesService")
@SuppressWarnings("unchecked")
public class DictionariesService implements DictionariesManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void save(PageData pd) throws Exception {
		dao.save("DictionariesMapper.save", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd) throws Exception {
		dao.delete("DictionariesMapper.delete", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd) throws Exception {
		dao.update("DictionariesMapper.edit", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@Override
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("DictionariesMapper.datalistPage", page);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("DictionariesMapper.findById", pd);
	}

	/**
	 * 通过编码获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findByBianma(PageData pd) throws Exception {
		return (PageData) dao.findForObject("DictionariesMapper.findByBianma", pd);
	}

	/**
	 * 通过ID获取其子级列表
	 * 
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Dictionaries> listSubDictByParentId(String parentId) throws Exception {
		return (List<Dictionaries>) dao.findForList("DictionariesMapper.listSubDictByParentId", parentId);
	}

	/**
	 * 获取所有数据并填充每条数据的子级列表(递归处理)
	 * 
	 * @param
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Dictionaries> listAllDict(String parentId) throws Exception {
		List<Dictionaries> dictList = this.listSubDictByParentId(parentId);
		for (Dictionaries dict : dictList) {
			dict.setTreeurl("dictionaries/list.do?DICTIONARIES_ID=" + dict.getDICTIONARIES_ID());
			dict.setSubDict(this.listAllDict(dict.getDICTIONARIES_ID()));
			dict.setTarget("treeFrame");
		}
		return dictList;
	}

	/**
	 * 排查表检查是否被占用
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findFromTbs(PageData pd) throws Exception {
		return (PageData) dao.findForObject("DictionariesMapper.findFromTbs", pd);
	}

	/**
	 * 字典表接口查询
	 */
	@Override
	public List<Dictionaries> listBianMaValue(String NAME_EN) throws Exception {
		return (List<Dictionaries>) dao.findForList("DictionariesMapper.listBianMaValue", NAME_EN);
	}

	@Override
	public List<Map> getOptions(String parentId) throws Exception {
		return (List<Map>) dao.findForList("DictionariesMapper.getOptions", parentId);
	}

	@Override
	public List<Map> getSelectedValue(Map<String, Object> map) throws Exception {
		return (List<Map>) dao.findForList("DictionariesMapper.getSelectedValue", map);
	}

}
