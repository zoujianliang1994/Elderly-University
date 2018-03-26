/**
 * 学员报名选课
 * @author wangyong
 */
package com.zhimu.service.manager.edu.student;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.zhimu.commons.utils.DateUtil;
import com.zhimu.commons.utils.OrderNoUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.alipay.AlipayConfigUtil;
import com.zhimu.service.manager.edu.grades.GradesManager;
import com.zhimu.service.manager.edu.semester.SemesterService;
import com.zhimu.service.manager.system.user.impl.UserService;

@Service("enrollService")
public class EnrollService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@Resource(name = "userService")
	private UserService userService;
	@Resource(name = "studentService")
	private StudentService studentService;
	@Resource(name = "gradesService")
	private GradesManager gradesService;
	@Resource(name = "semesterService")
	private SemesterService semesterService;

	public static void main(String args[]) {
		Map<String, Map> msp = new HashMap<String, Map>();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("id", "1");
		map1.put("name", "p");
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("id", "3");
		map2.put("name", "h");
		Map<String, Object> map3 = new HashMap<String, Object>();
		map3.put("id", "3");
		map3.put("name", "f");
		list.add(map1);
		list.add(map3);
		list.add(map2);

		List<Map<String, Object>> resultListMap = removeRepeatData(list, "id");
	}

	public static List<Map<String, Object>> removeRepeatData(List<Map<String, Object>> list, String mapKey) {
		List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
		Map<String, Map> msp = new HashMap<String, Map>();
		System.out.println("初始数据：" + list.toString());
		// 把list中的数据转换成msp,去掉同一id值多余数据，保留查找到第一个id值对应的数据
		for (int i = list.size() - 1; i >= 0; i--) {
			Map map = list.get(i);
			String id = (String) map.get(mapKey);
			map.remove(mapKey);
			msp.put(id, map);
		}
		// 把msp再转换成list,就会得到根据某一字段去掉重复的数据的List<Map>
		Set<String> mspKey = msp.keySet();
		for (String key : mspKey) {
			Map newMap = msp.get(key);
			newMap.put(mapKey, key);
			listMap.add(newMap);
		}
		System.out.println("去掉重复数据后的数据：" + listMap.toString());
		return listMap;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("StudentEnrollMapper.datalistPage", page);
	}

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public Map<String, String> save(PageData pd) throws Exception {
		Map<String, String> result = new HashMap<String, String>();
		// 报名费用
		BigDecimal orderAmount = new BigDecimal("0");
		orderAmount = orderAmount.setScale(2, BigDecimal.ROUND_HALF_UP);
		String isRepeat = "no";
		// 保存选课信息
		String selData = pd.getString("selData");
		if (StringUtils.isNotEmpty(selData)) {
			JSONArray json = JSONArray.fromObject(selData);
			if (json.size() > 0) {
				String sIds = "";
				String sNames = "";
				String cIds = "";
				String cNames = "";
				String lIds = "";
				for (int i = 0; i < json.size(); i++) {
					JSONObject job = json.getJSONObject(i);
					// 判断是否有重复选课
					if (this.isGradesRepeate(job, pd.getString("student_id"))) {
						isRepeat = "yes";
						result.put("isRepeat", isRepeat);
						return result;
					}
					// 根据班级ID获取班级
					PageData gPd = new PageData();
					gPd.put("id", job.getString("g_id"));
					PageData gradePd = this.gradesService.findObjectById(gPd);
					if (null == gradePd) {
						throw new RuntimeException("所选班级不存在！");
					}
					// 班级费用
					orderAmount = orderAmount.add(new BigDecimal(gradePd.get("tuition") + "").setScale(2, BigDecimal.ROUND_HALF_UP));
					gradePd.getString("gradePd");
					pd.put("id", UuidUtil.get32UUID());
					pd.put("school_name", job.getString("a_name"));
					pd.put("school_id", job.getString("a_id"));
					pd.put("child_school_id", job.getString("school_id"));
					pd.put("child_school_name", job.getString("school_name"));
					pd.put("g_name", job.getString("g_name"));
					pd.put("g_id", job.getString("g_id"));
					pd.put("teacher_name", job.getString("teacher_name"));
					pd.put("teacher_id", job.getString("teacher_id"));
					pd.put("classroom_name", job.getString("classroom_name"));
					pd.put("course_time", job.getString("course_time"));
					pd.put("money", job.getString("money"));
					pd.put("money_status", "2".equals(pd.getString("checkin_type")) ? "1" : "2");// 缴费状态
					pd.put("is_all", job.getString("zt"));
					pd.put("timePart", job.getString("time_part"));
					dao.save("StudentEnrollMapper.save", pd);
					if (sIds.indexOf(job.getString("school_id")) == -1) {
						sIds += job.getString("school_id") + ",";
					}
					if (sNames.indexOf(job.getString("school_name")) == -1) {
						sNames += job.getString("school_name") + ",";
					}
					if (cIds.indexOf(job.getString("g_id")) == -1) {
						cIds += job.getString("g_id") + ",";
					}
					if (cNames.indexOf(job.getString("g_name")) == -1) {
						cNames += job.getString("g_name") + ",";
					}
					if (lIds.indexOf(job.getString("lesson_id")) == -1) {
						lIds += job.getString("lesson_id") + ",";
					}

					// 写入学员班级关联表
					pd.put("semester_id", job.getString("semester_id"));
					pd.put("lesson_periods", job.getString("lesson_periods"));
					this.studentService.saveGrades(pd);
				}
				// 写入班级信息到学员表
				PageData stuPd = studentService.findByUser(pd.getString("user_id"));
				stuPd.put("s_id", sIds.substring(0, sIds.length() - 1));
				stuPd.put("s_name", sNames.substring(0, sNames.length() - 1));
				stuPd.put("c_id", cIds.substring(0, cIds.length() - 1));
				stuPd.put("c_name", cNames.substring(0, cNames.length() - 1));
				stuPd.put("l_id", lIds.substring(0, lIds.length() - 1));
				stuPd.put("l_name", "");
				// 根据当前报名日期和学校ID查询所在是哪个学期
				pd.put("regDate", DateUtil.getDay());
				pd.put("s_id", sIds.split(","));
				PageData semesterPd = semesterService.findByDateAndSid(pd);
				String semesterIds = "";
				if (null == semesterPd || semesterPd.size() <= 0) {
					throw new RuntimeException("当前时间段暂未查询到学期信息");
				} else {
					for (Object key : semesterPd.keySet()) {
						semesterIds = semesterPd.get(key).toString();
						break;
					}
				}
				pd.put("id", pd.getString("student_id"));
				stuPd.put("semester_id", semesterIds.substring(0, semesterIds.length() - 1));
				this.studentService.editStudentEnroll(stuPd);
				// 更新账号学校信息
				PageData userPd = new PageData();
				userPd.put("SCHOOL_ID", stuPd.getString("s_id"));
				userPd.put("SCHOOL_NAME", stuPd.getString("s_name"));
				userPd.put("USER_ID", pd.getString("user_id"));
				this.userService.editUserSchool(userPd);
			}
		}

		result.put("isRepeat", isRepeat);
		result.put("orderAmount", "0.00".equals(orderAmount.toString()) ? "0" : orderAmount.toString());
		return result;
	}

	/**
	 * 判断是否有重复选课
	 * 
	 * @param job
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public boolean isGradesRepeate(JSONObject job, String studenId) throws Exception {
		boolean result = false;
		if (null != job) {
			// 通过班级ID和学员ID查询是否有数据
			PageData pd = new PageData();
			pd.put("grades_id", job.getString("g_id"));
			pd.put("student_id", studenId);
			List<PageData> stuGradesList = this.studentService.findByCidAndStuId(pd);
			PageData pdt = new PageData();
			pdt.put("student_id", studenId);
			List<PageData> stuList = this.studentService.findByCidAndStuId(pdt);
			if (null == stuList || stuList.size() <= 0) {
				// 当前学员已有班级信息
				return false;
			} else if (null != stuGradesList && stuGradesList.size() > 0) {
				return true;
			} else {
				String[] split = job.getString("time_part").split("!");
				for (int i = 0; i < split.length; i++) {
					String[] split2 = split[i].split("-");// 获取时间段
															// 1.1_09:03:03-1.1_09:13:03
															// !
															// 1.1_09:13:03-1.1_09:43:09
					// 1.2_14:03:03-1.2_14:13:03
					String[] split3 = split2[0].split("_");// 获取周、上下午、开始时间
					String week = split3[0].split("\\.")[0];// 周
					String startPeriod = split3[0].split("\\.")[1];// 上下午
					String startTime = split3[1];// 开始时间
					// String endPeriod = split3[1].split(".")[1];// 上下午
					String endTime = split2[1].split("_")[1];// 结束时间

					// 根据所选班级时间查询该学员是否有班级冲突
					pd.put("week", week);
					pd.put("period", startPeriod);
					pd.put("startTime", startTime);
					pd.put("endTime", endTime);
					List<PageData> scheduleStuId = this.studentService.findByScheduleStuId(pd);
					if (null != scheduleStuId && scheduleStuId.size() > 0) {
						return true;
					}

				}
			}
		}

		return result;

	}

	/**
	 * 生成请求订单表单
	 * 
	 * @param orderAmount
	 *            金额
	 * @param productName
	 *            产品名称
	 * @return
	 */
	public String initPayFrom(String orderAmount, String productName) {
		// 生成订单号
		String orderNo = OrderNoUtils.getOrderNo();
		// 把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<>();
		sParaTemp.put("service", AlipayConfigUtil.service);
		sParaTemp.put("partner", AlipayConfigUtil.partner);
		sParaTemp.put("seller_id", AlipayConfigUtil.seller_id);
		sParaTemp.put("_input_charset", AlipayConfigUtil.input_charset);
		sParaTemp.put("payment_type", AlipayConfigUtil.payment_type);
		sParaTemp.put("notify_url", AlipayConfigUtil.notify_url);
		sParaTemp.put("return_url", AlipayConfigUtil.return_url);
		sParaTemp.put("anti_phishing_key", AlipayConfigUtil.anti_phishing_key);
		sParaTemp.put("exter_invoke_ip", AlipayConfigUtil.exter_invoke_ip);
		sParaTemp.put("out_trade_no", orderNo);
		sParaTemp.put("subject", productName);
		sParaTemp.put("total_fee", orderAmount);
		// sParaTemp.put("body", body);
		sParaTemp.put("qr_pay_mode", "2");
		// 建立支付请求
		// return AlipaySubmit.buildRequest(sParaTemp, "get", "确认");
		return "";
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception {
		dao.delete("StudentEnrollMapper.delete", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {
		dao.update("StudentEnrollMapper.edit", pd);
		// 取消学员班级关联关系

	}

	/**
	 * 修改订单号
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editOrderNo(PageData pd) throws Exception {
		dao.update("StudentEnrollMapper.editOrderNo", pd);
	}

	/**
	 * 根据订单号修改订单缴费状态
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editMoneyStatus(PageData pd) throws Exception {
		dao.update("StudentEnrollMapper.editMoneyStatus", pd);
	}

	/**
	 * 通过用户id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findByUserId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("StudentEnrollMapper.findByUserId", pd);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("StudentEnrollMapper.findById", pd);
	}

	/**
	 * 通过学生id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findByStuId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("StudentEnrollMapper.findByStuId", pd);
	}

}