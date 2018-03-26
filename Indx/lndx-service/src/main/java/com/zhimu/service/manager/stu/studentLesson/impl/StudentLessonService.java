package com.zhimu.service.manager.stu.studentLesson.impl;

import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.service.manager.stu.studentLesson.StudentLessonManager;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service("studentLessonService")
public class StudentLessonService implements StudentLessonManager {

  @Resource(name = "daoSupport")
  private DaoSupport dao;

  public Map<String, Object> studentLessonList(PageData pd) throws Exception {

    String childSchId = pd.getString("school_child_id"); // 分校id
    if (StringUtils.isNotBlank(childSchId)){ // 如果选了分校区,就将分校id设为学校id
      pd.put("school_id", childSchId);
    }

    List<PageData> all = (List<PageData>) dao.findForList("studentLessonMapper.dataList", pd);
    // Set<PageData> allSchedule = new HashSet<>(all);
    // all = new ArrayList<>(allSchedule);

    List<PageData> amMonday = new ArrayList<>();
    List<PageData> amTuesday = new ArrayList<>();
    List<PageData> amWednesday = new ArrayList<>();
    List<PageData> amThursday = new ArrayList<>();
    List<PageData> amFriday = new ArrayList<>();

    List<PageData> pmMonday = new ArrayList<>();
    List<PageData> pmTuesday = new ArrayList<>();
    List<PageData> pmWednesday = new ArrayList<>();
    List<PageData> pmThursday = new ArrayList<>();
    List<PageData> pmFriday = new ArrayList<>();

    Set<String> teacherNames = new HashSet<>();

    //循环list
    for (int j = 0; j < all.size(); j++) {
      PageData data = all.get(j);
      teacherNames.add(data.getString("teacher_name"));
      PageData am = new PageData();
      PageData pm = new PageData();
      if ("1".equals(data.get("period") + "")) {
        //上午
        am = data;
      } else {
        pm = data;
      }
      switch (Integer.parseInt(data.get("week") + "")) {
        case 1:
          if (am.size() != 0) {
            amMonday.add(am);
          } else {
            pmMonday.add(pm);
          }
          break;
        case 2:
          if (am.size() != 0) {
            amTuesday.add(am);
          } else {
            pmTuesday.add(pm);
          }
          break;
        case 3:
          if (am.size() != 0) {
            amWednesday.add(am);
          } else {
            pmWednesday.add(pm);
          }
          break;
        case 4:
          if (am.size() != 0) {
            amThursday.add(am);
          } else {
            pmThursday.add(pm);
          }
          break;
        case 5:
          if (am.size() != 0) {
            amFriday.add(am);
          } else {
            pmFriday.add(pm);
          }
          break;
      }
    }
    //上午
    Map<String, Object> amMap = new LinkedHashMap<>();
    amMap.put("Monday", amMonday);
    amMap.put("Tuesday", amTuesday);
    amMap.put("Wednesday", amWednesday);
    amMap.put("Thursday", amThursday);
    amMap.put("Friday", amFriday);
    //下午
    Map<String, Object> pmMap = new LinkedHashMap<>();
    pmMap.put("Monday", pmMonday);
    pmMap.put("Tuesday", pmTuesday);
    pmMap.put("Wednesday", pmWednesday);
    pmMap.put("Thursday", pmThursday);
    pmMap.put("Friday", pmFriday);
    Map<String, Object> map = new LinkedHashMap<>();
    map.put("am", amMap);
    map.put("pm", pmMap);
    map.put("teacherNames", teacherNames);
    return map;
  }
}
