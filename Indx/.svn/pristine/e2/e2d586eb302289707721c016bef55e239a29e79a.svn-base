package com.zhimu.controller.manager.system.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.RightsHelper;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Menu;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.Role;
import com.zhimu.dao.entity.system.User;
import com.zhimu.service.manager.edu.school.SchoolService;
import com.zhimu.service.manager.redis.RedisCacheUtil;
import com.zhimu.service.manager.system.menu.MenuManager;
import com.zhimu.service.manager.system.role.RoleManager;
import com.zhimu.service.manager.system.user.UserManager;

/**
 * 用户管理
 */
@Controller
@RequestMapping(value = "/user")
public class UserController extends BaseController {

	private static final String PTGL = "平台管理";

	@Resource(name = "userService")
	private UserManager userService;
	@Resource(name = "roleService")
	private RoleManager roleService;
	@Resource(name = "menuService")
	private MenuManager menuService;
	@Resource(name = "schoolService")
	private SchoolService schoolService;
	@Resource(name = "redisCacheUtil")
	private RedisCacheUtil redisCacheUtil;

	/**
	 * 显示用户列表
	 */
	@RequestMapping(value = "/listUsers")
	public ModelAndView listUsers(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		User userInfo = getUserInfo();
		try {
			pd.put("type", "1");
			String status = pd.getString("status");
			if ("".equals(status) || null == status) {
				status = "0";
			}
			String schoolIds = getUserInfo().getSchoolId() + ",";
			// 查询当前用户旗下学校或分校、教学点
			List<PageData> listSubSchools = this.schoolService.listSubSchools(getUserInfo().getSchoolId());
			if (null != listSubSchools && listSubSchools.size() > 0) {
				for (PageData pda : listSubSchools) {
					schoolIds += pda.getString("id") + ",";
				}
			}
			pd.put("schoolIds", schoolIds.split(","));
			pd.put("status", status);
			pd.put("userId", getUserInfo().getUSER_ID());
			page.setPd(pd);
			List<PageData> userList = userService.listUsers(page); // 列出用户列表
			mv.addObject("userList", userList);
			mv.addObject("pd", pd);
			mv.addObject("userName", userInfo.getUSERNAME());
			mv.setViewName("system/user/user_list");
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "用户列表异常"));
		}
		return mv;
	}

	/**
	 * 去新增用户页面
	 */
	@RequestMapping(value = "/goAddU")
	public ModelAndView goAddU(Model model) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			String roleRights = "";
			String username = getUserInfo().getUSERNAME();
			List<Menu> menuList = menuService.listRoleMenuQx("0", null); // 获取所有菜单
			menuList = this.readMenu(menuList, roleRights, username); // 根据角色权限处理菜单权限状态(递归处理)
			JSONArray arr = JSONArray.fromObject(menuList);
			String json = arr.toString();
			json = json.replaceAll("MENU_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("MENU_NAME", "title").replaceAll("subMenu", "children").replaceAll("hasMenu", "isChecked");
			model.addAttribute("zTreeNodes", json);

			mv.addObject("msg", "saveU");
			mv.addObject("pd", pd);
			mv.addObject("isAdmin", "admin".equals(username) ? true : false);
			mv.setViewName("system/user/user_edit");
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "打开用户新增页面异常!"));
		}
		return mv;
	}

	/**
	 * 保存用户
	 */
	@RequestMapping(value = "/saveU", method = RequestMethod.POST)
	@ResponseBody
	public Object saveU() {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = getPageData();
		String msg = "";
		try {
			pd.put("USER_ID", this.get32UUID()); // ID 主键
			pd.put("STATUS", "0");
			pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), pd.getString("PASSWORD")).toString()); // 密码加密
			if (null == userService.findByUsername(pd)) { // 判断用户名是否存在
				// 保存用户
				String ROLE_ID = this.get32UUID(); // 角色id
				String menuIds = pd.getString("menuIds");
				pd.put("ROLE_ID", ROLE_ID + ",");
				userService.saveU(pd); // 执行保存

				// 新增用户对应的角色
				String username = pd.getString("USERNAME"); // 获取新增的用户名
				pd.clear();
				pd.put("ROLE_NAME", username); // 将用户名作为角色名称
				pd.put("RIGHTS", ""); // 菜单权限
				pd.put("PARENT_ID", "1");
				pd.put("ROLE_ID", ROLE_ID); // 主键
				pd.put("ADD_QX", "0"); // 初始新增权限为否
				pd.put("DEL_QX", "0"); // 删除权限
				pd.put("EDIT_QX", "0"); // 修改权限
				pd.put("CHA_QX", "0"); // 查看权限
				roleService.add(pd); // 新增用户角色

				// 给新增的用户角色添加权限
				roleService.addRolePermission(ROLE_ID, menuIds);
				msg = "success";
			} else {
				msg = "fail";
			}
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "保存用户异常!"));
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 去修改用户页面
	 */
	@RequestMapping(value = "/goEditU")
	public ModelAndView goEditU(Model model) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			String TYPE = pd.getString("TYPE");
			String currentPage = pd.getString("currentPage");
			pd = userService.findById(pd); // 根据ID读取
			pd.put("currentPage", currentPage);
			pd.put("TYPE", TYPE);

			// 获取用户角色对应的权限
			String roleId = pd.getString("ROLE_ID");
			String username = getUserInfo().getUSERNAME();
			roleId = roleId.substring(0, roleId.indexOf(","));
			Role role = roleService.getRoleById(roleId); // 根据角色ID获取角色对象
			String roleRights = role.getRIGHTS(); // 取出本角色菜单权限
			List<Menu> menuList = menuService.listRoleMenuQx("0", roleId); // 获取所有菜单
			menuList = this.readMenu(menuList, roleRights, username); // 根据角色权限处理菜单权限状态(递归处理)
			JSONArray arr = JSONArray.fromObject(menuList);
			String json = arr.toString();
			json = json.replaceAll("MENU_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("MENU_NAME", "title").replaceAll("subMenu", "children").replaceAll("hasMenu", "isChecked");
			model.addAttribute("zTreeNodes", json);

			mv.addObject("ROLE_ID", roleId);
			mv.addObject("msg", "editU");
			mv.addObject("pd", pd);
			mv.addObject("isAdmin", "admin".equals(username) ? true : false);
			mv.setViewName("system/user/user_edit");
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "去修改用户页面异常!"));
		}
		return mv;
	}

	/**
	 * 修改用户
	 */
	@RequestMapping(value = "/editU", method = RequestMethod.POST)
	@ResponseBody
	public Object editU() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = getPageData();
		String msg = "";
		try {
			if (pd.getString("PASSWORD") != null && !"".equals(pd.getString("PASSWORD"))) {
				pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), pd.getString("PASSWORD")).toString());
			}

			String menuIds = pd.getString("menuIds"); // 权限菜单id

			Map roleMap = new HashMap<String, String>();
			String oldRoleId = pd.getString("ROLE_ID");
			if (StringUtils.isNotBlank(oldRoleId)) {
				oldRoleId = oldRoleId.substring(0, oldRoleId.indexOf(","));
				roleMap.put("ROLE_ID", oldRoleId);
				// 删除原来的角色和对应权限
				roleService.deleteRolePermission(roleMap);

				// 删除用户对应角色
				roleService.deleteRoleById(oldRoleId);
			}

			// 修改
			String roleId = this.get32UUID(); // 角色id
			pd.put("ROLE_ID", roleId + ",");
			userService.editU(pd); // 执行修改

			// 用户对应的角色
			String username = pd.getString("USERNAME"); // 获取新增的用户名
			pd.clear();
			pd.put("ROLE_NAME", username); // 将用户名作为角色名称
			pd.put("RIGHTS", ""); // 菜单权限
			pd.put("PARENT_ID", "1");
			pd.put("ROLE_ID", roleId); // 主键
			pd.put("ADD_QX", "0"); // 初始新增权限为否
			pd.put("DEL_QX", "0"); // 删除权限
			pd.put("EDIT_QX", "0"); // 修改权限
			pd.put("CHA_QX", "0"); // 查看权限
			roleService.add(pd); // 新增用户角色

			// 给用户角色添加权限
			roleService.addRolePermission(roleId, menuIds);

			msg = "success";
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "修改用户异常"));
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 删除用户
	 */
	@RequestMapping(value = "/deleteU")
	@ResponseBody
	public Object delete() {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = getPageData();
		String resultInfo = "";
		try {
			Map roleMap = new HashMap<String, String>();
			String roleId = pd.getString("ROLE_ID");
			if (StringUtils.isNotBlank(roleId)) {
				roleId = roleId.substring(0, roleId.indexOf(","));
				roleMap.put("ROLE_ID", roleId);
				// 删除角色权限表对应数据
				roleService.deleteRolePermission(roleMap);

				// 删除用户对应角色
				roleService.deleteRoleById(roleId);
			}

			// 删除用户
			userService.deleteU(pd);
			resultInfo = "success";
		} catch (Exception e) {
			resultInfo = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "删除用户异常!"));
		}
		map.put("result", resultInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 判断用户名是否存在
	 * 
	 * @return
	 */
	@RequestMapping(value = "/checkUserName")
	@ResponseBody
	public Object checkUserName() {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "";
		PageData pd = getPageData();
		try {
			if (userService.findByUsername(pd) == null) {
				msg = "no";
			} else {
				msg = "yes";
			}
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "判断用户名是否存在异常!"));
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 去修改用户密码页面
	 */
	@RequestMapping(value = "/goEditPassWord")
	public ModelAndView goEditPassWord() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		try {
			pd = userService.findById(pd);
			mv.addObject("msg", "editPassWord");
			mv.addObject("pd", pd);
			mv.setViewName("system/user/user_password");
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "去修改用户密码页面异常!"));
		}
		return mv;
	}

	/**
	 * 修改用户密码
	 */
	@RequestMapping(value = "/editPassWord", method = RequestMethod.POST)
	@ResponseBody
	public Object editPassWord() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = getPageData();
		String msg = "";
		try {
			String NEW_PASSWORD = pd.getString("NEW_PASSWORD").trim();
			String USERNAME = pd.getString("USERNAME").trim();
			// 密码加密
			String PASSWORD = new SimpleHash("SHA-1", USERNAME, pd.getString("PASSWORD").trim()).toString();
			pd.put("USERNAME", USERNAME);
			pd.put("PASSWORD", PASSWORD);
			// 根据用户名和密码去读取用户信息
			pd = userService.getUserByNameAndPwd(pd);
			if (pd != null) {
				// 新密码加密
				String NEW_PWD = new SimpleHash("SHA-1", USERNAME, NEW_PASSWORD).toString();
				pd.put("NEW_PWD", NEW_PWD);
				// 执行修改
				userService.editPassWord(pd);
				msg = "success";
			} else {
				msg = "fail";
			}
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "修改用户密码异常"));
		}
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 修改用户状态
	 */
	@RequestMapping(value = "/updateStatus")
	@ResponseBody
	public Object updateStatus() {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = getPageData();
		String resultInfo = "";
		try {
			userService.updateStatus(pd);
			resultInfo = "success";
		} catch (Exception e) {
			resultInfo = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "修改用户状态异常!"));
		}
		map.put("result", resultInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 查询内设机构或者角色
	 */
	@RequestMapping(value = "/listSectionOrRoles")
	@ResponseBody
	public Object listSectionOrRoles() {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = getPageData();
		JSONArray arr = null;
		String json = "";
		try {
			User userInfo = getUserInfo();
			String TYPE = pd.getString("TYPE");
			// String optType = pd.getString("optType");
			if ("1".equals(TYPE)) {
				// // 内设机构
				// pd.put("type", "1");// 默认不查询外部单位
				// if ("admin".equals(userInfo.getUSER_ID())) {
				// // 查询所有内设机构
				// pd.put("depId", "");
				// arr =
				// JSONArray.fromObject(sectionService.listSectionByDep(pd));
				// } else {
				// // 根据机构查询内设机构
				// String areaCode = userInfo.getAreaCode();
				// String userLevel = userInfo.getUserLevel();
				// // 如果是区县及以上人员，只能增加自己所在层级内部人员信息
				// // if (!"3".equals(userLevel) && !"4".equals(userLevel)) {
				// //
				// // } else
				// if ("3".equals(userInfo.getUserLevel())) {
				// areaCode = areaCode.substring(0, areaCode.length() - 3);
				// } else {
				// areaCode = userInfo.getAreaCode().length() == 12 ?
				// (AreaCodeUtils.returnXzqh(userInfo.getAreaCode())) :
				// userInfo.getAreaCode();
				// }
				// pd.put("areaCode", areaCode);
				// List<Section> departMentList =
				// this.sectionService.findByAreaCodeName(pd);
				// pd.put("depId", userInfo.getDEP_ID());
				// arr = JSONArray.fromObject(departMentList);
				// }
				// json = arr.toString();
				// json = json.replaceAll("SECTION_ID", "id").replaceAll("NAME",
				// "title");
			} else {
				List<String> liststr = new ArrayList<String>();
				// 根据用户层级查询所属角色
				pd.put("ROLE_ID", "1");
				// 系统管理员除外
				// if (!"admin".equals(userInfo.getUSERNAME()) &&
				// !"2".equals(userInfo.getUserLevel()) &&
				// !"1".equals(userInfo.getUserLevel())) {
				// liststr.add(userInfo.getUserLevel());
				// }
				if ("admin".equals(userInfo.getUSERNAME()) || "0".equals(userInfo.getUserLevel())) {
					liststr.add("0");
					liststr.add("1");
					liststr.add("2");
					liststr.add("3");
					liststr.add("4");
				}
				// 区县级人员可以查看乡镇、街道、村、社区下面所有角色
				if ("1".equals(userInfo.getUserLevel())) {
					liststr.add("1");
					liststr.add("2");
					// liststr.add("3");
					// liststr.add("4");
				} else if ("2".equals(userInfo.getUserLevel())) {
					// liststr.add("2");
					liststr.add("3");
					liststr.add("4");
				} else if ("3".equals(userInfo.getUserLevel())) {
					liststr.add("3");
					liststr.add("4");
				} else {
					liststr.add(userInfo.getUserLevel());
				}
				pd.put("list", liststr);
				// 列出所有系统角色
				List<Role> listAllRolesByPId = roleService.listAllRolesByPIdLevel(pd);
				String str = "";
				for (Role role : listAllRolesByPId) {
					if ("0".equals(role.getRoleLevel())) {
						str = "省";
					} else if ("1".equals(role.getRoleLevel())) {
						str = "市、洲";
					} else if ("2".equals(role.getRoleLevel())) {
						str = "区、县";
					} else if ("3".equals(role.getRoleLevel())) {
						str = "乡镇、街道办";
					} else if ("4".equals(role.getRoleLevel())) {
						str = "村、社区";
					}
					role.setROLE_NAME(role.getROLE_NAME() + "（" + str + "）");
				}
				arr = JSONArray.fromObject(listAllRolesByPId);

				json = arr.toString();
				json = json.replaceAll("ROLE_ID", "id").replaceAll("ROLE_NAME", "title");
			}
			map.put("data", json);
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "显示列表ztree异常"));
		}
		return map;
	}

	/**
	 * 根据角色权限处理权限状态(递归处理)
	 * 
	 * @param menuList
	 *            ：传入的总菜单
	 * @param roleRights
	 *            ：加密的权限字符串
	 * @return
	 */
	private List<Menu> readMenu(List<Menu> menuList, String roleRights, String username) throws Exception {

		for (int i = 0; i < menuList.size(); i++) {
			String menuName = menuList.get(i).getMENU_NAME();
			// 如果用户名不是admin,平台管理的菜单就不需要,直接跳过本次循环
			if (!"admin".equals(username) && PTGL.equals(menuName)){
				menuList.remove(i);
				continue;
			}

			// 最末层菜单,菜单对应的权限
			if ("endFrame".equals(menuList.get(i).getTarget())) {
				if ("0".equals(menuList.get(i).getMENU_STATE())) {
					menuList.get(i).setHasMenu(false);
				} else {
					menuList.get(i).setHasMenu(true);
				}
			} else {
				menuList.get(i).setHasMenu(RightsHelper.testRights(roleRights, menuList.get(i).getMENU_ID()));
				this.readMenu(menuList.get(i).getSubMenu(), roleRights, username); // 是：继续排查其子菜单
			}
		}
		return menuList;
	}

	/**
	 * 去密码找回页面
	 * 
	 * @param
	 */
	@RequestMapping(value = "/goPasswordBack")
	public ModelAndView goPasswordBack() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("pd", pd); // 放入视图容器
		mv.setViewName("system/user/user_password_reset");
		mv.addObject("msg", "getPwdbyUserName");
		return mv;
	}

	/**
	 * 通过用户名找回密码
	 * 
	 * @return
	 */
	@RequestMapping(value = "/validateUserName")
	@ResponseBody
	public Object validateUserName() {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "success";
		PageData pd = getPageData();
		String timestamp = String.valueOf(System.currentTimeMillis());
		try {
			// 判断系统是否存在此账号信息
			PageData findByUN = this.userService.findByUsername(pd);
			if (null == findByUN || findByUN.size() <= 0) {
				msg = "noneUsers";
			} else {
				int code = this.userService.validateUserName(pd);
				redisCacheUtil.setCacheObject(timestamp, code);
			}
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "通过用户名获取账号信息异常!"));
		}
		map.put("timestamp", timestamp);
		map.put("result", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 重置密码
	 */
	@RequestMapping(value = "/resetPwd")
	@ResponseBody
	public Object resetPwd() {
		PageData pd = getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		String msg = "success";
		try {
			// 获取session验证码比对
			String code = redisCacheUtil.getCacheObject(pd.getString("timestamp")).toString();
			Long s = (System.currentTimeMillis() - Long.valueOf(pd.getString("timestamp")).longValue()) / (1000 * 60);
			if (!pd.getString("code").equals(code)) {
				// 验证码不对
				msg = "codeError";
			} else if (s > 5) {
				// 验证码超过5分钟
				msg = "codeTimeOut";
			} else {
				// 密码重置
				String userName = pd.getString("USERNAME").trim();
				// 新密码加密
				String newPassword = new SimpleHash("SHA-1", userName, pd.getString("NEW_PASSWORD").trim()).toString();
				pd.put("NEW_PWD", newPassword);
				// 执行修改
				userService.editPassWord(pd);
			}
			pd = userService.findById(pd);
			map.put("msg", msg);
			map.put("pd", pd);
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "重置密码异常!"));
		}
		return map;
	}

}
