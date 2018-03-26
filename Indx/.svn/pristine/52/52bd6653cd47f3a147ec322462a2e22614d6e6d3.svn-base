package com.zhimu.service.manager.system.attachment;

import java.util.List;

import com.zhimu.dao.entity.system.Attachment;

/**
 * 附件业务
 * 
 * @author Weiyunchao
 * 
 *         2017年8月8日上午11:21:11
 */
public interface AttachmentManager {

	/**
	 * 保存附件
	 * 
	 * @param attachment
	 * @throws Exception
	 */
	public void save(Attachment attachment) throws Exception;

	/**
	 * 下载附件
	 * 
	 * @param attachment
	 * @throws Exception
	 */
	public Attachment findAttachmentById(Attachment attachment) throws Exception;

	/**
	 * 通过业务ID找到所有的附件列表
	 * 
	 * @param attachment
	 * @return
	 * @throws Exception
	 */
	public List<Attachment> findAttachmentByBusinessId(Attachment attachment) throws Exception;

	/**
	 * 删除附件文件
	 * 
	 * @param attachment
	 * @throws Exception
	 */
	public void deleteAttachment(Attachment attachment) throws Exception;

	/**
	 * 更新附件业务数据ID
	 * 
	 * @param attachment
	 * @throws Exception
	 */
	public void updateBuinessIdById(Attachment attachment) throws Exception;
}
