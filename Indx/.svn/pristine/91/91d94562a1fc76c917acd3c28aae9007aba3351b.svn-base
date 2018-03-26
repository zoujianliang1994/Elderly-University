package com.zhimu.commons.utils;

import java.util.Calendar;

/**
 * 计算两点之间的距离
 * @author Liang.Yuan
 * <br>2016年6月5日
 */
public class DistanceUtil {

	//地球半径
	private static final double EARTH_RADIUS = 6378137;

	private static double rad(double d) {
		return d * Math.PI / 180.0;
	}

	/**
	 * 
	 * @param lng1  第一个点的经度
	 * @param lat1   第一个点的纬度
	 * @param lng2  第二个点的经度
	 * @param lat2   第二个点的经度
	 * @return  两点之间的距离
	 * @author Liang.Yuan
	 * <br>2016年6月5日
	 */
	public static double GetDistance(double lng1, double lat1, double lng2, double lat2) {
		double radLat1 = rad(lat1);
		double radLat2 = rad(lat2);
		double a = radLat1 - radLat2;
		double b = rad(lng1) - rad(lng2);
		double s = 2 * Math.asin(Math
		    .sqrt(Math.pow(Math.sin(a / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)));
		s = s * EARTH_RADIUS;
		s = Math.round(s * 10000) / 10000;
		return s;
	}
	public static void main(String[] args) {
		Calendar calendar=Calendar.getInstance();
		calendar.add(Calendar.MINUTE, 50);
		System.out.println(calendar.get(Calendar.HOUR_OF_DAY));
		System.out.println(calendar.getTime().toString());
	}

}
