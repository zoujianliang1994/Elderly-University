package com.zhimu.controller.manager.system.login;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.constant.Const;
import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.HttpUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.PropertyUtils;
import com.zhimu.commons.utils.Tools;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Menu;
import com.zhimu.dao.entity.system.Role;
import com.zhimu.dao.entity.system.User;
import com.zhimu.dao.utils.Jurisdiction;
import com.zhimu.service.manager.edu.school.SchoolService;
import com.zhimu.service.manager.message.MessageManager;
import com.zhimu.service.manager.system.menu.MenuManager;
import com.zhimu.service.manager.system.personalpanel.PersonalPanelService;
import com.zhimu.service.manager.system.role.RoleManager;
import com.zhimu.service.manager.system.user.UserManager;

/**
 * 登录业务控制
 * 
 * @author Weiyunchao
 * 
 *         2017年7月3日下午2:11:58
 */
@Controller
public class LoginController extends BaseController {

	@Resource(name = "userService")
	private UserManager userService;
	@Resource(name = "menuService")
	private MenuManager menuService;
	@Resource(name = "roleService")
	private RoleManager roleService;
	@Resource(name = "messageService")
	private MessageManager messageService;
	@Resource(name = "personalPanelService")
	private PersonalPanelService personalPanelService;
	@Resource(name = "schoolService")
	private SchoolService schoolService;

