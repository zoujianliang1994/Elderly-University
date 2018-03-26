package com.zhimu.commons.utils;

public class ErrorUtils {
	
	/**
	 * 
	 * @param e	错误异常类
	 * @param info	你要传的哪里的错误信息如：订单创建出错
	 * @return	打印的错误信息
	 * @author Liang.Yuan
	 * <br>2016年7月20日
	 */
	public static String getErrorMessage(Exception e,String info){
		String message=info+":	"+e.getMessage()+"错误信息在";
		message+=System.getProperty("line.separator");
		for(int i=0;i<e.getStackTrace().length;i++){
			message+="\t\t"+e.getStackTrace()[i].getClassName()+"类的"+"\t"+e.getStackTrace()[i].getLineNumber()+"行"+System.getProperty("line.separator");
//			if(e.getStackTrace()[i].getClassName().toString().equals(errorClass)){
//				message+=e.getStackTrace()[i].getLineNumber()+"行";
//			}
		}
		e.printStackTrace();
		return message;
	}
}
