package com.zhimu.service.manager.websocket;

import java.util.Timer;
import java.util.TimerTask;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import com.zhimu.service.manager.websocket.SocketIoManager;

/**
 *   nettySocket启动服务配置类
 * @author Weiyunchao
 *
 * 2017年7月20日下午2:44:48
 */
@Component("nettySocketSpringApplication")
public class NettySocketSpringApplication implements ApplicationListener<ContextRefreshedEvent> {

	// 执行时间，时间单位为毫秒,读者可自行设定，不得小于等于0
	private static Long cacheTime = Long.MAX_VALUE;

	// 延迟时间，时间单位为毫秒,读者可自行设定，不得小于等于0
	private static Integer delay = 3000;

	@Autowired
	private SocketIoManager service;

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		Timer timer = new Timer();
		timer.scheduleAtFixedRate(new TimerTask() {
			@SuppressWarnings("static-access")
			public void run() {
				// 启动socket监听
				try {
					if (service.getServer() == null) {
						new Thread(new Runnable() {
							@Override
							public void run() {
								try {
									service.startServer();
								} catch (InterruptedException e) {
									e.printStackTrace();
								}
							}
						}).start();
					}
				} catch (Exception e) {
				}
			}
		}, delay, cacheTime);// 这里设定将延时每天固定执行

	}
}