	/**
	 * 访问欢迎页
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login_guide")
	public Object toGuide() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		mv.addObject("basePath", HttpUtils.getBasePath(this.getRequest()));
		mv.setViewName("system/index/guide");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 访问登录页
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login_toLogin")
	@ResponseBody
	public ModelAndView toLogin() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		// mv.setViewName("redirect:system/index/login");
		mv.addObject("basePath", HttpUtils.getBasePath(this.getRequest()));
		mv.addObject("pd", pd);
		mv.setViewName("system/index/login");
		return mv;
	}

	/**
	 * 访问功能模块页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/to_module")
	@ResponseBody
	public ModelAndView toModule() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String areaCode = pd.getString("areaCode");
		String menuId = pd.getString("menuId");
		// 业务模块列表页面
		String modulUrl = "";
		// 业务模块对应菜单
		JSONArray array = new JSONArray();
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER); // 读取session中的用户信息(单独用户信息)
		if (user != null) {
			String pid = user.getpId();
			User userr = (User) session.getAttribute(Const.SESSION_USERROL); // 读取session中的用户信息(含角色信息)
			if (null == userr) {
				user = userService.getUserAndRoleById(user.getUSER_ID()); // 通过用户ID读取用户信息和角色信息
				user.setpId(pid);
				session.setAttribute(Const.SESSION_USERROL, user); // 存入session
			} else {
				userr.setpId(user.getpId());
				user = userr;
			}
			// session获取菜单集合
			List<Menu> menuList = getMenuList(session, user, "index");
			// 组装菜单树
			array = getMenus2(areaCode, user.getUSERNAME(), menuList, new JSONArray(), menuId);
			// String[] roleIds = user.getROLE_ID().split(",");
			// if
			// (Arrays.asList(roleIds).contains(PropertyUtils.getValue("SYS_MAP_ROLE")))
			// {
			// // 如果拥有地图角色的用户可以查看地图页面
			// hasMap = true;
			// }
		}
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		// 获取用户未读消息数
		int num = this.personalPanelService.getTotalMsgNum(user);
		// mv.setViewName("redirect:system/index/login");
		// 查看标记为0未读的推送消息推送
		pd.put("USER_ID", user.getUSER_ID());
		List<PageData> messageList = messageService.findByUserId(pd);
		mv.addObject("waitApproverCount", messageList == null ? 0 : messageList.size());// 待处理信息
		JSONArray jsonmap = JSONArray.fromObject(messageList);
		mv.addObject("waitApproverMsg", jsonmap);
		mv.addObject("msgUrl", PropertyUtils.getValue("MESSAGE_URL") + user.getUSERNAME());

		mv.addObject("num", num);
		mv.addObject("pd", pd);
		mv.addObject("menuId", menuId);
		mv.addObject("user", user);
		mv.addObject("hasMap", false);
		mv.addObject("modulUrl", modulUrl);
		mv.addObject("menuList", array);
		mv.setViewName("system/index/index");
		mv.addObject("basePath", HttpUtils.getBasePath(this.getRequest()));
		return mv;
	}

	/**
	 * 请求登录，验证用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login_login", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Object login() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "";
		String KEYDATA[] = pd.getString("KEYDATA").split(",fh,");
		if (null != KEYDATA && KEYDATA.length == 2) {
			Session session = Jurisdiction.getSession();
			String USERNAME = KEYDATA[0]; // 登录过来的用户名
			String PASSWORD = KEYDATA[1]; // 登录过来的密码
			pd.put("USERNAME", USERNAME);
			String passwd = new SimpleHash("SHA-1", USERNAME, PASSWORD).toString(); // 密码加密
			pd.put("PASSWORD", passwd);
			pd = userService.getUserByNameAndPwd(pd); // 根据用户名和密码去读取用户信息
			if (pd != null) {
				pd.put("LAST_LOGIN", DateUtil.getTime().toString());
				userService.updateLastLogin(pd);
				User user = new User();
				user.setSchoolId(pd.getString("SCHOOL_ID"));
				user.setSchoolName(pd.getString("SCHOOL_NAME"));
				user.setUSER_ID(pd.getString("USER_ID"));
				user.setUSERNAME(pd.getString("USERNAME"));
				user.setPASSWORD(pd.getString("PASSWORD"));
				user.setNAME(pd.getString("NAME"));
				user.setRIGHTS(pd.getString("RIGHTS"));
				user.setROLE_ID(pd.getString("ROLE_ID"));
				user.setSEX(pd.getString("SEX"));
				user.setLAST_LOGIN(pd.getString("LAST_LOGIN"));
				user.setIP(pd.getString("IP"));
				user.setSTATUS(pd.getString("STATUS"));
				user.setIS_PARTY(pd.getString("IS_PARTY"));
				user.setRD_DATE(pd.get("RD_DATE") + "");
				user.setROLENAME(pd.getString("ROLENAME"));
				user.setPICTURES_PATH(pd.getString("PICTURES_PATH"));
				user.setpId(pd.getString("pId"));
				session.setAttribute(Const.SESSION_USER, user); // 把用户信息放session中
				session.removeAttribute(Const.SESSION_SECURITY_CODE); // 清除登录验证码的session
				// shiro加入身份验证
				Subject subject = SecurityUtils.getSubject();
				UsernamePasswordToken token = new UsernamePasswordToken(USERNAME, PASSWORD);
				try {
					subject.login(token);
				} catch (AuthenticationException e) {
					errInfo = "身份验证失败！";
					logger.error(ErrorUtils.getErrorMessage(e, "登录"));
				}
			} else {
				errInfo = "usererror"; // 用户名或密码有误
			}
			if (Tools.isEmpty(errInfo)) {
				errInfo = "success"; // 验证成功
			}
		} else {
			errInfo = "error"; // 缺少参数
		}
		map.put("result", errInfo);
		map.put("basePath", HttpUtils.getBasePath(this.getRequest()));
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 手机APP请求登录，验证用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login_app", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Object login_app(HttpServletRequest request) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "";
		String KEYDATA[] = pd.getString("KEYDATA").split(",fh,");
		if (null != KEYDATA && KEYDATA.length == 2) {
			Session session = Jurisdiction.getSession();
			String USERNAME = KEYDATA[0]; // 登录过来的用户名
			String PASSWORD = KEYDATA[1]; // 登录过来的密码
			pd.put("USERNAME", USERNAME);
			String passwd = new SimpleHash("SHA-1", USERNAME, PASSWORD).toString(); // 密码加密
			pd.put("PASSWORD", passwd);
			pd = userService.getUserByNameAndPwd(pd); // 根据用户名和密码去读取用户信息
			if (pd != null) {
				pd.put("LAST_LOGIN", DateUtil.getTime().toString());
				userService.updateLastLogin(pd);
				User user = new User();
				user.setUSER_ID(pd.getString("USER_ID"));
				user.setUSERNAME(pd.getString("USERNAME"));
				user.setPASSWORD(pd.getString("PASSWORD"));
				user.setNAME(pd.getString("NAME"));
				user.setRIGHTS(pd.getString("RIGHTS"));
				user.setROLE_ID(pd.getString("ROLE_ID"));
				user.setLAST_LOGIN(pd.getString("LAST_LOGIN"));
				user.setIP(pd.getString("IP"));
				user.setSTATUS(pd.getString("STATUS"));
				user.setIS_PARTY(pd.getString("IS_PARTY"));
				user.setRD_DATE(pd.get("RD_DATE") + "");
				user.setROLENAME(pd.getString("ROLENAME"));
				user.setPICTURES_PATH(pd.getString("PICTURES_PATH"));
				user.setpId(pd.getString("pId"));
				session.setAttribute(Const.SESSION_USER, user); // 把用户信息放session中
				session.removeAttribute(Const.SESSION_SECURITY_CODE); // 清除登录验证码的session
				// shiro加入身份验证
				Subject subject = SecurityUtils.getSubject();
				UsernamePasswordToken token = new UsernamePasswordToken(USERNAME, PASSWORD);
				try {
					subject.login(token);
				} catch (AuthenticationException e) {
					errInfo = "身份验证失败！";
					logger.error(ErrorUtils.getErrorMessage(e, "登录"));
				}
				map.put("userName", user.getUSERNAME());
				map.put("name", user.getNAME());
			} else {
				errInfo = "usererror"; // 用户名或密码有误
			}
			if (Tools.isEmpty(errInfo)) {
				errInfo = "success"; // 验证成功
			}
		} else {
			errInfo = "error"; // 缺少参数
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * session获取菜单
	 * 
	 * @param session
	 * @param user
	 * @param changeMenu
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Menu> getMenuList(Session session, User user, String changeMenu) throws Exception {
		List<Menu> allmenuList = new ArrayList<Menu>();
		List<Menu> menuList = new ArrayList<Menu>();
		if (user != null) {
			String userName = user.getUSERNAME();
			String[] role_id = user.getROLE_ID().substring(0, user.getROLE_ID().length() - 1).split(",");// 获取用户角色Id
			// String[] role_id = user.getROLE_ID().split(",");// 获取用户角色Id
			String rights = "";
			List<Role> roleList = userService.findByAllRolePermisson(role_id);
			if (null != session.getAttribute(userName + Const.SESSION_allmenuList)) {
				allmenuList = (List<Menu>) session.getAttribute(userName + Const.SESSION_allmenuList);
			} else {
				allmenuList = menuService.listAllMenuQx("0"); // 获取所有菜单
				for (Role r : roleList) {
					rights += r.getRIGHTS() + ",";
				}
				if (StringUtils.isNotEmpty(rights)) {
					rights = rights.substring(0, rights.length() - 1);
				}
				allmenuList = returnMenuList(rights);
				session.setAttribute(userName + Const.SESSION_allmenuList, allmenuList);// 菜单权限放入session中
				session.setAttribute(userName + Const.SESSION_ROLE_RIGHTS, rights); // 将角色权限存入session
			}
			session.setAttribute(Const.SESSION_USERNAME, userName); // 放入用户名到session
			// 切换菜单处理=====start

			if (null == session.getAttribute(userName + Const.SESSION_menuList) || ("yes".equals(changeMenu))) {
				List<Menu> menuList1 = new ArrayList<Menu>();
				List<Menu> menuList2 = new ArrayList<Menu>();
				// 拆分菜单
				for (int i = 0; i < allmenuList.size(); i++) {
					Menu menu = allmenuList.get(i);
					if ("1".equals(menu.getMENU_TYPE())) {
						menuList1.add(menu);
					} else {
						menuList2.add(menu);
					}
				}
				session.removeAttribute(userName + Const.SESSION_menuList);
				if ("2".equals(session.getAttribute("changeMenu"))) {
					session.setAttribute(userName + Const.SESSION_menuList, menuList1);
					session.removeAttribute("changeMenu");
					session.setAttribute("changeMenu", "1");
					menuList = menuList1;
				} else {
					session.setAttribute(userName + Const.SESSION_menuList, menuList2);
					session.removeAttribute("changeMenu");
					session.setAttribute("changeMenu", "2");
					menuList = menuList2;
				}
			} else {
				menuList = (List<Menu>) session.getAttribute(userName + Const.SESSION_menuList);
			}
		}

		return menuList;
	}

	/**
	 * 递归获取菜单树
	 * 
	 * @param userName
	 * @param menuList
	 * @param array
	 * @return
	 */
	public static JSONArray getMenus(String userName, List<Menu> menuList, JSONArray array) {

		if (null != menuList && menuList.size() > 0 && StringUtils.isNotEmpty(userName)) {

			for (int i = 0; i < menuList.size(); i++) {
				// 运维管理员只拥有系统管理菜单权限
				if (userName.equals(PropertyUtils.getValue("SYS_SUPER_USERNAME"))) {
					String sysMenuId = PropertyUtils.getValue("SYS_MENU_ID");
					if (menuList.get(i).getMENU_ID().equals(sysMenuId) || menuList.get(i).getPARENT_ID().equals(sysMenuId)) {

					} else {
						continue;
					}
				}
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", menuList.get(i).getMENU_ID());
				map.put("title", menuList.get(i).getMENU_NAME());
				map.put("lev", (i + 1));
				map.put("url", menuList.get(i).getMENU_URL());
				map.put("pid", menuList.get(i).getPARENT_ID());
				map.put("icon", menuList.get(i).getMENU_ICON());
				map.put("order", menuList.get(i).getMENU_ORDER());
				map.put("type", menuList.get(i).getMENU_TYPE());
				map.put("state", menuList.get(i).getMENU_STATE());
				if ("0".equals(menuList.get(i).getMENU_STATE())) {
					continue;
				}
				map.put("children", getMenus(userName, menuList.get(i).getSubMenu(), new JSONArray()));
				array.add(map);
			}
		}

		return array;
	}

