package com.zhimu.service.manager.system.permission.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.Permission;
import com.zhimu.service.manager.system.permission.PermissionManager;

/**
 * 说明： 权限 创建人：lwc
 * 
 * @version
 */
@Service("permissionService")
public class PermissionService implements PermissionManager {

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
		dao.save("PermissionMapper.save", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd) throws Exception {
		dao.delete("PermissionMapper.delete", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd) throws Exception {
		dao.update("PermissionMapper.edit", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("PermissionMapper.datalistPage", page);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PermissionMapper.findById", pd);
	}

	/**
	 * 通过编码获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findByBianma(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PermissionMapper.findByBianma", pd);
	}

	/**
	 * 对比获取是否已存在的权限sign
	 */
	@Override
	public PageData findBySign(PageData pd) throws Exception {
		return (PageData) dao.findForObject("PermissionMapper.findBySign", pd);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Permission> listAllPermissionByRoleId(String roleId) throws Exception {

		return (List<Permission>) dao.findForList("PermissionMapper.listAllPermissionByRoleId", roleId);
	}

}
