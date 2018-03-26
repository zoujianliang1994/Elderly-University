<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

	<%@ include file="../index/headcss.jsp"%>
<!-- jsp文件头和头部 -->
</head>
<body>
	<div class="tableBox">
		<div class="operationBox">
			<form action="permission/list.do" method="post" name="Form" id="Form" class="layui-form">
				<div class=" fl">
					<input value="${pd.keywords }"  id="keywords" name="keywords"   type="text" placeholder="请输入要搜索内容" class="layui-input fl search layui-input-color">


				</div>
				<div class="fl srarchBtn">
					<i class="iconfont icon-sousuo"></i>
					<span>搜索</span>
				</div>
			</form>
			<button class="add-btn f1" id="add">
				<i  class="iconfont icon-add"></i>
				<span>新增</span>
			</button>
		</div>
		<table class="layui-table center" lay-skin="line" id="table">
			<colgroup>
				<col width="60">
				<col>
				<col>
				<col>
				<col width="200">
			</colgroup>
			<thead>
			<tr class="table-head-tr">
				<th>序号</th>
				<th>名称</th>
				<th>标志</th>
				<th>是否禁用</th>
				<th style="border-left: 1px solid #dce3eb;">操作</th>
			</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${not empty varList}">

					<c:forEach items="${varList}" var="var" varStatus="vs">
						<tr>
							<td>${vs.index+1}</td>
							<td>${var.name}</td>
							<td>${var.sign}</td>
							<c:if test="${var.is_del}">
								<td>已启用</td>
							</c:if>
							<c:if test="${!var.is_del}">
								<td>已禁用</td>
							</c:if>
							<td  style="width: 160px; text-align: center;border-left: 1px solid #dce3eb;">
								<shiro:hasPermission name="system:permission:edit">
								<a class="table-btn bianji-btn set" data_id="${var.id }">
										编辑
										<%--<i class="iconfont icon-bianji" title="编辑"></i>--%>
									</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="system:permission:del">
									<a class="table-btn shanchu-btn del" data_id="${var.id }">
											<%--<i class="iconfont icon-shanchu" title="删除"></i>--%>
										删除
										</a>
								</shiro:hasPermission>
							</td>
						</tr>

					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="100" class="center">没有相关数据</td>
					</tr>
				</c:otherwise>
			</c:choose>

			</tbody>
		</table>

		<div class="laypageBox">
			<div id="laypage" class="fr"></div>
		</div>
	</div>
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<script type="text/javascript">

        layui.use('laypage', function() {
            var laypage = layui.laypage;
            var layer = layui.layer;
            var form = layui.form;
            //执行一个laypage实例
            laypage.render({
                elem: 'laypage',
                count: ${page.totalResult},
                curr: ${page.currentPage},
                layout: ['prev', 'page', 'next', 'count', 'skip'],
                jump: function (obj, first) {
                    if (!first) {
                        window.location.href = "<%=basePath%>permission/list.do?currentPage=" + obj.curr + '&keywords=' + '${keywords}';
                    }
                }
            });
            //搜索
            $("#keywords").on("keyup",function(e){
                var ev= e || window.event;
                if(ev.keyCode == 13){
                    gsearch();
                }
            });
            //新增
            $("#add").on("click", function() {
                parent.layer.open({
                    title:"新增权限",
                    type: 2,
                    content:'<%=basePath%>permission/goAdd.do?currentPage=${page.currentPage}',
                    area: ["700px","400px"]
                });
                transmit(window);
            });
            //设置
            $("#table").on("click", ".set", function() {
                var id =  $(this).attr("data_id");
                parent.layer.open({
                    title:"设置权限",
                    type: 2,
                    content:'<%=basePath%>permission/goEdit.do?id='+id+'&currentPage=' + '${page.currentPage}',
                    area: ["700px","400px"]
                });
                transmit(window);
            });


            //删除
            $("#table").on("click", ".del", function() {

                var id =  $(this).attr("data_id");
                parent.layer.confirm("是否确认删除此角色", {
                    btn : [ '确定', '取消' ] //按钮
                    ,resize : false
                    ,title : "提示"
                    ,maxWidth : 800
                }, function(index) {
                    var url = "<%=basePath%>permission/delete.do?id="+id+"&tm="+new Date().getTime();
                    $.get(url, function (data) {
                        if ("success" == data.result) {
                            window.location.href = "<%=basePath%>permission/list.do?currentPage=${page.currentPage}";
                            parent.parent.layer.closeAll();
                        } else if ("false" == data.result) {
                            layer.msg('删除失败,请重试!', {icon: 5});
                        }
                    });
                });

            })

        });

        function gsearch(){
            $("#Form").submit()
        }
        function transmit(obj){
            parent.layer.transmit= obj;
        }
	</script>


</body>
</html>