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
	.layui-layer-title{
		height: 4rem;
		line-height: 4rem;
		background-color: #3779f7;
		border: solid 1px #3879f7;
		font-size: 20px;
		color: #ffffff;
	}
    .layui-layer-setwin .layui-layer-close1 {
         background-position: 0;
         cursor: pointer;
    }
</style>
<div class="edit_menu" class="disnone">

	<form action="activity/${msg}.do" class="layui-form" enctype="multipart/form-data" name="form1" id="form1" method="post">
		<input type="text" id="selectId" name="selectId" style="display: none">
		<input type="hidden" name="id" id="id" value="${pd.id}" />
		<input type="hidden" id="target" name="target" value="${pd.publish_range}">
		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>活动名称</label>
					<div class="layui-input-block ">
						<input name="name" id="name" value="${pd.name}" maxlength="100" type="text" class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label"><span class="red-star">*</span>活动地点</label>
					<div class="layui-input-block ">
						<input name="activity_location" id="activity_location" value="${pd.activity_location}" maxlength="100" type="text" class="layui-input layui-input-color">
					</div>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label title-max" style="width: 90px;"><span><span class="red-star">*</span>是否需要</span><span>审核</span></label>
					<div class="layui-input-block ">
						<select lay-filter='need_check' id="need_check" name="need_check"  class="layui-input-inline"  >
							<option value="0" <c:if test="${0 == pd.need_check}"> selected="selected" </c:if> >需要</option>
							<option value="1" <c:if test="${1 == pd.need_check}"> selected="selected" </c:if> >不需要</option>
						</select>
					</div>
				</div>

				<div class="form-item-inline">
					<label class="form-label">失败通知</label>
					<div class="layui-input-block ">
						<select lay-filter='need_send_message' id="need_send_message" name="need_send_message"  class="layui-input-inline"  >
							<option value="0" <c:if test="${0 == pd.need_send_message}"> selected="selected" </c:if> >发送</option>
							<option value="1" <c:if test="${1 == pd.need_send_message}"> selected="selected" </c:if> >不发送</option>
						</select>
					</div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="form-item-inline" style="width:98%;">
				<label class="form-label"><span>发布范围</span></label>
				<div class="layui-input-block input-btn"  style="width: 90%;float: left;">
					<input type="text" value="${pd.publish_range }" name="publish_range" id="publish_range" required lay-verify="required" placeholder="请选择发布范围"
						   autocomplete="off" readonly class="layui-input layui-input-color">
				</div>
				<div id="btn-publish" class="layui-input-block layui-input-color" style="width: 10%;height: 38px;float: left;border: 1px solid #dce3eb;text-align: center;cursor: pointer;">选择</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline" style="width:98%;">
					<label class="form-label title-max"style="width: 90px" ><span><span class="red-star">*</span>活动内容</span><span>描述</span></label>
					<div class="layui-input-block " >
						<textarea class=" layui-textarea layui-input-color" name="content" id="content" maxlength="250">${pd.content}</textarea>
					</div>
				</div>
			</div>
		</div>


		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline"style="display: block;float: left;">
					<label class="form-label "><span class="red-star">*</span>参与人数</label>
					<div class="layui-input-block ">
						<input name="people_num" id="people_num" value="${pd.people_num}" type="number" maxlength="10" style="width: 10rem;"	class="layui-input layui-input-color">
					</div>
					<span class="layui-form-unit"></span>
				</div>
				<div class="form-item-inline" style="display: block;float: left;">
					<label class="form-label">活动文件</label>
					<c:choose>
						<c:when test="${pd.type==1}">
							<div class="layui-input-block ">
								<a style="color: #666;" href="<%=basePath%>attachment/fileDownload.do?fileName=${pd.file_url}&filePath=${pd.filePath}">${pd.file_url}<br></a>
							</div>
							<input type="text" name="file_url" value="${pd.file_url}" hidden>
						</c:when>
						<c:otherwise>
							<div class="layui-input-block ">
								<div class="text-tip " style=" position:absolute;text-align: center;top: 6px;width: auto;">
									<div class="file-btn"  >
										选择文件
									</div>
									<div class="file-text">
										<c:choose>
										<c:when test="${not empty pd.file_url}">
												<a style="color: #00b3ee" href="<%=basePath%>attachment/fileDownload.do?fileName=${pd.file_url}&filePath=${pd.filePath}">${pd.file_url}<br></a>
												<input type="text" name="file_url" value="${pd.file_url}" hidden>
										</c:when>
										<c:otherwise>
										未选择文件
										</c:otherwise>
										</c:choose>
									</div>
								</div>
								<input type="file" name="activityFile" id="activityFile" style="position: absolute;top: 6px;height: 2rem;width: 8rem;cursor: pointer;opacity: 0">
							</div>
						</c:otherwise>
					</c:choose>

					</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline" id="apply_start_time_div">
					<label class="form-label"><span class="red-star">*</span>报名时间</label>
					<div class="layui-input-block ">
						<input type="hidden" name="apply_start_time" id="startTime">
						<input type="hidden" name="apply_end_time" id="endTime">
						<input type="text" <c:if test="${pd.apply_start_time !=null}">value="${pd.apply_start_time }~${pd.apply_end_time }"</c:if> name="" id="apply_start_time" required lay-verify="required" placeholder="请输入报名时间"
							   autocomplete="off"
							   class="layui-input layui-input-color">
					</div>
				</div>

				<div class="form-item-inline" id="activity_start_time_div">
					<label class="form-label "><span class="red-star">*</span>活动时间</label>
					<div class="layui-input-block ">
						<input type="hidden" name="activity_start_time" id="activity_startTime">
						<input type="hidden" name="activity_end_time" id="activity_endTime">
						<input type="text"<c:if test="${pd.activity_start_time !=null}"> value="${pd.activity_start_time }~${pd.activity_start_time }"</c:if>name="" id="activity_start_time" required lay-verify="required" placeholder="请输入活动时间"
							   autocomplete="off"
							   class="layui-input layui-input-color">
					</div>
				</div>


			</div>
		</div>


		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label title-max"><span>活动负责</span><span>人清单</span></label>
				</div>
				<div class="btnbox form-item-inline" style="text-align: right">
					<div id="addList"  class="layui-btn layui-btn-primary layui-btn-small">新增一行</div>
				</div>
			</div>
		</div>

		<table class="layui-table center "  id="sonTable" style="margin-left: 1.5%; width: 98.5%;">

			<thead>
			<tr style="background-color: #f3f8ff;">
				<th class="center" style="width: 50px;">序号</th>
				<th class='center'>姓名</th>
				<th class='center'>手机号码</th>
				<th class='center' >负责内容描述</th>
				<th class='center' style="width: 150px;border-left: 1px solid #dce3eb;">操作</th>
			</tr>
			</thead>
			<tbody id="respTb">
				<c:choose>
					<c:when test="${not empty leaders}">
						<c:forEach items="${leaders}" var="var" varStatus="vs">
							<tr>
								<td class="td_center">${vs.index+1 }</td>
								<td><input id='leader_name' name='leader_name'  type='text' maxlength="50" value="${var.leader_name}"></td>
								<td><input type='text' id='leader_tel' name='leader_tel'  maxlength="50" value="${var.tel}"></td>
								<td><input type='text' id='resp_content' name='resp_content' maxlength="200" value="${var.resp_content}"></td>

								<td style="text-align: center;" >
									<c:if test="${vs.index != 0 }">
										<a class="table-btn shanchu-btn del" data_id="${var.id }">
											删除
										</a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td class="td_center">1</td>
							<td><input id='leader_name' name='leader_name' maxlength="50" placeholder="请输入姓名" style="border: 0px;text-align: center" type='text' value=""></td>
							<td><input type='text' id='leader_tel' name='leader_tel' placeholder="请输入手机号" style="border: 0px;text-align: center" maxlength="50" value=""></td>
							<td><input type='text' id='resp_content' name='resp_content' placeholder="请输入负责内容" style="border: 0px;text-align: center" maxlength="200" value=""></td>
							<td></td>
						</tr>
					</c:otherwise>
				</c:choose>

			</tbody>
		</table>

	</form>

	<div class="btnbox" >
		<c:if test="${pd.type=='0'}">
			<button id="go_publish" is_pub="1" class="layui-btn layui-btn-publish layui-btn-small">发布</button>
			<button id="sure" is_pub="0" class="layui-btn layui-btn-primary layui-btn-small">存为草稿</button>
		</c:if>
		<button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
	</div>
