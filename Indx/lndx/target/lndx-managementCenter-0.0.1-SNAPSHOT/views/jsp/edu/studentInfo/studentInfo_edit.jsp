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

	<form action="studentInfo/${msg}.do" class="layui-form"  name="form1" id="form1" >
		<input type="hidden" name="id" id="id" value="${pd.id}" />

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>姓名</label>
					<div class="layui-input-block ">
						<input name="xm" id="xm" value="${pd.xm}" type="text" class="layui-input layui-input-color">
					</div>
				</div>


				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>出生日期</label>
					<div class="layui-input-block birth_day">
						<input name="birth_day" id="birth_day" value="${pd.birth_day}" type="text" class="layui-input layui-input-color">
					</div>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
		<div class="layui-row">

			<div class="form-item-inline">
				<label class="form-label">籍贯</label>
				<div class="layui-input-block ">
					<input name="hjdz" id="hjdz" value="${pd.hjdz}" type="text" class="layui-input layui-input-color">
				</div>
			</div>

			<div class="form-item-inline">
				<label class="form-label"><span class="red-star">*</span>性别</label>
				<div class="layui-input-block xb">
					<html:select name="xb" id="xb" classs="layui-input" style=" lay-filter='xb'">
						<html:options collection="SEX" defaultValue="${pd.xb}"></html:options>
					</html:select>

				</div>
			</div>

		</div>
	</div>

	<div class="layui-form-item">
		<div class="layui-row">

			<div class="form-item-inline">
				<label class="form-label"><span class="red-star">*</span>身份证</label>
				<div class="layui-input-block ">
					<input name="sfz" id="sfz" value="${pd.sfz}" type="text" class="layui-input layui-input-color">
				</div>
			</div>

			<div class="form-item-inline">
				<label class="form-label">民族</label>
				<div class="layui-input-block ">
					<html:select name="mz" id="mz" classs="layui-input" style=" lay-filter='mz'">
						<html:options collection="Person_mz" defaultValue="${pd.mz}"></html:options>
					</html:select>
				</div>
			</div>

		</div>
	</div>

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>年龄</label>
					<div class="layui-input-block ">
						<input name="nl" id="nl" value="${pd.nl}" type="number" class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label">手机号码</label>
					<div class="layui-input-block ">
						<input name="phone" id="phone" value="${pd.phone}" type="text"	class="layui-input layui-input-color">
					</div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>疾病史</label>
					<div class="layui-input-block ">
						<input name="disease" id="disease" value="${pd.disease}" type="text" class="layui-input layui-input-color">
					</div>
				</div>
				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>当前住址</label>
					<div class="layui-input-block ">
						<input name="address" id="address" value="${pd.address}" type="text" class="layui-input layui-input-color">
					</div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label">学号</label>
					<div class="layui-input-block ">
						<input name="stu_number" id="stu_number" value="${pd.stu_number}" type="text" class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label">入学时间</label>
					<div class="layui-input-block ">
						<input name="join_school_date" id="join_school_date" value="${pd.join_school_date}" type="text"	class="layui-input layui-input-color">
					</div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>家庭联系人</label>
					<div class="layui-input-block ">
						<input name="family_con_name" id="family_con_name" value="${pd.family_con_name}" type="text" class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>联系人电话</label>
					<div class="layui-input-block ">
						<input name="family_con_tel" id="family_con_tel" value="${pd.family_con_tel}" type="text"	class="layui-input layui-input-color">
					</div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label">家庭第二联系人</label>
					<div class="layui-input-block ">
						<input name="sec_con" id="sec_con" value="${pd.sec_con}" type="text" class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label">联系人电话</label>
					<div class="layui-input-block ">
						<input name="sec_con_tel" id="sec_con_tel" value="${pd.sec_con_tel}" type="text"	class="layui-input layui-input-color">
					</div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">



		</div>

	</form>

	<div class="btnbox" >
		<c:if test="${pd.type=='2'}">
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
        $.myType('${pd.type}')



        layui.use('laydate', function () {
            var laydate = layui.laydate;
            laydate.render({
                elem: '#birth_day'
            });
            laydate.render({
                elem: '#join_school_date'
            });

        });


        $(document).ready(function(){
            form.on('select(semester_id)', function(data){
                $("#semester_name").val(data.elem[data.elem.selectedIndex].text);
            });



            $("#sure").on("click",function(){
                if ($("#xm").val() == "") {
                    layer.tips('请输入姓名',  $("#xm"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#school_id").focus();
                    return false;
                }

                if ($("#birth_day").val() == "") {
                    layer.tips('请选择出生日期',  $(".birth_day"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#birth_day").focus();
                    return false;
                }
                if ($("#xb").val() == "") {
                    layer.tips('请选择性别',  $(".xb"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#recess_time").focus();
                    return false;
                }

                if ($("#sfz").val() == "") {
                    layer.tips('请填写身份证',  $("#sfz"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#sfz").focus();
                    return false;
                }
                if ( !$.isCardId($("#sfz").val())) {
                    layer.tips('请填写正确身份证',  $("#sfz"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#sfz").focus();
                    return false;
                }



                if ($("#nl").val() == "") {
                    layer.tips('请填写年龄',  $("#nl"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#nl").focus();
                    return false;
                }
                if ($("#disease").val() == "") {
                    layer.tips('请填写有无病史',  $("#disease"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#disease").focus();
                    return false;
                }
                if ($("#family_con_name").val() == "") {
                    layer.tips('请填写家庭联系人',  $("#family_con_name"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#family_con_name").focus();
                    return false;
                }


                if ($("#family_con_tel").val() == "") {
                    layer.tips('请填写家庭联系人电话',  $("#family_con_tel"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#family_con_tel").focus();
                    return false;
                }

                if (!$.isPoneAvailable($("#family_con_tel").val())) {
                    layer.tips('请填写正确的家庭联系人电话',  $("#family_con_tel"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#family_con_tel").focus();
                    return false;
                }

                if ($("#address").val() == "") {
                    layer.tips('请填写当前住址',  $("#address"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#address").focus();
                    return false;
                }
				if($("#phone").val() != ""){
					if (!$.isPoneAvailable($("#phone").val())) {
                        layer.tips('请填写正确的电话',  $("#phone"), {
                            tips: [4, '#D16E6C'],
                            time: 4000
                        });
                        $("#phone").focus();
                        return false;
                    }
				}
               var page ="${pd.currentPage}";
               var sum ="&keywords=${pd.keywords}";


                $("#form1").ajaxSubmit({
                    type: 'post',
                    dataType:"html",
                    success: function(data) {
                        var jso = JSON.parse(data);
                        if ("success" == jso.msg) {
                            parent.layer.transmit.location.href = "<%=basePath%>studentInfo/list.do?currentPage=" + page + sum;
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

