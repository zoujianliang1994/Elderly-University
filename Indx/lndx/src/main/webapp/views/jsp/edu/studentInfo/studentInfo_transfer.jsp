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

	<form action="<%=basePath%>studentInfo/goTransfer.do" method="post" name="Form" id="Form" class="operationBox layui-form">

		<div class=" fl ">
			<input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="系别名称，班级名称" class="layui-input fl search layui-input-color">
			<input id="id" name="id" type="hidden" value="${stu.id}" >

		</div>
		<div class="fl srarchBtn" onclick="gsearch()">
			<i class="iconfont icon-sousuo"></i>
			<span>搜索</span>
		</div>
	</form>

	<form action="<%=basePath%>studentInfo/transfer.do" method="post" name="Form1" id="Form1" class="">


	<!-- table -->
	<table class="layui-table center " lay-skin="line" id="table">

		<thead>
		<tr style="background-color: #f3f8ff;">
			<th class="center staa" style="width: 100px;">
				转入班级
			</th>
			<th class='center'>班级名称</th>
			<th class='center'>课程名称</th>
			<th class='center'>创建日期</th>
			<th class='center'>学员人数</th>
		</tr>
		</thead>
		<tbody>

		<c:choose>
			<c:when test="${not empty list}">
					<c:forEach items="${list}" var="var" varStatus="vs">
						<tr>
							<td><input class="grades_id"  lay-filter='grades_id'  type="radio" name="grades_id" value="${var.id}"></td>
							<td>${var.name}</td>
							<td>${var.lesson_name}</td>
							<td>${var.createTime}</td>
							<td>${var.studentNum}</td>

						</tr>
					</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="100" class='center'>没有相关数据</td>
				</tr>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>

	<div class="laypageBox">
		<div id="laypage" class="fr"></div>
	</div>

	<div class="layui-form-item">
		<div class="layui-row">

			<div class="form-item-inline">
				<label class="form-label"><span class="red-star">*</span>转班时间</label>
				<div class="layui-input-block lesson_periods">
					<input name="event_time" id="event_time"  type="text" class="layui-input layui-input-color">

				</div>
			</div>
			<div class="form-item-inline" >
				<label class="form-label"><span class="red-star">*</span>转出班级</label>
				<div class="layui-input-block lesson_periods layui-form clrea_grades">

					<select lay-filter='clrea_grades' id="clrea_grades" name="clrea_grades"  class="layui-input-inline"  >
						<option value="" id="clrea_grades_c" >请选择</option>
						<c:forEach var="var" items="${allGrades}" varStatus="vs">
							<option value="${var.id}"  >${var.name}</option>
						</c:forEach>

					</select>


				</div>
			</div>


		</div>
	</div>



	<div class="layui-form-item ">
		<div class="layui-row">

			<div class="form-item-inline">
				<label class="form-label" ><span class="red-star">*</span>预计转出退费(元)</label>
				<div class="layui-input-block lesson_periods layui-form">
					<input type="text" value="0" name="pay" id="pay" class="layui-input layui-input-color" >
				</div>
			</div>
			<div class="form-item-inline">
				<label class="form-label"><span class="red-star">*</span>预计转入费用(元)</label>
				<div class="layui-input-block lesson_periods layui-form">
					<input type="text" value="0" name="income" id="income" class="layui-input layui-input-color" >
				</div>
			</div>
		</div>
	</div>

	<div class="layui-form-item" >

		<div class="form-item-inline"style="width: 98%">
		<label class="form-label">备注</label>
		<div class="layui-input-block "  >
			<textarea name="reason" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea>
		</div>
	</div>
	</div>
		<input type="hidden" name="event_type" value="4">
		<input type="hidden" name="student_id" id="student_id" value="${stu.id}">
		<input type="hidden" name="xm" id="xm" value="${stu.xm}">
		<input type="hidden" name="stu_number" id="stu_number" value="${stu.stu_number}">
		<input type="hidden" name="semester_id" id="semester_id" value="${stu.semester_id}">
