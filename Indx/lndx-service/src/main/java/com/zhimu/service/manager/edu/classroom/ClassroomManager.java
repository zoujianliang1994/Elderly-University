package com.zhimu.service.manager.edu.classroom;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;

import java.util.List;
import java.util.Map;

/**
 * Created by HASEE on 2018/1/3.
 */
public interface ClassroomManager {


  List<PageData> classroomlistPage(Page pd) throws Exception;

  void add(PageData pd) throws Exception;

  PageData findObjectById(PageData pd)  throws Exception ;

  void edit(PageData pd) throws Exception;

  void deleteById(String id) throws Exception;

  List<PageData> findObjectBySchoolId(String school_id) throws Exception;

  Map<String,Object> getClassroomUse(PageData pd) throws Exception;
}
