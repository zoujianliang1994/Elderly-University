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

	<form action="schedule/addDetaile.do" class="layui-form"  name="form1" id="form1" >
		<input type="hidden" name="schedule_id" id="schedule_id" value="${pd.id}" />

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label">选择班级</label>
					<div class="layui-input-block grades_id">
						<select lay-filter='grades_id' id="grades_id" name="grades_id"  class="layui-input-inline"  >
							<option value="">请选择</option>
							<c:forEach var="var" items="${grades}" varStatus="vs">
								<option value="${var.id}"  >${var.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>


				<div class="form-item-inline">
					<label class="form-label" style="width: 94px"><span class="red-star">*</span>选择星期</label>
					<div class="layui-input-block week">
						<select lay-filter='week' id="week" name="week"  class="layui-input-inline"  >
							<option value="">请选择</option>
							<option value="1">星期一</option>
							<option value="2">星期二</option>
							<option value="3">星期三</option>
							<option value="4">星期四</option>
							<option value="5">星期五</option>
						</select>

					</div>
				</div>
			</div>
		</div>


		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>教室</label>
					<div class="layui-input-block classroom_id">
						<select lay-filter='classroom_id' id="classroom_id" name="classroom_id"  class="layui-input-inline"  >
							<option value="">请选择</option>
							<c:forEach var="var" items="${classroom}" varStatus="vs">
								<option value="${var.id}"  >${var.classroom_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star"></span>老师</label>
					<div class="layui-input-block ">
						<input name="teacher_name" readonly id="teacher_name"  type="text"	class="layui-input layui-input-color">
					</div>
				</div>

			</div>
		</div>



		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>上课时间</label>
					<div class="layui-input-block ">
						<input name="start_time" id="start_time" type="text" class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>下课时间</label>
					<div class="layui-input-block ">
						<input name="end_time" id="end_time"  type="text" class="layui-input layui-input-color">
					</div>
				</div>
				<input value="1" name="period" id="period" type="hidden">
			</div>
		</div>


		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star"></span>课长</label>
					<div class="layui-input-block ">
						<input name="class_time" readonly id="class_time" type="text" class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star"></span>学费</label>
					<div class="layui-input-block ">
						<input name="tuition" readonly id="tuition"  type="text" class="layui-input layui-input-color">
					</div>
				</div>

			</div>
		</div>


	</form>

	<iframe id="ifr" style="" width="100%" frameborder="0px"  height="auto" src="<%=basePath%>schedule/getGradesDetail.do?grades_id=${pd.grades_id}&id=${pd.id}&semester_id=${schedule.semester_id}">

	</iframe>

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
        $.myType(type)

        $(document).ready(function(){
            form.on('select(semester_id)', function(data){
                $("#semester_name").val(data.elem[data.elem.selectedIndex].text);

            });

            layui.form.on('select(grades_id)', function(data){

                //获取选中的班级数据
                $.get('schedule/getGrades.do?id='+data.value, function (data) {
                    $("#tuition").val(data.grades.tuition);
                    $("#class_time").val(data.grades.class_time);
                    $("#teacher_name").val(data.grades.teacher_name);//.substring(0,data.grades.teacher_name.length-1)
					var html = "<option value=''>请选择</option>";
                    $.each(${classrooms}, function (key, val) {
						if(val.classroom_type==data.grades.classroom_type){
						    html += "<option value='"+val.id+"'  >"+val.classroom_name+"</option>";
						}
                    });
                    $("#classroom_id").html(html);
                    form.render();

                });
				$("#ifr").show();
                document.getElementById('ifr').src="<%=basePath%>schedule/getGradesDetail.do?grades_id="+data.value+"&id=${pd.id}&semester_id=${schedule.semester_id}";

            });





            layui.use('laydate', function () {
                var laydate = layui.laydate;
                laydate.render({
                    elem: '#start_time'
                    ,type: 'time'
                    ,done: function(value, date, endDate){
                        if($("#class_time").val()!= ''&&date!=''&&value!=''){
							var d = new Date(date.year+"/"+date.month+"/"+date.date+" "+value).getTime();
							var sd = d+($("#class_time").val()*60000)
							var d2 = new Date(sd);
							$("#end_time").val(d2.getHours()+":"+d2.getMinutes()+":"+d2.getSeconds());
							if(d2.getHours()>=12&&d2.getMinutes()>=30&&date.hours<=12){
                                layer.tips('下课时间接近午休时间',  $("#end_time"), {
                                    tips: [4, '#009bff'],
                                    time: 4000
                                });
                        	}
                        }
                    }
                });
                laydate.render({
                    elem: '#end_time'
                    ,type: 'time'
                });
            });




            $("#sure").on("click",function(){
                if ($("#grades_id").val() == "") {
                    layer.tips('请选择班级',  $(".grades_id"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#grades_id").focus();
                    return false;
                }

                if ($("#classroom_id").val() == "") {
                    layer.tips('请选择教室',  $(".classroom_id"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#classroom_id").focus();
                    return false;
                }
                if ($("#week").val() == "") {
                    layer.tips('请选择上课天数',  $(".week"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#week").focus();
                    return false;
                }

                if ($("#start_time").val() == "") {
                    layer.tips('请确认写上课时间',  $("#start_time"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#start_time").focus();
                    return false;
                }

                if ($("#end_time").val() == "") {
                    layer.tips('请写下课时间',  $("#end_time"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#end_time").focus();
                    return false;
                }

				if(  $("#start_time").val().substring(0,2)>12){
						//默认上午大于12变成下午
					  $("#period").val("2")
				}


               var page ="${pd.currentPage}";
               var sum ="&keywords=${pd.keywords}";


                $("#form1").ajaxSubmit({
                    type: 'post',
                    dataType:"html",
                    success: function(data) {
                        var jso = JSON.parse(data);
                        if ("success" == jso.msg) {
                            parent.layer.transmit.location.href = "<%=basePath%>schedule/details.do?id=${pd.id}";
                            parent.layer.closeAll();
                        } else if ("error" == jso.msg) {
                            layer.msg('系统异常,保存失败!', {icon: 5});
                        }else if ("classroom_type" == jso.msg) {
                            layer.msg('教室类型错误!', {icon: 5});
                        }else if ("classroom_size" == jso.msg) {
                            layer.msg('班级最大人数与教室最大人数不匹配!', {icon: 5});
                        }else if ("classroom_time" == jso.msg) {
                            layer.msg('当前时间该教室已被占用!', {icon: 5});
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

