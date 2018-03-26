package com.zhimu.controller.manager.app;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.PropertyUtils;
import com.zhimu.controller.manager.base.BaseController;

@Controller
@RequestMapping(value = "/app")
public class appController extends BaseController {

	/**
	 * APP更新验证
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/version")
	@ResponseBody
	public Object edit() throws Exception {
		PageData pd = new PageData();
		String msg = "";
		String url = PropertyUtils.getValue("APP_URL");
		String describe = PropertyUtils.getValue("APP_DESCRIBE");
		String newVersion = PropertyUtils.getValue("APP_VERSION");
		Map<String, String> map = new HashMap<String, String>();
		try {
			pd = this.getPageData();
			String appVersion = pd.getString("version");
			if (newVersion.equals(appVersion)) {
				msg = "true";
			} else {
				msg = "false";
			}

		} catch (Exception e) {
			logger.error(e.toString(), e);
			msg = "error";
		}
		map.put("msg", msg);
		map.put("url", url);
		map.put("describe", describe);
		map.put("newVersion", newVersion);
		return AppUtil.returnObject(new PageData(), map);
	}

}