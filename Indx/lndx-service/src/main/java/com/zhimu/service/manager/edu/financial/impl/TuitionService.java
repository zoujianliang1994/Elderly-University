package com.zhimu.service.manager.edu.financial.impl;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.financial.TuitionManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("tuitionService")
public class TuitionService implements TuitionManager {

  @Resource(name = "daoSupport")
  private DaoSupport dao;

  public List<PageData> tuitionListPage(Page pd) throws Exception {
    return (List<PageData>) dao.findForList("TuitionMapper.tuitionListData", pd);
  }

  public List<PageData> selectListAllSemester(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("TuitionMapper.selectListAllSemester", pd);
  }

  public List<PageData> selectListSemester(String schoolId) throws Exception {
    return (List<PageData>) dao.findForList("TuitionMapper.selectListSemester", schoolId);
  }

  public List<PageData> selectTuitionList(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("TuitionMapper.selectTuitionList", pd);
  }

  public List<PageData> selectOtherName(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("TuitionMapper.selectOtherName", pd);
  }

}
