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
			<form action="areaCode/list.do" method="post" name="Form" id="Form">
				<div class="searchBox fl">
					<input value="${pd.keywords }"  id="keywords" name="keywords"   type="text" placeholder="请输入要搜索内容" class="layui-input fl search">
					<div class="fl srarchBtn">
						<i class="layui-icon">&#xe615;</i>
					</div>
				</div>
			</form>
			<button class="layui-btn fl  marL-20 layui-btn-blue" id="add">新增</button>
			<button class="layui-btn fl  marL-20 layui-btn-blue" id="move">迁移</button>

		</div>
		<table class="layui-table center" id="table">

			<thead>
			<tr>
				<th>序号</th>
				<th>行政代码</th>
				<th>名称</th>
				<th>简称</th>
				<th>详细层级</th>
				<th>上级名称</th>
				<th>上级行政代码</th>
				<th>操作</th>

			</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${not empty areaList_z}">

					<c:forEach items="${areaList_z}" var="var" varStatus="vs">
						<tr>
							<td>${vs.index+1}</td>
							<td>${var.area_code}</td>
							<td>${var.name}</td>
							<td>${var.short_name}</td>
							<td>${var.merger_name}</td>
							<td>${var.sname}</td>
							<td>${var.scode}</td>
							<td><a class="layui-btn layui-btn-mini edit"  data_id="${var.id }">编辑</a></td>
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

	</div>
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<script type="text/javascript">

        layui.use('laypage', function() {
            var laypage = layui.laypage;
            var layer = layui.layer;
            var form = layui.form;
            //执行一个laypage实例

            //搜索
            $("#keywords").on("keyup",function(e){
                var ev= e || window.event;
                if(ev.keyCode == 13){
                    gsearch();
                }
            })


        });
        //编辑
        $("#table").on("click", ".edit", function() {
            var id =  $(this).attr("data_id");
            parent.layer.open({
                title:"编辑",
                type: 2,
                content:'<%=basePath%>areaCode/toEdit.do?id='+id,
                area: ["1000px","620px"]
            });
           // transmit(window);
        })

        //新增
        $("#add").on("click", function () {
            parent.parent.layer.edit = window;
            parent.parent.layer.open({
                title: "新增",
                type: 2,
                content: '<%=basePath%>areaCode/goAdd.do',
                area: ["600px", "600px"]
            });
        });
        //迁移
        $("#move").on("click", function () {
            parent.parent.layer.edit = window;
            parent.parent.layer.open({
                title: "迁移",
                type: 2,
                content: '<%=basePath%>areaCode/goMove.do',
                area: ["900px", "670px"]
            });
        });

        function gsearch(){
            $("#Form").submit()
        }

	</script>


</body>
</html>