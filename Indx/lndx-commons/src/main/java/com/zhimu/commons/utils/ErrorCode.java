package com.zhimu.commons.utils;
/**
 * 接口返回的错误码
 * @author wsq
 *
 */
public enum ErrorCode {
	
	REQEUST_SUCCESS(10000, "请求成功！"),

	REQUEST_PARAM(10001, "请求参数不完整！"),
    REQUEST_PARAM_ERROR(10002,"请求参数错误"),
   
    HEAD_ANALYSIS_ERROR(11001,"表头解析错误"),
    AREA_NOT_EXIST(12001,"该行政区域不存在"),
    AREA_DATA_EXIST(12002,"该行政区域已存在统计数据！"),
    AREA_PARENT_ERROR(12003,"行政区划上下级数据有误！"),
    DELETE_REPORT_CITY_ERROR(12004,"删除失败，未查询到市信息"),
    DELETE_REPORT_PROVINCE_ERROR(12005,"删除失败，未查询到省信息"),
    
	SELECT_NO_DATA(99997, "未查询到相关数据！"), 
	REQUEST_FAILD(99998, "请求失败！"), 
	REQUEST_SERVER_FAILD(99999, "服务器繁忙,请稍后重试！");

	private String msg;
	private int code;

	public String getMsg() {
		return msg;
	}

	public int getCode() {
		return code;
	}

	private ErrorCode(int code, String msg) {
		this.code = code;
		this.msg = msg;
	}

}
