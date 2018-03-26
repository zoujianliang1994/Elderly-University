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
<title>活动管理</title>
<%@ include file="../../system/index/headcss.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">

</head>
<body>
<div class="menu-list">

	<div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox  layui-form">

		<form action="list.do" method="post" name="Form" id="Form" class="layui-form">

			<div class=" fl " style="width: 16rem">
				<input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="请输入活动名称" class="layui-input layui-input-color">
			</div>

			<div class=" fl" style="margin-left: 20px">
				<select lay-filter='state' id="state" name="state"  class="layui-input-inline" >
					<option value="">请选择活动状态</option>
                    <option value="1" <c:if test="${pd.state == '1'}">selected</c:if>>已发布</option>
					<option value="0" <c:if test="${pd.state == '0'}">selected</c:if>>草稿</option>
				</select>
			</div>

			<div class="fl srarchBtn" onclick="gsearch()">
				<i class="iconfont icon-sousuo"></i>
				<span>搜索</span>
			</div>
		</form>

		<div class="operationBox">
			<shiro:hasPermission name="edu:activity:add">
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
					<th class='center'>活动名称</th>
					<th class='center'>报名日期</th>
					<th class='center'>活动日期</th>
					<th class='center'>活动状态</th>
					<th class='center table-left-line' style="width: 150px;border-left: 1px solid #dce3eb;">操作</th>
				</tr>
				</thead>
				<tbody>

				<c:choose>
					<c:when test="${not empty list}">

						<shiro:hasPermission name="edu:activity:select">
						<c:forEach items="${list}" var="var" varStatus="vs">
							<tr>
								<td>${vs.index+1 }</td>
								<td>${var.name}</td>
								<td>${var.activity_start_time}~${var.activity_end_time}</td>

								<td>${var.apply_start_time}~${var.apply_end_time}</td>


								<td><c:if test="${var.status == 0}">草稿</c:if>
									<c:if test="${var.status == 1}">已发布</c:if>
								</td>

								<td class="table-left-line"  style="border-left: 1px solid #dce3eb; width: 300px; text-align: center;" >

									<a data_id="${var.id }" class="table-btn chakan-btn sel">
										查看
									</a>

									<shiro:hasPermission name="edu:activity:update">
										<c:if test="${var.status == 0}">
											<a data_id="${var.id }" class="table-btn bianji-btn edit" data_id="${var.id }">
												修改
											</a>
										</c:if>
									</shiro:hasPermission>

									<a data_id="${var.id }" class="table-btn chakan-btn apply">
										管理
									</a>

									<shiro:hasPermission name="edu:activity:delete">
										<a class="table-btn shanchu-btn del" data_id="${var.id }">
											删除
										</a>
									</shiro:hasPermission>
								</td>
							</tr>
						</c:forEach>

						</shiro:hasPermission>
						<shiro:lacksPermission name="edu:activity:select">
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
                        window.location.href = "<%=basePath%>activity/list.do?currentPage=" + obj.curr + '&keywords=' + '${pd.keywords}' + '&state=' + '${pd.state}';
                    }
                }
            });

            //查看
            $("#table").on("click", ".sel", function() {
                var id =  $(this).attr("data_id");
                parent.layer.open({
                    title:"详情",
                    type: 2,
                    content:'<%=basePath%>activity/toSelect.do?id='+id,
                    area: ["900px","550px"]
                });
                transmit(window);
            });

            $("#table").on("click",".apply",function(){
                var id =  $(this).attr("data_id")
                parent.layer.open({
                    title:"<i  class=\"iconfont icon-add\"></i>\n" +
                    "<span>报名信息管理</span>",
                    type: 2,
                    content: 'activityGroup/list.do?activity_id='+id ,
                    area: ["1000px","660px"],
                });

                transmit(window);
            })

					
			//新增
			$("#add").on("click", function() {
				 parent.layer.open({
					  title:"<i  class=\"iconfont icon-add\"></i>\n" +
                      "<span>新增</span>",
					  type: 2,
					  content: '<%=basePath%>activity/toAdd.do?currentPage=${page.currentPage}&keywords=${pd.keywords}' ,
					  area: ["850px","700px"],
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
                    content:'<%=basePath%>activity/toEdit.do?id='+id+'&currentPage=${page.currentPage}&keywords=${pd.keywords}',
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

                    var url = "<%=basePath%>activity/delete.do?id="+id+"&guid="+new Date().getTime();
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