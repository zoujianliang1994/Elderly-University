package com.zhimu.service.manager.edu.financial.impl;

import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.financial.WagesManager;
import com.zhimu.service.manager.edu.teacherWages.TeacherWagesManager;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.List;

@Service("wagesService")
public class WagesService implements WagesManager {

  @Resource(name = "daoSupport")
  private DaoSupport dao;

  public List<PageData> wageslistPage(Page pd) throws Exception {
    return (List<PageData>) dao.findForList("WagesMapper.datalistPage", pd);
  }

  public List<PageData> selectListMonth(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("WagesMapper.selectListMonth", pd);
  }

  public List<PageData> selectListYear(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("WagesMapper.selectListYear", pd);
  }

}
