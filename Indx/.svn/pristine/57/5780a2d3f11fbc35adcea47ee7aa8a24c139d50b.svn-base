package com.zhimu.controller.manager.edu.schedule;


import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.classroom.ClassroomManager;
import com.zhimu.service.manager.edu.grades.GradesManager;
import com.zhimu.service.manager.edu.school.SchoolService;
import com.zhimu.service.manager.edu.studentFiles.ScheduleManager;
import com.zhimu.service.manager.edu.teacherLesson.TeacherLessonManager;
import com.zhimu.service.manager.edu.teacherLesson.impl.TeacherLessonService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/schedule")
public class ScheduleController extends BaseController {


  @Resource(name = "scheduleService")
  ScheduleManager scheduleService;

  @Resource(name = "classroomService")
  ClassroomManager classroomService;


  @Resource(name = "gradesService")
  GradesManager gradesService;

  @Resource(name = "teacherLessonService")
  TeacherLessonManager teacherLessonService;

  /**
   * 进入列表
   * @param page
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/list")
  public ModelAndView list(Page page) throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();
      //查询条件
      if(StringUtils.isEmpty(getUserInfo().getSchoolId())){
        return mv;
      }
      pd.put("userSchoolIds",getUserInfo().getSchoolId().split(","));

      page.setPd(pd);
      List<PageData> schedule_List = scheduleService.schedulelistPage(page); //分页排课计划

      mv.addObject("pd", pd);
      mv.addObject("page", page);
      mv.addObject("schedule_List", schedule_List);

      mv.setViewName("edu/schedule/schedule_list");
    } catch (Exception e) {
      e.printStackTrace();
      logger.error(e.toString(), e);
    }

    return mv;
  }

  @RequestMapping(value = "/details" )
  public ModelAndView details() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();
      Map<String,Object> map = scheduleService.getDetailsById(pd);
      pd = scheduleService.findObjectById(pd);
      JSONArray json = new JSONArray();
      json.put(map);

      PageData pg = new PageData();
      pg.put("userSchoolIds",getUserInfo().getSchoolId().split(","));
      List<PageData> schedule_List = scheduleService.scheduleList(pg); //全部排课计划

      mv.addObject("schedule_List", schedule_List);
      mv.addObject("data", json.toString());
      mv.setViewName("edu/schedule/schedule_details");
      mv.addObject("pd", pd);
    } catch (Exception e) {
      e.printStackTrace();
      logger.error(e.toString(), e);
    }
    return mv;
  }


  @RequestMapping(value = "/toAddSchedule" )
  public ModelAndView toAddSchedule() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();

      //根据id查询学校-教室-班级

      PageData schedule = scheduleService.findObjectById(pd);

      String schoolId = schedule.getString("school_id");

      //查询教室
      List<PageData> classroom = classroomService.findObjectBySchoolId(schoolId);
      //查询班级
      List<PageData> grades  =gradesService.findObjectBySchoolId(schoolId);


      mv.addObject("classroom", classroom);
      mv.addObject("classrooms", new JSONArray(classroom).toString());
      mv.addObject("schedule", schedule);
      mv.addObject("grades", grades);
      mv.addObject("msg", "add");
      pd.put("type","0");
      mv.setViewName("edu/schedule/schedule_add");
      mv.addObject("pd", pd);
    } catch (Exception e) {
      e.printStackTrace();
      logger.error(e.toString(), e);
    }
    return mv;
  }





  /**
   * 保存新增
   *
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/addDetaile",method = RequestMethod.POST)
  @ResponseBody
  public Object addDetaile() throws Exception {
    ModelAndView mv = this.getModelAndView();

    PageData pd = new PageData();
    String msgs = "";
    try {
      pd = this.getPageData();
      pd.put("id",get32UUID());
      //检查是否重复排课
      msgs = scheduleService.ischeakDetail(pd);
      if("success".equals(msgs)){
        scheduleService.addDetails(pd);
        teacherLessonService.insertTeacherZcSk(pd);
      }
    } catch (Exception e) {
      e.printStackTrace();
      logger.error(e.toString(), e);
      msgs = "error";
    }
    Map<String, String> map = new HashMap<String, String>();
    map.put("msg", msgs);
    return AppUtil.returnObject(new PageData(), map);
  }


  //查询班级情况
  @RequestMapping(value = "/getGrades")
  @ResponseBody
  public Object getGrades() throws Exception {
    ModelAndView mv = this.getModelAndView();

    Map<String, Object> map = new HashMap<String, Object>();
    PageData pd = new PageData();
    String msgs = "";
    try {
      pd = this.getPageData();
      PageData pg = gradesService.findObjectById(pd);
      map.put("grades",pg);

    } catch (Exception e) {
      logger.error(e.toString(), e);
      msgs = "error";
    }
    map.put("msg", msgs);
    return AppUtil.returnObject(new PageData(), map);
  }


  //删除排课
  @RequestMapping(value = "/deleteDetail")
  @ResponseBody
  public Object deleteDetail() throws Exception {
    ModelAndView mv = this.getModelAndView();

    Map<String, Object> map = new HashMap<String, Object>();
    PageData pd = new PageData();
    String msgs = "";
    try {
      pd = this.getPageData();
      scheduleService.deleteDetailById(pd);
      msgs = "success";
    } catch (Exception e) {
      logger.error(e.toString(), e);
      msgs = "error";
    }
    map.put("msg", msgs);
    return AppUtil.returnObject(new PageData(), map);
  }




  /**
   * 去新增页面
   *
   * @param
   * @return
   */
  @RequestMapping(value = "/toAdd" )
  public ModelAndView toAdd() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();

