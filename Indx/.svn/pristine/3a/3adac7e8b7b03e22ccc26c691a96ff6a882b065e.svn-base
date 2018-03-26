package com.zhimu.service.manager.system.personalpanel;

import java.util.List;

import javax.annotation.Resource;

import com.zhimu.dao.entity.system.User;
import org.springframework.stereotype.Service;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;

/**
 * 个人面板
 * 
 * @author wangyong
 * 
 */
@Service("personalPanelService")
public class PersonalPanelService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 列表
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("PersonalPanelMapper.listPage", page);
	}

	/**
	 * 获取未读消息数
	 * 
	 * @param user
	 * @return
	 * @throws NumberFormatException
	 * @throws Exception
	 */
	public int getTotalMsgNum(User user) throws NumberFormatException, Exception {
		return Integer.parseInt(dao.findForObject("PersonalPanelMapper.getTotalMsgNum", user).toString());
	}

}
