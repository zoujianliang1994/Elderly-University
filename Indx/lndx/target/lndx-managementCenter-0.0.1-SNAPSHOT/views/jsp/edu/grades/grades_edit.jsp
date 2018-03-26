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

	<form action="grades/${msg}.do" class="layui-form"  name="form1" id="form1" >
		<input type="hidden" name="id" id="id" value="${pd.id}" />

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>班级名称</label>
					<div class="layui-input-block ">
						<input name="name" id="name" value="${pd.name}" type="text" class="layui-input layui-input-color">
					</div>
				</div>


				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>学费<span class="layui-label-unit">(元)</span></label>
					<div class="layui-input-block ">
						<input name="tuition" id="tuition" value="${pd.tuition}" type="text" class="layui-input layui-input-color">
					</div>
					<span class="layui-form-unit">元</span>
				</div>



			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label">班级人数</label>
					<div class="layui-input-block ">
						<input name="class_size" id="class_size" value="${pd.class_size}" type="text"	class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label title-max" style="width: 110px;"><span>所属校区</span><span>/教学点</span></label>
					<div class="layui-input-block school_id">
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
					<label class="form-label"><span class="red-star">*</span>任课老师</label>
					<div class="layui-input-block ">

						<input readonly="readonly" type="hidden" name="teacher_id" id="teacher_id" value="${pd.teacher_id}" />
						<input readonly="readonly" type="hidden" name="teacher_name" id="teacher_name" value="${pd.teacher_name}" />
						<div id="teacher" class="search sTree layui-input-block" >
							<select lay-filter='teacher_isde' id="teacher_isde" name="teacher_isde"  class="layui-input-inline"  >
								<option value="">请选择</option>


							</select>
						</div>

					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label">人数</label>
                   <div class="layui-input-block  age-min-block"  style="width: 4%;float: left;">
                        <span style="display: inline-block;padding-left: 1%;">女</span>
                    </div>
					<div class="layui-input-block age-min-block"  style="width: 46%;float: left;padding-right: 4%;">
						<input name="sex_woman_number" id="sex_woman_number" value="${pd.sex_woman_number}" type="text" style="width:97%; height: 36px;padding-left: 3%"	class="layui-input-color">
					</div>
					<span class="layui-form-unit" style="padding:9px 5px">-</span>
                   <div class="layui-input-block  age-min-block"  style="width: 4%;float: left;">
                        <span style="display: inline-block">男</span>
                    </div>
                   <div class="layui-input-block  age-min-block"  style="width: 46%;float: left;">

                    <input name="sex_man_number" id="sex_man_number" value="${pd.sex_man_number}" type="text" style="width:97%; height: 36px;padding-left: 3%"	class="layui-input-color">
                    </div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>班主任</label>
					<div class="layui-input-block ">
						<input name="headmaster_name" id="headmaster_name" value="${pd.headmaster_name}" type="text" class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label "><span class="red-star">*</span>联系电话</label>
					<div class="layui-input-block ">
						<input name="headmaster_phone" id="headmaster_phone" value="${pd.headmaster_phone}" type="text" class="layui-input layui-input-color">
					</div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label">功能</label>
					<div class="layui-input-block classroom_type">

						<html:select name="classroom_type" id="classroom_type" classs="layui-input" style=" lay-filter='classroom_type'">
							<html:options collection="classroom_type" defaultValue="${pd.classroom_type}"></html:options>
						</html:select>

					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label">对应课程</label>
					<div class="layui-input-block lesson_id">
						<select  lay-search="" lay-filter='lesson_id' id="lesson_id" name="lesson_id"  class="layui-input-inline"  >
							<option value="">请选择</option>
							<c:forEach var="var" items="${lessonList}" varStatus="vs">
								<option title="${var.qs}" value="${var.id}" <c:if test="${var.id==pd.lesson_id}"> selected="selected" </c:if> >${var.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">


				<div class="form-item-inline">
					<label class="form-label title-max" style="width: 96px"><span><span class="red-star">*</span>对应课程</span><span>期数</span></label>
					<div class="layui-input-block lesson_periods">
						<select lay-filter='lesson_periods' id="lesson_periods" name="lesson_periods"  class="layui-input-inline"  >
							<option value="">请选择</option>
							<c:forEach var="var" items="${periodsList}" varStatus="vs">
								<option value="${var.no}" <c:if test="${var.no==pd.lesson_periods}"> selected="selected" </c:if> >${var.no}</option>
							</c:forEach>

						</select>
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>课长</label>
					<div class="layui-input-block ">
						<input name="class_time" id="class_time" value="${pd.class_time}" type="text" class="layui-input layui-input-color">
					</div>
					<span class="layui-form-unit">节</span>
				</div>



			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">


				<div class="form-item-inline">
					<label class="form-label title-max "style="width: 80px;"><span><span class="red-star">*</span>课费</span><span class="layui-label-unit">(元/节)</span></label>
					<div class="layui-input-block lesson_periods">
						<input name="teacher_wages" id="teacher_wages" value="${pd.teacher_wages}" type="text" class="layui-input layui-input-color">
					</div>
					<span class="layui-form-unit">元/节</span>
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
        var msg = '${msg}';

        if(msg=="edit"){
            var datas = eval(${listTeacher});
            var schoolStree = $.Stree({
                title: "${pd.teacher_name}",
                el: $("#teacher"),
                oldData: "${pd.teacher_id}".split(","),
                isSingle: false,  //单选
                data: datas,
                callback: function () {
                    if(this.arr == ""){
                        $("#teacher_id").val("");
                        $("#teacher_name").val("")
                        return
                    }
                    $("#teacher_name").val($.getString(this.arr, "title") );
                    $("#teacher_id").val($.getString(this.arr, "id") )
                }
            });
		}
        $.myType(type);

        $(document).ready(function(){
            form.on('select(lesson_id)', function(data){
				var dome=data.elem[data.elem.selectedIndex].title;
                $("#lesson_periods").html("<option value=\"\">请选择</option>")
                for (var i=1;i<=dome;i++)
                {
					$("#lesson_periods").append("<option value=\""+i+"\">"+i+"</option>")
                }
                form.render('select');
            });

            form.on('select(school_id)', function(data){
                var dome=data.value;
				//根据学校获取课程
                var url = "<%=basePath%>grades/getSchoolLesson.do?id=" + dome;
                $.get(url, function (data) {
                    if ("success" == data.result) {

                        var option = "<option value=\"\">请选择</option>"
                        $.each(data.list , function (i) {
                            option = option + "<option title='"+this.qs+"'  value='" + this.id + "'>" + this.name + "</option>"
                        });
                        $("#lesson_id").html(option);

                        $("#lesson_periods").html("<option value=\"\">请选择</option>")


                        var data = eval(data.listTeacher);
                        var schoolId='${pd.teacher_id}'
                        var schoolStree = $.Stree({
                            title: "${pd.teacher_name}",
                            el: $("#teacher"),
                            oldData: schoolId.split(","),
                            isSingle: false,  //单选
                            data: data,
                            callback: function () {
                                if(this.arr == ""){
                                    $("#teacher_id").val("");
                                    $("#teacher_name").val("")
                                    return
                                }
                                $("#teacher_name").val($.getString(this.arr, "title") );
                                $("#teacher_id").val($.getString(this.arr, "id") )
                            }
                        });

                    }
                    form.render();
                });


            });


            $("#sure").on("click",function(){
                if ($("#name").val() == ""||$().val("#name").length>50) {
                    layer.tips('请验证输入',  $("#name"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#name").focus();
                    return false;
                }
                if ($("#size").val() == "") {
                    layer.tips('请验证输入',  $("#size"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#size").focus();
                    return false;
                }
                if ($("#school_id").val() == "") {
                    layer.tips('请选择校区',  $("#school_id"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#school_id").focus();
                    return false;
                }
                if ($("#classroom_type").val() == "") {
                    layer.tips('请选择教室功能',  $(".classroom_type"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#classroom_type").focus();
                    return false;
                }
                if ($("#lesson_id").val() == "") {
                    layer.tips('请选择课程',  $(".lesson_id"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#lesson_id").focus();
                    return false;
                }else if ($("#lesson_periods").val() == "") {
                    layer.tips('请选择对应期数',  $(".lesson_periods"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#lesson_periods").focus();
                    return false;
                }
                if ($("#class_time").val() == "") {
                    layer.tips('请验证输入',  $("#class_time"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#class_time").focus();
                    return false;
                }
                if ($("#tuition").val() == "") {
                    layer.tips('请验证输入',  $("#tuition"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#tuition").focus();
                    return false;
                }

                if ($("#size").val()<($("#sex_woman_number").val()+$("#sex_man_number").val())) {
                    layer.tips('男女总和大于班级人数',  $("#size"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#size").focus();
                    return false;
                }




            var page ="${pd.currentPage}";
            var sum ="&keywords=${pd.keywords}";

			var s = $("#lesson_periods").val();
                $("#lesson_periods").val(s)
            $("#form1").ajaxSubmit({
                type: 'post',
                dataType:"html",
                success: function(data) {
                    var jso = JSON.parse(data);
                    if ("success" == jso.msg) {
                        parent.layer.transmit.location.href = "<%=basePath%>grades/list.do?currentPage=" + page + sum;
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

