package com.zhimu.service.manager.edu.agreement;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.service.manager.edu.school.SchoolService;

@Service("agreeMentService")
public class AgreeMentService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@Resource(name = "schoolService")
	private SchoolService schoolService;

	/**
	 * 根据学校ID获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findDataBySid(PageData pd) throws Exception {
		// 获取当前登录人学校信息
		PageData schoolPd = schoolService.getSchoolById(pd);
		if (null != schoolPd) {
			PageData result = (PageData) dao.findForObject("AgreeMentMapper.findDataBySid", schoolPd.getString("id"));
			if (null == result) {
				result = new PageData();
			}
			result.put("s_id", schoolPd.getString("id"));
			return result;
		}
		return null;
	}

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void addData(PageData pd) throws Exception {
		dao.save("AgreeMentMapper.addData", pd);
	}

	/**
	 * 编辑
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editData(PageData pd) throws Exception {
		dao.update("AgreeMentMapper.editData", pd);
	}

}
