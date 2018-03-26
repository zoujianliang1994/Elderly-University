package com.zhimu.service.manager.system.menu.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Menu;
import com.zhimu.service.manager.system.menu.MenuManager;

/**
 * 类名称：MenuService 菜单处理
 * 
 * @version v2
 */
@Service("menuService")
public class MenuService implements MenuManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 通过ID获取其子一级菜单
	 * 
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<Menu> listSubMenuByParentId(String parentId) throws Exception {
		return (List<Menu>) dao.findForList("MenuMapper.listSubMenuByParentId", parentId);
	}

	/**
	 * 通过菜单ID获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	public PageData getMenuById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("MenuMapper.getMenuById", pd);
	}

	/**
	 * 新增菜单
	 * 
	 * @param menu
	 * @throws Exception
	 */
	@Override
	public void saveMenu(Menu menu) throws Exception {
		dao.save("MenuMapper.insertMenu", menu);
	}

	/**
	 * 取最大ID
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	public PageData findMaxId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("MenuMapper.findMaxId", pd);
	}

	/**
	 * 删除菜单
	 * 
	 * @param MENU_ID
	 * @throws Exception
	 */
	@Override
	public void deleteMenuById(String MENU_ID) throws Exception {
		dao.save("MenuMapper.deleteMenuById", MENU_ID);
	}

	/**
	 * 编辑
	 * 
	 * @param menu
	 * @return
	 * @throws Exception
	 */
	@Override
	public void edit(Menu menu) throws Exception {
		dao.update("MenuMapper.updateMenu", menu);
	}

	/**
	 * 保存菜单图标
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	public PageData editicon(PageData pd) throws Exception {
		return (PageData) dao.findForObject("MenuMapper.editicon", pd);
	}

	/**
	 * 获取所有菜单并填充每个菜单的子菜单列表(菜单管理)(递归处理)
	 * 
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Menu> listAllMenu(String MENU_ID) throws Exception {
		List<Menu> menuList = this.listSubMenuByParentId(MENU_ID);
		for (Menu menu : menuList) {
			menu.setSubMenu(this.listAllMenu(menu.getMENU_ID()));
			menu.setTarget("treeFrame");
		}
		return menuList;
	}

	/**
	 * 获取所有菜单并填充每个菜单的子菜单列表(系统菜单列表)(递归处理)
	 * 
	 * @param MENU_ID
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Menu> listAllMenuQx(String MENU_ID) throws Exception {
		List<Menu> menuList = this.listSubMenuByParentId(MENU_ID);
		for (Menu menu : menuList) {
			menu.setSubMenu(this.listAllMenuQx(menu.getMENU_ID()));
			menu.setTarget("treeFrame");
		}
		return menuList;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Menu> listMenuQx(String MENU_ID) throws Exception {
		return (List<Menu>) dao.findForList("MenuMapper.getMenuByPermissMenu", MENU_ID);
	}

	@Override
	public void updatePermissions(PageData pd) throws Exception {
		dao.save("MenuMapper.updatePermissions", pd);
	}

	@Override
	public void deleteAllPermissions(String MENU_ID) throws Exception {
		dao.delete("MenuMapper.deleteAllPermissions", MENU_ID);
	}

	/**
	 * 获取角色各级的所有菜单目录(权限列表，增加、删除、修改、维护等)
	 * 
	 * 2017-7-11 by:yantz
	 */
	@Override
	public List<Menu> listRoleMenuQx(String MENU_ID, String ROLE_ID) throws Exception {
		List<Menu> menuList = this.listSubMenuByParentId(MENU_ID);
		for (Menu menu : menuList) {
			menu.setSubMenu(listAllMenuQx(menu.getMENU_ID()));
			menu.setTarget("treeFrame");

		}
		menuList = listGetRoel(menuList, ROLE_ID);
		return menuList;
	}

	public List<Menu> listGetRoel(List<Menu> menuTwoList, String role_id) throws Exception {
		for (Menu menuTwo : menuTwoList) {
			if (menuTwo.getSubMenu().size() == 0) {
				menuTwo.setSubMenu(listTwoSubMenuQx(menuTwo.getMENU_ID(), role_id));
				menuTwo.setTarget("treeFrame");
			} else {
				listGetRoel(menuTwo.getSubMenu(), role_id);
			}
		}
		return menuTwoList;
	}

	/**
	 * 查询获取子菜单的下级操作目录(权限列表，增加、删除、修改、维护等菜单)
	 */
	@SuppressWarnings({ "unchecked" })
	private List<Menu> listTwoSubMenuQx(String MENU_ID, String ROLE_ID) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("MENU_ID", MENU_ID);
		map.put("ROLE_ID", ROLE_ID);
		List<Menu> listMenu = (List<Menu>) dao.findForList("MenuMapper.getListTwoSubMenuQx", map);
		return listMenu;
	}

	/**
	 * 获取所有的菜单id,并将所有的菜单权限赋给系统角色
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<String> findAllId(PageData pd) throws Exception {
		return (List<String>) dao.findForList("MenuMapper.findAllId", pd);
	}
}
