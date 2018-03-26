package com.zhimu.controller.manager.system.head;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhimu.commons.constant.Const;
import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.utils.Jurisdiction;
import com.zhimu.service.manager.system.user.UserManager;

/**
 * 类名称：HeadController
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/head")
public class HeadController extends BaseController {

	@Resource(name = "userService")
	private UserManager userService;

	/**
	 * 获取头部信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getList")
	@ResponseBody
	public Object getList() {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			Session session = Jurisdiction.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute(Const.SESSION_userpds);
			if (null == pds) {
				pd.put("USERNAME", Jurisdiction.getUsername());// 当前登录者用户名
				pds = userService.findByUsername(pd);
				session.setAttribute(Const.SESSION_userpds, pds);
			}
			pdList.add(pds);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "获取头部信息"));
		} finally {
		}
		return AppUtil.returnObject(pd, map);
	}
}
