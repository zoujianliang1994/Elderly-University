package com.zhimu.service.manager.edu.lesson;


import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;

import java.util.List;

public interface LessonManager {

  List<PageData> lessonListPage(Page pd) throws Exception;

  List<PageData> lessonList(PageData pd) throws Exception;

  List<PageData> graduesList(PageData pd) throws Exception;

  PageData findDataById(PageData pd) throws Exception;

  void addData(PageData pd) throws Exception;

  void editData(PageData pd) throws Exception;

  void deleteData(PageData pd) throws Exception;

}
