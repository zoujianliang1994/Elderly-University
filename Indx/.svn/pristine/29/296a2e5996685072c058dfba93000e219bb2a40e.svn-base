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
	<%@ include file="../index/headcss.jsp" %>
</head>
<body class="no-skin">
	<div class="edit_menu">

			<form action="permission/${msg }.do" class="layui-form" lay-filter="editForm"  name="Form" id="Form" method="post">
				<input type="hidden" name="id" id="id" value="${pd.id}" />
				<div class="layui-form-item">
					<div class="layui-form-item">
						<div class="form-item-inline">
							<label class="form-label">名称</label>
							<div class="layui-input-block ">
									<input class="layui-input layui-input-color" type="text" name="name" id="name" value="${pd.name}" maxlength="50" placeholder="这里输入名称"  />
							</div>
						</div>
						<div class="form-item-inline">
							<label class="form-label">标志</label>
							<div class="layui-input-block ">
								<input class="layui-input layui-input-color"  type="text" name="sign" id="sign" value="${pd.sign}" maxlength="32" placeholder="这里输入标志 (不重复)"  onchange="hasSign();"/>
							</div>
						</div>
					</div>

					<div class="layui-form-item">
						<div class="form-item-inline">
							<label class="form-label">是否禁用:</label>
							<div class="layui-input-block ">
								<input type="radio" id="form-field-radio1" name="is_del" <c:if test="${pd.is_del == true }">checked="checked"</c:if>  value=true title="启用" />
								<input type="radio" id="form-field-radio2" name="is_del"  <c:if test="${pd.is_del == false }">checked="checked"</c:if>  value=false title="禁用" />
							</div>
						</div>
					</div>

				</div>

			</form>


		<div class="btnbox" >
			<button id="sure" class="layui-btn layui-btn-primary layui-btn-small">确认</button>
			<button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
		</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript">

        $(function () {
            $("#sure").on("click", function () {
                if($("#name").val()==""){
                    layer.tips('请输入名称', $("#name"), {
                        tips: [4, '#2795cd'],
                        time: 4000
                    });
                    $("#name").focus();
                    return false;
                }
                if($.trim($("#sign").val())==""){
                    layer.tips('请输入标志', $("#sign"), {
                        tips: [4, '#2795cd'],
                        time: 4000
                    });

                    $("#sign").focus();
                    return false;
                }
                $.post('permission/${msg}.do', $('#Form').serialize(), function (data) {
                    if ("success" == data.msg) {
                        parent.layer.transmit.location.href = "<%=basePath%>permission/list.do?currentPage=${pd.currentPage}";
                        parent.layer.closeAll();
                    } else {
                        layer.msg('系统异常,保存失败!', {icon: 5});
                    }
                });
            });
            $("#cancel").on("click", function () {
                parent.layer.closeAll();
            })
        });


		
		//判断编码是否存在
		function hasSign(){
			var sign = $.trim($("#sign").val());
			if("" == sign)return;
			$.ajax({
				type: "POST",
				url: '<%=basePath%>permission/hasSign.do',
				data : {
					sign : sign
				},
				dataType : 'json',
				cache : false,
				success : function(data) {
					if ("success" == data.result) {
					} else {

                        layer.tips('输入'+sign+'标志重复', $("#sign"), {
                            tips: [4, '#2795cd'],
                            time: 4000
                        });

						$('#sign').val('');
					}
				}
			});
		}
	</script>
</body>
</html>