package com.zhimu.service.manager.stu.myClass;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;

import java.util.List;

/**
 * 我的班级 lwc
 */
public interface MyClassManager {

	List<PageData> listPage(Page pd) throws Exception;

	void add(PageData pd) throws Exception;

	PageData findObjectById(PageData pd) throws Exception;

	PageData findLessonById(String id) throws Exception;

	void edit(PageData pd) throws Exception;

	void deleteById(String id) throws Exception;

	List<PageData> getUserLesson(PageData pd) throws Exception;

	List<PageData> getUserTeacher(PageData pd) throws Exception;

	Boolean isCheak(PageData pd) throws Exception;

	List<PageData> studentlistPage(Page page) throws Exception;

	PageData findStudentById(PageData pd) throws Exception;

	void saveClassCommittee(PageData pd) throws Exception;

	List<PageData> getAllStudentBycId(PageData pd) throws Exception;

	List<PageData> allGroupById(String gId) throws Exception;

	void editStudentGroup(PageData pd) throws Exception;

	void editStudentGroupLeader(PageData pd) throws Exception;

	void editStudentGroupAll(PageData pd) throws Exception;

	void editGroup(PageData pd) throws Exception;

	/**
	 * 根据学校的id数组查出所有的班级--lwc
	 * 
	 * @param pageData
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findBySchools(PageData pageData) throws Exception;

	/**
	 * 根据班级id集合查找所有老师--lwc
	 * 
	 * @param gradeIds
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findTeacherByIds(List<String> gradeIds) throws Exception;

	/**
	 * 班级详细
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	List<PageData> gradesDetaillistPage(Page pd) throws Exception;

	List<PageData> findObjectBySchoolId(String schoolId) throws Exception;

}