      //查询学期
      String[] schoolId=getUserInfo().getSchoolId().split(",");

      List<PageData> list = scheduleService.getAllSemesterBySchool(schoolId);

      mv.addObject("schoolList", getSchoolList());
      mv.addObject("semesterList", list);
      mv.addObject("msg", "add");
      pd.put("type","0");
      mv.setViewName("edu/schedule/schedule_edit");
      mv.addObject("pd", pd);
    } catch (Exception e) {
      e.printStackTrace();
      logger.error(e.toString(), e);
    }
    return mv;
  }

  /**
   * 保存新增
   *
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/add",method = RequestMethod.POST)
  @ResponseBody
  public Object add() throws Exception {
    ModelAndView mv = this.getModelAndView();

    PageData pd = new PageData();
    String msgs = "";
    try {
      pd = this.getPageData();
      pd.put("id",get32UUID());
      //检查是否存在排课
      List<PageData> list = scheduleService.getScheduleBySemesterId(pd.getString("semester_id"));
      if(list.size()<=0){
        msgs = "success";
        scheduleService.add(pd);
      }else{
        msgs = "false";
      }
    } catch (Exception e) {
      logger.error(e.toString(), e);
      msgs = "error";
    }
    Map<String, String> map = new HashMap<String, String>();
    map.put("msg", msgs);
    return AppUtil.returnObject(new PageData(), map);
  }

  /**
   * 请求编辑
   *
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/toEdit")
  public ModelAndView toEdit() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();
      String currentPage = pd.getString("currentPage");
      String keywords = pd.getString("keywords");

      pd = scheduleService.findObjectById(pd);

      pd.put("currentPage", currentPage);
      pd.put("keywords", keywords);
      pd.put("type","0");
      mv.addObject("schoolList", getSchoolList());
      mv.addObject("msg", "edit");
      mv.addObject("pd", pd);
      mv.setViewName("edu/schedule/schedule_edit");
    } catch (Exception e) {
      logger.error(e.toString(), e);
    }
    return mv;
  }

  /**
   * 保存修改
   *
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/edit" ,method = RequestMethod.POST)
  @ResponseBody
  public Object edit() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    String msg = "";
    try {
      pd = this.getPageData();
      //检查是否存在排课
      List<PageData> list = scheduleService.getDetailsByid(pd);
      if(list.size()<=0){
        msg = "success";
        scheduleService.edit(pd);
      }else{
        msg = "false2";
      }
    } catch (Exception e) {
      logger.error(e.toString(), e);
      msg = "error";
    }
    Map<String, String> map = new HashMap<String, String>();
    map.put("msg", msg);
    return AppUtil.returnObject(new PageData(), map);
  }

  /**
   * 删除
   *
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/delete")
  @ResponseBody
  public Object deleteRole(@RequestParam String id) throws Exception {
    Map<String, String> map = new HashMap<String, String>();
    PageData pd = new PageData();
    String errInfo = "";
    try {
      //检查是否存在排课
      pd.put("id",id);
      List<PageData> list = scheduleService.getDetailsByid(pd);
      if(list.size()<=0){
        scheduleService.deleteById(id); // 执行删除
        errInfo = "success";
      }else{
        errInfo = "false";
      }
    } catch (Exception e) {
      logger.error(e.toString(), e);
    }
    map.put("result", errInfo);
    return AppUtil.returnObject(new PageData(), map);
  }

  /**
   * 请求编辑
   *
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/getGradesDetail")
  public ModelAndView getGradesDetail() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();

      pd = scheduleService.getGradesDetail(pd);

      mv.addObject("pd", pd);
      mv.setViewName("edu/schedule/schedule_grades");
    } catch (Exception e) {
      e.printStackTrace();
      logger.error(e.toString(), e);
    }
    return mv;
  }


}
