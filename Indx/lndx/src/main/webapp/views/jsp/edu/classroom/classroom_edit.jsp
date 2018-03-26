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

	<form action="classroom/${msg}.do" class="layui-form"  name="form1" id="form1" >
		<input type="hidden" name="id" id="id" value="${pd.id}" />

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>教室名称</label>
					<div class="layui-input-block ">
						<input name="classroom_name" id="classroom_name" value="${pd.classroom_name}" type="text" class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>容量<span class="layui-label-unit">(人)</span></label>
					<div class="layui-input-block ">
						<input name="classroom_size" id="classroom_size" value="${pd.classroom_size}" type="text"	class="layui-input layui-input-color">
					</div>
					<span class="layui-form-unit">人</span>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>位置</label>
					<div class="layui-input-block ">
						<input name="classroom_address" id="classroom_address" value="${pd.classroom_address}" type="text"	class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label title title-max"><span><span class="red-star">*</span>所属校区</span><span>/教学点</span></label>
					<div class="layui-input-block ">
						<input readonly="readonly" type="hidden" name="school_name" id="school_name" value="${pd.school_name}" />
						<select lay-filter='school_id' id="school_id" name="school_id"  class="layui-input-inline"  >
							<option value="">请选择</option>
							<c:forEach var="var" items="${schoolList}" varStatus="vs">
								<option value="${var.schoolId}" <c:if test="${var.schoolId==pd.school_id}"> selected="selected" </c:if> >${var.schoolName}</option>
							</c:forEach>
						</select>
					</div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>功能</label>
					<div class="layui-input-block ">

						<html:select name="classroom_type" id="classroom_type" classs="layui-input" style=" lay-filter='classroom_type'">
							<html:options collection="classroom_type" defaultValue="${pd.classroom_type}"></html:options>
						</html:select>

					</div>
				</div>

			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline" style="width:98%;">
					<label class="form-label" >功能描述</label>
					<div class="layui-input-block " >
						<textarea class=" layui-textarea layui-input-color" name="classroom_describe" id="classroom_describe" maxlength="200">${pd.classroom_describe}</textarea>
					</div>
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
            form.on('select(school_id)', function(data){
                $("#school_name").val(data.elem[data.elem.selectedIndex].text);
            });


            $("#sure").on("click",function(){
                if ($("#classroom_name").val() == "") {
                    layer.tips('请输入教室名称',  $("#classroom_name"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#classroom_name").focus();
                    return false;
                }
                if ($("#classroom_size").val() == "") {
                    layer.tips('请输入教室容量',  $("#classroom_size"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#classroom_size").focus();
                    return false;
                }
                if ($("#classroom_address").val() == "") {
                    layer.tips('请输入教室位置',  $("#classroom_address"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#classroom_address").focus();
                    return false;
                }
                if ($("#school_id").val() == "") {
                    layer.tips('请输入教室校区',  $("#school_id"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#school_id").focus();
                    return false;
                }
                if ($("#classroom_type").val() == "") {
                    layer.tips('请选择教室功能',  $("#classroom_type"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#classroom_type").focus();
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
                            parent.layer.transmit.location.href = "<%=basePath%>classroom/list.do?currentPage=" + page + sum;
                            parent.layer.closeAll();
                        } else if ("error" == jso.msg) {
                            layer.msg('系统异常,保存失败!', {icon: 5});
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

