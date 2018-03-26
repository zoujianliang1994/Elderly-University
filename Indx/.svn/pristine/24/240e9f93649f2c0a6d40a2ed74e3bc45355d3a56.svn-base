package com.zhimu.service.manager.stu.leave.impl;

import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.message.Message;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.enums.MessageStatus;
import com.zhimu.dao.enums.MessageType;
import com.zhimu.service.manager.edu.grades.GradesManager;
import com.zhimu.service.manager.edu.student.StudentService;
import com.zhimu.service.manager.edu.studentFiles.ScheduleManager;
import com.zhimu.service.manager.message.MessageManager;
import com.zhimu.service.manager.stu.leave.LeaveManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 请假单服务层
 *
 * @author Liang Wenchao
 * @create 2018/1/15 16:32
 **/
@Service("leaveService")
public class LeaveService implements LeaveManager {

    @Resource(name = "daoSupport")
    private DaoSupport dao;
    @Resource(name = "studentService")
    private StudentService studentService;
    @Resource(name = "scheduleService")
    ScheduleManager scheduleService;
    @Resource(name = "gradesService")
    GradesManager gradesService;
    @Resource(name = "messageService")
    private MessageManager messageService;

    @Override
    public List<PageData> listPage(Page page) throws Exception {
        return (List<PageData>)dao.findForList("LeaveMapper.listPage", page);
    }

