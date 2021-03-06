package com.zhimu.service.manager.edu.studentFiles;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;

import java.util.List;
import java.util.Map;

/**
 * Created by HASEE on 2018/1/3.
 */
public interface ScheduleManager {


  List<PageData> schedulelistPage(Page pd) throws Exception;

  void add(PageData pd) throws Exception;

  PageData findObjectById(PageData pd)  throws Exception ;

  void edit(PageData pd) throws Exception;

  void deleteById(String id) throws Exception;

  List<PageData> getAllSemesterBySchool(String[] schoolId) throws Exception;

  List<PageData> getScheduleBySemesterId(String semester_id)throws Exception;

  Map<String,Object> getDetailsById(PageData pd)throws Exception;

  /**
   * 根据学期id和班级id数组查到对应的课程表数据
   * @param pageData
   * @return
   * @throws Exception
   */
  public List<PageData> findByGIdAndSId(PageData pageData) throws Exception;

  String ischeakDetail(PageData pd) throws Exception;

  void addDetails(PageData pd) throws Exception;

  void deleteDetailById(PageData pd)throws Exception;

  List<PageData> scheduleList(PageData pg)throws Exception;

  List<PageData> getDetailsByid(PageData pg)throws Exception;

  PageData getGradesDetail(PageData pd) throws Exception;
}
