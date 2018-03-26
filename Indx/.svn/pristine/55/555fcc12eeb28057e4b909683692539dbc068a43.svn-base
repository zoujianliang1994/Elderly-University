package com.zhimu.commons.utils;

import java.io.UnsupportedEncodingException;

import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import org.springframework.web.util.HtmlUtils;

/**
 * @author GunnyZeng
 * 
 */
public class SSUtils {

	/**
	 * 把骆驼命名法的变量，变为大写字母变小写且之前加下划线
	 * 
	 * @param str
	 * @return
	 */
	public static String toUnderline(String str) {
		str = capitalize(str);
		char[] letters = str.toCharArray();
		StringBuilder sb = new StringBuilder();
		for (char letter : letters) {
			if (Character.isUpperCase(letter)) {
				sb.append("_" + letter + "");
			} else {
				sb.append(letter + "");
			}
		}
		return lowerCase(sb.toString());
	}

	public static String toText(String str) {
		return HtmlUtils.htmlEscape(str);
	}
	
	public static String toHTML(String str) {
		return Jsoup.clean(str, Whitelist.relaxed());
	}
	 public static String lowerCase(String str) {
	        if (str == null) {
	            return null;
	        }
	        return str.toLowerCase();
	    }
	 public static String capitalize(String str) {
	        int strLen;
	        if (str == null || (strLen = str.length()) == 0) {
	            return str;
	        }
	        return new StringBuilder(strLen)
	            .append(Character.toTitleCase(str.charAt(0)))
	            .append(str.substring(1))
	            .toString();
	    }
	/**
	 * 截取字符串指定字节长度，其他用...表示
	 * @param str
	 * @param len
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public static String getFixedLengthStr(String str,int maxLength){
		if (str == null) {
			return str;
		}
		String suffix = "...";
		int suffixLen = suffix.length();
		
		final StringBuffer sbuffer = new StringBuffer();
		final char[] chr = str.trim().toCharArray();
		int len = 0;
		for (int i = 0; i < chr.length; i++) {
			
			if (chr[i] >= 0xa1) {
				len += 2;
			} else {
				len++;
			}
		}
		
		if(len<=maxLength){
			return str;
		}
		
		len = 0;
		for (int i = 0; i < chr.length; i++) {
 
			if (chr[i] >= 0xa1) {
				len += 2;
				if (len + suffixLen > maxLength) {
					break;
				}else {
					sbuffer.append(chr[i]);
				}
			} else {
				len++;
				if (len + suffixLen > maxLength) {
					break;
				}else {
					sbuffer.append(chr[i]);
				}
			}
		}
		sbuffer.append(suffix);
		return sbuffer.toString();
	}
	public static void main(String[] args) throws UnsupportedEncodingException {
		String text = "孙来斌：知识分子要做践行核心价值观的模范";
		System.out.println(getFixedLengthStr(text, 40));
		System.out.println(SSUtils.toText(text));
	}
}
