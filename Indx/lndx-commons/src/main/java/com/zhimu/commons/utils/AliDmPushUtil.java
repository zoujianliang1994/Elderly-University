package com.zhimu.commons.utils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import java.util.List;
import java.util.Properties;

public class AliDmPushUtil {

	private static final String ALIDM_SMTP_HOST = "smtp.trigger.edmcn.cn";
	private static final int ALIDM_SMTP_PORT = 25;
/**
 * 发送邮件
 * @param addresses		List<String> 地址列表
 * @param errorMessage		要发送的信息
 * @return
 */
	public boolean sendDM(List<String> addresses,String errorMessage) {
		try {
		// 配置发送邮件的环境属性
		final Properties props = new Properties();
		// 表示SMTP发送邮件，需要进行身份验证
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.host", ALIDM_SMTP_HOST);
		props.put("mail.smtp.port", ALIDM_SMTP_PORT);
		// 如果使用ssl，则去掉使用25端口的配置，进行如下配置,
		// props.put("mail.smtp.socketFactory.class",
		// "javax.net.ssl.SSLSocketFactory");
		// props.put("mail.smtp.socketFactory.port", "465");
		// props.put("mail.smtp.port", "465");

		// 发件人的账号
//		props.put("mail.user", "vjiankong@server.phpke.cn");
//		server@email.vjiankong.com
		//edmc05723882
		props.put("mail.user", "server@mail.jujiankong.com");
		// 访问SMTP服务时需要提供的密码
		props.put("mail.password", "00s9506c");

		// 构建授权信息，用于进行SMTP进行身份验证
		Authenticator authenticator = new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				// 用户名、密码
				String userName = props.getProperty("mail.user");
				String password = props.getProperty("mail.password");
				return new PasswordAuthentication(userName, password);
			}
		};
		// 使用环境属性和授权信息，创建邮件会话
		Session mailSession = Session.getInstance(props, authenticator);
		// 创建邮件消息
		MimeMessage message = new MimeMessage(mailSession);
		// 设置发件人
//		MimeUtility.encodeText(new String(.getBytes("utf-8"),"gbk"))
		InternetAddress form = new InternetAddress(MimeUtility.encodeText(new String("聚监控".getBytes("utf-8"),"utf-8"))+" <"+props.getProperty("mail.user")+">");
		message.setFrom(form);

		// 设置收件人
		// InternetAddress to = new InternetAddress("729939336@qq.com");
		// message.setRecipient(MimeMessage.RecipientType.TO, to);
//		InternetAddress[] tos = new InternetAddress[addresses.size()];
		for (int i = 0; i < addresses.size(); i++) {
			InternetAddress to = new InternetAddress(addresses.get(i));
			message.setRecipient(MimeMessage.RecipientType.TO, to);
			// 设置邮件标题
			message.setSubject("告警邮件");
			// 设置邮件的内容体
			message.setContent(errorMessage, "text/html;charset=UTF-8");
			// 发送邮件
			Transport.send(message);
//			tos[i] = new InternetAddress(addresses.get(i));
		}
		
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	
		return true;
	}

	
	public boolean sendDM(List<String> addresses,String title,String errorMessage) {
		try {
		// 配置发送邮件的环境属性
		final Properties props = new Properties();
		// 表示SMTP发送邮件，需要进行身份验证
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.host", ALIDM_SMTP_HOST);
		props.put("mail.smtp.port", ALIDM_SMTP_PORT);
		// 如果使用ssl，则去掉使用25端口的配置，进行如下配置,
		// props.put("mail.smtp.socketFactory.class",
		// "javax.net.ssl.SSLSocketFactory");
		// props.put("mail.smtp.socketFactory.port", "465");
		// props.put("mail.smtp.port", "465");

		// 发件人的账号
//		props.put("mail.user", "vjiankong@server.phpke.cn");
		props.put("mail.user", "server@mail.vjiankong.com");
		// 访问SMTP服务时需要提供的密码
		props.put("mail.password", "ASHANG94cto");

		// 构建授权信息，用于进行SMTP进行身份验证
		Authenticator authenticator = new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				// 用户名、密码
				String userName = props.getProperty("mail.user");
				String password = props.getProperty("mail.password");
				return new PasswordAuthentication(userName, password);
			}
		};
		// 使用环境属性和授权信息，创建邮件会话
		Session mailSession = Session.getInstance(props, authenticator);
		// 创建邮件消息
		MimeMessage message = new MimeMessage(mailSession);
		// 设置发件人
		InternetAddress form = new InternetAddress(props.getProperty("mail.user"));
		message.setFrom(form);

		// 设置收件人
		// InternetAddress to = new InternetAddress("729939336@qq.com");
		// message.setRecipient(MimeMessage.RecipientType.TO, to);
		InternetAddress[] tos = new InternetAddress[addresses.size()];
		for (int i = 0; i < addresses.size(); i++) {
			tos[i] = new InternetAddress(addresses.get(i));
		}
		// tos[0]=new InternetAddress("729939336@qq.com");
		// tos[1]=new InternetAddress("793658414@qq.com");
		message.setRecipients(MimeMessage.RecipientType.TO, tos);
		// 设置邮件标题
		message.setSubject(title);
		// 设置邮件的内容体
		message.setContent(errorMessage, "text/html;charset=UTF-8");

		// 发送邮件
		Transport.send(message);
		} catch (Exception e) {
			return false;
		}
	
		return true;
	}
	/*
	 * public void sample() { IClientProfile profile =
	 * DefaultProfile.getProfile("cn-hangzhou", "<your accessKey>",
	 * "<your accessSecret>"); IAcsClient client = new
	 * DefaultAcsClient(profile); SingleSendMailRequest request = new
	 * SingleSendMailRequest(); try { request.setAccountName("控制台创建的发信地址");
	 * request.setFromAlias("发信人昵称"); request.setAddressType(1);
	 * request.setTagName("控制台创建的标签"); request.setReplyToAddress(true);
	 * request.setToAddress("目标地址"); request.setSubject("邮件主题");
	 * request.setHtmlBody("邮件正文"); SingleSendMailResponse httpResponse =
	 * client.getAcsResponse(request); httpResponse.getRequestId(); } catch
	 * (ServerException e) { e.printStackTrace(); } catch (ClientException e) {
	 * e.printStackTrace(); } }
	 */
}
