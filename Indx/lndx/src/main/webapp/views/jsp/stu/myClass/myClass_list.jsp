﻿<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>我的班级</title>
<%@ include file="../../system/index/headcss.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">

</head>
<body>
<div class="menu-list">

	<div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox">

		<form action="list.do" method="post" name="Form" id="Form" class="layui-form">

			<div class="layui-form">
				<div class="layui-inline" style="width: 12rem">
					<div class="layui-input-block ">
						<select lay-filter='school_id' id="school_id" name="school_id"  class="layui-input-inline" lay-search>
							<option value="">请选择学校</option>
							<c:forEach var="var" items="${schoolList}" varStatus="vs">
								<option value="${var.id}" <c:if test="${var.id==pd.school_id}"> selected="selected" </c:if> >${var.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="layui-inline" style="width: 12rem">
					<div class="layui-input-block " id="selectToGrad">
						<select lay-filter='school_child_id' id="school_child_id" name="school_child_id"  class="layui-input-inline">
							<option value="">请选择校区、教学点</option>
							<c:forEach var="var" items="${childSchools}" varStatus="vs">
								<option class="childSchool" value="${var.id}" <c:if test="${var.id==pd.school_child_id}"> selected="selected" </c:if> >${var.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="layui-inline" style="width: 12rem">
					<div class="layui-input-block ">
						<select lay-filter='grade_id' id="grade_id" name="grade_id"  class="layui-input-inline">
							<option value="">请选择班级</option>
							<c:forEach var="var" items="${grades}" varStatus="vs">
								<option class="grade" value="${var.id}" <c:if test="${var.id==pd.grade_id}"> selected="selected" </c:if> >${var.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="layui-inline" style="width: 12rem">
					<div class="layui-input-block ">
						<select lay-filter='people_type' id="people_type" name="people_type"  class="layui-input-inline" >
							<option value="学生" <c:if test="${pd.people_type == '学生'}">selected</c:if>>学生</option>
							<option value="任课教师" <c:if test="${pd.people_type == '任课教师'}">selected</c:if>>任课教师</option>
							<option value="班主任" <c:if test="${pd.people_type == '班主任'}">selected</c:if>>班主任</option>
						</select>
					</div>
				</div>
				<div class="layui-inline" style="width: 12rem">
					<div class=" fl" style="margin: 20px 0;">
						<input value="${pd.keywords}"  id="keywords" name="keywords" placeholder="请输入姓名"  type="text" class="layui-input fl search layui-input-color">
					</div>
				</div>
				<div class="layui-inline">
					<div class="fl srarchBtn" onclick="gsearch()">
						<i class="iconfont icon-sousuo"></i>
						<span>搜索</span>
					</div>
				</div>
			</div>
		</form>

		<!-- table -->
			<table class="layui-table center " lay-skin="line" id="table">

				<thead>
				<tr style="background-color: #f3f8ff;">
					<th class="center" style="width: 50px;">序号</th>
					<th class='center'>姓名</th>
					<th class='center'>联系方式</th>
					<th class='center'>人员类别</th>
					<th class='center'>所属班级</th>
				</tr>
				</thead>
				<tbody>

				<c:choose>
					<c:when test="${not empty list}">

						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>
								<td>${vs.index+1 }</td>
								<td>${var.xm}</td>
								<td>${var.phone}</td>
								<td>
									<c:if test="${var.people_type==1}">组长</c:if>
									<c:if test="${var.people_type==0}">组员</c:if>
									<c:if test="${var.people_type==3}">班主任</c:if>
									<c:if test="${var.people_type==4}">任课教师</c:if>
								</td>
								<td>${var.name}</td>

							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="100" class='center'>没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>

			<div class="laypageBox">
                <div id="laypage" class="fr"></div>
            </div>
	</div>

</div>


	<%@ include file="../../system/index/foot.jsp"%>
	<script type="text/javascript">
        var form = layui.form;

        form.on('select(school_id)', function (data) {
            if(data.value){
                $("option").remove(".childSchool")
                //根据学校查询分校及教学点
                var url = "<%=basePath%>school/findSchoolBySid.do?id=" + data.value;
                $.get(url, function (res) {
                    if(res.data){
                        for(var i=0;i<res.data.length;i++){
                            $("#school_child_id").append('<option class="childSchool" value="'+res.data[i].id+'">'+res.data[i].name+'</option>');
                        }
                        form.render('select');
                    }
                });

                $("option").remove(".grade")
                //根据学校查询班级
                var url = "<%=basePath%>grades/findBySchool.do?schoolIds=" + data.value;
                $.get(url, function (res) {
                    if(res.data){
                        var objs = JSON.parse(res.data);
                        for(var i=0;i<objs.length;i++){
                            $("#grade_id").append('<option class="grade" value="'+objs[i].id+'">'+objs[i].name+'</option>');
                        }
                        form.render('select');
                    }
                });

            }else{
                $("option").remove(".childSchool");
                $("option").remove(".grade");
                form.render('select');
			}
        });

        form.on('select(school_child_id)', function (data) {
            if(data.value){
                $("option").remove(".grade")
                //根据学校查询班级
                var url = "<%=basePath%>grades/findBySchool.do?schoolIds=" + data.value;
                $.get(url, function (res) {
                    if(res.data){
                        var objs = JSON.parse(res.data);
                        for(var i=0;i<objs.length;i++){
                            $("#grade_id").append('<option class="grade" value="'+objs[i].id+'">'+objs[i].name+'</option>');
                        }
                        form.render('select');
                    }
                });
			}
        });



        $("#school_child_id").change(function() {
            alert(0);
            var val = $("#school_child_id").val();
            if(val!=""){
                $("option").remove(".grade")
                //根据学校查询班级
                var url = "<%=basePath%>grades/findBySchool.do?schoolIds=" + data.value;
                $.get(url, function (res) {
                    if(res.data){
                        var objs = JSON.parse(res.data);
                        for(var i=0;i<objs.length;i++){
                            $("#grade_id").append('<option class="grade" value="'+objs[i].id+'">'+objs[i].name+'</option>');
                        }
                        form.render('select');
                    }
                });
			}else{
                $("option").remove(".grade");
                form.render('select');
            }
		})

        parent.layer.config({
            skin: 'demo-class'
        });

        function gsearch() {
            $("#Form").submit();
        }

		layui.use('laypage', function() {
			var laypage = layui.laypage;
			var layer = layui.layer;
			var form = layui.form;
			var tree = layui.tree;

            //执行一个laypage实例
            laypage.render({
                elem: 'laypage',
                count: ${page.totalResult},
                curr: ${page.currentPage},
                layout: ['prev', 'page', 'next', 'count', 'skip'],
                jump: function (obj, first) {
                    if (!first) {
                        window.location.href = "<%=basePath%>grades/list.do?currentPage=" + obj.curr +sum;
                    }
                }
            });

            //查看
            $("#table").on("click", ".sel", function() {
                var id =  $(this).attr("data_id");
                parent.layer.open({
                    title:"详情",
                    type: 2,
                    content:'<%=basePath%>grades/toSelect.do?id='+id,
                    area: ["900px","700px"]
                });
                transmit(window);
            });

            $("#table").on("click",".student",function(){
                var id =  $(this).attr("data_id")
				alert(id)
                parent.addTab("学员管理","grades/listStudent.do?gId="+id)
            })

					
			//新增
			$("#add").on("click", function() {
				 parent.layer.open({
					  title:"<i  class=\"iconfont icon-add\"></i>\n" +
                      "<span>新增</span>",
					  type: 2,
					  content: '<%=basePath%>grades/toAdd.do?currentPage=${page.currentPage}&keywords=${pd.keywords}' ,
					  area: ["950px","700px"],
				});

				 transmit(window);
			});

            //编辑
            $("#table").on("click", ".edit", function() {
                var id =  $(this).attr("data_id");
                parent.layer.open({
                    title:"<i  class=\"iconfont icon-add\"></i>\n" +
                    "<span>编辑</span>",
                    type: 2,
                    content:'<%=basePath%>grades/toEdit.do?id='+id+'&currentPage=${page.currentPage}&keywords=${pd.keywords}',
                    area: ["950px","700px"]
                });
                transmit(window);
            });

			//删除
			$("#table").on("click", ".del", function() {

                var id =  $(this).attr("data_id");
				parent.layer.confirm("是否确认删除此班级", {
					btn : [ '确定', '取消' ] //按钮
					,resize : false
					,title : "提示"
					,maxWidth : 800
				}, function(index) {

                    var url = "<%=basePath%>grades/delete.do?id="+id+"&guid="+new Date().getTime();
                    $.get(url,function(data){
                        if("success" == data.result){
                        	parent.layer.closeAll();
                            window.location.reload()
                        }else if("false" == data.result){
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
		
		});

        function editmenu(id) {
            parent.layer.open({
                type: 2,
                content: '<%=basePath%>menu/toEdit.do?id='+id ,
                area: ["500px","500px"]
            });
            transmit(window);
        }
		
        function transmit(obj){
        	parent.layer.transmit= obj;
        }
        
		
	</script>
</body>
</html>