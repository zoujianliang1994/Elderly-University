package com.zhimu.service.manager.edu.teachPlan;


import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;

import java.util.List;

public interface TeachPlanManager {

  List<PageData> teachPlanListPage(Page pd) throws Exception;

  PageData findDataById(PageData pd) throws Exception;

  void addData(PageData pd) throws Exception;

  void editData(PageData pd) throws Exception;

  void editShData(PageData pd) throws Exception;

  void deleteData(PageData pd) throws Exception;

  List<PageData> getSchoolGrades(String schoolId) throws Exception;

}
