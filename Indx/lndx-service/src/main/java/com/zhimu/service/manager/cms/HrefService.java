package com.zhimu.service.manager.cms;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;

@Service("hrefService")
public class HrefService {
	
	@Autowired
	private DaoSupport hrefDao;
	
	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listPages(Page page) throws Exception {
		return (List<PageData>) hrefDao.findForList("HrefMapper.datalistPage", page);
	}
	
	/**
	 * 保存
	 */
	public void save(PageData pd) throws Exception {
		hrefDao.save("HrefMapper.addHref", pd);
	}
	
	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception {
		hrefDao.delete("HrefMapper.deleteHref", pd);
	}
	
	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void update(PageData pd) throws Exception {
		hrefDao.update("HrefMapper.updateHref", pd);
	}
}
