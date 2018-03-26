package com.zhimu.controller.manager.edu.teacherWages;

import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.teacherWages.impl.TeacherWagesService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/teacherWages")
public class TeacherWagesController extends BaseController {

  @Resource(name = "teacherWagesService")
  private TeacherWagesService teacherWagesService;

  /**
   * 教师-工资管理列表
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
      page.setPd(pd);
      List<PageData> varList = teacherWagesService.teacherWagesListPage(page);
      mv.setViewName("edu/teacherWages/teacherWages_list");
      mv.addObject("varList", varList);
      mv.addObject("pd", pd);
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "查询教师-工资管理列表异常!"));
    }
    return mv;
  }


  /**
   * 去编辑教师工资管理页面
   */
  @RequestMapping(value = "/goEditU")
  public ModelAndView goEditU() {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    try {
      String type = pd.getString("type");
      String currentPage = pd.getString("currentPage");
      pd = teacherWagesService.findDataById(pd);
      pd.put("type", type);
      pd.put("currentPage", currentPage);
      mv.addObject("msg", "editU");
      mv.addObject("pd", pd);
      //查询老师正常上课列表
      pd.put("zc", "yes");
      List<PageData> zcList = teacherWagesService.selectPkList(pd);
      int zcCountKs = zcList.size();
      int zcCountKf = 0;
      for (PageData z : zcList) {
        zcCountKf += Integer.parseInt(z.get("wages") + "");
      }
      pd.put("zcCountKs", zcCountKs);
      pd.put("zcCountKf", zcCountKf);
      mv.addObject("zcList", zcList);
      //查询教师当月请假未上课
      pd.put("zc", "");
      pd.put("qj", "yes");
      List<PageData> qjList = teacherWagesService.selectPkList(pd);
      int qjCountKs = qjList.size();
      int qjCountKf = 0;
      for (PageData q : qjList) {
        qjCountKf += Integer.parseInt(q.get("wages") + "");
      }
      pd.put("qjCountKs", qjCountKs);
      pd.put("qjCountKf", qjCountKf);
      mv.addObject("qjList", qjList);
      mv.addObject("pd", pd);
      mv.setViewName("edu/teacherWages/teacherWages_edit");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "去编辑教师工资管理页面异常!"));
    }
    return mv;
  }

  /**
   * 保存编辑教师工资页面
   */
  @RequestMapping(value = "/editU", method = RequestMethod.POST)
  @ResponseBody
  public Object editU() {
    Map<String, String> map = new HashMap<>();
    String msg;
    try {
      PageData pd = getPageData();
      // 执行保存
      teacherWagesService.editData(pd);
      msg = "success";
    } catch (Exception e) {
      msg = "error";
      logger.error(ErrorUtils.getErrorMessage(e, "保存编辑教师工资异常!"));
    }
    map.put("result", msg);
    return AppUtil.returnObject(new PageData(), map);
  }


  /**
   * 发送工资条信息给教师
   */
  @RequestMapping(value = "/sendWagesToTeacher")
  @ResponseBody
  public Object sendWagesToTeacher() {
    Map<String, String> map = new HashMap<>();
    PageData pd = getPageData();
    String resultInfo;
    try {
      teacherWagesService.sendWagesToTeacher(pd);
      resultInfo = "success";
    } catch (Exception e) {
      resultInfo = "error";
      logger.error(ErrorUtils.getErrorMessage(e, "发送工资条信息异常!"));
    }
    map.put("result", resultInfo);
    return AppUtil.returnObject(new PageData(), map);
  }

  /**
   * 我的工资列表
   */
  @RequestMapping(value = "/myWagesList")
  public ModelAndView myWagesList() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    try {
      String old_dy_month = pd.getString("dy_month");
      String keywords = pd.getString("keywords"); // 检索条件
      if (null != keywords && !"".equals(keywords)) {
        pd.put("keywords", keywords.trim());
      }
      //获取当前登陆人员员所属学校ID
      if (!StringUtils.isEmpty(getUserInfo().getSchoolId())) {
        pd.put("userSchoolIds", getUserInfo().getSchoolId().split(","));
      }
      pd.put("teacher_id", getUserInfo().getUSER_ID());
      String dy_month;
      int yf = 0;
      int kf = 0;
      int sf = 0;
      List<Map<String, List<?>>> varList = new ArrayList<>();
      Map map;
      //获取全年工资1月-12月
      for (int i = 0; i <= 11; i++) {
        if ("".equals(old_dy_month) || null == old_dy_month) {
          dy_month = DateUtil.getYearMonth(i - 1);
        } else {
          dy_month = old_dy_month;
        }
        pd.put("dy_month", dy_month);
        List<PageData> temp = teacherWagesService.myWagesList(pd);
        if (temp.size() > 0) {
          map = new HashMap();
          for (PageData p : temp) {
            yf += Integer.parseInt(p.get("yf_wages") + "");
            kf += Integer.parseInt(p.get("kf_wages") + "");
            sf += Integer.parseInt(p.get("sf_wages") + "");
          }
          map.put("dy_month", dy_month);
          map.put("list", temp);
          varList.add(map);
        }
        if (!"".equals(old_dy_month) && null != old_dy_month) {
          break;
        } else {
          pd.put("dy_month", "");
        }
      }
      pd.put("yf", yf);
      pd.put("kf", kf);
      pd.put("sf", sf);
      mv.setViewName("edu/teacherWages/myWages_list");
      mv.addObject("schoolList", getSchoolList());
      mv.addObject("varList", varList);
      mv.addObject("pd", pd);
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "查询我的工资表异常!"));
    }
    return mv;
  }

  /**
   * 查看我的工资详情
   */
  @RequestMapping(value = "/myWagesDetail")
  public ModelAndView myWagesDetail() {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    try {
      List<Map<String, List<?>>> varList = new ArrayList<>();
      Map map = new HashMap();
      List<PageData> temp = teacherWagesService.myWagesDetail(pd);
      String name = "";
      int yf = 0;
      int kf = 0;
      int sf = 0;
      for (PageData p : temp) {
        name = p.getString("name");
        yf += Integer.parseInt(p.get("yf") + "");
        kf += Integer.parseInt(p.get("kf") + "");
        sf += Integer.parseInt(p.get("sf") + "");
      }
      pd.put("yf", yf);
      pd.put("kf", kf);
      pd.put("sf", sf);
      map.put("name", name);
      map.put("list", temp);
      varList.add(map);
      mv.addObject("varList", varList);
      mv.addObject("pd", pd);
      mv.setViewName("edu/teacherWages/myWagesDetail");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "去查看我的工资详情异常!"));
    }
    return mv;
  }
}
