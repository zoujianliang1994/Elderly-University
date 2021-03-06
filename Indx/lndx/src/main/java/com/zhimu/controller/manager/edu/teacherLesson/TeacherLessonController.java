package com.zhimu.controller.manager.edu.teacherLesson;

import com.zhimu.commons.utils.*;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.service.manager.edu.teacherLesson.impl.TeacherLessonService;
import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping(value = "/teacherLesson")
public class TeacherLessonController extends BaseController {

  @Resource(name = "teacherLessonService")
  private TeacherLessonService teacherLessonService;

  /**
   * 教师我的课程列表
   */
  @RequestMapping(value = "/list")
  public ModelAndView list() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    try {
      String keywords = pd.getString("keywords"); // 检索条件
      if (null != keywords && !"".equals(keywords)) {
        pd.put("keywords", keywords.trim());
      }
      //获取当前登陆登陆老师的ID
      if (!StringUtils.isEmpty(getUserInfo().getUSER_ID())) {
        pd.put("teacher_id", getUserInfo().getUSER_ID());
      }
      Map<String, Object> map = teacherLessonService.teacherLessonList(pd);
      JSONArray array = new JSONArray();
      JSONObject jsonObject = new JSONObject();
      jsonObject.put("am", map.get("am"));
      jsonObject.put("pm", map.get("pm"));
      array.put(jsonObject);
      mv.addObject("data", array.toString());
      mv.addObject("pd", pd);
      mv.addObject("schoolList", getSchoolList());
      mv.setViewName("edu/teacherLesson/teacherLesson_list");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "查询教师我的课程列表异常!"));
    }
    return mv;
  }
}
