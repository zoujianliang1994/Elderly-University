package com.zhimu.commons.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.zhimu.commons.constant.Const;

/**
 * 说明：短信接口类 创建人：FH Q313596790 修改时间：2013年2月22日
 * 
 * @version
 */
public class SmsUtil {

	public static void main(String[] args) throws ClientException {

		// sendSms2("13511111111", "您的验证码是：1111。请不要把验证码泄露给其他人。");
		// sendSmsAll(List<PageData> list)
		// sendSmsInfo("15828175792");
		// sendSms1();
	}

	// 短信商 一 http://www.dxton.com/
	// =====================================================================================
	/**
	 * 给一个人发送单条短信
	 * 
	 * @param mobile
	 *            手机号
	 * @param code
	 *            短信内容
	 */
	public static void sendSms1(String mobile, String code) {
		String account = "", password = "";
		String strSMS1 = Tools.readTxtFile(Const.SMS1); // 读取短信1配置
		if (null != strSMS1 && !"".equals(strSMS1)) {
			String strS1[] = strSMS1.split(",fh,");
			if (strS1.length == 2) {
				account = strS1[0];
				password = strS1[1];
			}
		}
		String PostData = "";
		try {
			PostData = "account=" + account + "&password=" + password + "&mobile=" + mobile + "&content=" + URLEncoder.encode(code, "utf-8");
		} catch (UnsupportedEncodingException e) {
			System.out.println("短信提交失败");
		}
		// System.out.println(PostData);
		String ret = SMS(PostData, "http://sms.106jiekou.com/utf8/sms.aspx");
		System.out.println(ret);
		/*
		 * 100 发送成功 101 验证失败 102 手机号码格式不正确 103 会员级别不够 104 内容未审核 105 内容过多 106
		 * 账户余额不足 107 Ip受限 108 手机号码发送太频繁，请换号或隔天再发 109 帐号被锁定 110 发送通道不正确 111
		 * 当前时间段禁止短信发送 120 系统升级
		 */

	}

	public static String SMS(String postData, String postUrl) {
		try {
			// 发送POST请求
			URL url = new URL(postUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setRequestProperty("Connection", "Keep-Alive");
			conn.setUseCaches(false);
			conn.setDoOutput(true);
			conn.setRequestProperty("Content-Length", "" + postData.length());
			OutputStreamWriter out = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
			out.write(postData);
			out.flush();
			out.close();
			// 获取响应状态
			if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
				System.out.println("connect failed!");
				return "";
			}
			// 获取响应内容体
			String line, result = "";
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
			while ((line = in.readLine()) != null) {
				result += line + "\n";
			}
			in.close();
			return result;
		} catch (IOException e) {
			e.printStackTrace(System.out);
		}
		return "";
	}

	// ===================================================================================================================

	/**
	 * 
	 * 短信商 二 http://www.ihuyi.com/
	 * ==============================================
	 * =======================================
	 * 
	 */
	private static String Url = "http://106.ihuyi.com/webservice/sms.php?method=Submit";

	/**
	 * 给一个人发送单条短信
	 * 
	 * @param mobile
	 *            手机号
	 * @param code
	 *            短信内容
	 */
	public static void sendSms2(String mobile, String code) {
		HttpClient client = new HttpClient();
		PostMethod method = new PostMethod(Url);

		client.getParams().setContentCharset("UTF-8");
		method.setRequestHeader("ContentType", "application/x-www-form-urlencoded;charset=UTF-8");

		String content = new String(code);

		String account = "", password = "";
		String strSMS2 = Tools.readTxtFile(Const.SMS2); // 读取短信2配置
		if (null != strSMS2 && !"".equals(strSMS2)) {
			String strS2[] = strSMS2.split(",fh,");
			if (strS2.length == 2) {
				account = strS2[0];
				password = strS2[1];
			}
		}

		NameValuePair[] data = {// 提交短信
		new NameValuePair("account", account), new NameValuePair("password", password), // 密码可以使用明文密码或使用32位MD5加密
				new NameValuePair("mobile", mobile), new NameValuePair("content", content), };

		method.setRequestBody(data);

		try {
			client.executeMethod(method);

			String SubmitResult = method.getResponseBodyAsString();

			Document doc = DocumentHelper.parseText(SubmitResult);
			Element root = doc.getRootElement();

			code = root.elementText("code");
			String msg = root.elementText("msg");
			String smsid = root.elementText("smsid");

			System.out.println(code);
			System.out.println(msg);
			System.out.println(smsid);

			if (code == "2") {
				System.out.println("短信提交成功");
			}

		} catch (HttpException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 给多个人发送单条短信
	 * 
	 * @param list
	 *            手机号验证码
	 */
	public static void sendSmsAll(List<PageData> list) {
		String code;
		String mobile;
		for (int i = 0; i < list.size(); i++) {
			code = list.get(i).get("code").toString();
			mobile = list.get(i).get("mobile").toString();
			sendSms2(mobile, code);
		}
	}

	// =================================================================================================

	public static int sendSmsInfo(String mobile, String templateCode, Map<String, String> templatePara) throws ClientException {
		// 设置超时时间-可自行调整
		System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
		System.setProperty("sun.net.client.defaultReadTimeout", "10000");
		// 初始化ascClient需要的几个参数
		final String product = "Dysmsapi";// 短信API产品名称（短信产品名固定，无需修改）
		final String domain = "dysmsapi.aliyuncs.com";// 短信API产品域名（接口地址固定，无需修改）
		// 替换成你的AK
		final String accessKeyId = PropertyUtils.getValue("SMS_ACCESSKEY_ID");// 你的accessKeyId,参考本文档步骤2
		final String accessKeySecret = PropertyUtils.getValue("SMS_ACCESSKEY_SECRET");// 你的accessKeySecret，参考本文档步骤2
		// 初始化ascClient,暂时不支持多region（请勿修改）
		IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessKeySecret);
		DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
		IAcsClient acsClient = new DefaultAcsClient(profile);
		// 组装请求对象
		SendSmsRequest request = new SendSmsRequest();
		// 使用post提交
		request.setMethod(MethodType.POST);
		// 必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式
		request.setPhoneNumbers(mobile);
		// 必填:短信签名-可在短信控制台中找到
		request.setSignName("乐活邦");
		request.setTemplateCode(templateCode);
		int code = (int) ((Math.random() * 9 + 1) * 100000);
		// 必填:短信模板-可在短信控制台中找到
		if (PropertyUtils.getValue("SMS_TEMPLATE_01").equals(templateCode)) {
			// 可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
			// 友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
			request.setTemplateParam(" {'code':" + code + "} ");
		} else if (PropertyUtils.getValue("SMS_TEMPLATE_02").equals(templateCode)) {
			// String schoolName = templatePara.get("schoolname");
			String userName = templatePara.get("userName");
			request.setTemplateParam(" {'username':" + userName + "} ");
			// request.setTemplateParam("{'schoolname':" + schoolName +
			// ",'username':" + userName + "}");
		}

		// 可选-上行短信扩展码(扩展码字段控制在7位或以下，无特殊需求用户请忽略此字段)
		// request.setSmsUpExtendCode("90997");
		// 可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
		request.setOutId("yourOutId");
		// 请求失败这里会抛ClientException异常
		SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
		if (sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK")) {
			// 请求成功
			return code;
		}
		return 0;

	}
}
