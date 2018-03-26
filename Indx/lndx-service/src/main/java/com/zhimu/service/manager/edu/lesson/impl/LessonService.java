package com.zhimu.service.manager.edu.lesson.impl;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.lesson.LessonManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("lessonService")
public class LessonService implements LessonManager {

  @Resource(name = "daoSupport")
  private DaoSupport dao;

  public List<PageData> lessonListPage(Page pd) throws Exception {
    return (List<PageData>) dao.findForList("LessonMapper.datalistPage", pd);
  }

  public List<PageData> lessonList(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("LessonMapper.selectList", pd);
  }

  public List<PageData> graduesList(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("LessonMapper.graduesList", pd);
  }


  public PageData findDataById(PageData pd) throws Exception {
    return (PageData) dao.findForObject("LessonMapper.findDataById", pd);
  }

  public void addData(PageData pd) throws Exception {
    dao.save("LessonMapper.addData", pd);
  }

  public void editData(PageData pd) throws Exception {
    dao.update("LessonMapper.editData", pd);
  }

  public void deleteData(PageData pd) throws Exception {
    dao.delete("LessonMapper.deleteData", pd);
  }
}
