package com.zhimu.service.manager.system.menu;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Menu;

import java.util.List;

/**
 * 说明：MenuService 菜单处理接口
 * 
 */
public interface MenuManager {

	/**
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<Menu> listSubMenuByParentId(String parentId) throws Exception;

	/**
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getMenuById(PageData pd) throws Exception;

	/**
	 * @param menu
	 * @throws Exception
	 */
	public void saveMenu(Menu menu) throws Exception;

	/**
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void updatePermissions(PageData pd) throws Exception;

	/**
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findMaxId(PageData pd) throws Exception;

	/**
	 * @param MENU_ID
	 * @throws Exception
	 */
	public void deleteMenuById(String MENU_ID) throws Exception;

	/**
	 * @param menu
	 * @throws Exception
	 */
	public void edit(Menu menu) throws Exception;

	/**
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData editicon(PageData pd) throws Exception;

	/**
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Menu> listAllMenu(String MENU_ID) throws Exception;

	/**
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Menu> listAllMenuQx(String MENU_ID) throws Exception;

	/**
	 * 
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Menu> listMenuQx(String MENU_ID) throws Exception;

	/**
	 * 
	 * @param MENU_ID
	 * @throws Exception
	 */
	public void deleteAllPermissions(String MENU_ID) throws Exception;

	/**
	 * 获取子菜单的下级目录(权限列表，增加、删除、修改、维护等)
	 * 
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	public List<Menu> listRoleMenuQx(String MENU_ID, String ROLE_ID) throws Exception;

	/**
	 * 获取到所有的菜单id,并将所有的菜单权限赋给系统管理员
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<String> findAllId(PageData pd) throws Exception;
}
