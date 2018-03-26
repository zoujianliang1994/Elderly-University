package com.zhimu.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import com.zhimu.commons.cache.Cache;
import com.zhimu.commons.cache.CacheManager;
import com.zhimu.commons.utils.ApplicationContextHelper;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.service.manager.system.user.impl.UserService;
/**
 *  启动tomcat时运行此类
 * @author Weiyunchao
 *
 * 2017年7月18日下午4:37:15
 */
public class StartFilter extends BaseController implements Filter{
	
	/**
	 * 初始化
	 */
	public void init(FilterConfig fc) throws ServletException {
		this.startWebsocketInstantMsg();
		this.startWebsocketOnline();
		this.putAllUserToCache();//所有用户放到缓存
	}
	
	/**
	 * 启动即时聊天服务
	 */
	public void startWebsocketInstantMsg(){
//		WebSocketImpl.DEBUG = false;
//		ChatServer s;
//		try {
//			String strWEBSOCKET = Tools.readTxtFile(Const.WEBSOCKET);//读取WEBSOCKET配置,获取端口配置
//			if(null != strWEBSOCKET && !"".equals(strWEBSOCKET)){
//				String strIW[] = strWEBSOCKET.split(",fh,");
//				if(strIW.length == 5){
//					s = new ChatServer(Integer.parseInt(strIW[1]));
//					s.start();
//				}
//			}
//			//System.out.println( "websocket服务器启动,端口" + s.getPort() );
//		} catch (UnknownHostException e) {
//			e.printStackTrace();
//		}
	}
	
	/**
	 * 启动在线管理服务
	 */
	public void startWebsocketOnline(){
//		WebSocketImpl.DEBUG = false;
//		OnlineChatServer s;
//		try {
//			String strWEBSOCKET = Tools.readTxtFile(Const.WEBSOCKET);//读取WEBSOCKET配置,获取端口配置
//			if(null != strWEBSOCKET && !"".equals(strWEBSOCKET)){
//				String strIW[] = strWEBSOCKET.split(",fh,");
//				if(strIW.length == 5){
//					s = new OnlineChatServer(Integer.parseInt(strIW[3]));
//					s.start();
//				}
//			}
//			//System.out.println( "websocket服务器启动,端口" + s.getPort() );
//		} catch (UnknownHostException e) {
//			e.printStackTrace();
//		}
	}
	
	
	//计时器
	public void timer() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 9); // 控制时
		calendar.set(Calendar.MINUTE, 0); 		// 控制分
		calendar.set(Calendar.SECOND, 0); 		// 控制秒

		Date time = calendar.getTime(); 		// 得出执行任务的时间

		Timer timer = new Timer();
		timer.scheduleAtFixedRate(new TimerTask() {
			public void run() {
				
				//PersonService personService = (PersonService)ApplicationContext.getBean("personService");
				
				//System.out.println("-------设定要指定任务--------");
			}
		}, time, 1000*60*60*24);// 这里设定将延时每天固定执行
	}

	/**
	 *  启动是把所有的用户放到缓存中
	 * @throws Exception 
	 */
	public void putAllUserToCache()
	{
		List<PageData> userList = new ArrayList<PageData>();
		try {
			UserService userservice =ApplicationContextHelper.getBean("userService");
			userList = userservice.listAllUser(new PageData());//列出用户列表
			if(null != userList && userList.size() > 0)
			{
				for(int i=0;i<userList.size();i++)
				{
					PageData pd = userList.get(i);
					Cache c = new Cache(); 
					CacheManager.putCache(pd.getString("USER_ID"), c);//放入用户ID
				}
			}
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "启动把所有用户放到缓存"));
		}	
		
	}
	
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		// TODO Auto-generated method stub
		
	}
	
	
}
