package com.zhimu.service.manager.edu.teacherLesson.impl;

import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.DaoSupport;
import com.zhimu.service.manager.edu.teacherLesson.TeacherLessonManager;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service("teacherLessonService")
public class TeacherLessonService implements TeacherLessonManager {

  @Resource(name = "daoSupport")
  private DaoSupport dao;

  public void insertTeacherZcSk(PageData pd) throws Exception {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    try {
      //查询当前对应学期的开始时间和截止时间
      PageData semesterPd = (PageData) dao.findForObject("teacherLessonMapper.findBySemester", pd);
      if (!semesterPd.isEmpty()) {
        pd.put("schedule_detail_id", pd.getString("id"));
        pd.put("teacher_id", semesterPd.getString("teacher_id"));
        //获取学期开始时间
        String semesterBegin = semesterPd.getString("semester_start").substring(0, 7);
        pd.put("dy_month", semesterBegin);
        //获取学期结束时间
        String semesterEnd = semesterPd.getString("semester_end").substring(0, 7);
        //计算两者相差的月数
        int countMonths = DateUtil.countMonths(semesterBegin, semesterEnd, "YYYY-MM");
        //循环遍历写入当前学期具体日期的课程
        for (int i = 0; i <= countMonths; i++) {
          //指定日期1号的日期
          String begin_time = DateUtil.returnNowDate(0, 1, DateUtil.getZdYearMonth(i, semesterBegin) + "-01");
          //当前日期1号是周几
          int bengin_week = DateUtil.getWeek(sdf.parse(begin_time));
          String date_one = "";
          String date_two = "";
          String date_three = "";
          String date_four = "";
          String date_five = "";
          switch (bengin_week) {
            case 1:
              date_one = DateUtil.addDay(begin_time, 0);
              date_two = DateUtil.addDay(begin_time, 1);
              date_three = DateUtil.addDay(begin_time, 2);
              date_four = DateUtil.addDay(begin_time, 3);
              date_five = DateUtil.addDay(begin_time, 4);
              break;
            case 2:
              date_one = DateUtil.addDay(begin_time, 6);
              date_two = DateUtil.addDay(begin_time, 0);
              date_three = DateUtil.addDay(begin_time, 1);
              date_four = DateUtil.addDay(begin_time, 2);
              date_five = DateUtil.addDay(begin_time, 3);
              break;
            case 3:
              date_one = DateUtil.addDay(begin_time, 5);
              date_two = DateUtil.addDay(begin_time, 4);
              date_three = DateUtil.addDay(begin_time, 0);
              date_four = DateUtil.addDay(begin_time, 1);
              date_five = DateUtil.addDay(begin_time, 2);
              break;
            case 4:
              date_one = DateUtil.addDay(begin_time, 4);
              date_two = DateUtil.addDay(begin_time, 5);
              date_three = DateUtil.addDay(begin_time, 6);
              date_four = DateUtil.addDay(begin_time, 0);
              date_five = DateUtil.addDay(begin_time, 1);
              break;
            case 5:
              date_one = DateUtil.addDay(begin_time, 3);
              date_two = DateUtil.addDay(begin_time, 4);
              date_three = DateUtil.addDay(begin_time, 5);
              date_four = DateUtil.addDay(begin_time, 6);
              date_five = DateUtil.addDay(begin_time, 0);
              break;
            case 6:
              date_one = DateUtil.addDay(begin_time, 2);
              date_two = DateUtil.addDay(begin_time, 3);
              date_three = DateUtil.addDay(begin_time, 4);
              date_four = DateUtil.addDay(begin_time, 5);
              date_five = DateUtil.addDay(begin_time, 6);
              break;
            case 7:
              date_one = DateUtil.addDay(begin_time, 1);
              date_two = DateUtil.addDay(begin_time, 2);
              date_three = DateUtil.addDay(begin_time, 3);
              date_four = DateUtil.addDay(begin_time, 4);
              date_five = DateUtil.addDay(begin_time, 5);
              break;
          }
          //当月最后一天日期
          String end_time = DateUtil.returnNowDate(1, 0, DateUtil.getZdYearMonth(i, semesterBegin) + "-01");
          //当月开始到结束有几个周一
          int week_one = DateUtil.getMondayNumber(begin_time, end_time, 1);
          //当月开始到结束有几个周二
          int week_two = DateUtil.getMondayNumber(begin_time, end_time, 2);
          //当月开始到结束有几个周三
          int week_three = DateUtil.getMondayNumber(begin_time, end_time, 3);
          //当月开始到结束有几个周四
          int week_four = DateUtil.getMondayNumber(begin_time, end_time, 4);
          //当月开始到结束有几个周五
          int week_five = DateUtil.getMondayNumber(begin_time, end_time, 5);
          String week = pd.getString("week");
          switch (week) {
            case "1":
              if (week_one > 0) {
                List<PageData> list_one = selectQkList(pd);
                //写入周一正常上课情况
                if (list_one.size() > 0) {
                  batchInsertQkInfo(pd, list_one, week_one, date_one);
                }
              }
              break;
            case "2":
              if (week_two > 0) {
                List<PageData> list_two = selectQkList(pd);
                //写入周二正常上课情况
                if (list_two.size() > 0) {
                  batchInsertQkInfo(pd, list_two, week_two, date_two);
                }
              }
              break;
            case "3":
              if (week_three > 0) {
                List<PageData> list_three = selectQkList(pd);
                //写入周三正常上课情况
                if (list_three.size() > 0) {
                  batchInsertQkInfo(pd, list_three, week_three, date_three);
                }
              }
              break;
            case "4":
              if (week_four > 0) {
                List<PageData> list_four = selectQkList(pd);
                //写入周四正常上课情况
                if (list_four.size() > 0) {
                  batchInsertQkInfo(pd, list_four, week_four, date_four);
                }
              }
              break;
            case "5":
              if (week_five > 0) {
                List<PageData> list_five = selectQkList(pd);
                //写入周五正常上课情况
                if (list_five.size() > 0) {
                  batchInsertQkInfo(pd, list_five, week_five, date_five);
                }
              }
              break;
          }
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  //查询当前星期几是否有排课
  public List<PageData> selectQkList(PageData pd) throws Exception {
    return (List<PageData>) dao.findForList("teacherLessonMapper.selectQkList", pd);
  }

  //批量写入教师当月正常上课明细
  public void batchInsertQkInfo(PageData pd, List<PageData> list, int num, String nowDate) throws Exception {
    //循环周数
    for (int i = 1; i <= num; i++) {
      //写入缺课情况
      if (list.size() > 0) {
        for (PageData p : list) {
          p.put("id", UuidUtil.get32UUID());
          p.put("teacher_id", pd.getString("teacher_id"));
          p.put("dy_month", pd.getString("dy_month"));
          p.put("qj_zt", "3");
          p.put("qk_time", DateUtil.addDay(nowDate, (i - 1) * 7) + " " + (p.get("start_time") + ""));
        }
        //执行批量保存
        dao.batchSave("teacherLessonMapper.addQkBatch", list);
      }
    }
  }

  //生成教师周一到周五的排课情况
  public Map<String, Object> teacherLessonList(PageData pd) throws Exception {
    List<PageData> all = (List<PageData>) dao.findForList("teacherLessonMapper.dataList", pd);
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
    //循环list
    for (int j = 0; j < all.size(); j++) {
      PageData am = new PageData();
      PageData pm = new PageData();
      if ("1".equals(all.get(j).get("period") + "")) {
        //上午
        am = all.get(j);
      } else {
        pm = all.get(j);
      }
      switch (Integer.parseInt(all.get(j).get("week") + "")) {
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
    map.put("allCount", all.size());
    return map;
  }
}
