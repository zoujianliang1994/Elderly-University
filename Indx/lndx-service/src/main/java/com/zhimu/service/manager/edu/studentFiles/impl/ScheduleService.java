package com.zhimu.service.manager.edu.studentFiles.impl;


import com.zhimu.commons.utils.PageData;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.classroom.ClassroomManager;
import com.zhimu.service.manager.edu.studentFiles.ScheduleManager;
import org.springframework.stereotype.Service;
import sun.security.krb5.internal.PAData;

import javax.annotation.Resource;
import java.util.*;

@Service("scheduleService")
public class ScheduleService implements ScheduleManager {

  @Resource(name = "daoSupport")
  private DaoSupport dao;


  @Override
  public List<PageData> schedulelistPage(Page pd) throws Exception {

    return (List<PageData>) dao.findForList("ScheduleMapper.schedulelistPage", pd);

  }

  @Override
  public void add(PageData pd) throws Exception {
    dao.save("ScheduleMapper.save", pd);
  }

  /**
   * 通过id获取数据
   *
   * @param pd
   * @throws Exception
   */
  public PageData findObjectById(PageData pd) throws Exception {
    return (PageData) dao.findForObject("ScheduleMapper.findById", pd);
  }

  /**
   * 修改
   *
   * @param pd
   * @throws Exception
   */
  public void edit(PageData pd) throws Exception {
    dao.update("ScheduleMapper.edit", pd);
  }

  @Override
  public void deleteById(String id) throws Exception {
    dao.delete("ScheduleMapper.deleteById", id);
  }

  //查询学期
  @Override
  public List<PageData> getAllSemesterBySchool(String[] schoolId) throws Exception {

    return (List<PageData>) dao.findForList("ScheduleMapper.getAllSemesterBySchool", schoolId);
  }

  @Override
  public List<PageData> getScheduleBySemesterId(String semester_id) throws Exception {

    return (List<PageData>) dao.findForList("ScheduleMapper.getScheduleBySemesterId", semester_id);
  }

  @Override
  public List<PageData> getDetailsByid(PageData pd) throws Exception {

    return (List<PageData>) dao.findForList("ScheduleMapper.getDetailsByid", pd);
  }



  @Override
  public PageData getGradesDetail(PageData pd) throws Exception {
    //查询该班级教学计划
    PageData teachPlan = (PageData) dao.findForObject("ScheduleMapper.getGradesDetail", pd);
    //查询本周已排棵数
    List<PageData> all =  (List<PageData>) dao.findForList("ScheduleMapper.getDetailsByGrades", pd);

    pd.put("teachPlan",teachPlan);
    pd.put("all",all);


    return pd;
  }


  @Override
  public Map<String, Object> getDetailsById(PageData pd) throws Exception {
    //取得所有的details
    List<PageData> all =  (List<PageData>) dao.findForList("ScheduleMapper.getDetailsByid", pd);

    PageData Monday = new PageData();
    PageData Tuesday = new PageData();
    PageData Wednesday = new PageData();
    PageData Thursday = new PageData();
    PageData Friday = new PageData();
    //循环list
    for (int j = 0; j < all.size(); j++) {
      PageData am = new PageData();
      PageData pm = new PageData();
      if("1".equals(all.get(j).get("period")+"")){
        //上午
        am = all.get(j);
      }else{
        pm = all.get(j);
      }
      switch (Integer.parseInt(all.get(j).get("week")+"")){
        case 1:
            Monday = addPageData(Monday,am,pm);
          break;
        case 2:
          Tuesday = addPageData(Tuesday,am,pm);
          break;
        case 3:
          Wednesday = addPageData(Wednesday,am,pm);
          break;
        case 4:
          Thursday = addPageData(Thursday,am,pm);
          break;
        case 5:
          Friday = addPageData(Friday,am,pm);
          break;

      }

    }

    Map<String,Object> map = new LinkedHashMap<String,Object>();

    map.put("Monday",Monday);
    map.put("Tuesday",Tuesday);
    map.put("Wednesday",Wednesday);
    map.put("Thursday",Thursday);
    map.put("Friday",Friday);

    return map;
  }


  private PageData addPageData(PageData week,PageData am,PageData pm){

    if(week.size()==0){
      List<PageData> amList = new ArrayList<PageData>();
      List<PageData> pmList = new ArrayList<PageData>();
      //判断非空
      if(am.size()!=0){
        amList.add(am);
        week.put("am",amList);
      }
      if(pm.size()!=0){
        pmList.add(pm);
        week.put("pm",pmList);
      }
    }else{
      //判断该星期是否存在上午下午
      List<PageData> amList = new ArrayList<PageData>();
      List<PageData> pmList = new ArrayList<PageData>();
      if(week.get("am")!=null){
        amList = (List<PageData>)week.get("am");
        if(am.size()!=0){
          amList.add(am);
          week.put("am",amList);
        }
      }else{
        //判断非空
        if(am.size()!=0){
          amList.add(am);
          week.put("am",amList);
        }

      }
      if(week.get("pm")!=null){
        pmList = (List<PageData>)week.get("pm");
        if(pm.size()!=0){
          pmList.add(pm);
          week.put("pm",pmList);
        }
      }else{
        if(pm.size()!=0){
          pmList.add(pm);
          week.put("pm",pmList);
        }
      }

    }


    return week;
  }

  /**
   * 根据学期id和班级id数组查到对应的课程表数据
   *
   * @param pageData
   * @return
   * @throws Exception
   */
  @Override
  public List<PageData> findByGIdAndSId(PageData pageData) throws Exception {
    return (List<PageData>) dao.findForList("ScheduleMapper.findByGIdAndSId", pageData);
  }

  @Override
  public String ischeakDetail(PageData pd) throws Exception {
    //首先检查教室时候匹配
    //得到班级对应的教室
    PageData idPd = new PageData();

    idPd.put("id",pd.getString("grades_id"));
    PageData grades =  (PageData) dao.findForObject("GradesMapper.findById", idPd);
    String gType = grades.getString("classroom_type");//班级教室类型
    String gSize = grades.get("class_size")+"";
    //得到教室
    idPd.put("id",pd.getString("classroom_id"));
    PageData classroom = (PageData) dao.findForObject("ClassroomMapper.findById", idPd);
    String cType = classroom.getString("classroom_type");
    String cSize = classroom.get("classroom_size")+"";
    if(!cType.equals(gType)){
      //班级所用教室类型不符合所选教室类型
      return "classroom_type";
    }

    int gs = Integer.parseInt(gSize);
    int cs = Integer.parseInt(cSize);
    if(gs>cs){
      //班级的人数大于教室人数
      return "classroom_size";
    }
    //验证上课时间
    /**
     *
     */
    List<PageData> tiem = (List<PageData>) dao.findForList("ScheduleMapper.selClassroomSituation", pd);

    if(tiem.size()>0){
      return "classroom_time";
    }


    return "success";
  }

  @Override
  public void addDetails(PageData pd) throws Exception {
    dao.save("ScheduleMapper.saveDetail", pd);
  }

  @Override
  public void deleteDetailById(PageData pd) throws Exception {

    dao.delete("ScheduleMapper.deleteDetail", pd);
  }

  @Override
  public List<PageData> scheduleList(PageData pg) throws Exception {

    return (List<PageData>) dao.findForList("ScheduleMapper.scheduleList", pg);

  }
}
