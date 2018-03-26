package com.zhimu.shiro;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Permission;
import com.zhimu.dao.entity.system.Role;
import com.zhimu.dao.entity.system.User;
import com.zhimu.service.manager.system.permission.PermissionManager;
import com.zhimu.service.manager.system.role.RoleManager;
import com.zhimu.service.manager.system.user.UserManager;

/**
 * shiro权限控制访问
 * 
 * @author Weiyunchao
 *
 *         2017年7月10日下午1:40:49
 */
public class ShiroRealm extends AuthorizingRealm {
	
	public Logger logger = Logger.getLogger(this.getClass());
	@Resource(name = "userService")
	private UserManager userService;
	@Resource(name = "roleService")
	private RoleManager roleManager;
	@Resource(name = "permissionService")
	private PermissionManager permissionManager;
	
	/*
	 * 登录信息和用户验证信息验证(non-Javadoc)
	 * 
	 * @see
	 * org.apache.shiro.realm.AuthenticatingRealm#doGetAuthenticationInfo(org.
	 * apache.shiro.authc.AuthenticationToken)
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String username = (String) token.getPrincipal(); // 得到用户名
		String password = new String((char[]) token.getCredentials()); // 得到密码
		if (null != username && null != password) {
			return new SimpleAuthenticationInfo(username, password.toCharArray(), getName());
		} else {
			return null;
		}
	}
	
	/*
	 * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用,负责在应用程序中决定用户的访问控制的方法(non-Javadoc)
	 * 
	 * @see
	 * org.apache.shiro.realm.AuthorizingRealm#doGetAuthorizationInfo(org.apache.
	 * shiro.subject.PrincipalCollection)
	 */
	@SuppressWarnings("unused")
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		String currentUsername = (String) super.getAvailablePrincipal(principals);
		PageData pageData = new PageData();
		try {
			pageData.put("USERNAME", currentUsername);
			pageData = userService.findByUsername(pageData);
			User user = new User();
			user.setROLE_ID(pageData.getString("ROLE_ID"));
			List<String> roles = new ArrayList<String>();
			Set<String> permissions = new LinkedHashSet<String>();
			if (null != user) {
				//一个用户可能包含多个角色，单个不影响
				String[] role_ids = pageData.getString("ROLE_ID").split(",");
				for (int i = 0; i < role_ids.length; i++) {
					Role role = roleManager.getRoleById(role_ids[i]);
					roles.add(role.getROLE_NAME());
					List<Permission> list = permissionManager.listAllPermissionByRoleId(role_ids[i]);
					if (null != list && !list.isEmpty()) {
						for (Permission permission : list) {
							permissions.add(permission.getSign());
						}
					}
				}
			} else {
				throw new AuthorizationException();
			}
			SimpleAuthorizationInfo simpleAuthorInfo = new SimpleAuthorizationInfo();
			simpleAuthorInfo.addRoles(roles);
			simpleAuthorInfo.addStringPermissions(permissions);
			return simpleAuthorInfo;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("查询角色权限出现错误", e);
		}
		
		return null;
	}
	
}
