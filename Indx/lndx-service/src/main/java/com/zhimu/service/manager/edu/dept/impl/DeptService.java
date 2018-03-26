package com.zhimu.service.manager.edu.dept.impl;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.dept.DeptManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("deptService")
public class DeptService implements DeptManager {

  @Resource(name = "daoSupport")
  private DaoSupport dao;

  public List<PageData> deptlistPage(Page pd) throws Exception {
    return (List<PageData>) dao.findForList("DeptMapper.datalistPage", pd);
  }

  public List<PageData> selectList(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("DeptMapper.selectList", pd);
  }

  public PageData findDataById(PageData pd) throws Exception {
    return (PageData) dao.findForObject("DeptMapper.findDataById", pd);
  }

  public void addData(PageData pd) throws Exception {
    dao.save("DeptMapper.addData", pd);
  }

  public void editData(PageData pd) throws Exception {
    dao.update("DeptMapper.editData", pd);
  }

  public void deleteData(PageData pd) throws Exception {
    dao.delete("DeptMapper.deleteData", pd);
  }
}