</div>

<div id="publish" style="display: none" class="edit_menu">
	<form action="${msg}.do" class="layui-form" id="editForm1" enctype="multipart/form-data" lay-filter="editForm" method="post">
		<div class="layui-form-item">
			<div class="form-item-inline">
				<label class="layui-form-label" >目标对象</label>
				<div class="layui-input-block " style="float: left;width: 14rem;">
					<select lay-verify="">
						<option value="">请选择</option>
						<option value="0">所有人</option>
						<option value="1">所有老师</option>
						<option value="2">所有学员</option>
						<option value="3">校区</option>
						<option value="4">班级</option>
						<option value="5">人员</option>
					</select>
				</div>
			</div>
			<div class="form-item-inline">
				<label class="layui-form-label" >对象</label>
				<div class="layui-input-block " style="float: left;width: 14rem;">
					<input type="text" name="publishObj" id="publishObj" required lay-verify="required"
						   autocomplete="off"
						   class="layui-input layui-input-color">
				</div>
			</div>
		</div>

	</form>
    <div style="margin-left: 1.5%;display: none" id="school-show" class="layui-col-sm12">

		<div class="operationBox">
			<form action="list.do" method="post" class="layui-form" name="FormSchool" id="FormSchool" style="margin: 20px 0;">
				<div class=" fl" >
					<input value="${pd.keywords }"  id="schoolwords" name="keywords"   type="text" placeholder="请输入学校名称" class="layui-input fl search layui-input-color">

				</div>
				<div class="fl srarchBtn" onclick="gsearchSchool()">
					<i class="iconfont icon-sousuo"></i>
					<span>搜索</span>
				</div>
			</form>
		</div>
		<table class="layui-table center" id="schoolTable">
			<colgroup>
				<col width="80">
				<col>
				<col>
				<col>
				<col width="170">
			</colgroup>
			<thead>
			<tr class="table-head-tr">
				<th>
					<input type="checkbox" id="all-school">
				</th>
				<th>序号</th>
				<th>学校名称</th>
			</tr>
			</thead>
			<tbody class="school-list">

			</tbody>
		</table>
		<div class="laypageBox">
			<div id="laypage-school" class="fr"></div>
		</div>

    </div>

	<div style="margin-left: 1.5%;display: none" id="class-stu" class="layui-col-sm12">
		<div class="operationBox">
		<form action="list.do" method="post" class="layui-form" name="FormClass" id="FormClass" style="margin: 20px 0;">
			<div class=" fl" >
				<input value="${pd.keywords }"  id="classwords" name="keywords"   type="text" placeholder="请输入班级" class="layui-input fl search layui-input-color">

			</div>
			<div class="fl srarchBtn" onclick="gsearchClass()">
				<i class="iconfont icon-sousuo"></i>
				<span>搜索</span>
			</div>
		</form>
		</div>
		<table class="layui-table center" id="table">
			<colgroup>
				<col width="80">
				<col>
				<col>
				<col>
				<col width="170">
			</colgroup>
			<thead>
			<tr class="table-head-tr">
				<th>
					<input type="checkbox" id="all-class">
				</th>
				<th>序号</th>
				<th>班级名称</th>
				<th>对应课程</th>
			</tr>
			</thead>
			<tbody class="class-list">

			</tbody>
		</table>
		<div class="laypageBox">
			<div id="laypage" class="fr"></div>
		</div>
	</div>


	<div style="margin-left: 1.5%;display: none" id="stu-list" class="layui-col-sm12">
		<div class="operationBox">
		<form action="list.do" method="post" class="layui-form" name="FormStu" id="FormStu"style="margin: 20px 0;">
			<div class=" fl" >
				<input value="${pd.keywords }"  id="stuwords" name="stuwords"   type="text" placeholder="请输入名字" class="layui-input fl search layui-input-color">

			</div>
			<div class="fl srarchBtn" onclick="gsearchStu()">
				<i class="iconfont icon-sousuo"></i>
				<span>搜索</span>
			</div>
		</form>
		</div>
		<table class="layui-table center" id="stu-table">
			<colgroup>
				<col width="80">
				<col>
				<col>
				<col>
				<col width="170">
			</colgroup>
			<thead>
			<tr class="table-head-tr">
				<th>
					<input type="checkbox" id="all-checked">
				</th>
				<th>序号</th>
				<th>姓名</th>
				<th>身份证号</th>
				<th>类型</th>
			</tr>
			</thead>
			<tbody class="stu-list">

			</tbody>
		</table>
		<div class="laypageBox">
			<div id="laypage-stu" class="fr"></div>
		</div>
	</div>

	<div class="btnbox" id="sonBtn">
		<button id="sonSure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
		<button id="sonCancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
	</div>


