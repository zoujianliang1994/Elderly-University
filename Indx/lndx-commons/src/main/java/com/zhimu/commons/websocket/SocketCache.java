package com.zhimu.commons.websocket;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.shiro.SecurityUtils;

import com.corundumstudio.socketio.SocketIOClient;

public class  SocketCache {

	public static Map<String,SocketIOClient> userCache=new HashMap<String,SocketIOClient>();
	
	public static void getUser(){
		
	}
	
	public static void addUser(String username){
		userCache.put(username, null);
	}
	
	public static void addSocketClient(String userName,SocketIOClient client){
		userCache.put(userName, client);
	}
	
	public static void addSocketClientById(String userId,SocketIOClient client){
		userCache.put(userId, client);
	}
	
	public static SocketIOClient getSocketIOClient(String username){
		return userCache.get(username);
	}
	
	public static void removeSocketIOClient(String username){
		userCache.remove(username);
	}
	
	public static void forEachMap(){
		Iterator<Entry<String, SocketIOClient>> it = userCache.entrySet().iterator();  
		while (it.hasNext()) {  
		    Entry<String, SocketIOClient> entry = it.next();  
		    System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());  
		}   
	}
	
}
