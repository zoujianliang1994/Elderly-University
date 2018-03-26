﻿﻿<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>排课管理</title>
<%@ include file="../../system/index/headcss.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">

</head>
<body>
<div class="menu-list">

	<div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox">

		<form action="list.do" method="post" name="Form" id="Form" class="layui-form" >

			<div class=" fl">
				<select lay-filter='semester' id="semester" name="semester"  class="layui-input-inline"  >
					<option value="">请选择学期</option>
					<c:forEach var="var" items="${schedule_List}" varStatus="vs">
						<option value="${var.id}" <c:if test="${var.id==pd.id}"> selected="selected" </c:if>>${var.semester_name}</option>
					</c:forEach>
				</select>
			</div>
			<div class="break-btn rest-btn">
				课间休息${pd.recess_time}分钟
			</div>
			<div class="noon-btn rest-btn">
				午间休息${pd.siesta_time}分钟
			</div>

		</form>

		<div class="operationBox">
			<shiro:hasPermission name="edu:schedule:add">
				<button class="add-btn" id="adds">
					<i  class="iconfont icon-add"></i>
					<span>新增</span>
				</button>
			</shiro:hasPermission>
		</div>
		<!-- table -->
		<table class="layui-table center "  id="table">

			<thead>

			<tr style="background-color: #f3f8ff;">
				<th class="center" style="width: 50px;">星期</th>
				<th class='center'>上下午</th>
				<th>序号</th>
				<th class='center'>班级名称</th>
				<th class='center'>教师</th>
				<th class='center'>课长(分钟)</th>
				<th class='center'>教室</th>
				<th class='center'>上课时间</th>
				<th class='center'>学费</th>
				<th class='center' style="width: 150px;border-left: 1px solid #dce3eb;">操作</th>
			</tr>
			</thead>
			<tbody>

			</tbody>
		</table>

		<div class="laypageBox">
			<div id="laypage" class="fr"></div>
		</div>
	</div>

</div>


	<%@ include file="../../system/index/foot.jsp"%>
	<script type="text/javascript">
        console.log(${data})


		$(function(){
		   	var html;
		   	var num=1;
		   	$.each(${data}[0],function(key,val){

		   	    var week;
                switch(key){
                    case "Monday":
                        week="星期一";
                        break;
                    case "Tuesday":
                        week="星期二";
                        break;
                    case "Wednesday":
                        week="星期三";
                        break;
                    case "Thursday":
                        week="星期四";
                        break;
                    case "Friday":
                        week="星期五";
                        break;
                }
                if(JSON.stringify(val) != "{}"){
                    var amList=0;
                    var pmList=0;
		   	        if(val.am!=undefined){
                         amList=val.am.length;
                    }
                    if(val.pm!=undefined){
                         pmList=val.pm.length;
                    }
                    var dateList=amList+pmList;
                    html+="<tr><td rowspan="+dateList+">"+week+"</td>"
					$.each(val,function(day,data){
					    function getHtml(k) {

                            return "<td >" + num + "</td>" +
                            "<td > <a class='table-btn shanchu-btn sel' style='color: #3779f7' data-id='"+data[k].grades_id+"'>" + data[k].grades_name + " </a> </td>" +
                            "<td >" + data[k].teacher_name + "</td>" +
                            "<td >" + data[k].class_time + "</td>" +
                            "<td >" + data[k].classroom_name + "</td>" +
                            "<td >" + data[k].start_time +"-"+data[k].end_time+"</td>" +
                            "<td >" + data[k].tuition + "</td>" +
                            "<td > <a class='table-btn shanchu-btn del' data-id='"+data[k].id+"'>" + '删除' + "</a></td></tr>"
                        }
                        if(day!=undefined){
                            if(day=="am"){
                                html+="<td rowspan="+amList+">上午</td>"
								html+=getHtml(0);
                                num++;
								if(amList>1){
                                    for (var i=1;i<amList;i++){
                                        html+="<tr>"+getHtml(i);
                                        num++;
									}
								}
							}
                            if(day=="pm"){
                                html+="<td rowspan="+pmList+">下午</td>"
                                html+=getHtml(0);
                                num++;
                                if(pmList>1){
                                    for (var i=1;i<pmList;i++){
                                        html+="<tr>"+getHtml(i);
                                        num++;
                                    }
                                }
                            }



                        }
					})

                }
			})

            $("tbody").append(html)


            layui.form.on('select(semester)', function(data){
                window.location.href = "<%=basePath%>schedule/details.do?id="+data.value;
            });


            //编辑
			$("#adds").on("click", function() {
                var id =  "${pd.id}";
               parent.layer.open({
                    title:"<i  class=\"iconfont icon-add\"></i>\n" +
                    "<span>新增排课信息</span>",
                    type: 2,
                    content:'<%=basePath%>schedule/toAddSchedule.do?id='+id,
                    area: ["600px","550px"]
                });
                transmit(window);
            });

            $("#table").on("click", ".sel", function() {
                var id = $(this).attr("data-id");
                parent.layer.open({
                    title:"<span>排课计划</span>",
                    type: 2,
                    content:'<%=basePath%>schedule/getGradesDetail.do?id=${pd.id}&semester_id=${pd.semester_id}&grades_id='+id,
                    area: ["700px","400px"]
                });
                transmit(window);


            });

            $("#table").on("click", ".del", function() {
                var id =  $(this).attr("data-id");

                parent.layer.confirm("是否确认删除此排课信息", {
                    btn : [ '确定', '取消' ] //按钮
                    ,resize : false
                    ,title : "提示"
                    ,maxWidth : 800
                }, function(index) {

                    var url = "<%=basePath%>schedule/deleteDetail.do?id="+id+"&guid="+new Date().getTime();
                    $.get(url,function(data){
                        if("success" == data.msg){
                            parent.layer.closeAll();
                            window.location.reload()
                        }else if("false" == data.msg){
                            parent.layer.closeAll();
                            parent.layer.confirm("删除失败,请稍后再试!", {
                                btn : [ '确定' ] //按钮
                                ,resize : false
                                ,title : "提示"
                                ,maxWidth : 800
                            });

                        }
                    });

                });




            })

		})

        function transmit(obj){
            parent.layer.transmit= obj;
        }
		
	</script>
</body>
</html>