package com.zhimu.service.manager.system.attachment.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Attachment;
import com.zhimu.service.manager.system.attachment.AttachmentManager;

/**
 * 附件业务实现类
 * 
 * @author Weiyunchao
 * 
 *         2017年8月8日上午11:25:25
 */
@Service("attachmentService")
public class AttachmentService implements AttachmentManager {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@Override
	public void save(Attachment attachment) throws Exception {
		dao.save("AttachmentMapper.save", attachment);
	}

	@Override
	public Attachment findAttachmentById(Attachment attachment) throws Exception {
		return (Attachment) dao.findForObject("AttachmentMapper.findById", attachment);
	}

	@Override
	public List<Attachment> findAttachmentByBusinessId(Attachment attachment) throws Exception {
		return (List<Attachment>) dao.findForList("AttachmentMapper.findByBusinessId", attachment);
	}

	@Override
	public void deleteAttachment(Attachment attachment) throws Exception {
		dao.delete("AttachmentMapper.delete", attachment);

	}

	@Override
	public void updateBuinessIdById(Attachment attachment) throws Exception {
		dao.update("AttachmentMapper.updateBuinessIdById", attachment);

	}
}
