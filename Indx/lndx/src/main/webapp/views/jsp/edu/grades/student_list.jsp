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

			<div class=" fl " style="width: 16rem">
				<input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="请输入学员姓名/身份证号" class="layui-input fl search layui-input-color">
				<input id="gId"	name="gId" type="hidden" value="${pd.gId}">
				</div><div class="fl srarchBtn" onclick="gsearch()"> <i class="iconfont icon-sousuo"></i> <span>搜索</span>      </div>
		</form>
		<div class="operationBox">
			<shiro:hasPermission name="edu:grades:add">
				<button class="add-btn" id="add">
					<i  class="iconfont icon-add"></i>
					<span>定义分组</span>
				</button>
			</shiro:hasPermission>
		</div>

		<!-- table -->
			<table class="layui-table center " lay-skin="line" id="table">

				<thead>
				<tr style="background-color: #f3f8ff;">
					<th class="center" style="width: 50px;">序号</th>
					<th class='center'>姓名</th>
					<th class='center'>身份证号</th>
					<th class='center'>联系方式</th>
					<th class='center'>所在职务</th>
					<th class='center'>所在组别</th>
					<th class='center'>组内职务</th>
					<th class='center' style="width: 220px;border-left: 1px solid #dce3eb;">操作</th>
				</tr>
				</thead>
				<tbody>

				<c:choose>
					<c:when test="${not empty list}">

						<shiro:hasPermission name="edu:grades:sel">
						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>
								<td>${vs.index+1 }</td>
								<td>${var.xm}</td>
								<td>${var.sfz}</td>
								<td>${var.phone}</td>
								<td><html:selectedValue collection="class_committee" defaultValue="${var.class_committee}"></html:selectedValue></td>
								<td>${var.group_name}</td>
								<td>
									<c:if test="${var.group_leader==1}">组长</c:if>
									<c:if test="${var.group_leader==0}">组员</c:if>
								</td>


								<td  style="width: 200px; text-align: center;border-left: 1px solid #dce3eb;" >


									<a data_id="${var.id }" data_sid="${var.sid }" class="table-btn-max chakan-btn student">
											<%--<i class="iconfont icon-chakan" title="查看"></i>--%>
										设为班委
									</a>

										<a data-group="${var.group_leader}" data_id="${var.sid }" class="table-btn bianji-btn edit">
											<%--<i class="iconfont icon-bianji" title="编辑"></i>--%>
											调组
										</a>


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
                        window.location.href = "<%=basePath%>grades/listStudent.do?currentPage=" + obj.curr +"&gId=${pd.gId}";
                    }
                }
            });


            //班委设置
            $("#table").on("click", ".student", function() {
                var id =  $(this).attr("data_id");
                var sid =  $(this).attr("data_sid");
                parent.layer.open({
                    title:"详情",
                    type: 2,
                    content:'<%=basePath%>grades/toCommittee.do?sid='+sid+'&currentPage=${page.currentPage}&gId=${pd.gId}&id='+id,
                    area: ["600px","300px"]
                });
                transmit(window);
            });

					
			//新增  
			
			$("#add").on("click", function() {
				 parent.layer.open({
					  title:"<i  class=\"iconfont icon-add\"></i>\n" +
                      "<span>新增</span>",
					  type: 2,
					  content: '<%=basePath%>grades/toAddGroup.do?currentPage=${page.currentPage}&gId=${pd.gId}&keywords=${pd.keywords}' ,
					  area: ["700px","500px"],
                     cancel:function () {
                       	window.location.reload();
                     }
				});

				 transmit(window);
			});

            //编辑
            $("#table").on("click", ".edit", function() {
                var id =  $(this).attr("data_id");
                var dataGroup =  $(this).attr("data-group");
				if(dataGroup==1){
                    layer.msg('组长不能进行调组操作!', {icon: 5});
                    return false;
				}
                parent.layer.open({
                    title:"<i  class=\"iconfont icon-add\"></i>\n" +
                    "<span>编辑</span>",
                    type: 2,
                    content:'<%=basePath%>grades/toGroup.do?id='+id+'&currentPage=${page.currentPage}&gId=${pd.gId}&keywords=${pd.keywords}',
                    area: ["600px","300px"]
                });
                transmit(window);
            });

		
		});

        function editmenu(id) {
            parent.layer.open({
                type: 2,
                content: '<%=basePath%>menu/toEdit.do?id='+id ,
                area: ["400px","400px"]
            });
            transmit(window);
        }
		
        function transmit(obj){
        	parent.layer.transmit= obj;
        }
        
		
	</script>
</body>
</html>