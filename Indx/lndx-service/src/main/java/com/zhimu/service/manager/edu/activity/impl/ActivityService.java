package com.zhimu.service.manager.edu.activity.impl;

import com.zhimu.commons.constant.Const;
import com.zhimu.commons.constant.NoticeConstant;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.PropertyUtils;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.message.Message;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.User;
import com.zhimu.dao.enums.MessageStatus;
import com.zhimu.dao.enums.MessageType;
import com.zhimu.dao.utils.Jurisdiction;
import com.zhimu.service.manager.edu.activity.ActivityManager;
import com.zhimu.service.manager.edu.activityGroup.ActivityGroupService;
import com.zhimu.service.manager.edu.school.SchoolService;
import com.zhimu.service.manager.edu.student.StudentService;
import com.zhimu.service.manager.edu.teacher.TeacherManager;
import com.zhimu.service.manager.message.MessageManager;
import com.zhimu.service.manager.system.user.UserManager;
import net.sf.ehcache.util.PropertyUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.session.Session;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 活动管理服务层_lwc
 */
@Service("activityService")
public class ActivityService implements ActivityManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@Resource(name = "schoolService")
	private SchoolService schoolService;
	@Resource(name = "studentService")
	private StudentService studentService;
	@Resource(name = "teacherService")
	private TeacherManager teacherService;
	@Resource(name = "messageService")
	private MessageManager messageService;
	@Resource(name = "activityGroupService")
	private ActivityGroupService activityGroupService;
	@Resource(name = "userService")
	private UserManager userService;

	@Override
	public List<PageData> listPage(Page pd) throws Exception {

		return (List<PageData>) dao.findForList("ActivityMapper.listPage", pd);

	}

	/**
	 * 保存活动
	 *
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void add(PageData pd, String[] respContents) throws Exception {
		dao.save("ActivityMapper.save", pd);

		// 发送消息推送
		String id = pd.getString("id");
		String url = "activity/toSelect.do?id=" + id + "&msg=1";
		Message msg = new Message(url, pd.getString("name"), pd.getString("content"), id,
				"", "", MessageType.ACTIVITY.toString(), MessageStatus.NO_SEND
				.toString(), "", pd.getString("activity_start_time"));
		msg.setWorkType(MessageType.ACTIVITY.toString());
		msg.setPublishRange(pd.getString("publish_range"));
		boolean status = "1".equals(pd.getString("status"))?true:false; // 草稿或者发布

		PageData groupPd = new PageData(); // 用作保存活动参与人员分组的pagedata
		groupPd.put("activity_id", id); // 活动id
		String needCheck = pd.getString("need_check");
		groupPd.put("need_check", needCheck); // 是否需要审核
		groupPd.put("check_state", '0'); // 待提交审核状态
		groupPd.put("activity_location", pd.getString("activity_location")); // 活动地点
		groupPd.put("school_id", pd.getString("school_id")); // 活动学校id
		groupPd.put("school_name", pd.getString("school_name")); // 活动学校地点

		// 先保存活动负责人信息
		String leaderNames = pd.getString("leader_name");
		if (StringUtils.isNotBlank(leaderNames)){
			String[] leaderNameArr = leaderNames.split(",");
			String[] leaderTelArr = pd.getString("leader_tel").split(",");
			// String[] respContentArr = pd.getString("resp_content").split(",");
			for (int i = 0; i < leaderNameArr.length; i++) {
				String userId = UuidUtil.get32UUID();
				groupPd.put("resp_content", respContents[i]); // 负责内容
				groupPd.put("leader_name", leaderNameArr[i]);
				groupPd.put("tel", leaderTelArr[i]); // 负责人电话
				groupPd.put("id", UuidUtil.get32UUID()); // 负责人id
				groupPd.put("position", "1"); // 负责人职位标识
				groupPd.put("order_num", i+1); // 负责人顺序

				// 给负责人建立账户
				PageData user = new PageData();
				user.put("USERNAME",leaderTelArr[i]);
				PageData leader = userService.findByUsername(user);
				if (null == leader){ // 如果不存在账户直接创建, 如果存在了就取出数据存起来
					groupPd.put("user_id", userId);

					user.put("USER_ID", userId);
					user.put("pwdStrategy", "2");
					user.put("phone", leaderTelArr[i]);
					user.put("SCHOOL_ID", "");
					user.put("ROLE_ID", PropertyUtils.getValue("ACTIVITY_RESP_ROLE_ID")); // 活动负责人默认角色
					user.put("password", "123456"); // 初始密码
					PageData result = userService.initeAccount(user);
				}else{
					groupPd.put("user_id", leader.getString("USER_ID")); // 负责人用户id
				}
				activityGroupService.add(groupPd); // 保存活动负责人
			}

		}

		String target = pd.getString("target");
		if (StringUtils.isNotBlank(target)){

			String personIds = pd.getString("selectId"); // 前台传过来的id
			String[] personArr = null;
			String schoolIds = this.getSchoolId(); // 获取当前用户所有学校id
			PageData pageData = new PageData();
			List<PageData> people = new ArrayList<>();

			// 获取前台传过来的目标对象类型, 根据不同的类型获取相应的人员进项消息保存
			if (target.equals(NoticeConstant.ALL_PEOPLE.getName())){ // 所有人
				pageData.put("array",schoolIds.split(","));
				pageData.put("sId",schoolIds);
				people.addAll(studentService.findBySid(pageData)); // 所有学员
				people.addAll(teacherService.findBySchools(pageData)); // 所有老师
			}else if(target.equals(NoticeConstant.ALL_TEACHER.getName())){ // 所有老师
				pageData.put("sId",schoolIds);
				people.addAll(teacherService.findBySchools(pageData));
			}else if(target.equals(NoticeConstant.ALL_STUDENT.getName())){ // 所有学员
				pageData.put("array",schoolIds.split(","));
				people.addAll(studentService.findBySid(pageData));
			}else if(target.equals(NoticeConstant.CAMPUS.getName())){ // 校区
				if (StringUtils.isNotBlank(personIds)){
					pageData.put("array",personIds.split(","));
					pageData.put("sId",personIds);
					people.addAll(studentService.findBySid(pageData)); // 所有学员
					people.addAll(teacherService.findBySchools(pageData)); // 所有老师
				}

			}else if(target.equals(NoticeConstant.CLASS_AND_GRADE.getName())){ // 班级
				if (StringUtils.isNotBlank(personIds)){
					people.addAll(studentService.findByCid(personIds)); // 班上的同学
				}
			}else{ // 人员
				if (StringUtils.isNotBlank(personIds)){
					personArr = personIds.split(",");
					for (int i = 0; i <personArr.length ; i++) {
						String messageId = UuidUtil.get32UUID();
						String userId = personArr[i];

						if (status){ // 如果是发布状态则推送消息
							msg.setId(messageId);
							msg.setUserId(userId);
							messageService.sendMessage(msg); // 发送推送消息
						}

						// 保存活动团队
						groupPd.put("id", messageId);
						groupPd.put("user_id", userId);
						groupPd.put("position", "0"); // 普通团员
						groupPd.put("resp_content", "");
						groupPd.put("leader_name", "");
						groupPd.put("tel", "");
						groupPd.put("order_num", null);
						activityGroupService.add(groupPd);
					}
				}
			}
			if(!people.isEmpty()){
				for (PageData pagedata : people) {
					String messageId = UuidUtil.get32UUID();
					String userId = pagedata.getString("user_id");

					if (status){ // 如果是发布状态则推送消息
						msg.setId(messageId);
						msg.setUserId(userId);
						messageService.sendMessage(msg); // 发送推送消息
					}
					// 保存活动团队
					groupPd.put("id", messageId);
					groupPd.put("user_id", userId);
					groupPd.put("position", "0"); // 普通团员
					groupPd.put("resp_content", "");
					groupPd.put("leader_name", "");
					groupPd.put("tel", "");
					groupPd.put("order_num", null);
					activityGroupService.add(groupPd);
				}
			}
		}
	}


	/**
	 * 获取用户所有学校id
	 * @return
	 * @throws Exception
	 */
	public String getSchoolId() throws Exception {
		PageData pageData = new PageData();
		List<PageData> schools = new ArrayList<>();
		// 获取到当前登录用户所属的学校
		Session session = Jurisdiction.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		pageData.put("array", user.getSchoolId().split(","));
		List<PageData> school = schoolService.findByIdArr(pageData);
		schools.addAll(school);

		for (PageData pd: school) {
			String type = pd.getString("type");
			// 如果学校类型为空则寻找它的分校区
			if (type.isEmpty()) {
				List<PageData> subSchools = schoolService.listSubSchools(pd.getString("id"));
				schools.addAll(subSchools);
			}
		}
		String schoolIds = "";
		for (int i = 0; i < schools.size(); i++) {
			if (i == schools.size()-1){
				schoolIds += schools.get(i).getString("id");
			}else {
				schoolIds += schools.get(i).getString("id")+",";
			}
		}
		return schoolIds;
	}

	/**
	 * 根据id查询
	 *
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	public PageData findObjectById(PageData pd) throws Exception {
		return (PageData)dao.findForObject("ActivityMapper.findById", pd);
	}

	/**
	 * 编辑
	 *
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd) throws Exception {
		dao.update("ActivityMapper.edit", pd);
	}

	/**
	 * 删除
	 *
	 * @param id
	 * @throws Exception
	 */
	@Override
	public void deleteById(String id) throws Exception {
		dao.delete("ActivityMapper.deleteById", id);
	}


}
