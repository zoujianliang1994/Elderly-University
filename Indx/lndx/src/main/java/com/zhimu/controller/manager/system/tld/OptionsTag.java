package com.zhimu.controller.manager.system.tld;

import com.zhimu.commons.utils.ApplicationContextHelper;
import com.zhimu.service.manager.system.dictionaries.DictionariesManager;
import com.zhimu.service.manager.system.dictionaries.impl.DictionariesService;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.BodyTagSupport;

@SuppressWarnings("serial")
public class OptionsTag extends BodyTagSupport {


  @Override
  public int doStartTag() throws JspException {
    return EVAL_BODY_INCLUDE;
  }
  @Override
  public int doEndTag() throws JspException {
    try {
      StringBuffer results = new StringBuffer("");
      //defaultValue
      //根据英文名称获取id;
      if(collection!=null&&!"".equals(collection)){
        DictionariesService dictionariesService = ApplicationContextHelper.getBean("dictionariesService");
        List<Map> listMap =  dictionariesService.getOptions(collection);
        if(listMap.size()>0){

          results.append("<option value=\"\" >请选择</option>");
          for (int i = 0; i < listMap.size(); i++) {
            String txt = listMap.get(i).get("NAME")+"";
            String val= listMap.get(i).get("BIANMA")+"";
            String selected = "selected=\"selected\"";
            //判断是否默认选中
            if(!val.equals(defaultValue)){
              selected = "";
            }
            results.append("<option value=\""+val+"\" "+selected+" >"+txt+"</option>");
          }
          
        }else {
          results.append("<option value=\"error\" >错误</option>");
        }

      }else{
        results.append("<option value=\"error\" >错误</option>");
      }

      pageContext.getOut().write(results.toString());
    } catch (IOException ex) {
      throw new JspTagException("错误");
    }catch (Exception e){

    }
    return EVAL_PAGE;
  }
  // collection只是传递一个标识，具体下拉值内容是从数据库取还是从请求中得到为不同具体实现
  protected String defaultValue;

  protected String collection;
  public String getCollection() {
    return collection;
  }
  public void setCollection(String collection) {
    this.collection = collection;
  }

  public String getDefaultValue() {
    return defaultValue;
  }

  public void setDefaultValue(String defaultValue) {
    this.defaultValue = defaultValue;
  }
}