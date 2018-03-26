package com.zhimu.controller.manager.edu.activity;

import com.zhimu.commons.constant.Const;
import com.zhimu.commons.utils.*;
import com.zhimu.controller.manager.base.BaseController;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.entity.system.User;
import com.zhimu.dao.utils.Jurisdiction;
import com.zhimu.service.manager.edu.activity.ActivityManager;
import com.zhimu.service.manager.edu.activityGroup.ActivityGroupService;
import com.zhimu.service.manager.edu.grades.GradesManager;
import com.zhimu.service.manager.message.MessageManager;
import com.zhimu.service.manager.message.impl.MessageService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 活动管理控制层__lwc
 */
@Controller
@RequestMapping(value = "/activity")
public class ActivityController extends BaseController {

    @Resource(name = "activityService")
    private ActivityManager activityService;
    @Resource(name = "messageService")
    private MessageService messageService;
    @Resource(name = "activityGroupService")
    private ActivityGroupService activityGroupService;

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
            pd.put("username", Jurisdiction.getUsername()); // 放入用户名作为筛选条件
            page.setPd(pd);
            List<PageData> activityList = activityService.listPage(page); // 列出所有的角色

            mv.addObject("pd", pd);
            mv.addObject("page", page);
            mv.addObject("list", activityList);

            mv.setViewName("edu/activity/activity_list");
        } catch (Exception e) {
            logger.error(ErrorUtils.getErrorMessage(e, "去活动列表异常!"));
        }
        return mv;
    }

    /**
     * 去新增页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/toAdd")
    public ModelAndView toAdd() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        try {
            mv.addObject("msg", "add");
            pd.put("type", "0");
            mv.setViewName("edu/activity/activity_edit");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(ErrorUtils.getErrorMessage(e, "去活动新增页面异常!"));
        }
        return mv;
    }

    /**
     * 保存新增
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/add")
    @ResponseBody
    public Object add(HttpServletRequest request, @RequestParam(value = "activityFile", required = false) MultipartFile activityFile) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData(request);
        String msgs = "";
        try {
            User user = this.getUserInfo();
            pd.put("create_by", user.getUSERNAME());
            pd.put("create_time", DateUtil.getTime());
            pd.put("id", get32UUID());
            pd.put("school_id", user.getSchoolId());
            pd.put("school_name", user.getSchoolName());

            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
            // 上传附件
            if (null != activityFile && !activityFile.isEmpty()) {
                String url = FileUpload.fileUp(activityFile, filePath,
                        activityFile.getOriginalFilename().split("\\.")[0] + "(" + DateUtil.getTime() + ")");
                pd.put("file_url", url);
            }
            String[] respContents = request.getParameterValues("resp_content");
            activityService.add(pd, respContents);
            msgs = "success";
        } catch (Exception e) {
            logger.error(ErrorUtils.getErrorMessage(e, "活动保存异常!"));
            msgs = "error";
        }
        Map<String, String> map = new HashMap<String, String>();
        map.put("msg", msgs);
        return AppUtil.returnObject(new PageData(), map);
    }

    /**
     * 去编辑页面
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
            pd = activityService.findObjectById(pd);
            // 获取活动负责人供展示
            List<PageData> leaders = activityGroupService.findLeaders(pd);
            if (null != pd) {
                pd.put("filePath", PathUtil.getClasspath() + Const.FILEPATHFILE + pd.getString("file_url"));
            }

            //封装参数
            pd.put("currentPage", currentPage);
            pd.put("keywords", keywords);
            pd.put("type", "0");
            mv.addObject("msg", "edit");
            mv.addObject("pd", pd);
            mv.addObject("leaders", leaders);
            mv.setViewName("edu/activity/activity_edit");
        } catch (Exception e) {
            logger.error(ErrorUtils.getErrorMessage(e, "去活动编辑页面异常!"));
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
    public Object edit(HttpServletRequest request, @RequestParam(value = "activityFile", required = false) MultipartFile activityFile) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData(request);
        String msg = "";
        try {
            msg = "success";
            this.deleteRole(pd.getString("id")); // 先删除旧数据
            this.add(request, activityFile); // 再新增新数据
            // activityService.edit(pd);
        } catch (Exception e) {
            logger.error(ErrorUtils.getErrorMessage(e, "活动编辑保存异常!"));
        }
        Map<String, String> map = new HashMap<String, String>();
        map.put("msg", msg);
        return AppUtil.returnObject(new PageData(), map);
    }

    /**
     * 删除
     *
     * @param id
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public Object deleteRole(@RequestParam String id) throws Exception {
        Map<String, String> map = new HashMap<String, String>();
        String errInfo = "";
        try {
            activityService.deleteById(id); // 执行删除
            activityGroupService.deleteByActiId(id);// 删除关联活动人员
            messageService.delBybuinessId(id); // 删除关联消息
            errInfo = "success";
        } catch (Exception e) {
            logger.error(ErrorUtils.getErrorMessage(e, "活动删除异常!"));
        }
        map.put("result", errInfo);
        return AppUtil.returnObject(new PageData(), map);
    }

    /**
     * 去查看页面
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
            // String currentPage = pd.getString("currentPage");
            String keywords = pd.getString("keywords");
            String msg = pd.getString("msg");
            if (StringUtils.isNotBlank(msg) && "1".equals(msg)) {
                pd.put("BUSINESS_ID", pd.getString("id"));
                messageService.updateStatus(pd); // 更新消息状态为已读
            }
            //查询
            pd = activityService.findObjectById(pd);
            // 获取活动负责人供展示
            List<PageData> leaders = activityGroupService.findLeaders(pd);
            if (null != pd) {
                pd.put("filePath", PathUtil.getClasspath() + Const.FILEPATHFILE + pd.getString("file_url"));

            }

            //封装参数
            // pd.put("currentPage", currentPage);
            pd.put("keywords", keywords);
            pd.put("type", "1");
            mv.addObject("msg", "select");
            mv.addObject("pd", pd);
            mv.addObject("leaders", leaders);
            mv.setViewName("edu/activity/activity_edit");
        } catch (Exception e) {
            logger.error(ErrorUtils.getErrorMessage(e, "去活动查看页面异常!"));
        }
        return mv;
    }

}
