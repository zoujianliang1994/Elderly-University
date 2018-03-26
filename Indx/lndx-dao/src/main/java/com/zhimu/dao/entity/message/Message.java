package com.zhimu.dao.entity.message;

import java.util.ArrayList;
import java.util.List;

import com.zhimu.dao.entity.BaseEntity;

/**
 *  推送消息实体类
 * @author Weiyunchao
 *
 * 2017年7月18日下午1:54:00
 */
public class Message extends BaseEntity{

	private String url;//业务链接
	private String title;//消息标题
	private String content;//消息内容
	private String businessId;//业务ID
	private String userId;//需要推送用户ID
	private String userName;//需要推送用户名称
	private String type;//消息类型
	private String status;//消息状态  0 （表示未推送）：1（表示已推送）
	private String workType;//工作类型  （1.工作计划 2.工作要点）
	private String publishTime; // 发布时间
	private String fileUrl; // 文件路径
	private String publishRange; // 发布范围
	private String publishDesc; // 发布范围描述
	private String target; // 目标
	private String selectId; // 选中人员id
	private List<String> userNameList = new ArrayList<String>();//多用户推送消息
	public Message(){}
	public Message(String url,String title,String content,String businessId,
			String userId,String userName,String type,String status,String workType,String publishTime )
	{
		this.url = url;
		this.title = title;
		this.content = content;
		this.businessId = businessId;
		this.userId = userId;
		this.userName = userName;
		this.type = type;
		this.status = status;
		this.workType = workType;
		this.publishTime = publishTime;
	}
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBusinessId() {
		return businessId;
	}
	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getWorkType() {
		return workType;
	}
	public void setWorkType(String workType) {
		this.workType = workType;
	}
	public String getPublishTime() {
		return publishTime;
	}
	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public String getPublishRange() {
		return publishRange;
	}
	public void setPublishRange(String publishRange) {
		this.publishRange = publishRange;
	}
	public List<String> getUserNameList() {
		return userNameList;
	}
	public void setUserNameList(List<String> userNameList) {
		this.userNameList = userNameList;
	}

	public String getPublishDesc() {
		return publishDesc;
	}

	public void setPublishDesc(String publishDesc) {
		this.publishDesc = publishDesc;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getSelectId() {
		return selectId;
	}

	public void setSelectId(String selectId) {
		this.selectId = selectId;
	}
}