package com.zhimu.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.utils.HttpUtils;

/**
 * sping拦截器,在视图渲染前执行，方便每个页面获取通用值
 * 
 * @author: taikoo
 * @date: 2017年7月11日 下午4:53:13
 * 
 */
@Component("globalInterceptor")
public class GlobalInterceptor implements HandlerInterceptor {
	/*
	 * @Autowired private FolderService folderfigService;
	 */
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if (null == modelAndView) {
			return;
		}
		String basePath = HttpUtils.getBasePath(request);
		modelAndView.addObject("basePath", basePath);
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		return true;
	}

}
