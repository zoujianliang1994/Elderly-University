package com.zhimu.dao.entity.system;

import com.zhimu.dao.entity.BaseEntity;

/**
 *    上传附件实体类
 * @author Weiyunchao
 *
 * 2017年8月8日上午9:55:17
 */
public class Attachment extends BaseEntity{
	private String businessId; // 用户id
	private String name;//附件名称
	private String fileType;//文件类型
	private String path;//文件路径
	private String fileIdentity;//文件标识
	private String isDel;//是否删除
	public String getBusinessId() {
		return businessId;
	}
	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getFileIdentity() {
		return fileIdentity;
	}
	public void setFileIdentity(String fileIdentity) {
		this.fileIdentity = fileIdentity;
	}
	public String getIsDel() {
		return isDel;
	}
	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}
	
	
}
