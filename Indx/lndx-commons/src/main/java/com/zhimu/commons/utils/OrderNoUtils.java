package com.zhimu.commons.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

public class OrderNoUtils {

	public static String getOrderNo() {
		String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + "";
		String seed = "999999";
		String noStr = new Random().nextInt(Integer.parseInt(seed)) + "";
		StringBuffer result = new StringBuffer();
		result.append(timestamp);
		for (int i = 0; i < (seed.length() - noStr.length()); i++) {
			result.append("0");
		}
		result.append(noStr);
		return result.toString();
	}

	// 生成20位随机数
	public static String newGuid20() {
		String str1 = "";
		String[] strArr36 = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
				"y", "z" };
		Calendar cal = Calendar.getInstance();
		int yy = cal.get(Calendar.YEAR);
		int mm = cal.get(Calendar.MONTH) + 1;
		int dd = cal.get(Calendar.DAY_OF_MONTH);
		yy = (yy % 100) % 36;
		int hh = 100 + cal.get(Calendar.HOUR);
		;
		int mins = 100 + cal.get(Calendar.MINUTE);
		int sec = 100 + cal.get(Calendar.SECOND);
		String hhstr = ("" + hh).substring(1);
		String minsStr = ("" + mins).substring(1);
		String secStr = ("" + sec).substring(1);

		str1 = strArr36[yy] + strArr36[mm] + strArr36[dd] + hhstr + minsStr + secStr;
		StringBuilder sb = new StringBuilder("");
		for (int i = 0; i < 11; i++) {
			int k = (int) (Math.random() * 35);
			sb.append(strArr36[k]);
		}
		str1 = str1 + sb.toString();
		return str1;
	}

	public static void main(String[] args) {
		System.out.println("this order no is :" + getOrderNo());
	}
}
