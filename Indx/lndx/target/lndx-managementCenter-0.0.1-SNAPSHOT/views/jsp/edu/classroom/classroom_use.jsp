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
<style>
	td span {
		display: block;
	}
</style>
<div class="edit_menu" class="disnone">

	<form action="classroom/${msg}.do" class="layui-form"  name="form1" id="form1" >
		<input type="hidden" name="id" id="id" value="${pd.id}" />

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="layui-form-label">教室名称</label>
					<div class="layui-input-block ">
						<input name="classroom_name" id="classroom_name" value="${pd.classroom_name}" type="text" class="layui-input">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="layui-form-label">教室类型</label>
					<div class="layui-input-block ">
						<html:selectedValue collection="classroom_type" defaultValue="${pd.classroom_type}"></html:selectedValue>
					</div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline" style="width: 98%;">
					<label class="form-label" style="color: #999;">教室使用情况</label>
					<div class="layui-input-block ">
						<table class="layui-table center">
							<colgroup>
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr class="table-head-tr">
									<th>周一</th>
									<th>周二</th>
									<th>周三</th>
									<th>周四</th>
									<th>周五</th>
								</tr>
							</thead>
							<tbody>


							</tbody>
						</table>
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
		if("${pd.type}"=="1"){
            $.formToDiv(true);
		}
        $(function () {
            var html='';
            var num = 1;
            $.each(${json}, function (key, val) {
                var maxLength = 0;
                if (JSON.stringify(val) != "{}") {
                    $.each(val, function (day, data) {
                        if (maxLength < data.length) {
                            maxLength = data.length
                        }
                    })

                    for (var i = 0; i < maxLength; i++) {
						html += "<tr><td >" + ((val.Monday[i] != undefined) ? '<div ><span>' + val.Monday[i].grades_name + '</span><span>' + val.Monday[i].start_time + '-' + val.Monday[i].end_time + '</span><span>' + val.Monday[i].semester_name + '</span></div>' : '') + "</td>" +
							"<td >" + ((val.Tuesday[i] != undefined) ? '<div ><span>' + val.Tuesday[i].grades_name + '</span><span>' + val.Tuesday[i].start_time + '-' + val.Tuesday[i].end_time +  '</span><span>' + val.Tuesday[i].semester_name+ '</span></div>' : '') + "</td>" +
							"<td >" + ((val.Wednesday[i] != undefined) ? '<div ><span>' + val.Wednesday[i].grades_name + '</span><span>' + val.Wednesday[i].start_time + '-' + val.Wednesday[i].end_time +  '</span><span>' + val.Wednesday[i].semester_name + '</span></div>' : '') + "</td>" +
							"<td >" + ((val.Thursday[i] != undefined) ? '<div ><span>' + val.Thursday[i].grades_name+ '</span><span>' + val.Thursday[i].start_time + '-' + val.Thursday[i].end_time +'</span><span>' + val.Thursday[i].semester_name + '</span></div>' : '') + "</td>" +
							"<td >" + ((val.Friday[i] != undefined) ? '<div ><span>' + val.Friday[i].grades_name + '</span><span>' + val.Friday[i].start_time + '-' + val.Friday[i].end_time +  '</span><span>' + val.Friday[i].semester_name + '</span></div>' : '') + "</td></tr>"
                    }
                }
            })
            $("tbody").append(html);

        });

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

               var page ="${pd.currentPage}"
               var sum ="&keywords=${pd.keywords}"


                $("#form1").ajaxSubmit({
                    type: 'post',
                    dataType:"html",
                    success: function(data) {
                        var jso = JSON.parse(data)
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

