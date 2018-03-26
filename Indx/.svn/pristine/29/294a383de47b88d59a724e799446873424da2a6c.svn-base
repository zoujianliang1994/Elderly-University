package com.zhimu.service.manager.edu.teacherApply.impl;

import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.teacherApply.TeacherApplyManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.List;

@Service("teacherApplyService")
public class TeacherApplyService implements TeacherApplyManager {

  @Resource(name = "daoSupport")
  private DaoSupport dao;

  public List<PageData> teacherApplyListPage(Page pd) throws Exception {
    return (List<PageData>) dao.findForList("TeacherApplyMapper.datalistPage", pd);
  }

  public List<PageData> teacherApplyList(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("TeacherApplyMapper.selectList", pd);
  }

  public PageData findDataById(PageData pd) throws Exception {
    return (PageData) dao.findForObject("TeacherApplyMapper.findDataById", pd);
  }

  public void addData(PageData pd) throws Exception {
    dao.save("TeacherApplyMapper.addData", pd);
    pd.put("teacherApply_id", pd.getString("id"));
    //修改当前正常排课
    dao.update("TeacherApplyMapper.updateTeacherPk", pd);
  }

  public void editData(PageData pd) throws Exception {
    dao.update("TeacherApplyMapper.editData", pd);
  }

  public void deleteData(PageData pd) throws Exception {
    dao.delete("TeacherApplyMapper.deleteData", pd);
  }
}
