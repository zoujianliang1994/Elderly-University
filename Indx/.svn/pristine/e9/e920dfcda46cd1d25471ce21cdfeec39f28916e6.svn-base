package com.zhimu.controller.manager.system.tld;

import com.zhimu.commons.utils.ApplicationContextHelper;
import com.zhimu.service.manager.system.dictionaries.impl.DictionariesService;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@SuppressWarnings("serial")
public class CheckboxTag extends BodyTagSupport {


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
          for (int i = 0; i < listMap.size(); i++) {
            String txt = listMap.get(i).get("NAME")+"";
            String val= listMap.get(i).get("BIANMA")+"";
            String selected = "checked=\"\"";
            //判断是否默认选中
            if(defaultValue!=null&&!"".equals(defaultValue)){
              if(!defaultValue.contains(val)){
                selected = "";
              }
            }else{
              selected = "";
            }

            results.append("<input type=\"checkbox\" lay-skin=\"primary\" name=\""+name+"\" value=\""+val+"\" "+selected+" title=\""+txt+"\" />");
          }
          
        }else {
          results.append("<input type=\"checkbox\" lay-skin=\"primary\" title=\"错误\" />");
        }

      }else{
        results.append("<input type=\"checkbox\" lay-skin=\"primary\" title=\"错误\" />");
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

  protected String name;

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

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }
}