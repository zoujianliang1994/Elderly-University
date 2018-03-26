package com.zhimu.service.manager.cms;

import java.lang.reflect.Method;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.stereotype.Service;

@Service
public class KeyGeneratorService implements KeyGenerator {
	
	protected final Logger logger = Logger.getLogger(this.getClass());

	
	public Object generate(Object target, Method method, Object... params) {
		String key = method.getName().toLowerCase() + "_" + StringUtils.join(params, "_");
		logger.debug("KEY："+key);
		return key;
	}

	public static void main(String[] args) {

	}
}
