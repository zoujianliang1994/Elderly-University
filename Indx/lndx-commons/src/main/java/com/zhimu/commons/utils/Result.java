package com.zhimu.commons.utils;

public class Result {

	/**
	 * 
	 *@desc:返回信息
	 *@param code
	 *@param obj
	 *@return
	 *@author：wsq
	 *@createDate:2017年11月29日
	 *@version:V1.0
	 *@updateDate:
	 */
	public static JsonData getResult(ErrorCode code,Object obj){
		return new JsonData(code.getCode(), obj, code.getMsg());
	}
	
}
