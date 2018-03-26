package com.zhimu.controller.manager.system.tld;

import com.zhimu.commons.utils.ApplicationContextHelper;
import com.zhimu.service.manager.system.dictionaries.impl.DictionariesService;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SuppressWarnings("serial")
public class SelectedValue extends BodyTagSupport {


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
      if(collection!=null&&!"".equals(collection)&&defaultValue!=null&&!"".equals(defaultValue)){
        DictionariesService dictionariesService = ApplicationContextHelper.getBean("dictionariesService");
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("parentId",collection);
        map.put("defaultValue",defaultValue.split(","));
        List<Map> listMap =  dictionariesService.getSelectedValue(map);
        if(listMap.size()>0){
          for (int i = 0; i < listMap.size(); i++) {
            String txt = listMap.get(i).get("NAME")+"";
            if(!"".equals(results.toString())){
              results.append(",");
            }

            results.append(txt);
          }
        }else {
          results.append("错误");
        }

      }else{
        results.append("错误");
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