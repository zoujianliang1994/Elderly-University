package com.zhimu.service.manager.edu.financial;


import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.entity.system.Page;

import java.util.List;

public interface WagesManager {

  List<PageData> wageslistPage(Page pd) throws Exception;

  List<PageData> selectListMonth(PageData pd) throws Exception;

  List<PageData> selectListYear(PageData pd) throws Exception;

}
