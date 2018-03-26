package com.zhimu.controller.manager.stu.studentAttendance;

import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.teacherApply.impl.TeacherApplyService;
import com.zhimu.service.manager.message.MessageManager;
import com.zhimu.service.manager.message.impl.MessageService;
import com.zhimu.service.manager.stu.leave.impl.LeaveService;
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

/**
 * 学生缺勤管理控制层
 */
@Controller
@RequestMapping(value = "/studentAttendance")
public class StudentAttendanceController extends BaseController {

  @Resource(name = "leaveService")
  private LeaveService leaveService;
  @Resource(name = "messageService")
  private MessageService messageService;

  /**
   * 学生-缺勤管理列表
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
      List<PageData> varList = leaveService.studentApplyListPage(page);
      mv.setViewName("stu/studentAttendance/studentAttendance_list");
      mv.addObject("varList", varList);
      mv.addObject("schoolList", getSchoolList());
      mv.addObject("pd", pd);
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "查询学生-缺勤管理列表异常!"));
    }
    return mv;
  }


  /**
   * 去审核学生请假申请页面
   */
  @RequestMapping(value = "/goEditU")
  public ModelAndView goEditU() {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    try {
      String type = pd.getString("type");
      String currentPage = pd.getString("currentPage");
      String msg = pd.getString("msg");
      pd = leaveService.findDataById(pd);

      if (StringUtils.isNotBlank(msg) && "1".equals(msg)){
        PageData pageData = new PageData();
        pageData.put("BUSINESS_ID", pd.getString("id"));
        messageService.updateStatus(pageData);
      }

      pd.put("type", type);
      pd.put("currentPage", currentPage);
      mv.addObject("msg", "editU");
      mv.addObject("pd", pd);
      mv.setViewName("stu/studentAttendance/studentAttendance_edit");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "去审核学生请假申请页面异常!"));
    }
    return mv;
  }

  /**
   * 审核学生-考勤申请
   */
  @RequestMapping(value = "/editU", method = RequestMethod.POST)
  @ResponseBody
  public Object editU() {
    Map<String, String> map = new HashMap<>();
    String msg;
    try {
      PageData pd = getPageData();
      pd.put("check_time", DateUtil.getTime());
      pd.put("checker_name", this.getUserInfo().getNAME());
      pd.put("checker_id", this.getUserInfo().getUSER_ID());
      // 执行保存
      leaveService.editData(pd);
      msg = "success";
    } catch (Exception e) {
      msg = "error";
      logger.error(ErrorUtils.getErrorMessage(e, "审核学生请假申请异常!"));
    }
    map.put("result", msg);
    return AppUtil.returnObject(new PageData(), map);
  }

}
