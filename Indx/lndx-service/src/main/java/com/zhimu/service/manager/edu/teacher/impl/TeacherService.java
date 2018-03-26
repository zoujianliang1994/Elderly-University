package com.zhimu.service.manager.edu.teacher.impl;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.teacher.TeacherManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("teacherService")
public class TeacherService implements TeacherManager {

  @Resource(name = "daoSupport")
  private DaoSupport dao;

  public List<PageData> teacherListPage(Page pd) throws Exception {
    return (List<PageData>) dao.findForList("TeacherMapper.datalistPage", pd);
  }

  public List<PageData> teacherList(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("TeacherMapper.selectList", pd);
  }

  public PageData findDataById(PageData pd) throws Exception {
    return (PageData) dao.findForObject("TeacherMapper.findDataById", pd);
  }

  public void addData(PageData pd) throws Exception {
    dao.save("TeacherMapper.addData", pd);
  }

  public void editData(PageData pd) throws Exception {
    dao.update("TeacherMapper.editData", pd);
  }

  public void updateData(PageData pd) throws Exception {
    dao.update("TeacherMapper.updateData", pd);
  }

  public void deleteData(PageData pd) throws Exception {
    dao.delete("TeacherMapper.deleteData", pd);
  }

  @Override
  public List<PageData> findBySchools(PageData pd) throws Exception {
    String[] ids = pd.getString("sId").split(",");
    pd.put("array", ids);
    return (List<PageData>) dao.findForList("TeacherMapper.findBySchools", pd);
  }

  /**
   * 根据用户id查找对应老师数据--lwc
   */
  @Override
  public PageData findByUser(String userId) throws Exception {
    return (PageData) dao.findForObject("TeacherMapper.findByUser", userId);
  }

  public List<PageData> teacherLvList(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("TeacherMapper.teacherLvList", pd);
  }

  @Override
  public PageData findBySchoolPid(String school_id) throws Exception {
    return (PageData) dao.findForObject("TeacherMapper.findBySchoolPid", school_id);
  }
}
