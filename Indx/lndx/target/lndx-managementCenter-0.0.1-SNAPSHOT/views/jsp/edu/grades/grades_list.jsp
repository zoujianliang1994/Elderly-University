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
<title>班级管理</title>
<%@ include file="../../system/index/headcss.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">

</head>
<body>
<div class="menu-list">

	<div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox">

		<form action="list.do" method="post" name="Form" id="Form" class="layui-form">

			<div class=" fl ">
				<input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="请输入班级名称/课程名称" class="layui-input fl search layui-input-color">

				</div><div class="fl srarchBtn" onclick="gsearch()"> <i class="iconfont icon-sousuo"></i> <span>搜索</span>      </div>
		</form>
		<div class="operationBox">
			<shiro:hasPermission name="edu:grades:add">
				<button class="add-btn" id="add">
					<i  class="iconfont icon-add"></i>
					<span>新增</span>
				</button>
			</shiro:hasPermission>
		</div>

		<!-- table -->
			<table class="layui-table center " lay-skin="line" id="table">

				<thead>
				<tr style="background-color: #f3f8ff;">
					<th class="center" style="width: 50px;">序号</th>
					<th class='center'>班级名称</th>
					<th class='center'>课程名称</th>
					<th class='center'>所属校区/教学点</th>
					<th class='center'>创建日期</th>
					<th class='center'>学员人数</th>
					<th class='center' style="width: 150px;border-left: 1px solid #dce3eb;">操作</th>
				</tr>
				</thead>
				<tbody>

				<c:choose>
					<c:when test="${not empty list}">

						<shiro:hasPermission name="edu:grades:sel">
						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>
								<td>${vs.index+1 }</td>
								<td>${var.name}</td>
								<td>${var.lesson_name}</td>
								<td>${var.school_name}</td>
								<td>${var.createTime}</td>
								<td>${var.studentNum}</td>


								<td  style="width: 300px; text-align: center;border-left: 1px solid #dce3eb;" >

									<a data_id="${var.id }" class="table-btn chakan-btn sel">
										<%--<i class="iconfont icon-chakan" title="查看"></i>--%>
										查看
									</a>

									<a data_id="${var.id }" class="table-btn-max chakan-btn student">
											<%--<i class="iconfont icon-chakan" title="查看"></i>--%>
										学员管理
									</a>

									<shiro:hasPermission name="edu:grades:edit">
										<a data_id="${var.id }" class="table-btn bianji-btn edit" data_id="${var.id }">
											<%--<i class="iconfont icon-bianji" title="编辑"></i>--%>
											编辑
										</a>
									</shiro:hasPermission>

									<shiro:hasPermission name="edu:grades:del">
										<a class="table-btn shanchu-btn del" data_id="${var.id }">
											<%--<i class="iconfont icon-shanchu" title="删除"></i>--%>
											删除
										</a>

									</shiro:hasPermission>
								</td>
							</tr>
						</c:forEach>

						</shiro:hasPermission>
						<shiro:lacksPermission name="edu:grades:sel">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</shiro:lacksPermission>
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
                        window.location.href = "<%=basePath%>grades/list.do?currentPage=" + obj.curr +"&keywords=${pd.keywords}";
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
                    area: ["700px","500px"]
                });
                transmit(window);
            });

            $("#table").on("click",".student",function(){
                var id =  $(this).attr("data_id")
                parent.addTab("学员管理","grades/listStudent.do?gId="+id)
            })

					
			//新增
			$("#add").on("click", function() {
				 parent.layer.open({
					  title:"<i  class=\"iconfont icon-add\"></i>\n" +
                      "<span>新增</span>",
					  type: 2,
					  content: '<%=basePath%>grades/toAdd.do?currentPage=${page.currentPage}&keywords=${pd.keywords}' ,
					  area: ["800px","550px"],
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
                    area: ["700px","550px"]
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