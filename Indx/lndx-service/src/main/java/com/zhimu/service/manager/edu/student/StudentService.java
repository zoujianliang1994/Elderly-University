/**
 * 学员
 * @author wangyong
 */
package com.zhimu.service.manager.edu.student;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.PropertyUtils;
import com.zhimu.commons.utils.SmsUtil;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.student.Student;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.system.user.impl.UserService;

@Service("studentService")
public class StudentService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@Resource(name = "userService")
	private UserService userService;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception {
		dao.save("StudentMapper.save", pd);
	}

	/**
	 * 保存新学员信息
	 * 
	 * @param student
	 * @throws Exception
	 */
	public PageData saveInfo(Student student) throws Exception {
		// 新建学员账号
		PageData pd = new PageData();
		pd.put("name", student.getXm());
		pd.put("phone", student.getPhone());
		pd.put("pwdStrategy", "2");
		pd.put("SCHOOL_ID", student.getsId());
		pd.put("SCHOOL_NAME", student.getsName());
		pd.put("ROLE_ID", PropertyUtils.getValue("MENBER_ROLE_ID"));// 默认注册用户角色
		pd.put("SEX", student.getXb());
		PageData account = this.userService.initeAccount(pd);
		// 保存学员信息
		student.setUserId(account.getString("userId"));
		dao.save("StudentMapper.saveInfo", student);
		// 发送新学员注册成功短信信息
		Map<String, String> paraMap = new HashMap<String, String>();
		// paraMap.put("schoolname", student.getsName());
		paraMap.put("userName", account.getString("userName"));
		SmsUtil.sendSmsInfo(pd.getString("phone"), PropertyUtils.getValue("SMS_TEMPLATE_02"), paraMap);
		return account;
	}

	/**
	 * 保存学员班级关联
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void saveGrades(PageData pd) throws Exception {
		pd.put("id", UuidUtil.get32UUID());
		pd.put("grades_id", pd.getString("g_id"));
		pd.put("student_id", pd.getString("student_id"));
		pd.put("create_date", DateUtil.getDay());
		pd.put("creator_id", pd.getString("user_id"));
		pd.put("status", "0");
		dao.save("StudentMapper.saveGrades", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception {
		dao.delete("StudentMapper.delete", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(Student student) throws Exception {
		dao.update("StudentMapper.edit", student);
		// 修改学员账号信息
		PageData pd = new PageData();
		pd.put("sex", student.getXb());
		pd.put("userId", student.getUserId());
		dao.update("UserMapper.editUserSex", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void update(PageData pd) throws Exception {
		dao.update("StudentMapper.update", pd);

	}

	/**
	 * 修改学员班级关联
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editGrades(PageData pd) throws Exception {
		dao.update("StudentMapper.editStudentGrades", pd);

	}

	/**
	 * 写入主表学员选课信息
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editStudentEnroll(PageData pd) throws Exception {
		dao.update("StudentMapper.editStudentEnroll", pd);

	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("StudentMapper.datalistPage", page);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("StudentMapper.findById", pd);
	}

	/**
	 * 通过sfz获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findBySfz(PageData pd) throws Exception {
		return (PageData) dao.findForObject("StudentMapper.findBySfz", pd);
	}

	/**
	 * 通过学员学籍号获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> findByStuNumber(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("StudentMapper.findByStuNumber", pd);
	}

	/**
	 * 根据用户id查找对应学生数据--lwc
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public PageData findByUser(String userId) throws Exception {
		return (PageData) dao.findForObject("StudentMapper.findByUser", userId);
	}

	/**
	 * 根据学校id查找对应所有的学生用户id--lwc
	 * 
	 * @param sIds
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<String> findUidBySid(String[] sIds) throws Exception {
		return (List<String>) dao.findForList("StudentMapper.findUidBySid", sIds);
	}

	/**
	 * 获取所选学校的所有学生--lwc
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findBySid(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("StudentMapper.findBySid", pd);
	}

	public List<PageData> findByCid(String ids) throws Exception {
		String[] array = ids.split(",");
		return (List<PageData>) dao.findForList("StudentMapper.findByCid", array);
	}

	/**
	 * 根据班级id或学员ID查找
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findByCidAndStuId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("StudentMapper.findByCidAndStuId", pd);
	}

	/**
	 * 根据学员ID查询学员已读班级时间表
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findByScheduleStuId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("StudentMapper.findByScheduleStuId", pd);
	}

}