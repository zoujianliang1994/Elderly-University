package com.zhimu.controller.manager.cms.manage;

import com.zhimu.commons.Exception.ValidateException;
import com.zhimu.commons.utils.PageData;
import com.zhimu.commons.utils.UuidUtil;
import com.zhimu.dao.entity.system.Page;
import com.zhimu.dao.vo.JsonVo;
import com.zhimu.service.manager.cms.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

public class BaseManageAction {
  protected final Logger logger = Logger.getLogger(this.getClass());
  @Autowired
  protected ConfigService configService;
  @Autowired
  protected FolderService folderService;
  @Autowired
  protected ArticleService articleService;
  @Autowired
  protected ManageTemplateService manageTemplateService;
  @Autowired
  protected NavigationService navigationService;

  /**
   * new PageData对象
   *
   * @return
   */
  public PageData getPageData() {
    return new PageData(this.getRequest());
  }

  /**
   * 得到ModelAndView
   *
   * @return
   */
  public ModelAndView getModelAndView() {
    return new ModelAndView();
  }

  /**
   * 得到request对象
   *
   * @return
   */
  public HttpServletRequest getRequest() {
    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    return request;
  }

  /**
   * 得到32位的uuid
   *
   * @return
   */
  public String get32UUID() {
    return UuidUtil.get32UUID();
  }

  /**
   * 得到分页列表的信息
   *
   * @return
   */
  public Page getPage() {
    return new Page();
  }

  public static void logBefore(Logger logger, String interfaceName) {
    logger.info("");
    logger.info("start");
    logger.info(interfaceName);
  }

  public static void logAfter(Logger logger) {
    logger.info("end");
    logger.info("");
  }

  /**
   * 参数校验
   *
   * @param json
   * @throws ValidateException
   */
  protected <T> void validate(JsonVo<T> json) throws Exception {
    if (json.getErrors().size() > 0) {
      json.setResult(false);
      throw new Exception("系统发生错误");
    } else {
      json.setResult(true);
    }
  }
}
