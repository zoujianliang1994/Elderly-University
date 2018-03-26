package com.zhimu.commons.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class HashMapUtils {
	public static List<Map<String, Object>> removeRepeatData(List<PageData> list, String mapKey) {
		List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
		Map<String, Map> msp = new HashMap<String, Map>();
		System.out.println("初始数据：" + list.toString());
		// 把list中的数据转换成msp,去掉同一id值多余数据，保留查找到第一个id值对应的数据
		for (int i = list.size() - 1; i >= 0; i--) {
			Map map = list.get(i);
			String id = (String) map.get(mapKey);
			map.remove(mapKey);
			msp.put(id, map);
		}
		// 把msp再转换成list,就会得到根据某一字段去掉重复的数据的List<Map>
		Set<String> mspKey = msp.keySet();
		for (String key : mspKey) {
			Map newMap = msp.get(key);
			newMap.put(mapKey, key);
			listMap.add(newMap);
		}
		System.out.println("去掉重复数据后的数据：" + listMap.toString());
		return listMap;
	}
}
