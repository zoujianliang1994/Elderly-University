package com.zhimu.service.manager.system.role;

import java.util.List;
import java.util.Map;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.Role;
import com.zhimu.dao.entity.system.RolePermission;

/**
 * 角色接口类
 * 
 */
public interface RoleManager {

	/**
	 * 列出此组下级角色
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<Role> listAllRolesByPId(PageData pd) throws Exception;

	/**
	 * 根据层级列出此组下级角色
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<Role> listAllRolesByPIdLevel(PageData pd) throws Exception;

	/**
	 * 通过id查找
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findObjectById(PageData pd) throws Exception;

	/**
	 * 添加
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void add(PageData pd) throws Exception;

	/**
	 * 保存修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;

	/**
	 * 删除角色
	 * 
	 * @param ROLE_ID
	 * @throws Exception
	 */
	public void deleteRoleById(String ROLE_ID) throws Exception;

	/**
	 * 给当前角色附加菜单权限
	 * 
	 * @param role
	 * @throws Exception
	 */
	public void updateRoleRights(Role role) throws Exception;

	/**
	 * 通过id查找
	 * 
	 * @param roleId
	 * @return
	 * @throws Exception
	 */
	public Role getRoleById(String ROLE_ID) throws Exception;

	/**
	 * 给全部子角色加菜单权限
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void setAllRights(PageData pd) throws Exception;

	/**
	 * 权限(增删改查)
	 * 
	 * @param msg
	 *            区分增删改查
	 * @param pd
	 * @throws Exception
	 */
	public void saveB4Button(String msg, PageData pd) throws Exception;

	/**
	 * 查询角色菜单细化菜单权限
	 */
	public Map<String, String> selectRolePermission(String role_id, String menu_id) throws Exception;

	/**
	 * 新增角色菜单细化菜单权限
	 */
	public void insertRolePermission(List<RolePermission> rolePermissionList) throws Exception;

	/**
	 * 修改角色菜单细化菜单权限
	 */
	public void iupdateRolePermission(String role_id) throws Exception;

	/**
	 * 删除角色的细化菜单权限
	 */
	public void deleteRolePermission(Map<String, String> map) throws Exception;

	/**
	 * 查找所有系统管理员id
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public List<String> findSysRoleId(String id) throws Exception;

	/**
	 * 分页的角色列表
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listRoles(Page pd) throws Exception;

	/**
	 * 获取所用用户
	 * 
	 * @param
	 * @return
	 */
	public List<Map> getRoleUser(String role_id) throws Exception;

	/**
	 * 清楚用户权限
	 * 
	 * @param map
	 */
	public void clearUserRole(Map<String, Object> map) throws Exception;

	/**
	 * 新增用户权限
	 * 
	 * @param map
	 */
	public void addUserRole(Map<String, Object> map) throws Exception;

	/**
	 * 新增用户添加角色的权限
	 * @param ROLE_ID
	 * @param menuIds
	 * @throws Exception
	 */
	public void addRolePermission(String ROLE_ID, String menuIds) throws  Exception;

}
