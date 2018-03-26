package com.zhimu.dao.enums;

/**
 * 业务流程状态
 * 
 * @author Weiyunchao
 * 
 *         2017年8月10日下午3:05:32
 */
public enum TasksStatus {

	/**
	 *  默认 待审核
	 */
	DEFAULT("待审核"), 
	/**
	 *  审核通过
	 */
	PASS("审核通过"), 
	/**
	 *   审核未通过
	 */
	FAIL("审核拒绝"), 
	/**
	 *  退回
	 */
	RETURN_BACK("退回");

	private String value;

	private TasksStatus(String value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return value;
	}
}
