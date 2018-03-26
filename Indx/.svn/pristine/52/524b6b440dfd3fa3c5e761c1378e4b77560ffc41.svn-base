package com.zhimu.controller.manager.system.tld;
import java.io.IOException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.BodyTagSupport;
/**
 * TagSupport与BodyTagSupport的区别:
 * 主要看标签处理类是否要读取标签体的内容和改变标签体返回的内容，如果不需要就用TagSupport，否则就用BodyTagSupport
 * 用TagSupport实现的标签，都可以用BodyTagSupport来实现，因为BodyTagSupport继承了TagSupport
 */
@SuppressWarnings("serial")
public class SelectTag extends BodyTagSupport {

  @Override
  public int doStartTag() throws JspException {
    try {
      StringBuffer results = new StringBuffer("<select");
      if(name != null){
        results.append(" name=\"");
        results.append(name);
        results.append("\"");
      }
      if(style != null){
     //   results.append(" style=\"");
        results.append(style);
       // results.append("\"");
      }
      if(classs != null){
        results.append(" class=\"");
        results.append(classs);
        results.append("\"");
      }
      if(id != null){
        results.append(" id=\"");
        results.append(id);
        results.append("\"");
      }
      results.append(">");
      pageContext.getOut().write(results.toString());
    } catch (IOException ex) {
      throw new JspTagException("错误");
    }
    return EVAL_BODY_INCLUDE;
  }
  @Override
  public int doEndTag() throws JspException {
    try {
      StringBuffer results = new StringBuffer("");
      // 因为下拉中包含下拉内容，所以只能在遇到结束标签时才能写select结束
      results.append("</select>");

      pageContext.getOut().write(results.toString());
    } catch (IOException ex) {
      throw new JspTagException("错误");
    }
    return EVAL_PAGE;
  }




  // 样式
  protected String style;
  // 名字
  protected String name;

  // 类
  protected String classs;

  protected String id;

  public String getStyle() {
    return style;
  }
  public void setStyle(String style) {
    this.style = style;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }

  public String getClasss() {
    return classs;
  }

  public void setClasss(String classs) {
    this.classs = classs;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }
  /**
   doStartTag()方法是遇到标签开始时会呼叫的方法，其合法的返回值是EVAL_BODY_INCLUDE与SKIP_BODY,前者表示将显示标签间的文字，后者表示不显示标签间的文字
   doEndTag()方法是在遇到标签结束时呼叫的方法，其合法的返回值是EVAL_PAGE与SKIP_PAGE，前者表示处理完标签后继续执行以下的JSP网页，后者是表示不处理接下来的JSP网页
   doAfterBody(),这个方法是在显示完标签间文字之后呼叫的，其返回值有EVAL_BODY_AGAIN与SKIP_BODY，前者会再显示一次标签间的文字，后者则继续执行标签处理的下一步
   EVAL_BODY_INCLUDE：把Body读入存在的输出流中，doStartTag()函数可用
   EVAL_PAGE：继续处理页面，doEndTag()函数可用
   SKIP_BODY：忽略对Body的处理，doStartTag()和doAfterBody()函数可用
   SKIP_PAGE：忽略对余下页面的处理，doEndTag()函数可用
   EVAL_BODY_BUFFERED：申请缓冲区，由setBodyContent()函数得到的BodyContent对象来处理tag的body，如果类实现了BodyTag，那么doStartTag()可用，否则非法
   EVAL_BODY_AGAIN：请求继续处理body，返回自doAfterBody()，这个返回值在你制作循环tag的时候是很有用的
   预定的处理顺序是：doStartTag()返回SKIP_BODY,doAfterBodyTag()返回SKIP_BODY,doEndTag()返回EVAL_PAGE
   如果继承了TagSupport之后，如果没有改写任何的方法，标签处理的执行顺序是：doStartTag() ->不显示文字 ->doEndTag()->执行接下来的网页
   如果您改写了doStartTag(),则必须指定返回值,
   如果指定了EVAL_BODY_INCLUDE,则执行顺序是：doStartTag()->显示文字->doAfterBodyTag()->doEndTag()->执行下面的网页
   */
}