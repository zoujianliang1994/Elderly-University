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

	<form action="activityGroup/${msg}.do" class="layui-form" name="form1" id="form1">
		<input type="hidden" name="activity_group_id" id="activity_group_id" value="${pd.id}" />
		<input type="hidden" name="type" id="type" value="${person.type}" />
		<input type="hidden" name="id" id="id" value="${person.id}" />
		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline" style="width:98%">
					<label class="form-label"><span class="red-star">*</span>姓名</label>
					<div class="layui-input-block ">
						<input name="xm" id="xm" value="${person.xm}" type="text" class="layui-input layui-input-color">
					</div>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline" style="width:98%">
					<label class="form-label"><span class="red-star">*</span>身份证号</label>
					<div class="layui-input-block ">
						<input name="sfz" id="sfz" value="${person.sfz}" type="text" class="layui-input layui-input-color">
					</div>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline" style="width:98%">
					<label class="form-label"><span class="red-star">*</span>联系电话</label>
					<div class="layui-input-block ">
						<input name="phone" id="phone" value="${person.phone}" type="text" class="layui-input layui-input-color">
					</div>
				</div>
			</div>
		</div>

		<div style="color: red">
			请确认姓名、身份证号、手机号码是否正确；如果不正确，
			请更新信息。
		</div>

	</form>

	<div class="btnbox" >
		<button id="sure" class="layui-btn layui-btn-primary layui-btn-small">确认</button>
		<button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
	</div>
</div>

	</form>

	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript">

        var form = layui.form;

            $("#sure").on("click",function(){
                if ($("#xm").val() == "") {
                    layer.tips('请输入姓名',  $("#xm"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#xm").focus();
                    return false;
                }
                if ($("#sfz").val() == "") {
                    layer.tips('请输入身份证',  $("#sfz"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#sfz").focus();
                    return false;
                }
                if ($("#phone").val() == "") {
                    layer.tips('请输入联系电话',  $("#phone"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#phone").focus();
                    return false;
                }

                $("#form1").ajaxSubmit({
                    type: 'post',
                    dataType:"html",
                    success: function(data) {
                        var jso = JSON.parse(data);
                        if ("success" == jso.msg) {
                            parent.parent.layer.transmit.location.href = "activityGroup/listByUser.do";
                            parent.layer.closeAll();
                        } else {
                            layer.msg('系统异常,报名失败!', {icon: 5});
                        }
                    }
                });

            });

            $("#cancel").on("click",function(){
                parent.layer.closeAll();
            })

	</script>
</body>
</html>