	/**
	 * 递归获取菜单树2
	 * 
	 * @param userName
	 * @param menuList
	 * @param array
	 * @return
	 */
	public static JSONArray getMenus2(String areaCode, String userName, List<Menu> menuList, JSONArray array, String pid) {

		if (null != menuList && menuList.size() > 0) {

			for (int i = 0; i < menuList.size(); i++) {
				if (StringUtils.isNotEmpty(pid) && (menuList.get(i).getMENU_ID().equals(pid) || menuList.get(i).getPARENT_ID().equals(pid))) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("id", menuList.get(i).getMENU_ID());
					map.put("title", menuList.get(i).getMENU_NAME());
					map.put("lev", (i + 1));
					String url = menuList.get(i).getMENU_URL();
					// 如果url包含区划条件，替换变量
					if (url.indexOf("xzqh") != -1) {
						url = url.replaceAll("xzqh=", "xzqh=" + areaCode);
					}
					map.put("url", url);
					map.put("pid", menuList.get(i).getPARENT_ID());
					map.put("icon", menuList.get(i).getMENU_ICON());
					map.put("order", menuList.get(i).getMENU_ORDER());
					map.put("type", menuList.get(i).getMENU_TYPE());
					map.put("state", menuList.get(i).getMENU_STATE());
					if ("0".equals(menuList.get(i).getMENU_STATE())) {
						continue;
					}
					map.put("children", getMenus2(areaCode, userName, menuList.get(i).getSubMenu(), new JSONArray(), menuList.get(i).getMENU_ID()));
					array.add(map);
				}
			}
		}

