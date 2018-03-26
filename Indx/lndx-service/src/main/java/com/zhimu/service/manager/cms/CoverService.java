package com.zhimu.service.manager.cms;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("coverService")
public class CoverService {
  protected final Logger logger = Logger.getLogger(this.getClass());
  @Autowired
  private DaoSupport coverDao;

  /**
   * 列表
   *
   * @param page
   * @throws Exception
   */
  public List<PageData> listPages(Page page) throws Exception {
    return (List<PageData>) coverDao.findForList("CoverMapper.datalistPage", page);
  }


  /**
   * 根据id获取列表
   *
   * @param pd
   * @throws Exception
   */
  public PageData getIdInfo(PageData pd) throws Exception {
    return (PageData) coverDao.findForObject("CoverMapper.getIdInfo", pd);
  }

  /**
   * 新增
   *
   * @param pd
   * @throws Exception
   */
  public void addData(PageData pd) throws Exception {
    coverDao.save("CoverMapper.addData", pd);
  }


  /**
   * 修改
   *
   * @param pd
   * @throws Exception
   */
  public void updateData(PageData pd) throws Exception {
    coverDao.update("CoverMapper.updateData", pd);
  }

  /**
   * 删除
   *
   * @param pd
   * @throws Exception
   */
  public void delData(PageData pd) throws Exception {
    coverDao.delete("CoverMapper.delData", pd);
  }

}
