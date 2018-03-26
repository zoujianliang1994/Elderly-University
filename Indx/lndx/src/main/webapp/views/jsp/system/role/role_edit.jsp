<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<%@ include file="../index/headcss.jsp"%>
</head>
<body >
<div class="edit_menu" class="disnone">
	<form action="role/${msg}.do" class="layui-form" name="form1" id="form1" method="post" >
		<input type="hidden" name="ROLE_ID" id="id" value="${pd.ROLE_ID}" />
		<input name="PARENT_ID" id="parent_id" value="${pd.parent_id }" type="hidden">
		<input type="hidden" name="IS_PARTY" id="IS_PARTY" value="${pd.IS_PARTY}" title="名称" />
		<div class="layui-form-item">
			<div class="form-item-inline">
				<label class="form-label">角色名称</label>
				<div class="layui-input-block ">
					<input  name="ROLE_NAME" id="roleName" placeholder="这里输入名称" value="${pd.ROLE_NAME}" type="text" placeholder="请输入角色名"
							class="layui-input layui-input-color">

				</div>
			</div>
			<div class="form-item-inline">
				<label class="form-label">角色等级</label>
				<div class="layui-input-block ">
					<html:select name="roleLevel" id="roleLevel"  classs="layui-input " style=" lay-filter='roleLevel'">
						<html:options collection="role_level" defaultValue="${pd.roleLevel}"></html:options>
					</html:select>
				</div>
			</div>
		</div>





	<%--	<div class="layui-form-item">
			<label class="layui-form-label">角色名称</label>
			<div class="layui-input-block " >
				<html:select id="sts" name="sts" classs="layui-input-inline" >
					<!--传入父级的英文名，defaultValue为默认选中值，如果值为0或者error表示未选中-->
					<!--样式问题 询问佳杰-->
					<html:options collection="activity_type" defaultValue="1"></html:options>
				</html:select>
			</div>
		</div>--%>

	</form>
	<div class="btnbox" >
		<button id="sure" class="layui-btn layui-btn-primary layui-btn-small">确认</button>
		<button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
	</div>
</div>


	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>

	<!--提示框-->
	<script type="text/javascript">

        $(document).ready(function(){

            $("#form1").on("submit",function(){
                    return false;
            });


            $("#sure").on("click",function(){
                if ($("#roleName").val() == "") {
                    layer.tips('请输入名称',  $("#roleName"), {
                        tips: [4, '#2795cd'],
                        time: 4000
                    });
                    $("#roleName").focus();
                    return false;
                }
               var page =${pd.currentPage};
                $.post('<%=basePath%>role/${msg}.do', $('#form1').serialize(), function (data) {
                    if ("success" == data.msg) {
                        parent.layer.transmit.location.href = "<%=basePath%>role/list.do?currentPage="+page;
                        parent.layer.closeAll();
                    } else if ("error" == data.result) {
                        layer.msg('系统异常,保存失败!', {icon: 5});
                    }
                });


            });

            $("#cancel").on("click",function(){
                parent.layer.closeAll();
            })
        });

	</script>
</body>
</html>

