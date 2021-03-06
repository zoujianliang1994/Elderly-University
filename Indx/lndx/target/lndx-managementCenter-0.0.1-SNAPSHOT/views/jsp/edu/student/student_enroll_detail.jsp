<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>学籍管理查看</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>
<div class="tableBox">
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title">
        <li class='layui-this' >学员资料</li>
        <li id="sel_grades">所选课程</li>

    </ul>
    <div class="layui-tab-content" style="padding: 0 16px;">
        <div class="layui-tab-item info layui-show">
            <div class="info-left" style="width: 10%;margin-right: 2%">
                <img class="img" src="<%=basePath %>uploadFiles/file/${pd.photo_url}"style="max-width: 100%;max-height: 100%;"/>
            </div>
            <div class="info-right" style="width: 88%">
                <form  class="layui-form" id="editForm" lay-filter="editForm" method="post">
                    <div class="layui-form-item">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="form-label"><i class="require">*</i>姓名<span class="colon"></span></label>
                               <div class="layui-input-block " style="width: 10rem;">
                                    <input type="text" id="name" value="${pd.xm}"  required lay-verify="required" autocomplete="off" maxlength="200"  class="layui-input layui-input-color">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="form-label"><i class="require">*</i>性别<span class="colon"></span></label>
                               <div class="layui-input-block " style="width: 10rem;">
                                    <html:select name="xb" id="xb" classs="layui-input" style=" lay-filter='xb'">
                                        <html:options collection="SEX" defaultValue="${pd.xb}"></html:options>
                                    </html:select>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="form-label"><i class="require">*</i>年龄<span class="colon"></span></label>
                               <div class="layui-input-block " style="width: 10rem;"  >
                                    <input type="text" id="age" value="${pd.nl}" required lay-verify="required"
                                           autocomplete="off" maxlength="200"
                                           class="layui-input layui-input-color">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="form-label"><i class="require">*</i>出生日期<span class="colon"></span></label>
                               <div class="layui-input-block " style="width: 10rem;">
                                    <input type="text" id="birth_date"  value="${pd.birth_day}"  required lay-verify="required" placeholder="请选择日期"
                                           autocomplete="off" maxlength="200"
                                           class="layui-input layui-input-color">
                                </div>
                            </div>

                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="form-label"><i class="require">*</i>身份证号<span class="colon"></span></label>
                               <div class="layui-input-block " style="width:20rem;">
                                    <input type="text" value="${pd.sfz}" id="ID_num" name="NAME"  required lay-verify="required"
                                           autocomplete="off" maxlength="200"
                                           class="layui-input layui-input-color">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="form-label">籍贯<span class="colon"></span></label>
                               <div class="layui-input-block " style="width: 10rem;">
                                    <input type="text" value="${pd.hjdz}"  required lay-verify="required"
                                           autocomplete="off" maxlength="200"
                                           class="layui-input layui-input-color">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="form-label">民族<span class="colon"></span></label>
                               <div class="layui-input-block " style="width: 10rem;">
                                    <html:select name="mz" id="mz" classs="layui-input" style=" lay-filter='mz'">
                                        <html:options collection="Person_mz" defaultValue="${pd.mz}"></html:options>
                                    </html:select>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="form-label">手机号码<span class="colon"></span></label>
                               <div class="layui-input-block " style="width: 10rem;"  >
                                    <input type="text"  value="${pd.phone}" required lay-verify="required"
                                           autocomplete="off" maxlength="200"
                                           class="layui-input layui-input-color">
                                </div>
                            </div>

                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="form-label"><i class="require">*</i>疾病历史<span class="colon"></span></label>
                               <div class="layui-input-block " style="width:20rem;">
                                    <input type="text" value="${pd.disease}" id="diseases_history" name="NAME"  required lay-verify="required"
                                           autocomplete="off" maxlength="200"
                                           class="layui-input layui-input-color">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="layui-form-item my-form" style="border-bottom: 1px solid #dce3eb;">
                    <div class="layui-inline citys" id="selectList">
                        <label class="form-label">当前住址<span class="colon"></span></label>
                       <div class="layui-input-block " style="width: 10rem; margin-right: 34px;float: left;">
                            <select name="province" id="province" class="select-linkage layui-input-color"></select>
                        </div>
                       <div class="layui-input-block " style="width: 10rem; margin-right: 34px;float: left;">
                            <select name="city" id="city" class="select-linkage layui-input-color"></select>
                        </div>
                       <div class="layui-input-block " style="width: 10rem; margin-right: 34px;float: left;">
                            <select name="area" id="country" class="select-linkage layui-input-color"></select>
                        </div>

                       <div class="layui-input-block " style="width: 12rem;float: left;">
                            <input type="text"  required lay-verify="required" name="address" id="address" value="${pd.address}"
                                   autocomplete="off" maxlength="100" placeholder="请输入详细地址"
                                   class="layui-input layui-input-color">
                        </div>

                    </div>
                </div>
                        <%--<div class="layui-form-item">--%>
                            <%--<div class="layui-inline">--%>
                                <%--<label class="form-label">当前住址<span class="colon"></span></label>--%>
                                <%--<div class="layui-input-block " style="width: 40rem;">--%>
                                    <%--<input type="text" value="${pd.address}"  required lay-verify="required"--%>
                                           <%--autocomplete="off" maxlength="200"--%>
                                           <%--class="layui-input layui-input-color">--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                <form  class="layui-form" id="editForm" lay-filter="editForm" method="post">
                    <div class="layui-form-item" style="padding: 10px 0 5px 0;border-bottom: 1px solid #dce3eb;">
                        <div class="layui-inline" style="padding-right: 6px;">
                            <label class="form-label">学号<span class="colon"></span></label>
                           <div class="layui-input-block " style="width: 21rem;margin-right: 70px;">
                                <input type="text" value="${pd.stu_number}"  required lay-verify="required"
                                       autocomplete="off" maxlength="200"
                                       class="layui-input layui-input-color">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="form-label">入学时间<span class="colon"></span></label>
                           <div class="layui-input-block " style="width: 10rem;">
                                <input type="text" value="${pd.join_school_date}" id="entrance_date"   required lay-verify="required" placeholder="请选择日期"
                                       autocomplete="off" maxlength="200"
                                       class="layui-input layui-input-color">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item" style="padding: 10px 0 5px 0;">
                        <div class="layui-inline">
                            <label class="form-label title-max"><span><i class="require">*</i>家庭联系</span><span>人</span></label>
                           <div class="layui-input-block " style="width: 10rem;">
                                <input type="text" id="linkman" value="${pd.family_con_name}"  required lay-verify="required"
                                       autocomplete="off" maxlength="200"
                                       class="layui-input layui-input-color">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="form-label title-max"><span><i class="require">*</i>联系人电</span><span>话</span></label>
                           <div class="layui-input-block " style="width: 10rem;">
                                <input type="text" id="linkman_phone" value="${pd.family_con_tel}"   required lay-verify="required"
                                       autocomplete="off" maxlength="200"
                                       class="layui-input layui-input-color">
                            </div>

                        </div>
                        <div class="layui-inline">
                            <label class="form-label title-max"><span>第二家庭</span><span>联系人</span></label>
                           <div class="layui-input-block " style="width: 10rem;">
                                <input type="text"  required lay-verify="required"
                                       autocomplete="off" value="${pd.sec_con}" maxlength="200"
                                       class="layui-input layui-input-color">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="form-label title-max"><span>联系人电</span><span>话</span></label>
                           <div class="layui-input-block " style="width: 10rem;">
                                <input type="text"  value="${pd.sec_con_tel}"   required lay-verify="required"
                                       autocomplete="off" maxlength="200"
                                       class="layui-input layui-input-color">
                            </div>
                        </div>
                    </div>
                    <div class="btnbox" id="btnDiv">
                        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="layui-tab-item">
            <p class="class-info-title">已报班级</p>
            <div class="">
                <table class="layui-table center" lay-skin="line" id="table">
                    <colgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col width="170">
                    </colgroup>
                    <thead>
                    <tr class="table-head-tr">

                        <th>班级名称</th>
                        <th>上课时间</th>
                        <th>教室</th>
                        <th>任课老师</th>
                        <th>人数（人）</th>
                        <th>学费</th>
                        <th style="border-left: 1px solid #dce3eb;">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty enrollPd}">
                            <c:forEach items="${enrollPd}" var="var" varStatus="vs">
                             	<c:if test="${var.money_status== 1}">
	                                <tr>
	                                    <td>${var.g_name}</td>
	                                    <td>${var.course_time.replaceAll('!','<br>')}</td>
	                                    <td>${var.classroom_name}</td>
	                                    <td>${var.teacher_name}</td>
	                                    <td>${var.is_all}</td>
	                                    <td>${var.money}</td>
	                                    <td style="text-align: center;border-left: 1px solid #dce3eb;">
	                                        <a class="table-btn-max chakan-btn edit" onclick="cancleEnroll('${var.id}','${var.g_id}','${var.student_id}');">
	                                            退班退款
	                                        </a>
	                                    </td>
	                                </tr>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr class="main_info">
                                <td colspan="100" class="center">没有相关数据</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>

            </div>

            <p class="class-info-title">已取消班级</p>

            <div class="">
                <table class="layui-table center" lay-skin="line" id="change-table">
                    <colgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col width="150">
                    </colgroup>
                    <thead>
                    <tr class="table-head-tr">
                        <th>班级名称</th>
                        <th>上课时间</th>
                        <th>教室</th>
                        <th>任课老师</th>
                        <th>人数（人）</th>
                        <th>学费</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty canclePd}">
                            <c:forEach items="${canclePd}" var="var" varStatus="vs">
                             	<c:if test="${var.money_status== 3}">
	                                <tr>
	                                    <td>${var.g_name}</td>
	                                    <td>${var.course_time.replaceAll('!','<br>')}</td>
	                                    <td>${var.classroom_name}</td>
	                                    <td>${var.teacher_name}</td>
	                                    <td>${var.is_all}</td>
	                                    <td>${var.money}</td>
	                                    <td style="text-align: center;border-left: 1px solid #dce3eb;">
	                                        <a class="table-btn-max chakan-btn edit" onclick="reEnroll('${var.id}','${var.g_id}','${var.student_id}');">
	                                            重新缴费并报名
	                                        </a>
	                                    </td>
	                                </tr>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr class="main_info">
                                <td colspan="100" class="center">没有相关数据</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</div>

