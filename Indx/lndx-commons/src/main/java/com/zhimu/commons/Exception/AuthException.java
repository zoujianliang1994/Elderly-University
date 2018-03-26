package com.zhimu.commons.Exception;

/**
 * 
 * 系统配置Key获得的Value为空
 * 
 * @author GunnyZeng
 * 
 */
public class AuthException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public AuthException(String msg) {
		super(msg);
	}
}
