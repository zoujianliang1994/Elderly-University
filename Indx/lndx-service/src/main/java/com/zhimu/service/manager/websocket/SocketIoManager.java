package com.zhimu.service.manager.websocket;

import org.springframework.stereotype.Service;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;
import com.corundumstudio.socketio.listener.ConnectListener;
import com.corundumstudio.socketio.listener.DataListener;
import com.corundumstudio.socketio.listener.DisconnectListener;
import com.zhimu.commons.utils.PropertyUtils;
import com.zhimu.commons.websocket.SocketCache;
import com.zhimu.dao.entity.message.Message;

/**
 * socket.io推送服务类
 * 
 * @author Weiyunchao
 * 
 *         2017年7月20日下午2:44:11
 */
@Service("socketIoService")
public class SocketIoManager {

	static SocketIOServer server;

	// @Autowired
	// private SocketIoDao socketIoDao;

	public static SocketIOServer getServer() {
		return server;
	}

	/**
	 * 启动服务
	 * 
	 * @throws InterruptedException
	 */
	public void startServer() throws InterruptedException {
		Configuration config = new Configuration();
		// 服务器主机ip
		config.setHostname(PropertyUtils.getValue("SERVER_IP"));
		// 端口
		config.setPort(Integer.parseInt(PropertyUtils.getValue("MESSAGE_PORT")));
		server = new SocketIOServer(config);
		// 监听消息事件
		server.addEventListener("chatevent", Message.class, new DataListener<Message>() {
			@Override
			public void onData(SocketIOClient client, Message sendData, AckRequest ackRequest) {
				onEvent(client, ackRequest, sendData);
			}
		});

		/**
		 * 添加connect事件，当客户端发起连接时调用，将clientid加入到在线map中 方便后面发送消息时查找到对应的目标client
		 */
		server.addConnectListener(new ConnectListener() {
			@Override
			public void onConnect(SocketIOClient client) {
				// String currentName =
				// "admin";//Jurisdiction.getUsername();//SecurityUtils.getSubject().getPrincipal().toString();
				String currentName = client.getHandshakeData().getSingleUrlParam("clientid");
				System.out.println(currentName + "-------------------------客户端已连接------------------------");
				SocketCache.addSocketClient(currentName, client);
				SocketCache.forEachMap();

			}
		});
		// 添加事件，客户端断开连接时调用，刷新客户端信息
		server.addDisconnectListener(new DisconnectListener() {
			@Override
			public void onDisconnect(SocketIOClient client) {
				// String sa = client.getRemoteAddress().toString();
				// String clientIp = sa.substring(1, sa.indexOf(":"));// 获取设备ip
				// String clientId =
				// client.getHandshakeData().getSingleUrlParam("clientid");
				String currentName = client.getHandshakeData().getSingleUrlParam("clientid");
				System.out.println(currentName + "-------------------------" + "客户端已断开连接");
				SocketCache.removeSocketIOClient(currentName);
				SocketCache.forEachMap();
			}
		});
		server.start();
		System.out.println("—————*******—————消息服务启动完成——————*******——————");

		Thread.sleep(Integer.MAX_VALUE);

		server.stop();
	}

	public void stopServer() {
		if (server != null) {
			server.stop();
			server = null;
		}
	}

	/**
	 * 消息接收入口，当接收到消息后，查找发送目标客户端，并且向该客户端发送消息，且给自己发送消息
	 * 
	 * @param client
	 * @param request
	 * @param data
	 */
	public void onEvent(SocketIOClient client, AckRequest request, Message sendData) {
		server.getBroadcastOperations().sendEvent("messageEvent", sendData);
	}

	/**
	 * 推送信息到客户端
	 * 
	 * @param client
	 * @param request
	 * @param sendData
	 */
	public void sendEventMessage(Message sendData) {

		SocketCache.forEachMap();
		// server.getBroadcastOperations().sendEvent("messageEvent", sendData);
		SocketCache.getSocketIOClient(sendData.getUserName()).sendEvent("messageEvent", sendData);
	}

}