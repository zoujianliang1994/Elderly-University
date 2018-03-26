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
<title>报名信息管理</title>
<%@ include file="../../system/index/headcss.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">

</head>
<body>
<style>

	.layui-layer-title{
		height: 4rem;
		line-height: 4rem;
		background-color: #3779f7;
		border: solid 1px #3879f7;
		font-size: 20px;
		color: #ffffff;
	}
	.layui-layer-setwin .layui-layer-close1 {
		background-position: 0;
		cursor: pointer;
	}
</style>

<div class="menu-list">

	<div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox  layui-form">
		<div class="operationBox">
		<form action="list.do?activity_id=${pd.activity_id}" method="post" name="Form" id="Form">

			<div class=" fl " style="width: 16rem;">
				<input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="姓名或身份证" class="layui-input fl search layui-input-color">
			</div>
			<div class=" fl" style="margin-left: 10px">
				<select lay-filter='type' id="type" name="type"  class="layui-input-inline" >
					<option value="">请选择团员类型</option>
                    <option value="1" <c:if test="${pd.type == '1'}">selected</c:if>>教师</option>
					<option value="0" <c:if test="${pd.type == '0'}">selected</c:if>>学员</option>
				</select>
			</div>

			<div class=" fl" style="margin-left: 10px">
				<select lay-filter='checkState' id="checkState" name="checkState"  class="layui-input-inline" >
					<option value="">请选择审核状态</option>
                    <option value="2" <c:if test="${pd.checkState == 2}">selected</c:if>>通过</option>
					<option value="3" <c:if test="${pd.checkState == 3}">selected</c:if>>未通过</option>
					<option value="1" <c:if test="${pd.checkState == 1}">selected</c:if>>待审核</option>
				</select>
			</div>

			<div class="fl srarchBtn" onclick="gsearch()">
				<i class="iconfont icon-sousuo"></i>
				<span>搜索</span>
			</div>
		</form>
		</div>
		<!-- table -->
			<table class="layui-table center" lay-skin="line" id="table">

				<thead>
				<tr style="background-color: #f3f8ff;">
					<th class="center" style="width: 50px;">序号</th>
					<th class='center'>姓名</th>
					<th class='center'>身份证号</th>
					<th class='center'>年龄</th>
					<th class='center'>联系电话</th>
					<th class='center'>人员类型</th>
					<th class='center'>报名状态</th>
					<th class='center' style="width: 150px;border-left: 1px solid #dce3eb;">操作</th>
				</tr>
				</thead>
				<tbody>

				<c:choose>
					<c:when test="${not empty list}">

						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>
								<td>${vs.index+1 }</td>
								<td>${var.xm}</td>
								<td>${var.sfz}</td>
								<td>${var.nl}</td>
								<td>${var.phone}</td>
								<td>
									<c:if test="${var.type == 1}">教师</c:if>
									<c:if test="${var.type == 0}">学员</c:if>
								</td>

								<td>
									<c:if test="${var.check_state == '0'}">待提交审核</c:if>
									<c:if test="${var.check_state == '1'}">待审核</c:if>
									<c:if test="${var.check_state == '2'}">审核通过</c:if>
									<c:if test="${var.check_state == '3'}">驳回</c:if>
								</td>

								<td  style="width: 150px; text-align: center;border-left: 1px solid #dce3eb;">

									<a data_id="${var.id}" data_type="${var.type}" class="table-btn chakan-btn sel">
										查看
									</a>

									<c:if test="${var.check_state == 1}">
										<a data_id="${var.id }" data_type="${var.type}" class="table-btn bianji-btn edit">
											审核
										</a>
									</c:if>
								</td>
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
			<div class="btnbox" >
				<button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
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
                        window.location.href = "<%=basePath%>activityGroup/list.do?currentPage=" + obj.curr + "&activity_id=${pd.activity_id}"
                    }
                }
            });
            $("#cancel").on("click",function(){
                parent.layer.closeAll();
            })
            //查看
            $("#table").on("click", ".sel", function() {
                var id =  $(this).attr("data_id");
                var type =  $(this).attr("data_type");
                layer.open({
                    title:"详情",
                    type: 2,
                    content:'<%=basePath%>activityGroup/toSelect.do?id='+id+'&personType='+type+'&operation=select',
                    area: ["700px","500px"]
                });
                transmit(window);
            });

            //审核
            $("#table").on("click", ".edit", function() {
                var id =  $(this).attr("data_id");
                var type =  $(this).attr("data_type");
                layer.open({
                    title:"<i  class=\"iconfont icon-add\"></i>\n" +
                    "<span>审核</span>",
                    type: 2,
                    content:'<%=basePath%>activityGroup/toSelect.do?id='+id+'&personType='+type+'&operation=check',
                    area: ["700px","500px"]
                });
                transmit(window);
            });
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