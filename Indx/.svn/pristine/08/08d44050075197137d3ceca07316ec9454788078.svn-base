package com.zhimu.controller.manager.edu.dept;

import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.dept.impl.DeptService;
import com.zhimu.service.manager.edu.lesson.impl.LessonService;
import org.apache.commons.lang.StringUtils;
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
@RequestMapping(value = "/dept")
public class DeptController extends BaseController {

  @Resource(name = "deptService")
  private DeptService deptService;

  @Resource(name = "lessonService")
  private LessonService lessonService;

  /**
   * 系别列表
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
      //人员所属学校ID
      if (!StringUtils.isEmpty(getUserInfo().getSchoolId())) {
        pd.put("userSchoolIds", getUserInfo().getSchoolId().split(","));
      }
      page.setPd(pd);
      List<PageData> varList = deptService.deptlistPage(page);
      mv.setViewName("edu/dept/dept_list");
      mv.addObject("varList", varList);
      mv.addObject("pd", pd);
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "查询系别列表异常!"));
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
    pd.put("createTime", getNowTime());
    mv.addObject("pd", pd);
    mv.addObject("msg", "save");
    mv.addObject("schoolList", getSchoolList());
    mv.setViewName("edu/dept/dept_edit");
    return mv;
  }

  /**
   * 保存系别
   */
  @RequestMapping(value = "/save", method = RequestMethod.POST)
  @ResponseBody
  public Object save() {
    Map<String, String> map = new HashMap();
    PageData pd = getPageData();
    String msg = "";
    try {
      pd.put("name", pd.getString("name").replace(" ", ""));
      if (getReptDeptListSize(pd) == 0) {
        pd.put("dept_id", this.get32UUID());
        // 执行保存
        deptService.addData(pd);
        msg = "success";
      } else {
        msg = "fail";
      }
    } catch (Exception e) {
      msg = "error";
      logger.error(ErrorUtils.getErrorMessage(e, "保存系别信息异常!"));
    }
    map.put("result", msg);
    return AppUtil.returnObject(new PageData(), map);
  }


  /**
   * 去修改系别页面
   */
  @RequestMapping(value = "/goEditU")
  public ModelAndView goEditU() {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    try {
      String type = pd.getString("type");
      String currentPage = pd.getString("currentPage");
      pd = deptService.findDataById(pd);
      pd.put("type", type);
      pd.put("currentPage", currentPage);
      mv.addObject("schoolList", getSchoolList());
      mv.addObject("msg", "editU");
      mv.addObject("pd", pd);
      mv.setViewName("edu/dept/dept_edit");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "去修改系别页面异常!"));
    }
    return mv;
  }

  /**
   * 修改系别
   */
  @RequestMapping(value = "/editU", method = RequestMethod.POST)
  @ResponseBody
  public Object editU() throws Exception {
    Map<String, String> map = new HashMap<>();
    PageData pd = getPageData();
    String msg;
    try {
      //新系名
      String name = pd.getString("name").replace(" ", "");
      //旧系名
      String old_name = pd.getString("old_name").replace(" ", "");
      pd.put("name", name);
      if ((name.equals(old_name)) || (!name.equals(old_name) && getReptDeptListSize(pd) == 0)) {
        deptService.editData(pd);
        msg = "success";
      } else {
        msg = "fail";
      }
    } catch (Exception e) {
      msg = "error";
      logger.error(ErrorUtils.getErrorMessage(e, "修改系别异常!"));
    }
    map.put("result", msg);
    return AppUtil.returnObject(new PageData(), map);
  }

  /**
   * 去查看课程列表
   */
  @RequestMapping(value = "/goViewLesson")
  public ModelAndView goViewLesson() {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    try {
      List<PageData> varList = lessonService.lessonList(pd);
      mv.addObject("pd", pd);
      mv.addObject("varList", varList);
      mv.setViewName("edu/dept/dept_lesson_list");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "去查看课程列表页面异常!"));
    }
    return mv;
  }


  /**
   * 删除系别
   */
  @RequestMapping(value = "/deleteU")
  @ResponseBody
  public Object delete() {
    Map<String, String> map = new HashMap<>();
    PageData pd = getPageData();
    String resultInfo;
    try {
      deptService.deleteData(pd);
      resultInfo = "success";
    } catch (Exception e) {
      resultInfo = "error";
      logger.error(ErrorUtils.getErrorMessage(e, "删除系别异常!"));
    }
    map.put("result", resultInfo);
    return AppUtil.returnObject(new PageData(), map);
  }

  private int getReptDeptListSize(PageData pd) throws Exception {
    return deptService.selectList(pd).size();
  }
}
