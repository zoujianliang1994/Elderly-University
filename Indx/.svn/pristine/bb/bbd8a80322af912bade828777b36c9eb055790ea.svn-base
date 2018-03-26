package com.zhimu.service.manager.cms;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.cms.Navigation;
import com.zhimu.dao.entity.system.Page;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("navigationService")
public class NavigationService {
  protected final Logger logger = Logger.getLogger(this.getClass());
  @Autowired
  private DaoSupport navigationDao;

  /**
   * 列表
   *
   * @param page
   * @throws Exception
   */
  @SuppressWarnings("unchecked")
  public List<PageData> listPages(Page page) throws Exception {
    return (List<PageData>) navigationDao.findForList("NavigationMapper.datalistPage", page);
  }


  /**
   * 列表
   *
   * @param ID
   * @throws Exception
   */
  @SuppressWarnings("unchecked")
  public List<Navigation> cmsListIndex(String ID) throws Exception {
    return (List<Navigation>) navigationDao.findForList("NavigationMapper.cmsListIndex", ID);
  }


  /**
   * 根据id获取列表
   *
   * @param pd
   * @throws Exception
   */
  @SuppressWarnings("unchecked")
  public PageData getIdInfo(PageData pd) throws Exception {
    return (PageData) navigationDao.findForObject("NavigationMapper.getIdInfo", pd);
  }

  /**
   * 新增
   *
   * @param pd
   * @throws Exception
   */
  public void addData(PageData pd) throws Exception {
    navigationDao.save("NavigationMapper.addData", pd);
  }


  /**
   * 修改
   *
   * @param pd
   * @throws Exception
   */
  public void updateData(PageData pd) throws Exception {
    navigationDao.update("NavigationMapper.updateData", pd);
  }

  /**
   * 删除
   *
   * @param pd
   * @throws Exception
   */
  public void delData(PageData pd) throws Exception {
    navigationDao.delete("NavigationMapper.delData", pd);
  }

}
