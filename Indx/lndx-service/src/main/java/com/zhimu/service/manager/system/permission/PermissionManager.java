package com.zhimu.service.manager.system.permission;

import java.util.List;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.Permission;

/**
 * 说明： 权限接口类 创建人：lwc
 * 
 * @version
 */
public interface PermissionManager {

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception;

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception;

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page) throws Exception;

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception;

	/**
	 * 通过编码获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByBianma(PageData pd) throws Exception;

	/**
	 * 通过角色ID获取所有角色下的所有权限
	 * 
	 * @param roleId
	 * @return
	 * @throws Exception
	 */
	public List<Permission> listAllPermissionByRoleId(String roleId) throws Exception;

	/**
	 * 根据用户传入的标志对比数据库
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findBySign(PageData pd) throws Exception;

}
