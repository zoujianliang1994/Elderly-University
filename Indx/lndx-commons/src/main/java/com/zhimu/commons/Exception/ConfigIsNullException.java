package com.zhimu.commons.Exception;

/**
 * 
 * 系统配置Key获得的Value为空
 * 
 * @author GunnyZeng
 * 
 */
public class ConfigIsNullException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ConfigIsNullException(String msg) {
		super(msg);
	}
}
