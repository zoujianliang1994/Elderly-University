<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>学期编辑</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>
<div class="edit_menu" class="disnone">
    <form action="${msg}.do" class="layui-form" id="editForm" lay-filter="editForm" method="post">
        <input type="hidden" value="${pd.id}" name="id" id="id"/>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label"><i class="require">*</i>名称<span class="colon"></span></label>
					<div class="layui-input-block ">
						<input  name="name" id="name" value="${pd.name}" type="text" class="layui-input layui-input-color" placeholder="请输入学期名称" autocomplete="off" maxlength="30">
					</div>
				</div>
				<div class="form-item-inline">
					<label class="form-label">创建日期<span class="colon"></span></label>
					<div class="layui-input-block ">
						<input  name="create_date" id="create_date" value="${pd.create_date}" type="text" readonly="readonly"	class="layui-input layui-input-color" placeholder="" autocomplete="off" maxlength="30">
					</div>
				</div>

			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label title-max"><i class="require">*</i>报名时间</label>
					<div class="layui-input-block ">
						<input type="hidden" name="reg_start" id="regStart">
						<input type="hidden" name="reg_end" id="regEtart">
					 <input type="text" <c:if test="${pd.reg_start !=null}">value="${pd.reg_start }~${pd.reg_end }"</c:if>  name="" id="reg_start" required lay-verify="required" placeholder="请输入报名日期"
                               autocomplete="off" maxlength="100"
                               class="layui-input layui-input-color" >
					</div>
				</div>
				<div class="form-item-inline">
					<label class="form-label title-max"><i class="require">*</i>学期时间</label>
					<div class="layui-input-block ">
						<input type="hidden" name="semester_start" id="semesterStart">
						<input type="hidden" name="semester_end" id="semesterEtart">
						<input type="text" <c:if test="${pd.semester_start !=null}">value="${pd.semester_start }~${pd.semester_end }"</c:if>  name="" id="semester_start" required lay-verify="required" placeholder="请输入学期时间"
							   autocomplete="off" maxlength="100"
							   class="layui-input layui-input-color" >
					</div>
				</div>
			</div>
		</div>
		

		
		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label title-max" style="width: 110px;"><i class="require">*</i><span>所属校区</span><span>/教学点</span><span class="colon"></span></label>
					<div class="layui-input-block " id="school_point">
						<select lay-filter='school_id' id="school_id" name="s_id"  class="layui-input-inline"  >
							<option value="">请选择</option>
							<c:forEach var="var" items="${schoolList}" varStatus="vs">
								<option value="${var.schoolId}" <c:if test="${var.schoolId==pd.s_id}"> selected="selected" </c:if> >${var.schoolName}</option>
							</c:forEach>
						</select>
					</div>


				</div>

				<div class="form-item-inline">
					<label class="layui-form-label">限报课程</label>
					<div class="layui-input-block ">
						<input type="text" value="${pd.limite_count }" name="limite_count" id="limite_count" required lay-verify="required" placeholder="请输入限报课程数"
							   autocomplete="off" maxlength="100"
							   class="layui-input layui-input-color" >
					</div>
					<span class="layui-form-unit">门</span>
				</div>

			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label"><i class="require">*</i>周数<span class="colon"></span></label>
					<div class="layui-input-block ">
						<input type="text" value="${pd.weeks }" name="weeks" id="weeks" required lay-verify="required" placeholder="请输入周数"
							   autocomplete="off" maxlength="100"
							   class="layui-input layui-input-color" >
					</div>
					<span class="layui-form-unit">周</span>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline" style="width: 98%;">
					<label class="form-label">备注<span class="colon"></span></label>
					<div class="layui-input-block ">
						<textarea class=" layui-textarea layui-input-color"  name="remark" id="remark" placeholder="这里输入备注" title="备注"  maxlength="200">${pd.remark}</textarea>
					</div>
				</div>
			</div>
		</div>

    </form>

    <div class="btnbox" id="btnDiv" >
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
    </div>
</div>
<%@ include file="../../system/index/foot.jsp" %>
<script>
	var optype = '${pd.optype}';

    $(function () {
        //初始化日期控件
        layui.use('laydate', function () {
            var laydate = layui.laydate;
            //执行一个laydate实例
            laydate.render({
                elem: '#reg_start'//指定元素
				,range: '~'
            });

            laydate.render({
                elem: '#semester_start' //指定元素
                ,range: '~'
            });

        });
        
        $("#sure").on("click", function () {

			var reg=$("#reg_start").val().split("~");
            $("#regStart").val(reg[0].replace(/(^\s*)|(\s*$)/g, ""))
            $("#regEtart").val(reg[1].replace(/(^\s*)|(\s*$)/g, ""))
            var semester =$("#semester_start").val().split("~");
            $("#semesterStart").val(semester[0].replace(/(^\s*)|(\s*$)/g, ""))
            $("#semesterEtart").val(semester[1].replace(/(^\s*)|(\s*$)/g, ""))


            if ($("#name").val() == "") {
                layer.tips('名称不能为空', $("#name"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#name").focus();
                return false;
            }
            if ($("#reg_start").val() == "") {
                layer.tips('报名开始日期不能为空', $("#reg_start"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#reg_start").focus();
                return false;
            }

            if ($("#reg_end").val()==""){
                layer.tips('报名结束日期不能为空', $("#reg_end"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#reg_end").focus();
                return false;
            }
            if ($("#semester_start").val() == "") {
                layer.tips('学期开始日期不能为空', $("#semester_start"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#semester_start").focus();
                return false;
            }
            if ($("#semester_end").val() == "") {
                layer.tips('学期结束日期不能为空', $("#semester_end"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#semester_end").focus();
                return false;
            }
            if ($("#weeks").val() == "") {
                layer.tips('周数不能为空', $("#weeks"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#weeks").focus();
                return false;
            }
            if ($("#s_id").val() == "") {
                layer.tips('所属校区或教学点不能为空', $("#school_point"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#school_point").focus();
                return false;
            }
            parent.layer.load(1);

            $.post('${msg}.do', $('#editForm').serialize(), function (data) {
                parent.layer.closeAll('loading');
                if ("success" == data.msg) {
                    parent.layer.edit.location.href = "<%=basePath%>semester/list.do?currentPage=${currentPage}";
                    parent.layer.closeAll();
                } else {
                    layer.msg('系统异常,保存失败!', {icon: 5});
                }
            });
        });
        $("#cancel").on("click", function () {
            parent.layer.closeAll();
        });
        $.myType(optype);
    });
    

</script>
</body>
</html>