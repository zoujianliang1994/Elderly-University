package com.zhimu.controller.manager.edu.student;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.OrderNoUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.grades.GradesManager;
import com.zhimu.service.manager.edu.school.SchoolAptitudeService;
import com.zhimu.service.manager.edu.school.SchoolService;
import com.zhimu.service.manager.edu.semester.SemesterService;
import com.zhimu.service.manager.edu.student.EnrollService;
import com.zhimu.service.manager.edu.student.StudentService;
import com.zhimu.service.manager.redis.RedisCacheUtil;
import com.zhimu.service.manager.system.user.impl.UserService;

/**
 * 说明：学员网上报名
 */
@Controller
@RequestMapping(value = "/studentEnroll")
public class EnrollController extends BaseController {

	@Resource(name = "userService")
	private UserService userService;
	@Resource(name = "gradesService")
	private GradesManager gradesService;
	@Resource(name = "enrollService")
	private EnrollService enrollService;
	@Resource(name = "studentService")
	private StudentService studentService;
	@Resource(name = "schoolAptitudeService")
	private SchoolAptitudeService schoolAptitudeService;
	@Resource(name = "schoolService")
	private SchoolService schoolService;
	@Resource(name = "semesterService")
	private SemesterService semesterService;
	@Resource(name = "redisCacheUtil")
	private RedisCacheUtil redisCacheUtil;

