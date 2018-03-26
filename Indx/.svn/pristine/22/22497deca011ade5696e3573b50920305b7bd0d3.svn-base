package com.zhimu.commons.utils;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

public class PropertyUtils extends PropertyPlaceholderConfigurer {
	public static final Logger logger = Logger.getLogger(PropertyUtils.class);
	private static Map<String, String> propertyMap;

	@Override
	protected void processProperties(ConfigurableListableBeanFactory beanFactoryToProcess, Properties props) {
		super.processProperties(beanFactoryToProcess, props);
		propertyMap = new HashMap<String, String>();
		for (Object key : props.keySet()) {
			String keyStr = key.toString();
			String value = props.getProperty(keyStr);
			propertyMap.put(keyStr, value);
		}
	}

	public static String getValue(String name) {
		String value = propertyMap.get(name);
		if ("".equals(value)) {
			return "";
		} else {
			return value;
		}
	}

	public static String getRoot() {
		String rootKey = "managementCenter.root";
		String cmsRootString = System.getProperty(rootKey);
		Enumeration<?> enu = System.getProperties().propertyNames();
		if (cmsRootString.endsWith(java.io.File.separatorChar + "")) {
			cmsRootString = cmsRootString.substring(0, cmsRootString.length() - 1);
		}
		logger.info(cmsRootString);
		return cmsRootString;
	}

}