<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
    if('${pd.province}'==""||'${pd.province}'=="undefined"){
        $('#selectList').citys({valueType:'name',required: false});
    }else{
        $('#selectList').citys({valueType:'name',province:'${pd.province}',city:'${pd.city}',area:'${pd.country}'});
    }
    if('${pd.type}'=="1"){
    	 $("#sel_grades").click();
    }
    var data={ province: '${pd.province}', city: '${pd.city}', country: '${pd.country}'};
    console.log(data)
    $(".my-form select").each(function(){
        setVal($(this),'.layui-input-block',data)
    })
    $(".myaddr").css({"width":"auto","margin":"0","line-height":"38px"});
    function setVal(obj,parent,data){
        var id= $(obj).attr("id");
        $(obj).closest(parent).css({"width":"auto","margin":"0","line-height":"38px"});
        $(obj).closest(parent).html(data[id]);
    }

    $.myType(1);

    
    //退班退费
    function  cancleEnroll(id,grades_id,stu_id){
 	    parent.layer.load(1);
    	$.post('cancleEnroll.do',{id:id,grades_id:grades_id,stu_id:stu_id},function(result){
       	   	   parent.layer.closeAll('loading');
    	       if(result.msg=="success"){
          	   	   layer.msg('退班成功!', {icon: 1});
           	   	   window.location.href ='<%=basePath%>studentEnroll/goDetail.do?id=${pd.id}&type=1' ;
    	       }else{
          	   	   layer.msg('系统异常，请稍后再试!', {icon: 5});
    	       }
    	 },"json");
    }
    
    var orderNo,interval;
    
    //重新缴费报名
    function reEnroll(id,grades_id,stu_id){
 	    parent.layer.load(1);
    	$.post('reEnroll.do',{id:id,grades_id:grades_id,stu_id:stu_id},function(data){
    		console.log(data);
    		if(data.msg=="success"){
    			 orderNo=data.orderNo;
  			   	 interval= setInterval("getOrderStatus()","1000");
  	    	   	 window.open("<%=basePath%>alipay/alipayInitPay?orderNo="+orderNo+"&checkin_type=2", '_blank');
 	        }else{
        	     parent.layer.closeAll('loading');
       	   	     layer.msg('系统异常，请稍后再试!', {icon: 5});
 	        }
    	},"json");
    }
    //获取订单状态
    function getOrderStatus(){
 	   	$.get("<%=basePath%>/alipay/getOrderStatus.do?orderNo="+orderNo, function (res) {
 	 	   	 console.log(res.msg);
    	     parent.layer.closeAll('loading');
 	   		 if(res.msg=='1'){
           	   	   console.log(111)
 				   clearInterval(interval);
           	   	   layer.msg('缴费成功!', {icon: 1});
           	   	   window.location.href ='<%=basePath%>studentEnroll/goDetail.do?id=${pd.id}&type=1' ;
 	   	       }else if(res.msg=='2'){
 	  			   clearInterval(interval);
 	          	   layer.msg('缴费异常!', {icon: 5});
 	   	       }else{
 	   	    	   //继续
 	   	       }
 	   	 });
    }
</script>
</body>
</html>