    /**
     * 保存学员请假信息
     * @param pd
     * @throws Exception
     */
    @Override
    public void save(PageData pd) throws Exception {
        // 根据用户id找到学生数据(学期:semester_id,班级:c_id)
        PageData student = studentService.findByUser(pd.getString("user_id"));
        if (null != student){
            // 获取到学生报名的所有班级
            String gradesId = student.getString("c_id");
            String[] gIdArr = gradesId.split(",");

            // 获取到学生报名的学期id
            String semesterId = student.getString("semester_id");
            student.put("gIdArr", gIdArr);
            // 根据学期id和班级id数组查到对应的课程表数据
            List<PageData> schedules = scheduleService.findByGIdAndSId(student);
            String starTime = pd.getString("start_time"); // 请假开始时间
            String endTime = pd.getString("end_time"); // 请假结束时间
            int startWeek = DateUtil.getWeek(DateUtil.fomatDate(starTime)); // 开始周X
            int endWeek = DateUtil.getWeek(DateUtil.fomatDate(endTime)); // 结束周X

            // 获取请假时间相隔的天数
            int numDays =  DateUtil.daysBetween(starTime, endTime);

            /*
                判断如果: 1.请假时间之差为0,则为同一天,比较课程表的开始于结束时间是否包含了请假的结束开始时间
                        有就获取对应的班级id
                        2.请假之和大于0,就获取所有的周x,并进行去重,将请假第一天的时间和最后一天的时间对课程表
                        时间进行对比,获取范围内的课程对应班级
            */
            List<String> gradeIds = new ArrayList<>();
            if (numDays == 0){
                for (PageData schedule: schedules) {
                    int week = (int)schedule.get("week");
                    if (week == startWeek){
                        String schSTime = schedule.getString("start_time"); // 课程表开始时间
                        String schETime = schedule.getString("end_time"); // 课程表开始时间
                        if ((DateUtil.compareTime(schSTime,endTime) && DateUtil.compareTime(endTime,schETime))
                        || (DateUtil.compareTime(schSTime,starTime) && DateUtil.compareTime(starTime,schETime))
                        || (DateUtil.compareTime(starTime,schSTime) && DateUtil.compareTime(schETime,endTime))){
                            gradeIds.add(schedule.getString("grades_id"));
                        }
                    }
                }
            }else if (0 < numDays &&  numDays < 7){
                for (PageData schedule: schedules) {
                    int week = (int)schedule.get("week");
                    String schSTime = schedule.getString("start_time"); // 课程表开始时间
                    String schETime = schedule.getString("end_time"); // 课程表开始时间
                    for (int i = 0; i < numDays; i++) {
                        int weekCount = startWeek + i;
                        if (6 != weekCount && 7 != weekCount && weekCount == startWeek && week == weekCount){
                            if ((DateUtil.compareTime(schSTime,starTime) && DateUtil.compareTime(starTime,schETime))){
                                gradeIds.add(schedule.getString("grades_id"));
                            }
                        }else if (6 != weekCount && 7 != weekCount && weekCount == endWeek && week == weekCount){
                            if ((DateUtil.compareTime(schSTime,endTime) && DateUtil.compareTime(endTime,schETime))){
                                gradeIds.add(schedule.getString("grades_id"));
                            }
                        }else if(6 != weekCount && 7 != weekCount && weekCount != endWeek && weekCount != startWeek && week == weekCount){
                            gradeIds.add(schedule.getString("grades_id"));
                        }
                    }
                }
            }else {
                for (PageData schedule: schedules) {
                    gradeIds.add(schedule.getString("grades_id"));
                }
            }

            // 根据班级id集合查找所有老师,组长,班委
            if (!gradeIds.isEmpty()){
                // 消息推送的message
                String id = pd.getString("id");
                String url = "studentAttendance/goEditU.do?id=" + id + "&type=1&msg=1";
                Message msg = new Message(url, pd.getString("name")+"请假申请", pd.getString("reason"), id,
                        "", "", MessageType.LEAVE.toString(), MessageStatus.NO_SEND
                        .toString(), "", pd.getString("create_time"));
                msg.setWorkType(MessageType.LEAVE.toString());

                List<PageData> teachers = gradesService.findTeacherByIds(gradeIds);
                if (!teachers.isEmpty()) {
                    String teacherId = "";
                    String teacherName = "";
                    for (PageData teacher : teachers) {
                        String messageId = UuidUtil.get32UUID();
                        msg.setId(messageId);
                        msg.setUserId(teacher.getString("teacher_id"));
                        messageService.sendMessage(msg); // 发送推送消息

                        teacherId += teacher.getString("teacher_id") + ","; // 取出老师id
                        teacherName += teacher.getString("teacher_name") + ","; // 取出教师名字
                    }
                    pd.put("teacher_id", teacherId.substring(0, teacherId.length() - 1));
                    pd.put("teacher_name", teacherName.substring(0, teacherName.length() - 1));
                }
                // 根据班级和学生id查找组长和班委
                List<PageData> committees = gradesService.findComtByGrades(gradeIds);
                if (!committees.isEmpty()) {
                    String monitorId = "";
                    String monitorName = "";
                    for (PageData committee : committees) {
                        String messageId = UuidUtil.get32UUID();
                        msg.setId(messageId);
                        msg.setUserId(committee.getString("user_id"));
                        messageService.sendMessage(msg); // 发送推送消息

                        monitorId += committee.getString("user_id") + ","; // 取出班长id
                        monitorName += committee.getString("xm") + ","; // 取出班长名字
                    }
                    pd.put("monitor_id", monitorId.substring(0, monitorId.length() - 1));
                    pd.put("monitor_name", monitorName.substring(0, monitorName.length() - 1));
                }
                // 根据班级和组名查找组长
                PageData pageData = new PageData();
                pageData.put("list", gradeIds);
                pageData.put("groupName", student.getString("group_name").split(","));
                List<PageData> groupLeaders = gradesService.findGleaderByGrades(pageData);
                if (!groupLeaders.isEmpty()) {
                    String groupLeaderId = "";
                    String groupLeaderName = "";
                    for (PageData groupLeader : groupLeaders) {
                        String messageId = UuidUtil.get32UUID();
                        msg.setId(messageId);
                        msg.setUserId(groupLeader.getString("user_id"));
                        messageService.sendMessage(msg); // 发送推送消息

                        groupLeaderId += groupLeader.getString("user_id") + ","; // 取出组长id
                        groupLeaderName += groupLeader.getString("xm") + ","; // 取出组长名字
                    }
                    pd.put("group_leader_id", groupLeaderId.substring(0, groupLeaderId.length() - 1));
                    pd.put("group_leader_name", groupLeaderName.substring(0, groupLeaderName.length() - 1));
                }
            }
        }
        dao.save("LeaveMapper.save", pd);
    }

    /**
     * 获取学生请假单详情
     *
     * @param pd
     * @return
     * @throws Exception
     */
    @Override
    public PageData findDataById(PageData pd) throws Exception {
        return (PageData)dao.findForObject("LeaveMapper.findDataById", pd);
    }

    /**
     * 获取本学校的所有学生请假数据
     * @param pd
     * @return
     * @throws Exception
     */
    @Override
    public List<PageData> studentApplyListPage(Page pd) throws Exception {
        return (List<PageData>) dao.findForList("LeaveMapper.datalistPage", pd);
    }

    /**
     * 编辑状态
     * @param pd
     * @throws Exception
     */
    @Override
    public void editData(PageData pd) throws Exception {
        dao.update("LeaveMapper.editData", pd);
    }

    /**
     * 重新编辑提交
     * @param pd
     * @throws Exception
     */
    @Override
    public void edit(PageData pd) throws Exception {
        dao.update("LeaveMapper.edit", pd);
    }
}
