package com.zhimu.controller.manager.edu.grades;


import com.zhimu.commons.utils.AppUtil;
import com.zhimu.commons.utils.ErrorUtils;
import com.zhimu.commons.utils.PageData;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.service.manager.edu.classroom.ClassroomManager;
import com.zhimu.service.manager.edu.grades.GradesManager;
import com.zhimu.service.manager.edu.school.SchoolService;
import net.sf.json.JSONArray;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/grades")
public class GradesController extends BaseController {


  @Resource(name = "gradesService")
  GradesManager gradesService;

  @Resource(name = "schoolService")
  private SchoolService schoolService;
  /**
   * 进入列表
   * @param page
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/list")
  public ModelAndView list(Page page) throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();
      //查询条件
      if(StringUtils.isEmpty(getUserInfo().getSchoolId())){
        return mv;
      }
      pd.put("userSchoolIds",getUserInfo().getSchoolId().split(","));

      page.setPd(pd);
      List<PageData> grades_List = gradesService.gradeslistPage(page); // 列出所有的角色

      mv.addObject("pd", pd);
      mv.addObject("page", page);
      mv.addObject("list", grades_List);

      mv.setViewName("edu/grades/grades_list");
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
  @RequestMapping(value = "/toAdd" )
  public ModelAndView toAdd() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();
      mv.addObject("schoolList", getSchoolList());
      mv.addObject("msg", "add");
      pd.put("type","0");
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
  @RequestMapping(value = "/add",method = RequestMethod.POST)
  @ResponseBody
  public Object add() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    String msgs = "";
    try {
      pd = this.getPageData();
      Boolean f = gradesService.isCheak(pd);
      if(f){
        pd.put("id",get32UUID());
        msgs = "success";
        gradesService.add(pd);
      }else{
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
      pd = gradesService.findObjectById(pd);

      String schoolId=pd.get("school_id")+"";

      //查询选择的学校对应的课程
      String[] ids = {schoolId};
      pd.put("userSchoolIds",ids);
      List<PageData> lessonList = gradesService.getUserLesson(pd);
      String periods = "";
      //循环出课程期数
      for (int i = 0; i < lessonList.size(); i++) {
        if(lessonList.get(i).getString("id").equals(pd.getString("lesson_id"))){
          periods = lessonList.get(i).get("qs")+"";
          break;
        }
      }
      List<PageData> periodsList = new ArrayList<PageData>();

      for (int i = 1; i <= Integer.parseInt(periods) ; i++) {
        PageData pa = new PageData();
        pa.put("no",i);
        periodsList.add(pa);
      }

      JSONArray arr = null;
      String json = "";
      //选择老师
      List<PageData> listTeacher = gradesService.getUserTeacher(pd);
      arr = JSONArray.fromObject(listTeacher);
      json = arr.toString();
      json = json.replaceAll("name", "title");

      //封装参数
      pd.put("currentPage", currentPage);
      pd.put("keywords", keywords);
      pd.put("type","0");
      mv.addObject("schoolList", getSchoolList());
      mv.addObject("listTeacher", json);
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
  @RequestMapping(value = "/edit" ,method = RequestMethod.POST)
  @ResponseBody
  public Object edit() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    String msg = "";
    try {
      pd = this.getPageData();
      msg = "success";
      gradesService.edit(pd);
    } catch (Exception e) {
      e.printStackTrace();
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
      gradesService.deleteById(id); // 执行删除
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
      pd = gradesService.findObjectById(pd);

      String schoolId=pd.get("school_id")+"";

      //查询选择的学校对应的课程
      String[] ids = {schoolId};
      pd.put("userSchoolIds",ids);
      List<PageData> lessonList = gradesService.getUserLesson(pd);
      String periods = "";
      //循环出课程期数
      for (int i = 0; i < lessonList.size(); i++) {
        if(lessonList.get(i).getString("id").equals(pd.getString("lesson_id"))){
          periods = lessonList.get(i).get("qs")+"";
          break;
        }
      }
      List<PageData> periodsList = new ArrayList<PageData>();

      for (int i = 1; i <= Integer.parseInt(periods) ; i++) {
        PageData pa = new PageData();
        pa.put("no",i);
        periodsList.add(pa);
      }

      //封装参数
      pd.put("currentPage", currentPage);
      pd.put("keywords", keywords);
      pd.put("type","1");
      mv.addObject("schoolList", getSchoolList());
      mv.addObject("lessonList", lessonList);
      mv.addObject("periodsList", periodsList);
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
      pd.put("userSchoolIds",ids);
      List<PageData> list = gradesService.getUserLesson(pd);
      List<PageData> listTeacher = gradesService.getUserTeacher(pd);
      arr = JSONArray.fromObject(listTeacher);
      json = arr.toString();
      json = json.replaceAll("name", "title");
      map.put("list",list);
      map.put("listTeacher",json);
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
      if(StringUtils.isEmpty(pd.getString("gId"))){
        return mv;
      }
      pd.put("gradesIds",pd.getString("gId").split(","));

      page.setPd(pd);
      List<PageData> list = gradesService.studentlistPage(page); // 列出所有的角色

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
  @RequestMapping(value = "/toCommittee" )
  public ModelAndView toCommittee() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();
      String currentPage = pd.getString("currentPage");
      String keywords = pd.getString("keywords");
      String gId = pd.getString("gId");
      //查询该学生班委
      pd = gradesService.findStudentCommitteeById(pd);
      //封装参数
      pd.put("currentPage", currentPage);
      pd.put("gId", gId);
      pd.put("keywords", keywords);

      mv.addObject("msg", "add");
      mv.addObject("url", "saveClassCommittee");
      pd.put("type","0");
      mv.setViewName("edu/grades/gradesStudent_edit");
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
  @RequestMapping(value = "/saveClassCommittee",method = RequestMethod.POST)
  @ResponseBody
  public Object saveClassCommittee() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    String msgs = "";
    try {
      pd = this.getPageData();

      msgs = "success";
      gradesService.saveClassCommittee(pd);

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
  @RequestMapping(value = "/toAddGroup" )
  public ModelAndView toAddGroup() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();
      String gId = pd.getString("gId");
      pd.put("gradesIds",gId.split(","));
      //查询
      //查询所有学生
      List<PageData> allStudent = gradesService.getAllStudentBycId(pd);
      //查询以分组
      List<PageData> allGroupById = gradesService.allGroupById(pd.getString("gId"));

      //封装参数
      mv.addObject("allStudent", allStudent);
      mv.addObject("allGroupById", allGroupById);
      pd.put("type","0");
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
      PageData pa= new PageData();
      pa.put("gId",pd.getString("c_id"));
      pa.put("id",pd.getString("student_id"));
      pa.put("sid",pd.getString("sid"));
      PageData pg = gradesService.findStudentCommitteeById(pa);
      //student_id  c_id group_id

      if(!"1".equals(pg.getString("group_leader"))){
        if (!"1".equals(pd.getString("type"))) {
            //清除改分组的组长重新设置
            gradesService.editStudentGroupLeader(pd);
        }else{
          String group_id = get32UUID();
          //新增分组
          pd.put("group_id",group_id);
          gradesService.addStudentGroup(pd);
        }

        pd.put("group_leader","1");
        gradesService.editStudentGroup(pd);
        msg = "success";
      }else{
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
        gradesService.editStudentGroupAll(pd);
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
  @RequestMapping(value = "/toGroup" )
  public ModelAndView toGroup() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();
      String gId = pd.getString("gId");
      pd.put("gradesIds",gId.split(","));
      //查询
      //查询以分组
      List<PageData> allGroupById = gradesService.allGroupById(pd.getString("gId"));

      mv.addObject("allGroupById", allGroupById);
      pd.put("type","0");
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
  @RequestMapping(value = "/editGroup",method = RequestMethod.POST)
  @ResponseBody
  public Object editGroup() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    String msgs = "";
    try {
      pd = this.getPageData();

      msgs = "success";
      gradesService.editGroup(pd);

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
   * @return
   */
  @RequestMapping(value = "findBySchool")
  @ResponseBody
  public Object findBySchool(){
    Map<String, String> map = new HashMap<String, String>();
    PageData pd = this.getPageData();
    JSONArray arr = null;
    String json = "";
    List<PageData> classes = null;
    try {
      String schoolIds = pd.getString("schoolIds");
      if (StringUtils.isNotBlank(schoolIds)){ // 获取前台传过来的学校id
        classes = gradesService.findBySchools(pd);
      }else { // 如果没有传则拿到当前登录用户的所属学校及分校区的所有班级
        String schoolId = this.getUserInfo().getSchoolId();
        PageData pageData = new PageData();
        pageData.put("id", schoolId);
        PageData school = schoolService.findById(pageData);
        schoolIds = schoolId;

        String type = school.getString("type");
        // 如果学校类型为空则寻找它的分校区
        if (type.isEmpty()) {
          List<PageData> subSchools = schoolService.listSubSchools(schoolId);
          for (int i = 0; i < subSchools.size()-1 ; i++) {
            if (i == subSchools.size()-1){
              schoolIds += subSchools.get(i).getString("id");
            }else {
              schoolIds += subSchools.get(i).getString("id") + ",";
            }
          }
        }
        pd.put("schoolIds", schoolIds);
        classes = gradesService.findBySchools(pd);
      }
      arr = JSONArray.fromObject(classes);
      json = arr.toString();
      map.put("data", json);
    }catch (Exception e){
      logger.error(ErrorUtils.getErrorMessage(e,"获取学校班级异常__lwc"));
    }
    return map;
  }

  /**
   * 根据学校id获取班级数据_lwc
   * @return
   */
  @RequestMapping(value = "/findObjectBySchoolId")
  @ResponseBody
  public Object findObjectBySchoolId() {
    PageData pd = getPageData();
    JSONArray arr = new JSONArray();
    try {

      arr = JSONArray.fromObject(gradesService.findObjectBySchoolId(pd.getString("schoolIds")));
    } catch (Exception e) {
      logger.error(ErrorUtils.getErrorMessage(e, "根据学校id获取班级数据异常"));
    }
    return arr;
  }


}
