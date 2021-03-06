package com.zhimu.service.manager.edu.activityGroup;

import com.zhimu.commons.constant.Const;
import com.zhimu.commons.constant.NoticeConstant;
import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.message.Message;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.User;
import com.zhimu.dao.enums.MessageStatus;
import com.zhimu.dao.enums.MessageType;
import com.zhimu.dao.utils.Jurisdiction;
import com.zhimu.service.manager.edu.activity.ActivityManager;
import com.zhimu.service.manager.edu.school.SchoolService;
import com.zhimu.service.manager.edu.student.StudentService;
import com.zhimu.service.manager.edu.teacher.TeacherManager;
import com.zhimu.service.manager.message.MessageManager;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 活动管理服务层_lwc
 */
@Service("activityGroupService")
public class ActivityGroupService{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@Resource(name = "activityService")
	private ActivityManager activityService;

	public List<PageData> listPage(Page page) throws Exception {
		// 该团体所有学生
		return (List<PageData>) dao.findForList("ActivityGroupMapper.personlistPage", page);
		// 该团体所有老师
		// List<PageData> teachers = (List<PageData>) dao.findForList("ActivityGroupMapper.teacherlistPage", page);

		// String type = page.getPd().getString("type"); // 团员类型
		// if ("1".equals(type)){ // 教师
		// 	return teachers;
		// }else if("0".equals(type)){ // 学生
		// 	return students;
		// }else{ // 所有
		// 	students.addAll(teachers);
		// 	return students;
		// }
	}

	/**
	 * 我的活动列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listByUser(Page page) throws Exception {
		PageData pd = page.getPd();
		String childSchId = pd.getString("school_child_id"); // 分校id
		if (StringUtils.isNotBlank(childSchId)){ // 如果选了分校区,就将分校id设为学校id
			pd.put("school_id", childSchId);
		}
		return (List<PageData>) dao.findForList("ActivityGroupMapper.listPage", page);
	}

	/**
	 * 查找活动负责人
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findLeaders(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ActivityGroupMapper.findLeaders", pd);
	}

	/**
	 * 保存活动
	 *
	 * @param pd
	 * @throws Exception
	 */
	public void add(PageData pd) throws Exception {
		dao.save("ActivityGroupMapper.save", pd);

	}


	/**
	 * 根据id查询
	 *
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findObjectById(PageData pd) throws Exception {
		String type = pd.getString("personType");
		if ("1".equals(type)){
			return (PageData)dao.findForObject("ActivityGroupMapper.findTeacherById", pd);
		}else if("0".equals(type)){
			return (PageData)dao.findForObject("ActivityGroupMapper.findStuById", pd);
		}
		return (PageData)dao.findForObject("ActivityGroupMapper.findById", pd);
	}

	/**
	 * 更新与报名
	 *
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void updateAndApply(PageData pd) throws Exception {
		pd.put("id", pd.getString("activity_group_id"));
		PageData activity = this.findObjectById(pd);
		if ("0".equals(activity.getString("need_check"))){ // 需要审核
			pd.put("check_state", "1");
		}else{ // 无需审核
			pd.put("check_state", "2");
		}
		pd.put("regis_time", DateUtil.getTime());
		dao.update("ActivityGroupMapper.updateAndApply", pd);
	}


	/**
	 * 审核
	 *
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void check(PageData pd) throws Exception {
		dao.update("ActivityGroupMapper.check", pd);
	}

	/**
	 * 删除
	 *
	 * @param activityId
	 * @throws Exception
	 */
	public void deleteByActiId(String activityId) throws Exception {
		dao.delete("ActivityGroupMapper.deleteByActiId", activityId);
	}


}