	/**
	 * 去平台报名页面
	 * 
	 * @param
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		boolean isgo = false;
		// 检测当前用户资料信息是否填写完善
		try {
			pd = this.studentService.findByUser(getUserInfo().getUSER_ID());
			if (null != pd && pd.size() > 0) {
				if (StringUtils.isEmpty(pd.getString("xb"))) {
					isgo = true;
					mv.addObject("isgo", true);
					mv.setViewName("redirect:/student/goDataFinish");
					return mv;
				} else {
					mv.setViewName("redirect:/studentEnroll/goGrades.do?checkin_type=1");
					return mv;
				}
			}
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "查询学员资料异常!"));
			e.printStackTrace();
		}
		mv.addObject("isgo", isgo);
		mv.addObject("msg", "save");
		mv.setViewName("edu/student/stu_enroll");
		return mv;
	}

	/**
	 * 去平台内部报名页面（学校端）
	 * 
	 * @param
	 */
	@RequestMapping(value = "/goEnroll")
	public ModelAndView goEnroll() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.addObject("currentPage", pd.get("currentPage"));
		mv.addObject("msg", "save");
		mv.setViewName("edu/student/student_platform_enroll");
		return mv;
	}

	/**
	 * 去班级筛选页面
	 * 
	 * @param
	 */
	@RequestMapping(value = "/goGrades")
	public ModelAndView goGrades(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			String userId = getUserInfo().getUSER_ID();
			if (StringUtils.isNotEmpty(pd.getString("user_id"))) {
				userId = pd.getString("user_id");
			} else if ("2".equals(pd.getString("checkin_type"))) {
				// 线下报名
				userId = pd.getString("user_id");
			}
			PageData findByUser = this.studentService.findByUser(userId);
			pd.put("sex", findByUser.getString("xb"));
			// if ("admin".equals(userId)) {
			// pd.put("userSchoolIds", "");
			// } else {
			// pd.put("userSchoolIds",
			// StringUtils.isNotEmpty(getUserInfo().getSchoolId()) ?
			// getUserInfo().getSchoolId().split(",") : "");
			// }
			pd.put("d_time", DateUtil.getDay());
			page.setPd(pd);
			List<Map<String, Object>> grades_List = gradesService.gradesDetaillistPage(page); // 列出所有的班级
			// 根据当前用户查询学校以及校区、教学点信息
			pd.put("user_id", userId);
			mv.addObject("pd", pd);
			mv.addObject("page", page);
			mv.addObject("varList", grades_List);
			mv.addObject("msg", "saveEnroll");
			// pd.put("userSchoolIds", "");
			mv.addObject("schoolList", schoolAptitudeService.findBySid(pd));
			mv.addObject("schoolChildList", schoolService.listSubSchools(pd.getString("school_id")));
			mv.setViewName("edu/student/stu_grades");
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "查询选课信息异常!"));
			e.printStackTrace();
		}
		return mv;
	}

	/**
	 * 保存学员选课信息
	 */

	@RequestMapping(value = "/saveEnroll")
	@ResponseBody
	public Object saveEnroll(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String msg = "success";
		PageData pd = this.getPageData();
		pd.put("id", this.get32UUID()); // 主键
		pd.put("create_time", DateUtil.getDay());
		// 生成订单号
		String orderNo = OrderNoUtils.getOrderNo();
		// 报名类型
		String checkinType = pd.getString("checkin_type");

		try {
			String userId = getUserInfo().getUSER_ID();
			if (StringUtils.isNotEmpty(pd.getString("user_id"))) {
				userId = pd.getString("user_id");
			} else {
				pd.put("user_id", getUserInfo().getUSER_ID());
			}
			PageData stuPd = this.studentService.findByUser(userId);
			pd.put("student_id", stuPd.getString("id"));
			pd.put("orderNo", orderNo);
			pd.put("tradeNo", "");
			Map<String, String> result = enrollService.save(pd);
			if ("no".equals(result.get("isRepeat"))) {
				String orderAmount = result.get("orderAmount");
				// 将订单信息放入缓存中
				redisCacheUtil.setCacheObject(orderNo, orderAmount);
			}
			map.put("result", result.get("isRepeat"));

		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "保存学员选课信息异常!"));
			e.printStackTrace();
		}

		map.put("orderNo", orderNo);
		map.put("pd", pd);
		map.put("checkinType", checkinType);
		map.put("msg", msg);

		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 重新报名缴费
	 */

	@RequestMapping(value = "/reEnroll")
	@ResponseBody
	public Object reEnroll(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "success";
		PageData pd = this.getPageData();
		// 生成订单号
		String orderNo = OrderNoUtils.getOrderNo();
		// 报名类型
		String checkinType = pd.getString("checkin_type");
		try {
			// 更新订单号
			pd.put("orderNo", orderNo);
			PageData gradesPd = this.enrollService.findById(pd);
			String orderAmount = gradesPd.getString("money");
			enrollService.editOrderNo(pd);
			// 将订单信息放入缓存中
			redisCacheUtil.setCacheObject(orderNo, orderAmount);
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "学员重新选课信息异常!"));
			e.printStackTrace();
		}
		map.put("orderNo", orderNo);
		map.put("checkinType", checkinType);
		map.put("msg", msg);

		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 学员已选课列表
	 * 
	 * @param page
	 */
	@RequestMapping(value = "/listGrades")
	public ModelAndView listGrades(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		List<PageData> varList = new ArrayList<PageData>();
		try {
			if (StringUtils.isEmpty(pd.getString("user_id"))) {
				pd.put("user_id", getUserInfo().getUSER_ID());
			}
			varList = enrollService.findByUserId(pd);
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "学员已选课列表异常!"));
			e.printStackTrace();
		} // 列表
		mv.setViewName("edu/student/student_grades_enroll_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 学员报名列表
	 * 
	 * @param page
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		pd.put("school_id", getUserInfo().getSchoolId().split(","));
		page.setPd(pd);
		List<PageData> varList = new ArrayList<PageData>();
		List<PageData> semesterList = new ArrayList<PageData>();
		try {
			varList = enrollService.list(page);
			semesterList = this.semesterService.findBySid(pd);
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "学员报名列表信息异常!"));
			e.printStackTrace();
		} // 列表
		mv.setViewName("edu/student/student_enroll_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("semesterList", semesterList);
		return mv;
	}

	/**
	 * 去学员报名详细页面
	 * 
	 * @param
	 */
	@RequestMapping(value = "/goDetail")
	public ModelAndView goEdit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String type = pd.getString("type");
		String currentPage = pd.getString("currentPage");
		List<PageData> enrollPd = new ArrayList<PageData>();
		List<PageData> canclePd = new ArrayList<PageData>();

		try {
			pd = studentService.findById(pd);
			// 通过学生ID查询已选课信息
			pd.put("money_status", "1");
			enrollPd = this.enrollService.findByStuId(pd);
			// 通过学生ID查询取消的选课信息
			pd.put("money_status", "3");
			canclePd = this.enrollService.findByStuId(pd);
		} catch (Exception e) {
			logger.error(ErrorUtils.getErrorMessage(e, "去学员报名详细页面异常!"));
			e.printStackTrace();
		} // 根据ID读取
		pd.put("type", type);
		mv.addObject("pd", pd); // 放入视图容器
		mv.addObject("currentPage", currentPage);
		mv.addObject("enrollPd", enrollPd);
		mv.addObject("canclePd", canclePd);
		mv.setViewName("edu/student/student_enroll_detail");
		mv.addObject("msg", "edit");
		return mv;
	}

	/**
	 * 取消学员报名选课信息
	 */

	@RequestMapping(value = "/cancleEnroll")
	@ResponseBody
	public Object cancleEnroll(HttpSession session) {
		Map<String, String> map = new HashMap<String, String>();
		String msg = "success";
		PageData pd = this.getPageData();
		try {
			pd.put("money_status", "3");// 3:退班退费
			enrollService.edit(pd);
		} catch (Exception e) {
			msg = "error";
			logger.error(ErrorUtils.getErrorMessage(e, "取消学员报名选课信息异常!"));
			e.printStackTrace();
		}
		map.put("msg", msg);
		return AppUtil.returnObject(new PageData(), map);
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
