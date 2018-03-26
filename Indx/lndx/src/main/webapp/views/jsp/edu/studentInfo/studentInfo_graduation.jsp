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

	<div class="layui-form-item">
		<div class="layui-row">

				<label class="layui-form-label" style="width: 17rem"><span class="red-star">*</span>请选择您所需要结业的课程<span class="colon"></span></label>
				<div class="layui-input-block select_id" style="width: 18rem;padding-right: 15px;">
					<select lay-verify="" id="select_id"class="select-linkage layui-input-color" style="padding-left: 10px;">
						<option>请选择</option>
					</select>
				</div>

		</div>
	</div>

	<div class="layui-col-sm12">
		<table class="layui-table center " lay-skin="line" id="table">

			<thead>
			<tr style="background-color: #f3f8ff;">
				<th class='center'>包含期数</th>
				<th class='center'>对应班级</th>
				<th class='center'>对于学期</th>
				<th class='center' style="width: 150px;">是否完成</th>
			</tr>
			</thead>
			<tbody>
				<tr class="main_info">
					<td colspan="100" class="center">没有相关数据</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="btnbox" >
		<button id="sure" class="layui-btn layui-btn-primary layui-btn-small">确定</button>
		<button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
	</div>
</div>


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript">
		$(function(){
			console.log()
			var data=${mapJson}.json;
			console.log(data)
			function getHtml(){
                if(data.length>0){
                    $('tbody').empty();
                    var num=0
                    for(var i=0;i<data.length;i++){
                        $.each(data[i],function(key,val){

                            var html='';
                            if(key=='lesson_name'){
                                html+="<option value="+num+">"+val+"</option>";
                                $('#select_id').append(html)
                            }
                            if(key=='content'){
                                for (var j=0;j<val.length;j++){
									var v = parseInt(val[j].status);
									var s = "";
									switch (v) {
										case 1:
										    s = "正常";
										    break;
										case 2:
                                            s = "休学";
                                            break;
										case 3:
                                            s = "退课";
                                            break;
										case 4:
                                            s = "结业";
                                            break;
                                    }


                                    html+="<tr data-id="+num+" style='display:none' data-num="+val[j].grades_id+"><td>"+val[j].lesson_periods+"</td><td>"+val[j].grades_name+"</td><td>"+val[j].semester_name+
										"</td><td> "+s+" </td></tr>";


                                }
                                $('tbody').append(html)
                            }

                        })
                        num++;
                    }
                }
			}
			getHtml()
            var str ="";
			$(document).on("change","#select_id",function () {
				var id=$(this).val();
                str = "";
				$("tbody tr").each(function(){
				    if($(this).attr("data-id")==id){
				        if(str==""){
                            str+=$(this).attr("data-num");
                        }else{
                            str= str+","+$(this).attr("data-num");

                        }

				        $(this).show()
					}else{
                        $(this).hide()
					}
				})
            })

            $("#sure").on("click",function(){
                //提交学生id，班级id


                if (str == "") {
                    layer.tips('请选择结业课程',  $(".select_id"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    return false;
                }

                parent.layer.confirm("是否确认该学员在读班级已经完成结业", {
                    btn : [ '确定', '取消' ] //按钮
                    ,resize : false
                    ,title : "提示"
                    ,maxWidth : 800
                }, function(index) {

                    $.post('studentInfo/graduation.do', {"grades_id":str,"student_id":"${stu.id}"}, function (data) {

                        parent.layer.closeAll();
                        if ("success" == data.result) {
                            layer.msg('结业成功!', {icon: 1});
                            parent.layer.closeAll();
                        } else if ("fail" == data.result) {
                            layer.msg('稍后再试!', {icon: 5});
                        } else {
                            layer.msg('系统异常,结业失败!', {icon: 5});
                        }
                    });

                });




            });


            $("#cancel").on("click",function(){
                parent.layer.closeAll();
            })

		})
	</script>
</body>
</html>

