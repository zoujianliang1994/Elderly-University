package com.zhimu.service.manager.edu.activity;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;

import java.util.List;

/**
 * 活动管理服务层_lwc
 */
public interface ActivityManager {

	/**
	 * 活动列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPage(Page pd) throws Exception;

	/**
	 * 保存活动
	 * @param pd
	 * @throws Exception
	 */
	public void add(PageData pd, String[] respContents) throws Exception;

	/**
	 * 根据id查询
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findObjectById(PageData pd) throws Exception;

	/**
	 * 根据id查询
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;

	/**
	 * 删除
	 * @param id
	 * @throws Exception
	 */
	public void deleteById(String id) throws Exception;

}
