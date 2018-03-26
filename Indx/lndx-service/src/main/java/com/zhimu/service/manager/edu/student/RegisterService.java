/**
 * 学员注册
 * @author wangyong
 */
package com.zhimu.service.manager.edu.student;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhimu.commons.utils.OrderNoUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.PropertyUtils;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.semester.SemesterService;
import com.zhimu.service.manager.system.user.impl.UserService;

@Service("registerService")
public class RegisterService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@Resource(name = "userService")
	private UserService userService;
	@Resource(name = "semesterService")
	private SemesterService semesterService;
	@Resource(name = "studentService")
	private StudentService studentService;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception {
		// 生成学员登录账号
		pd.put("pwdStrategy", "2");// 手机号策略
		pd.put("TYPE", "4");// 标记为学员
		pd.put("NAME", pd.getString("xm"));
		pd.put("PHONE", pd.getString("phone"));
		pd.put("ROLE_ID", PropertyUtils.getValue("MENBER_ROLE_ID"));// 注册学员角色
		PageData accountPd = this.userService.initeAccount(pd);
		if (null == accountPd) {
			throw new RuntimeException("账号初始化异常");
		} else {
			pd.put("user_id", accountPd.getString("userId"));
		}
		// 保存注册信息
		String orderNo = OrderNoUtils.getOrderNo();
		// 检测学籍号是否有重复
		pd.put("stu_number", orderNo);
		List<PageData> stuPd = studentService.findByStuNumber(pd);
		if (null != stuPd && stuPd.size() >= 1) {
			pd.put("stu_number", UuidUtil.get32UUID());
		}
		pd.put("semester_id", "");
		pd.put("zt", "1");
		dao.save("StudentMapper.register", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception {
		dao.delete("StudentMapper.delete", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {
		dao.update("StudentMapper.edit", pd);

	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("StudentMapper.datalistPage", page);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("StudentMapper.findById", pd);
	}

}