package com.zhimu.commons.utils;

/**
 * 行政区划工具类
 *
 * @author wangyong
 */
public class AreaCodeUtils {

  /**
   * 根据区划编码，判断查询条件范围
   */
  public static String returnXzqh(String xzqh) {
    if ("".equals(xzqh) || null == xzqh || xzqh.equals("510000000000")) {
      return "";
    }
    xzqh = xzqh.trim();
    int number_1 = xzqh.substring(4).length() - xzqh.substring(4).replaceAll("0", "").length();
    if (number_1 == 8) {
      return xzqh.substring(0, 4);
    }
    int number_2 = xzqh.substring(6).length() - xzqh.substring(6).replaceAll("0", "").length();
    if (number_2 == 6) {
      return xzqh.substring(0, 6);
    }
    int number_3 = xzqh.substring(9).length() - xzqh.substring(9).replaceAll("0", "").length();
    if (number_3 == 3) {
      return xzqh.substring(0, 9);
    }
    return xzqh;
  }
}
