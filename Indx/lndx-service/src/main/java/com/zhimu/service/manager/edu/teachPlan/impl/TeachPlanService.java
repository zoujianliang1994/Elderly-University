package com.zhimu.service.manager.edu.teachPlan.impl;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.teachPlan.TeachPlanManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("teachPlanService")
public class TeachPlanService implements TeachPlanManager {

  @Resource(name = "daoSupport")
  private DaoSupport dao;

  public List<PageData> teachPlanListPage(Page pd) throws Exception {
    return (List<PageData>) dao.findForList("TeachPlanMapper.datalistPage", pd);
  }

  public PageData findDataById(PageData pd) throws Exception {
    return (PageData) dao.findForObject("TeachPlanMapper.findDataById", pd);
  }

  public void addData(PageData pd) throws Exception {
    dao.save("TeachPlanMapper.addData", pd);
  }

  public void editData(PageData pd) throws Exception {
    dao.update("TeachPlanMapper.editData", pd);
  }

  public void editShData(PageData pd) throws Exception {
    dao.update("TeachPlanMapper.editShData", pd);
  }

  public void deleteData(PageData pd) throws Exception {
    dao.delete("TeachPlanMapper.deleteData", pd);
  }

  public List<PageData> getSchoolGrades(String schoolId) throws Exception {
    return (List<PageData>) dao.findForList("TeachPlanMapper.getSchoolGrades", schoolId);
  }
}