</form>


	<div class="btnbox" >

		<button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>

		<button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
	</div>
</div>


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript">


        var form = layui.form;


        function gsearch() {
            $("#Form").submit();
        }

        layui.use('laydate', function () {
            var laydate = layui.laydate;
            laydate.render({
                elem: '#event_time',
                done: function(value){
                    var g_id = $('#table input[name="grades_id"]:checked').val();
                    if(g_id==""||g_id==undefined){
                        layer.tips('请优先选择转入班级',  $(".staa"), {
                            tips: [4, '#D16E6C'],
                            time: 4000
                        })
                        $("#event_time").val("")
                        form.render()
                    }else{
                       var tuition = update('1',g_id,value);
                    }

                }
            });
        });




        function update(id,g_id,date) {

            $.ajax({
                url:'<%=basePath%>studentInfo/getStuGradesTuition.do?gid='+g_id+'&time='+date,
                type:"post",
                data:"data",

                success:function(data){
					if(id=='1'){
                        $("#income").val(data.tuition);
					}else{
                        $("#pay").val(data.tuition);
					}
                }
            })
        }

        layui.use('laypage', function() {
            var laypage = layui.laypage;
            var layer = layui.layer;
            var form = layui.form;
            var tree = layui.tree;

            //执行一个laypage实例
            laypage.render({
                elem: 'laypage',
                count: ${page.totalResult},
                curr: ${page.currentPage},
                layout: ['prev', 'page', 'next', 'count', 'skip'],
                jump: function (obj, first) {
                    if (!first) {
                        window.location.href = "<%=basePath%>studentInfo/goTransfer.do?id=${stu.id}&currentPage=" + obj.curr +"&keywords=${pd.keywords}";
                    }
                }
            });
		});

        $(document).ready(function(){
            form.on('select(clrea_grades)', function(data){
               var g_id =  data.value//转出班级id
				var event_time = $("#event_time").val()

                if(event_time==""||event_time==undefined){
                    layer.tips('请优先选择转班时间',  $("#event_time"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    })

                    $("#clrea_grades_c").attr("selected","selected")
                    form.render()
                }else{
                    var tuition = update('2',g_id,event_time);

                }
            });

            //rido 选择事件
            $(".grades_id").change(
                function() {
                    var id = $("input[name='grades_id']:checked").val();
                    var event_time = $("#event_time").val()
					if(event_time!=null||event_time !=undefined){
                    	update('1',id,event_time);
                    }
                });





            $("#sure").on("click",function(){

				if($("#event_time").val() == ""){
                        layer.tips('请选择转班时间',  $("#event_time"), {
                            tips: [4, '#D16E6C'],
                            time: 4000
                        });
                        $("#event_time").focus();
                        return false;
				}

                var g_id = $('#table input[name="grades_id"]:checked').val();
                if(g_id==""||g_id==undefined){
                    layer.tips('请选择转入班级',  $(".staa"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    })
                    return false;
                }

				if($("#clrea_grades").val()==""){
                    layer.tips('请选择转出班级',  $(".clrea_grades"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    })
                    return false;
                }
                if($("#clrea_grades").val()==g_id){

                    layer.msg('转出班级和转入班级相同!', {icon: 5});
                    return false;
                }





                if($("#pay").val()==""){
                    layer.tips('请确认转出退费',  $("#pay"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    })
                    return false;
                }
                if($("#income").val()==""){
                    layer.tips('请确认转入收费',  $("#income"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    })
                    return false;
                }




                $("#Form1").ajaxSubmit({
                    type: 'post',
                    dataType:"html",
                    success: function(data) {
                        var jso = JSON.parse(data);
                        if ("success" == jso.msg) {
                            <%--parent.layer.transmit.location.href = "<%=basePath%>studentInfo/list.do?currentPage=" + page + sum;--%>
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

