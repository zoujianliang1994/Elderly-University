package com.zhimu.dao.entity.system;

import java.util.Date;

/**
 * 
 * 类名称：权限
 */
public class Permission {

	private String id; // 权限ID
	private String name; // 权限名称
	private String sign; // 权限标志
	private boolean is_del; // 是否禁用
	private Date createTime; // 创建时间

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public boolean isIs_del() {
		return is_del;
	}

	public void setIs_del(boolean is_del) {
		this.is_del = is_del;
	}

}
