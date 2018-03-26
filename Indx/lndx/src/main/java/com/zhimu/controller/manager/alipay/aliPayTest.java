package com.zhimu.controller.manager.alipay;

import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePrecreateRequest;
import com.alipay.api.response.AlipayTradePrecreateResponse;
import com.zhimu.commons.utils.QRCodeUtils;

@Controller
@RequestMapping(value = "/alipaytest")
public class aliPayTest {

	/**
	 * @Description: pc支付宝支付
	 * @author wy
	 * @throws Exception
	 */
	@RequestMapping(value = "/alipayInitPay")
	public void alipayInitPay(HttpServletRequest httprequest, HttpServletResponse httpresponse) throws Exception {
		AlipayClient alipayClient = new DefaultAlipayClient(
				"https://openapi.alipaydev.com/gateway.do",
				"2088921585773740",
				"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCL56SJjsVlXICUbp6ujGY40xxDh4wXY+x5S/wWT+WsdLYrpwyL/aqpEgs2mc/JqlH0t7fYq8pAb09AtGHrQ3vb8HMHXtV/AMvIICzERrLo8U3dvr0CuibGqJscrgj21gCmAN8X2ktwhTJdNtH6x6wInlph4CWikxis80OhWbEVM2irfuaohEQ925vTFHxdxa5CJGfh+05wZw9+Hvp44vwF98NOL6juQgeSCKKDAOnz0OBbmQTMMHnrxySz7B2w7oVeFwXdskaPy1KM+S/ZccKAKvcIk3ljvsjVBUrPzxQFoisAtsRssAyBWgmkqZ5AkujbekZi9AHAc8qbmsvcm/vjAgMBAAECggEAAwtNRzj2DpiOq6wkg8PGTaI6UTXX1IJ2GMWQfKPMaY44kIaX/UvNtNQRrmR2YvrzwZFlzK8gPXqujMfgAZB8V3LJ7fUgTB0mUfpxPuwS5IKroRGPZ0nJojT0+xDGXSiW5wXJ1OkJDy+2wtR4iS5jDeT0LoEEEJ+Gv+yjIhWjhsSJUQN0nB2t4JH3GVng+lDbn8EHX6LEi4zdp/JLnFuik08cwTB+1Qz4cWKKMxzIR51zqgMp6vspfvn09l6l+AyKtDb5fCQl50WhSj5lTow5QBNrKwiI/RCC0PaCrvjXutw+NbHt+Qk0klRTr8KaI38AeZ0FuDT7Ypl5/8iEZ3KG8QKBgQDRuCSa4+c8LR7L4Cbi0896BD/N1P1plnNlBT5jH18tXc6nPOq5eZBDJZZwCV8yJA3NBDmV+wgraz9oRqs9neY/gL3KOa2wfXJLBK6iq8xigZxrqFV4GA0favV8e76lzfJ7k8eKyrH7UAfbzuhXS9mg/SfzvZcEIBvkPaalo9lbFwKBgQCqx2kVoQQUOmpKgacq6u8Ir/PWnDnSe6DeY1ffwn3lG3hyix7fYVdg52wq/2Ey5KKIIKYtcdD5BjGTb9YtgM8Mo/V41lmsE94ie8fwdvnJgA1sarU0WiVLzDPGKcgi3wG2+gPAGg+7GuYabkw/Cg/Q6ea6jHaOZaoDlSd1k8p1FQKBgA7r8jbPFmnSsAlDhqDG/1EoMj379Jfpq4Y5jEnTNptsvEJr9CuEOb59UynfkNVpeU3oCgzg0qD8PYO224JD1NkZ2OclmXUgR9yMlbxfSuiLXkzOql4kH/LnUlYsG9GCSMmAJ0d5ypYeCKEcJK3paK+qs4gFKlSR0Eo6FLxeXx27AoGBAJI0CWi04jMXF2wVtzFs05rSV6RBNtdVc5Ev50juzqzXabRWGeYPBak2NkpRO7tANUzo9pstN0QZ41NfiTKHdbpSm5IJn9dLYv6Ojcr1cD7rW5KXf+4Dxq4vcZuSpX4FAQjO3WsWZKVAEAJMrwXA7W1i8V5/ZffeXUCX7qIgFlFJAoGBALGuyZ2U7vRmCs6Faig9RAnLhzFWfIrs3oMro3LZQUX5EjwmrhSRaACWuFzjntWjmurpKIEeaKvNNrq69T2qphXQpKbor8/uspdbLCTX6ObQrKuaOCzfbiqJ29RK3li7UJfKhQWlL/hWmgClGoX2DvPo/OeoIZfCpypRnXpNfDjh",
				"json",
				"utf-8",
				"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvnrJvYBW3HPgBg5iLaWa0XcnY+qH8GxyxSIm/QYyQf0ShgsU8sI53KX5T7YoDFlqqyZVM/r+z2/0wqFVkMNiHDv/yRTZAdiRqv8ha5mud84blBPvm2MyLQdjG9qh/d7a9ttWVa3OrfDd+w6a6wqY7gNMBjSgNmMBnY66+/IFQzEL2AgmS0tFFOrf+XRM74j0H3GynI8cUjJR3eKgBGRRGqMBTq8ZXqLYESYBwFP8u1QqzeGbDaSYm5qdtT76+Plhxoh90X4sTq0fQXFKLaSW0J9QY1GA6/0zq4Mm+1T2W+I2QwAMCqRC+whT0T6ZilER9k0nMIe/Ldzwjr3JH3XDqQIDAQAB",
				"MD5");
		AlipayTradePrecreateRequest request = new AlipayTradePrecreateRequest();// 创建API对应的request类
		request.setBizContent("{" + "    \"out_trade_no\":\"20150320010101013\"," + "    \"total_amount\":\"1888888.88\"," + "    \"subject\":\"Iphone66 1666G\"," + "    \"store_id\":\"NJ_001\","
				+ "    \"timeout_express\":\"90m\"}");// 设置业务参数
		AlipayTradePrecreateResponse response;
		response = alipayClient.execute(request);
		OutputStream os = httpresponse.getOutputStream();
		QRCodeUtils.encode(response.getQrCode(), os);
		System.out.print(response.getBody());
	}
}
