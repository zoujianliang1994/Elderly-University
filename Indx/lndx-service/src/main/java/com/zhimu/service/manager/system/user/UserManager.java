package com.zhimu.service.manager.system.user;

import java.util.List;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.Role;
import com.zhimu.dao.entity.system.User;

/**
 * 用户接口类
 * 
 * @author wy 修改时间：2017.11.2
 */
public interface UserManager {

	/**
	 * 登录判断
	 */
	PageData getUserByNameAndPwd(PageData pd) throws Exception;

	/**
	 * 更新登录时间
	 */
	void updateLastLogin(PageData pd) throws Exception;

	/**
	 * 通过用户ID获取用户信息和角色信息
	 */
	User getUserAndRoleById(String USER_ID) throws Exception;

	/**
	 * 通过USERNAEME获取数据
	 */
	PageData findByUsername(PageData pd) throws Exception;

	/**
	 * 列出某角色下的所有用户
	 */
	List<PageData> listAllUserByRoldId(PageData pd) throws Exception;

	/**
	 * 列出某学校下的所有用户
	 */
	List<PageData> listAllUserBySid(PageData pd) throws Exception;

	/**
	 * 保存用户IP
	 */
	void saveIP(PageData pd) throws Exception;

	/**
	 * 用户列表
	 */
	List<PageData> listUsers(Page page) throws Exception;

	/**
	 * 通过邮箱获取数据
	 */
	PageData findByUE(PageData pd) throws Exception;

	/**
	 * 通过编号获取数据
	 */
	PageData findByUN(PageData pd) throws Exception;

	/**
	 * 通过id获取数据
	 */
	PageData findById(PageData pd) throws Exception;

	/**
	 * 修改用户
	 */
	void editU(PageData pd) throws Exception;

	/**
	 * 更新用户学校信息
	 * 
	 * @param pd
	 * @throws Exception
	 */
	void editUserSchool(PageData pd) throws Exception;

	/**
	 * 保存用户
	 */
	void saveU(PageData pd) throws Exception;

	/**
	 * 删除用户
	 */
	void deleteU(PageData pd) throws Exception;

	/**
	 * 批量删除用户
	 */
	void deleteAllU(String[] USER_IDS) throws Exception;

	/**
	 * 用户列表(全部)
	 */

	List<PageData> listAllUser(PageData pd) throws Exception;

	/**
	 * 根据搜索条件搜索用户
	 */
	List<User> listUsersByName(String keyword) throws Exception;

	/**
	 * 获取总数
	 */
	PageData getUserCount(String value) throws Exception;

	/**
	 * 修改用户
	 */
	void updateOnline(PageData pd) throws Exception;

	/**
	 * 根据角色id，查询所有的角色权限
	 */
	List<Role> findByAllRolePermisson(String[] ROLEID) throws Exception;

	/**
	 * 获取角色下所有用户
	 */
	List<User> listUsersByRoleId(PageData pd) throws Exception;

	/**
	 * 获取计划责任主体为部门时的相关下级人员id
	 */
	List<PageData> findByRoleAndDept(PageData pd) throws Exception;

	/**
	 * 判断本单位下是否有人员
	 * 
	 * @param unitCode
	 * @return
	 * @throws Exception
	 */
	boolean hasUsers(String unitCode) throws Exception;

	/**
	 * 修改密码
	 */
	void editPassWord(PageData pd) throws Exception;

	/**
	 * 修改用户状态
	 */
	void updateStatus(PageData pd) throws Exception;

	/**
	 * 初始化账号
	 * 
	 * @param pd
	 * @throws Exception
	 */
	PageData initeAccount(PageData pd) throws Exception;

	/**
	 * 通过用户名找回密码
	 * 
	 * @param pd
	 * @throws Exception
	 */
	int validateUserName(PageData pd) throws Exception;

}
