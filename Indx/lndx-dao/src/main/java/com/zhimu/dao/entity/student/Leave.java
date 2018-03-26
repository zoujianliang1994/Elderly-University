package com.zhimu.dao.entity.student;

import com.zhimu.dao.entity.BaseEntity;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 学员请假申请实体类
 *
 * @author Liang Wenchao
 * @create 2018/1/15 15:49
 **/
public class Leave extends BaseEntity {
    private String schoolId; // 请假学校id
    private String schoolName; // 请假学校name
    private String startTime; // 请假开始时间
    private String endTime; // 请假结束时间
    private BigDecimal duration; // 请假时长
    private String reason; // 请假理由
    private String teacherId; // 任课老师id
    private String teacherName; // 任课老师name
    private String monitorId; // 班长id
    private String monitorName; // 班长name
    private String groupLeaderId; // 组长id
    private String groupLeaderName; // 组长name

    public String getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(String schoolId) {
        this.schoolId = schoolId;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public BigDecimal getDuration() {
        return duration;
    }

    public void setDuration(BigDecimal duration) {
        this.duration = duration;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getMonitorId() {
        return monitorId;
    }

    public void setMonitorId(String monitorId) {
        this.monitorId = monitorId;
    }

    public String getMonitorName() {
        return monitorName;
    }

    public void setMonitorName(String monitorName) {
        this.monitorName = monitorName;
    }

    public String getGroupLeaderId() {
        return groupLeaderId;
    }

    public void setGroupLeaderId(String groupLeaderId) {
        this.groupLeaderId = groupLeaderId;
    }

    public String getGroupLeaderName() {
        return groupLeaderName;
    }

    public void setGroupLeaderName(String groupLeaderName) {
        this.groupLeaderName = groupLeaderName;
    }
}
