package com.zhimu.controller.manager.stu.myClass;


import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.User;
import com.zhimu.service.manager.edu.grades.GradesManager;
import com.zhimu.service.manager.edu.school.SchoolAptitudeService;
import com.zhimu.service.manager.edu.school.SchoolService;
import com.zhimu.service.manager.stu.myClass.MyClassManager;
import net.sf.json.JSONArray;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.*;

/**
 * 我的班级控制层_lwc
 */
@Controller
@RequestMapping(value = "/myClass")
public class MyClassController extends BaseController {


    @Resource(name = "myClassService")
    private MyClassManager myClassService;
    @Resource(name = "schoolService")
    private SchoolService schoolService;
    @Resource(name = "schoolAptitudeService")
    private SchoolAptitudeService schoolAptitudeService;
    @Resource(name = "gradesService")
    private GradesManager gradesService;

    /**
     * 进入列表
     *
     * @param page
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/list")
    public ModelAndView list(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        try {
            User user = getUserInfo();
            //查询条件
            if (StringUtils.isEmpty(user.getSchoolId())) {
                return mv;
            }
            pd.put("userId", user.getUSER_ID());
            String schoolId = user.getSchoolId();
            Set<PageData> schoolSet = null;
            if (StringUtils.isNotBlank(schoolId)){
                schoolSet = schoolService.listPschools(schoolId.split(",")); // 列出所有学校
            }

            // 拿到前传过来的条件,判断,如果有选择学校班级数据,就查出来作为前台查询条件显示
            String school_child_id = pd.getString("school_child_id"); // 分校区
            String school_id = pd.getString("school_id"); // 校区
            String grade_id = pd.getString("grade_id"); // 班级

            page.setPd(pd);
            List<PageData> grades_List = myClassService.listPage(page); // 列出所有的班级

            // 如果分校不为空, 拿到所有当前学校分校及分校的班级
            if (StringUtils.isNotBlank(school_child_id)){
                pd.put("school_id",school_id);
                mv.addObject("childSchools", schoolService.listSubSchools(school_id));
                PageData pageData = new PageData();
                pageData.put("schoolIds",school_child_id);
                mv.addObject("grades", gradesService.findBySchools(pageData));
            }
            // 如果学校不为空且分校为空,则拿到学校的所有分校以及学校的所有班级
            if (StringUtils.isNotBlank(school_id) && StringUtils.isEmpty(school_child_id)){
                pd.put("school_id",school_id);
                mv.addObject("childSchools", schoolService.listSubSchools(school_id));
                PageData pageData = new PageData();
                pageData.put("schoolIds",school_id);
                mv.addObject("grades", gradesService.findBySchools(pageData));
            }

            mv.addObject("pd", pd);
            mv.addObject("page", page);
            mv.addObject("schoolList", schoolSet);
            mv.addObject("list", grades_List);

            mv.setViewName("stu/myClass/myClass_list");
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 去新增页面
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/toAdd")
    public ModelAndView toAdd() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            mv.addObject("schoolList", getSchoolList());
            mv.addObject("msg", "add");
            pd.put("type", "0");
            mv.setViewName("edu/grades/grades_edit");
            mv.addObject("pd", pd);
        } catch (Exception e) {
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
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Object add() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        String msgs = "";
        try {
            pd = this.getPageData();
            Boolean f = myClassService.isCheak(pd);
            if (f) {
                pd.put("id", get32UUID());
                msgs = "success";
                myClassService.add(pd);
            } else {
                msgs = "false";
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
            //查询
            pd = myClassService.findObjectById(pd);

            String schoolId = pd.get("school_id") + "";

            //查询选择的学校对应的课程
            String[] ids = {schoolId};
            pd.put("userSchoolIds", ids);
            List<PageData> lessonList = myClassService.getUserLesson(pd);
            String periods = "";
            //循环出课程期数
            for (int i = 0; i < lessonList.size(); i++) {
                if (lessonList.get(i).getString("id").equals(pd.getString("lesson_id"))) {
                    periods = lessonList.get(i).get("qs") + "";
                    break;
                }
            }
            List<PageData> periodsList = new ArrayList<PageData>();

            for (int i = 1; i <= Integer.parseInt(periods); i++) {
                PageData pa = new PageData();
                pa.put("no", i);
                periodsList.add(pa);
            }

            //封装参数
            pd.put("currentPage", currentPage);
            pd.put("keywords", keywords);
            pd.put("type", "0");
            mv.addObject("schoolList", getSchoolList());
            mv.addObject("lessonList", lessonList);
            mv.addObject("periodsList", periodsList);
            mv.addObject("msg", "edit");
            mv.addObject("pd", pd);
            mv.setViewName("edu/grades/grades_edit");
        } catch (Exception e) {
            e.printStackTrace();
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
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object edit() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        String msg = "";
        try {
            pd = this.getPageData();
            msg = "success";
            myClassService.edit(pd);
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
            myClassService.deleteById(id); // 执行删除
            errInfo = "success";
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }


    /**
     * 请求查看
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/toSelect")
    public ModelAndView toSelect() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            String currentPage = pd.getString("currentPage");
            String keywords = pd.getString("keywords");
            //查询
            pd = myClassService.findObjectById(pd);

            String schoolId = pd.get("school_id") + "";

            //查询选择的学校对应的课程
            String[] ids = {schoolId};
            pd.put("userSchoolIds", ids);
            List<PageData> lessonList = myClassService.getUserLesson(pd);
            String periods = "";
            //循环出课程期数
            for (int i = 0; i < lessonList.size(); i++) {
                if (lessonList.get(i).getString("id").equals(pd.getString("lesson_id"))) {
                    periods = lessonList.get(i).get("qs") + "";
                    break;
                }
            }
            List<PageData> periodsList = new ArrayList<PageData>();

            for (int i = 1; i <= Integer.parseInt(periods); i++) {
                PageData pa = new PageData();
                pa.put("no", i);
                periodsList.add(pa);
            }

            //封装参数
            pd.put("currentPage", currentPage);
            pd.put("keywords", keywords);
            pd.put("type", "1");
            mv.addObject("schoolList", getSchoolList());
            mv.addObject("lessonList", lessonList);
            mv.addObject("periodsList", periodsList);
            mv.addObject("msg", "edit");
            mv.addObject("pd", pd);
            mv.setViewName("edu/grades/grades_edit");
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 获取选择学校的课程
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getSchoolLesson")
    @ResponseBody
    public Object getSchoolLesson(@RequestParam String id) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = new PageData();
        String errInfo = "";
        String json = "";
        JSONArray arr = null;
        try {
            String[] ids = {id};
            pd.put("userSchoolIds", ids);
            List<PageData> list = myClassService.getUserLesson(pd);
            List<PageData> listTeacher = myClassService.getUserTeacher(pd);
            arr = JSONArray.fromObject(listTeacher);
            json = arr.toString();
            json = json.replaceAll("name", "title");
            map.put("list", list);
            map.put("listTeacher", json);
            errInfo = "success";
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }


//==================================学员管理

    /**
     * 进入列表
     *
     * @param page
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/listStudent")
    public ModelAndView listStudent(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            //查询条件
            if (StringUtils.isEmpty(pd.getString("gId"))) {
                return mv;
            }
            pd.put("gradesIds", pd.getString("gId").split(","));

            page.setPd(pd);
            List<PageData> list = myClassService.studentlistPage(page); // 列出所有的角色

            mv.addObject("pd", pd);
            mv.addObject("page", page);
            mv.addObject("list", list);

            mv.setViewName("edu/grades/student_list");
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.toString(), e);
        }

        return mv;
    }

    /**
     * 去新增页面
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/toCommittee")
    public ModelAndView toCommittee() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            String currentPage = pd.getString("currentPage");
            String keywords = pd.getString("keywords");
            String gId = pd.getString("gId");
            //查询
            pd = myClassService.findStudentById(pd);
            //封装参数
            pd.put("currentPage", currentPage);
            pd.put("gId", gId);
            pd.put("keywords", keywords);
            mv.addObject("schoolList", getSchoolList());

            mv.addObject("msg", "add");
            mv.addObject("url", "saveClassCommittee");
            pd.put("type", "0");
            mv.setViewName("edu/grades/gradesStudent_edit");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 保存班委设置
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/saveClassCommittee", method = RequestMethod.POST)
    @ResponseBody
    public Object saveClassCommittee() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        String msgs = "";
        try {
            pd = this.getPageData();

            msgs = "success";
            myClassService.saveClassCommittee(pd);

        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.toString(), e);
            msgs = "error";
        }
        Map<String, String> map = new HashMap<String, String>();
        map.put("msg", msgs);
        return AppUtil.returnObject(new PageData(), map);
    }


    /**
     * 去新增分组页面
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/toAddGroup")
    public ModelAndView toAddGroup() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            String gId = pd.getString("gId");
            pd.put("gradesIds", gId.split(","));
            //查询
            //查询所有学生
            List<PageData> allStudent = myClassService.getAllStudentBycId(pd);
            //查询以分组
            List<PageData> allGroupById = myClassService.allGroupById(pd.getString("gId"));

            //封装参数
            mv.addObject("allStudent", allStudent);
            mv.addObject("allGroupById", allGroupById);
            pd.put("type", "0");
            mv.setViewName("edu/grades/gradesStudent_addGroup");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.toString(), e);
        }
        return mv;
    }

    @RequestMapping(value = "/addGroup", method = RequestMethod.GET)
    @ResponseBody
    public Object save() {
        Map<String, String> map = new HashMap();
        PageData pd = getPageData();
        String msg = "";
        try {
            //验证是否是修改组长
            //验证该用户是否为组长
            PageData pg = myClassService.findStudentById(pd);

            if (!"1".equals(pg.getString("group_leader"))) {
                if (!"1".equals(pd.getString("type"))) {
                    //清除改分组的组长重新设置
                    myClassService.editStudentGroupLeader(pd);
                }
                pd.put("group_leader", "1");
                myClassService.editStudentGroup(pd);
                msg = "success";
            } else {
                msg = "false";
            }

        } catch (Exception e) {
            msg = "error";
            logger.error(ErrorUtils.getErrorMessage(e, "保存系别信息异常!"));
        }
        map.put("result", msg);
        return AppUtil.returnObject(new PageData(), map);
    }


    @RequestMapping(value = "/deleteGroup", method = RequestMethod.GET)
    @ResponseBody
    public Object deleteGroup() {
        Map<String, String> map = new HashMap();
        PageData pd = getPageData();
        String msg = "";
        try {
            //验证是否是修改组长
            //验证该用户是否为组长
            myClassService.editStudentGroupAll(pd);
            msg = "success";
        } catch (Exception e) {
            msg = "error";
            logger.error(ErrorUtils.getErrorMessage(e, "删除小组异常!"));
        }
        map.put("result", msg);
        return AppUtil.returnObject(new PageData(), map);
    }


    /**
     * 去调整
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/toGroup")
    public ModelAndView toGroup() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            String gId = pd.getString("gId");
            pd.put("gradesIds", gId.split(","));
            //查询
            //查询以分组
            List<PageData> allGroupById = myClassService.allGroupById(pd.getString("gId"));

            mv.addObject("allGroupById", allGroupById);
            pd.put("type", "0");
            mv.setViewName("edu/grades/gradesStudent_editGroup");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 保存班委设置
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editGroup", method = RequestMethod.POST)
    @ResponseBody
    public Object editGroup() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        String msgs = "";
        try {
            pd = this.getPageData();

            msgs = "success";
            myClassService.editGroup(pd);

        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.toString(), e);
            msgs = "error";
        }
        Map<String, String> map = new HashMap<String, String>();
        map.put("msg", msgs);
        return AppUtil.returnObject(new PageData(), map);
    }


    /**
     * 获取所选学校的所有的班级--lwc
     *
     * @return
     */
    @RequestMapping(value = "findBySchool")
    @ResponseBody
    public Object findBySchool() {
        Map<String, String> map = new HashMap<String, String>();
        PageData pd = this.getPageData();
        JSONArray arr = null;
        String json = "";
        List<PageData> classes = null;
        try {
            String schoolIds = pd.getString("schoolIds");
            if (StringUtils.isNotBlank(schoolIds)) { // 获取前台传过来的学校id
                classes = myClassService.findBySchools(pd);
            } else { // 如果没有传则拿到当前登录用户的所属学校及分校区的所有班级
                String schoolId = this.getUserInfo().getSchoolId();
                PageData pageData = new PageData();
                pageData.put("id", schoolId);
                PageData school = schoolService.findById(pageData);
                schoolIds = schoolId;

                String type = school.getString("type");
                // 如果学校类型为空则寻找它的分校区
                if (type.isEmpty()) {
                    List<PageData> subSchools = schoolService.listSubSchools(schoolId);
                    for (int i = 0; i < subSchools.size() - 1; i++) {
                        if (i == subSchools.size() - 1) {
                            schoolIds += subSchools.get(i).getString("id");
                        } else {
                            schoolIds += subSchools.get(i).getString("id") + ",";
                        }
                    }
                }
                pd.put("schoolIds", schoolIds);
                classes = myClassService.findBySchools(pd);
            }
            arr = JSONArray.fromObject(classes);
            json = arr.toString();
            map.put("data", json);
        } catch (Exception e) {
            logger.error(ErrorUtils.getErrorMessage(e, "获取学校班级异常__lwc"));
        }
        return map;
    }


}
