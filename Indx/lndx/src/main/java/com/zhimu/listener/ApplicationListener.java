package com.zhimu.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import net.sf.json.JSONArray;

import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.service.manager.websocket.SocketIoManager;

public class ApplicationListener implements ServletContextListener {
	protected org.slf4j.Logger logger = LoggerFactory.getLogger(this.getClass());
	public static JSONArray json = new JSONArray();
	public static JSONArray jsonArea = new JSONArray();

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// 关闭socket服务
		ApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(sce.getServletContext());
		Object obj = context.getBean("socketIoService");
		SocketIoManager socketManager = (SocketIoManager) obj;
		System.out.println("******************消息服务关闭开始******************");
		socketManager.stopServer();
		System.out.println("******************消息服务关闭结束******************");
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		try {
			// ApplicationContext context =
			// WebApplicationContextUtils.getRequiredWebApplicationContext(sce.getServletContext());
			// Object obj = context.getBean("departmentService");
			// Object areaCodeServiceBean = context.getBean("areaCodeService");
			// Object redisCacheUtilBean = context.getBean("redisCacheUtil");

			// DepartmentService departmentService = (DepartmentService) obj;
			// AreaCodeService areaCodeService = (AreaCodeService)
			// areaCodeServiceBean;
			// RedisCacheUtil redisCacheUtil = (RedisCacheUtil)
			// redisCacheUtilBean;
			// json = departmentService.listAllDepartmentStree("0", null);
			// jsonArea = areaCodeService.listAreaCodeStree("0", "0");

			// ServletContext sc = sce.getServletContext();
			// sc.setAttribute("deptJson", json);
			// sc.setAttribute("areaJson", jsonArea);
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "显示列表ztree异常"));
		}

	}
}