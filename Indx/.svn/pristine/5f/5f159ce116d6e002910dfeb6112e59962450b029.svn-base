package com.zhimu.commons.utils;

import io.netty.channel.ChannelHandlerContext;
import net.sf.json.JSONObject;

public class ServerStaticChanle {
	public static  ChannelHandlerContext channelHandlerContext; 
	
	/**
	 * 把消息组装成消息模板最后变为字符串
	 * @param type
	 * @param context
	 * @return
	 */
	public static String messageTemplate (int type,JSONObject context){
		JSONObject  jsonObject = new JSONObject();
		jsonObject.put("type", type);
		jsonObject.put("context", context);
		return jsonObject.toString();
	}
	
}
