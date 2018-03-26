package com.zhimu.commons.utils;

public class UrlUtils {

	public String cleanHttpPro(String url){
		url=url.toLowerCase();
		url=url.replace("http://", "");
		url=url.replace("https://", "");
		return url;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(new UrlUtils().cleanHttpPro("HTTP://www.baidu.com"));
	}

}
