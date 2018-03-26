package com.zhimu.controller.manager.edu.financial;

import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.financial.impl.TuitionService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.*;

@Controller
@RequestMapping(value = "/tuitionFees")
public class TuitionController extends BaseController {

  @Resource(name = "tuitionService")
  private TuitionService tuitionService;


  /**
   * 财务-学费管理列表
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
      //当前学校对应的学期
      List<PageData> xqList = tuitionService.selectListAllSemester(pd);
      String x_id = pd.getString("x_id");
      if ("".equals(x_id) || null == x_id) {
        //取最新的学期
        x_id = xqList.get(0).getString("x_id");
        pd.put("x_id", x_id);
      }
      page.setPd(pd);
      List<PageData> varList = tuitionService.tuitionListPage(page);
      int tf = 0;
      int qtss = 0;
      int ys = 0;
      int ss = 0;
      for (PageData q : varList) {
        tf += Integer.parseInt(q.get("tf") + "");
        qtss += Integer.parseInt(q.get("qtss") + "");
        ys += Integer.parseInt(q.get("ys") + "");
        q.put("ss", Integer.parseInt(q.get("ys") + "") - Integer.parseInt(q.get("tf") + "") + Integer.parseInt(q.get("qtss") + ""));
        ss += Integer.parseInt(q.get("ss") + "");
      }
      pd.put("tf", tf);
      pd.put("qtss", qtss);
      pd.put("ys", ys);
      pd.put("ss", ss);
      mv.addObject("xqList", xqList);
      mv.addObject("varList", varList);
      mv.addObject("pd", pd);
      mv.setViewName("edu/tuition/tuition_list");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "查询财务-学费管理列表异常!"));
    }
    return mv;
  }

  /**
   * 去查看财务-退费、其它退费、实收详情页面
   */
  @RequestMapping(value = "/goEditU")
  public ModelAndView goEditU() {
    ModelAndView mv = this.getModelAndView();
    PageData pd = getPageData();
    try {
      List<PageData> varList = tuitionService.selectTuitionList(pd);
      int tf = 0;
      int qtss = 0;
      int ys = 0;
      int ss = 0;
      for (PageData q : varList) {
        tf += Integer.parseInt(q.get("tf") + "");
        qtss += Integer.parseInt(q.get("qtss") + "");
        ys += Integer.parseInt(q.get("ys") + "");
        ss += Integer.parseInt(q.get("ss") + "");
      }
      List<PageData> otherName = tuitionService.selectOtherName(pd);
      pd.put("bj_name", otherName.get(0).getString("name"));
      pd.put("xq_name", otherName.get(1).getString("name"));
      pd.put("tf", tf);
      pd.put("qtss", qtss);
      pd.put("ys", ys);
      pd.put("ss", ss);
      mv.addObject("pd", pd);
      mv.addObject("varList", varList);
      mv.setViewName("edu/tuition/tuitionDetail_list");
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "去查看学费管理详情页面异常!"));
    }
    return mv;
  }
}
