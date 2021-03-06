package com.zhimu.service.manager.edu.alipay;

/**
 * 类名：AlipayConfigUtil 功能：基础配置类 详细：设置帐户有关信息及返回路径
 */
public class AlipayConfigUtil {

	// private static final Log LOG = LogFactory.getLog(AlipayConfigUtil.class);

	// ↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 支付宝网关
	public static final String alipay_gateway_new = "https://mapi.alipay.com/gateway.do?";

	// 合作身份者ID，签约账号，以2088开头由16位纯数字组成的字符串，查看地址：https://b.alipay.com/order/pidAndKey.htm
	public static final String partner = "2088921585773740";

	// 收款支付宝账号，以2088开头由16位纯数字组成的字符串，一般情况下收款账号就是签约账号
	public static final String seller_id = "2088921585773740";

	// MD5密钥，安全检验码，由数字和字母组成的32位字符串，查看地址：https://b.alipay.com/order/pidAndKey.htm
	/* public static final String key = (String) properties.get("key"); */
	public static String key = "cl91wqjmiacunlgof89wq9du8cxr1acj";

	// 服务器异步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static final String notify_url = "http://192.168.3.27:8080/lndx/alipay/notify/ALIPAY";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static final String return_url = "http://192.168.3.27:8080/lndx/alipay/result/ALIPAY";

	// 签名方式
	public static final String sign_type = "MD5";

	// 调试用，创建TXT日志文件夹路径，见AlipayCore.java类中的logResult(String sWord)打印方法。
	public static final String log_path = "C:";

	// 字符编码格式 目前支持 gbk 或 utf-8
	public static final String input_charset = "utf-8";

	// 支付类型 ，无需修改
	public static final String payment_type = "1";

	// 调用的接口名，无需修改
	public static final String service = "create_direct_pay_by_user";

	// 退款接口
	public static final String refund_service = "refund_fastpay_by_platform_nopwd";

	// 退款异步通知地址
	public static final String refund_notify_url = "http://192.168.3.13:8080/lndx/alipay/refundNotify/ALIPAY";

	// 充值异步通知地址
	public static final String dback_notify_url = "https:www.alipay.com";

	// 账单保存路径
	public static final String accountDir = "D:/account";

	// 获取key
	public static void getKeyData(String strKey) {
		key = strKey;
	}

	// ↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

	// ↓↓↓↓↓↓↓↓↓↓ 请在这里配置防钓鱼信息，如果没开通防钓鱼功能，为空即可 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 防钓鱼时间戳 若要使用请调用类文件submit中的query_timestamp函数
	public static final String anti_phishing_key = "";

	// 客户端的IP地址 非局域网的外网IP地址，如：221.0.0.1
	public static final String exter_invoke_ip = "";

	// ↑↑↑↑↑↑↑↑↑↑请在这里配置防钓鱼信息，如果没开通防钓鱼功能，为空即可 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

}
