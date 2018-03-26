package com.zhimu.service.manager.edu.classroom.impl;


import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.classroom.ClassroomManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service("classroomService")
public class ClassroomService implements ClassroomManager {

  @Resource(name = "daoSupport")
  private DaoSupport dao;


  @Override
  public List<PageData> classroomlistPage(Page pd) throws Exception {

    return (List<PageData>) dao.findForList("ClassroomMapper.classroomlistPage", pd);

  }

  @Override
  public void add(PageData pd) throws Exception {
    dao.save("ClassroomMapper.save", pd);
  }

  /**
   * 通过id获取数据
   *
   * @param pd
   * @throws Exception
   */
  public PageData findObjectById(PageData pd) throws Exception {
    return (PageData) dao.findForObject("ClassroomMapper.findById", pd);
  }

  /**
   * 修改
   *
   * @param pd
   * @throws Exception
   */
  public void edit(PageData pd) throws Exception {
    dao.update("ClassroomMapper.edit", pd);
  }

  @Override
  public void deleteById(String id) throws Exception {
    dao.update("ClassroomMapper.deleteById", id);
  }

  @Override
  public List<PageData> findObjectBySchoolId(String school_id) throws Exception {

    return (List<PageData>) dao.findForList("ClassroomMapper.findObjectBySchoolId", school_id);
  }

  @Override
  public Map<String,Object> getClassroomUse(PageData pd) throws Exception {

    List<PageData> list = (List<PageData>) dao.findForList("ClassroomMapper.getClassroomUse", pd);

    List<PageData> Monday = new ArrayList<PageData>();
    List<PageData> Tuesday = new ArrayList<PageData>();
    List<PageData> Wednesday = new ArrayList<PageData>();
    List<PageData> Thursday = new ArrayList<PageData>();
    List<PageData> Friday = new ArrayList<PageData>();
    //循环list
    for (int j = 0; j < list.size(); j++) {

      switch (Integer.parseInt(list.get(j).get("week") + "")) {
        case 1:
          Monday.add(list.get(j));
          break;
        case 2:
          Tuesday.add(list.get(j));
          break;
        case 3:
          Wednesday.add(list.get(j));
          break;
        case 4:
          Thursday.add(list.get(j));
          break;
        case 5:
          Friday.add(list.get(j));
          break;

      }

    }
    Map<String, Object> map = new LinkedHashMap<String, Object>();
    map.put("Monday", Monday);
    map.put("Tuesday", Tuesday);
    map.put("Wednesday", Wednesday);
    map.put("Thursday", Thursday);
    map.put("Friday", Friday);

    return map;
  }



}
