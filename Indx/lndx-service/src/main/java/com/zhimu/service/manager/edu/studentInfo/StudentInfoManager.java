package com.zhimu.service.manager.edu.studentInfo;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;

import java.util.List;
import java.util.Map;

/**
 * Created by HASEE on 2018/1/3.
 */
public interface StudentInfoManager {


  List<PageData> studentInfolistPage(Page pd) throws Exception;


  PageData findObjectById(PageData pd) throws Exception;

  void edit(PageData pd) throws Exception;

  List<PageData>  getStuGradesJson(PageData pd) throws Exception;

  void addTuition(List<PageData> list) throws Exception;

  int getStuGradesTuition(PageData pd) throws Exception;

  List<PageData> getAllStudentBycId(PageData pc) throws Exception;

  void studentTransfer(PageData info) throws Exception;

  void studentJoin(PageData stu) throws Exception;

  List<PageData> getStuGradesLesson(PageData pd) throws Exception;

  int graduation(PageData pd) throws Exception;

  List<PageData> getStuGradesDetail(String[] grades) throws Exception;

  List<PageData> getStuTuitionDetail(String id) throws Exception;

  List<PageData> getStuStatusDetail(String id) throws Exception;
}
