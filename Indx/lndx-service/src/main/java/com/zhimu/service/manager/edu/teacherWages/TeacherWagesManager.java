package com.zhimu.service.manager.edu.teacherWages;


import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;

import java.util.List;

public interface TeacherWagesManager {

  List<PageData> teacherWagesListPage(Page pd) throws Exception;

  PageData findDataById(PageData pd) throws Exception;

  void editData(PageData pd) throws Exception;

  void deleteData(PageData pd) throws Exception;

  List<PageData> selectPkList(PageData pd) throws Exception;

  List<PageData> myWagesList(PageData pd) throws Exception;

  List<PageData> myWagesDetail(PageData pd) throws Exception;

  void sendWagesToTeacher(PageData pd) throws Exception;

}
