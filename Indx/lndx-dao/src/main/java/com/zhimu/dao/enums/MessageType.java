package com.zhimu.dao.enums;

import net.sf.ehcache.constructs.asynchronous.CommandNotFoundInCacheException;

/**
 *   消息类型
 * @author Weiyunchao
 *
 * 2017年7月18日下午1:44:04
 */
public enum MessageType {

	/**
	 * 站内信
	 */
	MAIL("mail"),
	/**
	 * 短信
	 */
	SHORT_MESSAGE("short_message"),
	/**
	 * 公告通知
	 */
	NOTICE("notice"),
	/**
	 * 活动
	 */
	ACTIVITY("activity"),
	/**
	 * 请假
	 */
	LEAVE("leave");
	
	
	private String value;

	private MessageType(String value) {
		this.value = value;
	}
	
	@Override
	public String toString() {
		return value;
	}
}
