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
	<%@ include file="../../system/index/headcss.jsp"%>

    <style>
		.imgBox{
			position:relative;
		}
		#imgfile{
			position:absolute;
			z-index: -1;
			top: 0px;
			left:0
		}
		.layui-upload-drag{
			background-size:cover;
		}

	</style>
</head>
<body >
<div class="edit_menu" class="disnone">

	<form action="grades/${url}.do" class="layui-form"  name="form1" id="form1" >
		<input type="hidden" name="id" id="id" value="${pd.id}" />

		<div class="layui-form-item">

				<div class="form-item-inline" style="width: 100%">
					<label class="form-label"><span class="red-star">*</span>职位名称</label>
					<div class="layui-input-block class_committee">
						<input name="name" id="name" value="${msg}" type="hidden" class="layui-input layui-input-color">
						<html:select name="class_committee" id="class_committee" classs="layui-input" style=" lay-filter='classroom_type'">
							<html:options collection="class_committee" defaultValue="${pd.class_committee}"></html:options>
						</html:select>
					</div>
				</div>

		</div>

	</form>

	<div class="btnbox" >
		<c:if test="${pd.type=='0'}">
			<button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
		</c:if>
		<button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
	</div>
</div>


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript">


        var form = layui.form;

        var type = '${pd.type}';
        $.myType(type);

        $(document).ready(function(){

            $("#sure").on("click",function(){
                if ($("#class_committee").val() == ""||$().val("#class_committee").length>50) {
                    layer.tips('请验证选择',  $(".class_committee"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#class_committee").focus();
                    return false;
                }



                var page ="${pd.currentPage}";
                var sum ="&keywords=${pd.keywords}";


                $("#form1").ajaxSubmit({
                    type: 'post',
                    dataType:"html",
                    success: function(data) {
                        var jso = JSON.parse(data);
                        if ("success" == jso.msg) {
                            parent.layer.transmit.location.href = "<%=basePath%>grades/listStudent.do?gId=${pd.gId}&currentPage=" + page + sum;
                            parent.layer.closeAll();
                        } else if ("error" == jso.msg) {
                            layer.msg('系统异常,保存失败!', {icon: 5});
                        } else if("false" == jso.msg){
                            layer.msg('班级人数超出最大功能教室人数,或者学校没有改功能教室,保存失败!', {icon: 5});
						}
                    }
                });

            });

            $("#cancel").on("click",function(){
                parent.layer.closeAll();
            })
        });

        function test(file_name,symbol){
            var result = file_name.split(symbol);
            return result[result.length-1];
        }
	</script>
</body>
</html>

