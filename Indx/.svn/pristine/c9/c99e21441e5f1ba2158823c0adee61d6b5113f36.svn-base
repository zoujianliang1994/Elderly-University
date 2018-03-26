package com.zhimu.service.manager.edu.notice;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.message.Message;
import com.zhimu.dao.entity.system.Page;

import java.util.List;

/**
 *   通知公告
 * @author liangwenchao
 *
 */
public interface NoticeManager {
	
	/**
	 *   保存推送消息
	 * @param message
	 * @return
	 */
	public void saveMessage(Message message) throws Exception;
	/**
	 *    根据消息ID查询
	 * @param id
	 * @return
	 */
	public Message findById(String id) throws Exception;
	/**
	 *   根据消息的用户ID查询
	 * @param pd
	 * @return
	 */
	public List<PageData> findByUserId(PageData pd) throws Exception;

	/**
	 *  查询个人公告列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageByUser(Page page) throws  Exception;
	/**
	 *   查询所有消息列表
	 * @param message
	 * @return
	 */
	public List<Message> listAll(Message message) throws Exception;

	/**
	 * 根据id删除消息
	 * @param id
	 * @throws Exception
	 */
	public void delete(String id) throws Exception;

	/**
	 * 修改消息
	 * @param message
	 * @throws Exception
	 */
	public void edit(Message message) throws Exception;
}