</div>
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript">


        var form = layui.form;

        var type = '${pd.type}';
        if('${pd.file_url}'==''&& type==1){
            $(".isShow").hide()
        }else{
            $(".isShow").show()
        }
        $.myType(type);
        $("#addList").on("click",function () {
            var num = parseInt($("#sonTable tr:last td:first").text())+1;
            var html="";
            html+="<tr><td class='td_center'>"+num+"</td><td><input id='leader_name' name='leader_name' placeholder='请输入姓名' style='border: 0px;text-align: center' maxlength='50' type='text'></td>"+
                "<td><input type='text' id='leader_tel' name='leader_tel' placeholder='请输入手机号' style='border: 0px;text-align: center' maxlength='50'></td>"+
                "<td><input type='text' id='resp_content' name='resp_content' placeholder='请输入负责内容' style='border: 0px;text-align: center' maxlength='200'></td>"+
                "<td><a class='table-btn shanchu-btn del'>删除</a></td>";
            $("#sonTable tbody").append(html);
        })
		$(document).on("click","#sonTable .del",function(){
			$(this).parent().parent().remove();
            var num = $("#respTb tr").length;     //获取tr的长度

            for (var i = 0; i <= num; i++) {         //进行循环
                $("#respTb tr .td_center").eq(i).html(i + 1);
            }
		})
        $(document).ready(function(){
            layui.use('laydate', function () {
                var laydate = layui.laydate;

                //执行一个laydate实例
                laydate.render({
                    elem: '#activity_start_time' //指定元素
					,range: '~'
            	});

                laydate.render({
                    elem: '#apply_start_time' //指定元素
					,range: '~'
                });

            });

            $("#sure,#go_publish").on("click",function(){
                var apply=$("#apply_start_time").val().split("~");
                $("#startTime").val(apply[0].replace(/(^\s*)|(\s*$)/g, ""))
                $("#endTime").val(apply[1].replace(/(^\s*)|(\s*$)/g, ""))
                var activity=$("#activity_start_time").val().split("~");
                $("#activity_startTime").val(activity[0].replace(/(^\s*)|(\s*$)/g, ""))
                $("#activity_endTime").val(activity[1].replace(/(^\s*)|(\s*$)/g, ""))


                if ($("#name").val() == ""||$().val("#name").length>50) {
                    layer.tips('请输入活动名称',  $("#name"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#name").focus();
                    return false;
                }
                if ($("#activity_location").val() == "") {
                    layer.tips('请输入活动地点',  $("#activity_location"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#activity_location").focus();
                    return false;
                }
                if ($("#content").val() == "") {
                    layer.tips('请输入活动内容描述',  $("#content"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#content").focus();
                    return false;
                }
                if ($("#people_num").val() == "") {
                    layer.tips('请输入活动参与人数',  $("#people_num"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#people_num").focus();
                    return false;
                }
                var activity_start_time = $("#activity_startTime").val();
                if (activity_start_time == "") {
                    layer.tips('请选择活动开始时间',  $("#activity_start_time_div"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#activity_start_time").focus();
                    return false;
                }
                var activity_end_time = $("#activity_endTime").val();
                if (activity_end_time == "") {
                    layer.tips('请选择活动结束时间',  $("#activity_start_time_div"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#activity_start_time").focus();
                    return false;
                }
				if ($.compareDate(activity_start_time,activity_end_time)){
                    layer.tips('活动开始时间必须在结束时间之前',  $("#activity_start_time_div"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#activity_start_time").focus();
                    return false;
				}

                var apply_start_time = $("#startTime").val();
                if (apply_start_time == "") {
                    layer.tips('请选择报名时间',  $("#apply_start_time_div"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#apply_start_time").focus();
                    return false;
                }
                var apply_end_time = $("#endTime").val();
                if ($("#apply_end_time").val() == "") {
                    layer.tips('请选择报名结束时间',  $("#apply_start_time_div"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#apply_start_time").focus();
                    return false;
                }

                if ($.compareDate(apply_start_time,activity_start_time)){
                    layer.tips('活动报名时间必须在活动开始时间之前',  $("#apply_start_time_div"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#apply_end_time_div").focus();
                    return false;
                }
                if ($.compareDate(apply_start_time,apply_end_time)){
                    layer.tips('活动报名开始时间必须在报名结束时间之前',  $("#apply_end_time_div"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#apply_end_time").focus();
                    return false;
                }

                // 遍历验证负责人信息
				var leaderNameRes = true;
				$("input[name = 'leader_name']").each(function () {
                    if ($(this).val() == "") {
                        leaderNameRes = false;
                        return;
                    }
                })
                if (!leaderNameRes) {
                    layer.tips('请输入负责人姓名',  $("#leader_name"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#leader_name").focus();
                    return false;
                }
                // 遍历验证负责人手机号码
				var leaderTelRes = true;
				$("input[name = 'leader_tel']").each(function () {
                    var tel = $(this).val();
                    if (tel == "" || !$.isPoneAvailable(tel) || !$.isPoneAvailable(tel)) {
                        leaderTelRes = false;
                        return;
                    }
                })
                if (!leaderTelRes) {
                    layer.tips('请输入正确手机号码',  $("#leader_tel"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#leader_tel").focus();
                    return false;
                }
                // 遍历验证负责人负责内容
				var leaderNameCont = true;
				$("input[name = 'resp_content']").each(function () {
                    if ($(this).val() == "") {
                        leaderNameCont = false;
                        return;
                    }
                })
                if (!leaderNameCont) {
                    layer.tips('请输入负责人负责内容',  $("#resp_content"), {
                        tips: [4, '#D16E6C'],
                        time: 4000
                    });
                    $("#resp_content").focus();
                    return false;
                }

                var page ="${pd.currentPage}";
                var sum ="&keywords=${pd.keywords}";
                var is_pub =  $(this).attr("is_pub");

                $("#form1").ajaxSubmit({
                    type: 'post',
                    dataType:"html",
					data:{'status':is_pub},
                    success: function(data) {
                        var jso = JSON.parse(data);
                        if ("success" == jso.msg) {
                            parent.layer.transmit.location.href = "<%=basePath%>activity/list.do?currentPage=" + page + sum;
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

        $("#publish_range,#btn-publish").on("click", function () {
            var layer = layui.layer;
            $("#publish").css("display","block")
            layer.open({
                title:"选择发布",
                type: 1,
                content: $("#publish"),
                area: ["600px", "500px"],
                cancel: function(index, layero){
                    $("#publish").css("display","none")
                }

            })
        });

        function eventBind() {
            $("#publish dd").on("click",function(){
                var str=$(this).text();
                $("#target").val(str);
                $("#publish_range").val(str);
                $(".school-list").html("");
                $(".class-list").html("");
                $(".stu-list").html("")
                $("#publishObj").val(str);
                if(str=="班级"){
                    $("#class-stu").css("display","block");
                    $("#school-show").css("display","none");
                    $("#stu-list").css("display","none");
                    getClass()
                }else if(str=="校区"){
                    $("#school-show").css("display","block");
                    $("#class-stu").css("display","none");
                    $("#stu-list").css("display","none");
                    getShool()
                }else if(str=="人员"){
                    $("#stu-list").css("display","block")
                    $("#school-show").css("display","none");
                    $("#class-stu").css("display","none");
                    getStudent()
                }else{
                    $("#stu-list").css("display","none");
                    $("#school-show").css("display","none");
                    $("#class-stu").css("display","none");
                }
            })
            $("#sonCancel").on("click", function () {
                layer.closeAll();
                $("#publish").css("display","none")
            });
            $("#all-checked,#all-class,#all-school").click(function(){
                if(this.checked){
                    $(" :checkbox").prop("checked", true);
                }else{
                    $(" :checkbox").prop("checked", false);
                }
            });
            $("#sonSure").live("click",function () {
                var str='';
                var id='';
                // console.log($("input[name='checkbox'][checked]"))
                $("input[name='checkbox']").each(function(){
                    if($(this).is(":checked")){
                        if ($(this).attr("title")!=undefined){
                            str+=$(this).attr("title")+",";

                        }
                        if($(this).attr("data-id")!="undefined"){
                            id+=$(this).attr("data-id")+",";
                        }
                    }
                });
                id = id.split(",")[0];
                id = id.replace("/", ",");
                $("#selectId").val(id);
                if($("input[name='checkbox']").length>0){
                    $("#publish_range").val(str);
                }

                $("#publish").css("display","none")
                layer.closeAll();
            });
			$.myUploading("activityFile",200,150)
        }


        eventBind()
        function getClass(data) {
            $.ajax({
                url:"<%=basePath %>grades/findBySchool",
                type:"post",
                data:data,
                success:function(data){

                    if(JSON.stringify(data)!="{}"){
                        var classData=JSON.parse(data.data);
                        // console.log(classData)
                        var html="";
                        for (var i=0;i<classData.length;i++){
                            html+="<tr><td><input type='checkbox' data-id="+classData[i].user_id+"  name='checkbox' title="+classData[i].name+" lay-skin='school'/></td>"+
                                "<td>"+(i+1)+"</td>"+
                                "<td>"+classData[i].name+"</td>"+
                                "<td>"+classData[i].name+"</td></tr>"
                        }

                        $(".class-list").append(html);
                        layui.use('laypage', function(){
                            var laypage = layui.laypage;

                            //执行一个laypage实例
                            laypage.render({
                                elem: 'laypage' //注意，这里的 test1 是 ID，不用加 # 号
                                ,count: classData.length  //数据总数，从服务端得到
                            });
                        });
                    }
                }
            })
        }
        function getShool(data) {
            $.ajax({
                url:"<%=basePath %>school/findSchoolById",
                type:"post",
                data:data,
                success:function(data){

                    if (JSON.stringify(data)!="{}"){

                        var classData=JSON.parse(data.data);

                        var html="";
                        for (var i=0;i<classData.length;i++){
                            console.log(classData[i])
                            html+="<tr><td><input type='checkbox' data-id="+classData[i].user_id+"  name='checkbox' title="+classData[i].name+" lay-skin='school'/></td>"+
                                "<td>"+(i+1)+"</td>"+
                                "<td>"+classData[i].name+"</td></tr>"
                        }
						// html+="</form>"
                        $(".school-list").append(html);

                        layui.use('laypage', function(){
                            var laypage = layui.laypage;
                            laypage.render({
                                elem: 'laypage-school' //注意，这里的 test1 是 ID，不用加 # 号
                                ,count: classData.length //数据总数，从服务端得到
                            });
                        });
                    }
                }
            })
        }
        function getStudent(data) {

            $.ajax({
                url:"<%=basePath %>notice/findPersonBySid",
                type:"post",
                data:data,
				dataType:"json",
                success:function(data){
                    if(JSON.stringify(data)!="{}"){
                        var classData=JSON.parse(data.data)
                         console.log(classData)
                        var html="";
                        for (var i=0;i<classData.length;i++){
                            html+="<tr><td><input type='checkbox'  name='checkbox' title="+classData[i].name+" lay-skin='school'data-id="+classData[i].user_id+"></td>"+
                                "<td>"+(i+1)+"</td>"+
                                "<td>"+classData[i].name+"</td>"+
                                "<td>"+classData[i].sfz+"</td>"+
                                "<td>"+classData[i].type+"</td></tr>"
                        }

                        $(".stu-list").append(html);
                        layui.use('laypage', function(){
                            var laypage = layui.laypage;
                            laypage.render({
                                elem: 'laypage-stu' //注意，这里的 test1 是 ID，不用加 # 号
                                ,count: classData.length //数据总数，从服务端得到
                            });
                        });
                    }
                }
            })
        }

        function gsearchClass() {
            $(".class-list").html("");
            var keywords=$("#classwords").val()
            var data={"keywords":keywords}
            getClass(data);
        }
        function gsearchSchool() {
            $(".school-list").html("");
            var keywords=$("#schoolwords").val()
            var data={"keywords":keywords}
            getShool(data);
        }
        function gsearchStu() {
            $(".stu-list").html("")
            var keywords=$("#stuwords").val();
            var data={"keywords":keywords};
            getStudent(data);
        }

	</script>
</body>
</html>