		return array;
	}

	/**
	 * 用户注销
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/logout")
	public ModelAndView logout() {
		String USERNAME = Jurisdiction.getUsername(); // 当前登录的用户名
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		Session session = Jurisdiction.getSession(); // 以下清除session缓存
		session.removeAttribute(Const.SESSION_USER);
		session.removeAttribute(USERNAME + Const.SESSION_ROLE_RIGHTS);
		session.removeAttribute(USERNAME + Const.SESSION_allmenuList);
		session.removeAttribute(USERNAME + Const.SESSION_menuList);
		session.removeAttribute(USERNAME + Const.SESSION_QX);
		session.removeAttribute(Const.SESSION_userpds);
		session.removeAttribute(Const.SESSION_USERNAME);
		session.removeAttribute(Const.SESSION_USERROL);
		session.removeAttribute("changeMenu");
		// shiro销毁登录
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		pd = this.getPageData();
		pd.put("msg", pd.getString("msg"));
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		mv.setViewName("system/index/login");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 更新登录用户的IP
	 * 
	 * @param USERNAME
	 * @throws Exception
	 */
	public void getRemortIP(String USERNAME) throws Exception {
		PageData pd = new PageData();
		HttpServletRequest request = this.getRequest();
		String ip = "";
		if (request.getHeader("x-forwarded-for") == null) {
			ip = request.getRemoteAddr();
		} else {
			ip = request.getHeader("x-forwarded-for");
		}
		pd.put("USERNAME", USERNAME);
		pd.put("IP", ip);
		userService.saveIP(pd);
	}

	/**
	 * 请求百度接口获取身份证识别token
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/getBaiduToken")
	@ResponseBody
	public Object getBaiduToken() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", "");
		map.put("res", false);
		String apiKey = PropertyUtils.getValue("APP_BAIDU_APIKEY");
		String apiSecretKey = PropertyUtils.getValue("APP_Secret_KEY");
		try {
			String token = HttpUtils.httpRequest("https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=" + apiKey + "&client_secret=" + apiSecretKey, "POST", null);
			JSONObject t = JSONObject.fromObject(token); //
			map.put("data", t.getString("access_token"));
			map.put("res", true);
		} catch (Exception e) {

		}
		return map;
	}

	/**
	 * 访问ie下载页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/to_iedownload")
	@ResponseBody
	public ModelAndView to_IeDownLoad() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String areaCode = pd.getString("areaCode");
		// 业务模块对应菜单
		mv.addObject("pd", pd);
		mv.addObject("areaCode", areaCode);
		mv.addObject("user", getUserInfo());
		mv.setViewName("system/index/ieDownLoad");
		mv.addObject("basePath", HttpUtils.getBasePath(this.getRequest()));
		mv.addObject("ie64Path", HttpUtils.getBasePath(this.getRequest()) + "/uploadFiles/file/IE11-Windows6.1-x64-zh-cn.exe");
		mv.addObject("ie32Path", HttpUtils.getBasePath(this.getRequest()) + "/uploadFiles/file/EIE11_ZH-CN_MCM_WIN7.EXE");
		return mv;
	}

}
