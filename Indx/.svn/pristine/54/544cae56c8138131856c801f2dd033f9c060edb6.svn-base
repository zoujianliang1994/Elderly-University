package com.zhimu.controller.manager.edu.teacherApply;

import com.zhimu.commons.utils.*;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.teacherApply.impl.TeacherApplyService;
import com.zhimu.service.manager.edu.teacherLesson.impl.TeacherLessonService;
import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/teacherApply")
public class TeacherApplyController extends BaseController {

  @Resource(name = "teacherApplyService")
  private TeacherApplyService teacherApplyService;

  @Resource(name = "teacherLessonService")
  private TeacherLessonService teacherLessonService;

  /**
   * 教师-我的申请列表
   */
  @RequestMapping(value = "/list")
  public ModelAndView list(Page page) throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    try {
      String keywords = pd.getString("keywords"); // 检索条件
      if (null != keywords && !"".equals(keywords)) {
        pd.put("keywords", keywords.trim());
      }
      //获取当前登陆人员员所属学校ID
      if (!StringUtils.isEmpty(getUserInfo().getSchoolId())) {
        pd.put("userSchoolIds", getUserInfo().getSchoolId().split(","));
      }
      pd.put("teacher_id", getUserInfo().getUSER_ID());
      page.setPd(pd);
      List<PageData> varList = teacherApplyService.teacherApplyListPage(page);
      mv.setViewName("edu/teacherApply/teacherApply_list");
      mv.addObject("varList", varList);
      mv.addObject("schoolList", getSchoolList());
      mv.addObject("pd", pd);
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "查询我的申请列表异常!"));
    }
    return mv;
  }

  /**
   * 去新增页面
   */
  @RequestMapping(value = "/goAdd")
  public ModelAndView goAdd() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    pd.put("create_time", getNowTime());
    pd.put("dwkc_number", "0");
    mv.addObject("pd", pd);
    mv.addObject("msg", "save");
    mv.addObject("schoolList", getSchoolList());
    mv.addObject("minDate", DateUtil.getYearMonth(0) + "-1");
    mv.setViewName("edu/teacherApply/teacherApply_edit");
    return mv;
  }

  /**
   * 保存教师-我的申请
   */
  @RequestMapping(value = "/save", method = RequestMethod.POST)
  @ResponseBody
  public Object save() {
    Map<String, String> map = new HashMap<>();
    String msg;
    try {
      PageData pd = getPageData();
      pd.put("id", this.get32UUID());
      pd.put("teacher_id", getUserInfo().getUSER_ID());
      pd.put("zt", "0");
      pd.put("create_time", DateUtil.getTime());
      // 执行保存
      teacherApplyService.addData(pd);
      msg = "success";
    } catch (Exception e) {
      msg = "error";
      logger.error(ErrorUtils.getErrorMessage(e, "保存我的申请信息异常!"));
    }
    map.put("result", msg);
    return AppUtil.returnObject(new PageData(), map);
  }

  /**
   * 去修改教师-我的申请页面
   */
  @RequestMapping(value = "/goEditU")
  public ModelAndView goEditU() {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    try {
      String type = pd.getString("type");
      String currentPage = pd.getString("currentPage");
      pd = teacherApplyService.findDataById(pd);
      pd.put("type", type);
      pd.put("currentPage", currentPage);
      mv.addObject("msg", "editU");
      mv.addObject("pd", pd);
      mv.addObject("schoolList", getSchoolList());
      mv.addObject("minDate", DateUtil.getYearMonth(0) + '1');
      mv.setViewName("edu/teacherApply/teacherApply_edit");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "去修改我的申请页面异常!"));
    }
    return mv;
  }

  @RequestMapping(value = "/editU", method = RequestMethod.POST)
  @ResponseBody
  public Object editU() {
    Map<String, String> map = new HashMap<>();
    PageData pd = getPageData();
    String msg;
    try {
      pd.put("zt", "0");
      pd.put("shyj", "");
      // 执行保存
      teacherApplyService.editData(pd);
      msg = "success";
    } catch (Exception e) {
      msg = "error";
      logger.error(ErrorUtils.getErrorMessage(e, "修改教师请假申请异常!"));
    }
    map.put("result", msg);
    return AppUtil.returnObject(new PageData(), map);
  }

  /**
   * 去查看课程情况页面
   */
  @RequestMapping(value = "/goViewLesson")
  public ModelAndView goViewLesson() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    try {
      Map<String, Object> map = returnGetPkData(pd);
      JSONArray array = new JSONArray();
      JSONObject jsonObject = new JSONObject();
      jsonObject.put("am", map.get("am"));
      jsonObject.put("pm", map.get("pm"));
      array.put(jsonObject);
      mv.addObject("data", array.toString());
      mv.addObject("pd", pd);
      mv.setViewName("edu/teacherApply/teacherLesson_Detail");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "去查看课程情况异常!"));
    }
    return mv;
  }

  /**
   * 获取请假耽误课程总数
   */
  @RequestMapping(value = "/getDwPkCount")
  @ResponseBody
  public Object getDwPkCount() throws Exception {
    PageData pd = getPageData();
    JSONObject jsonObject = new JSONObject();
    try {
      Map<String, Object> map = returnGetPkData(pd);
      String allCount = map.get("allCount") + "";
      jsonObject.put("dwkc_number", allCount);
    } catch (Exception e) {
      logger.error(e.toString(), e);
    }
    return jsonObject.toString();
  }

  /**
   * 获取排课情况
   */
  private Map<String, Object> returnGetPkData(PageData pd) throws Exception {
    Map<String, Object> map = new HashMap<>();
    try {
      pd.put("teacher_id", getUserInfo().getUSER_ID());
      pd.put("moreWeek", "yes");
      //获取请假开始时间
      String begin_time = pd.getString("begin_time");
      //获取请假开始时间是周几
      int bengin_week = DateUtil.returnNowDay(begin_time);
      //获取请假结束时间
      String end_time = pd.getString("end_time");
      //获取结束时间是周几
      int end_week = DateUtil.returnNowDay(end_time);
      //两个日期间隔几个星期
      int count_week = DateUtil.getMondayNumber(begin_time, end_time, bengin_week);
      String weeks = "";
      if ((bengin_week == end_week) && (count_week == 1)) {//当天
        weeks = bengin_week + "";
      } else if ((bengin_week == end_week) && (count_week != 1)) {//跨周
        weeks = "1,2,3,4,5";
      } else {
        if (bengin_week < end_week) {
          for (int i = bengin_week; i <= end_week; i++) {
            weeks += i + ",";
          }
        } else if (bengin_week > end_week) {
          for (int i = 1; i <= end_week; i++) {
            weeks += i + ",";
          }
          for (int i = bengin_week; i <= 5; i++) {
            weeks += i + ",";
          }
          weeks = weeks.substring(0, weeks.length() - 1);
        } else {
          //
        }
      }
      pd.put("weeks", weeks.split(","));
      map = teacherLessonService.teacherLessonList(pd);
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "获取请假耽误课程信息异常!"));
    }
    return map;
  }
}
