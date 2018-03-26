<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
	<%@ include file="../index/headcss.jsp"%>
</head>
<body>
<div class="tableBox">
	<div class="operationBox">
		<form action="dictionaries/list.do" method="post" name="Form" id="Form">
			<div class="searchBox fl">
				<input value="${page.pd.keywords }"  id="keywords" name="keywords"   type="text" placeholder="请输入要搜索内容" class="layui-input fl search">

				<input value="${pd.DICTIONARIES_ID}"  id="DICTIONARIES_ID" name="DICTIONARIES_ID"   type="hidden">

				<div class="fl srarchBtn">
					<i class="layui-icon">&#xe615;</i>
				</div>
			</div>
		</form>
		<button class="layui-btn fl layui-btn-blue marL-20" id="add">新增</button>
			<button class="layui-btn fl layui-btn-primary marL-20"  onclick="goSondict('${pd.PARENT_ID}');">返回</button>
	</div>
	<table class="layui-table center" id="table">
			<colgroup>
				<col width="60">
				<col>
				<col>
				<col>
				<col>
				<col width="200">
			</colgroup>
			<thead>
			<tr>
				<th  style="width: 50px;">序号</th>
				<th >名称</th>
				<th >英文</th>
				<th >编码值</th>
				<th >排序</th>
				<th >操作</th>
			</tr>
			</thead>
			<tbody>
			<c:choose>
			<c:when test="${not empty varList}">
				<c:forEach items="${varList}" var="var" varStatus="vs">
					<tr>
					<td  style="width: 30px;">${vs.index+1}</td>
					<td >
						<a style="color: #0C64B5;" href="javascript:goSondict('${var.DICTIONARIES_ID }')">
							${var.NAME}
						</a>
					</td>
					<td >
						<a  href="javascript:goSondict('${var.DICTIONARIES_ID }')">${var.NAME_EN}</a>
					</td>
					<td >${var.BIANMA}</td>
					<td >${var.ORDER_BY}</td>
					<td style="width: 160px; text-align: center;">
						<a class="layui-btn layui-btn-mini edit" data_id="${var.DICTIONARIES_ID }">编辑</a>
						<a class="layui-btn layui-btn-danger layui-btn-mini del" data_id="${var.DICTIONARIES_ID}">删除</a>
					</td>
				</c:forEach>
			</c:when>
				<c:otherwise>
					<tr class="main_info">
						<td colspan="100" >没有相关数据</td>
					</tr>
				</c:otherwise>
			</c:choose>
			</tbody>

		</table>


	<div class="laypageBox">
		<div id="laypage" class="fr"></div>
	</div>
</div>
<%@ include file="../index/foot.jsp"%>

	<script type="text/javascript">
        function goSondict(id){
            window.location.href="<%=basePath%>dictionaries/list.do?DICTIONARIES_ID="+id;
        };
		function gsearch(){
		    $("#Form").submit()
		}

        layui.use('laypage', function() {
            var laypage = layui.laypage;
            var layer = layui.layer;
            var form = layui.form;


            //执行一个laypage实例
            //执行一个laypage实例
            laypage.render({
                elem: 'laypage',
                count: ${page.totalResult},
                curr: ${page.currentPage},
                layout: ['prev', 'page', 'next', 'count', 'skip'],
                jump: function (obj, first) {
                    if (!first) {
                        window.location.href = "<%=basePath%>dictionaries/list.do?DICTIONARIES_ID=${DICTIONARIES_ID}&currentPage=" + obj.curr + '&keywords=' + '${keywords}';
                    }
                }
            });
            //搜索
            $("#keywords").on("keyup",function(e){
                var ev= e || window.event;
                if(ev.keyCode == 13){
                    gsearch();
                }
            })
            //新增
            $("#add").on("click", function() {
                parent.layer.open({
                    title:"新增字典",
                    type: 2,
                    content:'<%=basePath%>dictionaries/goAdd.do?DICTIONARIES_ID=${DICTIONARIES_ID}'+'&currentPage=${page.currentPage}',
                    area: ["500px","500px"]
                });
                transmit(window);
            })

            //编辑
            $("#table").on("click", ".edit", function() {
                var id =  $(this).attr("data_id");
                parent.layer.open({
                    title:"编辑字典",
                    type: 2,
                    content:'<%=basePath%>dictionaries/goEdit.do?DICTIONARIES_ID='+id+'&currentPage=${page.currentPage}',
                    area: ["500px","500px"]
                });
                transmit(window);
            })

            //删除
            $("#table").on("click", ".del", function() {

                var ROLE_ID =  $(this).attr("data_id");
                parent.layer.confirm("是否确认删除数据", {
                    btn : [ '确定', '取消' ] //按钮
                    ,resize : false
                    ,title : "提示"
                    ,maxWidth : 800
                }, function(index) {
                    var url = "<%=basePath%>dictionaries/delete.do?DICTIONARIES_ID="+ROLE_ID+"&tm="+new Date().getTime();

                    $.get(url, function (data) {
                        if ("success" == data.result) {
                            window.location.href = "<%=basePath%>dictionaries/list.do?DICTIONARIES_ID=${DICTIONARIES_ID}&currentPage=${page.currentPage}&keywords=${keywords}";
                            parent.parent.layer.closeAll();
                        } else if ("false" == data.result) {
                            parent.layer.msg('删除失败!!请先删除子级或删除占用资源.', {icon: 5});
                        }
                    });
                });

            })

        });


        function transmit(obj){
            parent.layer.transmit= obj;
        }
	</script>
</body>
</html>