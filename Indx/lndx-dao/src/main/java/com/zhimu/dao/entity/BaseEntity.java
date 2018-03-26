package com.zhimu.dao.entity;

import java.sql.Timestamp;
import java.util.Date;

import com.zhimu.commons.utils.IDUtil;

public class BaseEntity {
	
	String id;
	private String createTime; //创建时间
	private String updateTime;//修改时间
	private String createBy;//创建人
	private String updateBy;//创建时间

	public BaseEntity() {
		super();
		this.id=IDUtil.getID();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}
	

}
