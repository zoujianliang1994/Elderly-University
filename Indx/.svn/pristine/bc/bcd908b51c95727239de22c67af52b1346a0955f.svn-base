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
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<%@ include file="../index/headcss.jsp"%>
	<style>
		.layui-form-label{
			text-align:center
		}
	</style>
</head>
<body >
<div class="edit_menu" class="disnone">

	<form  class="layui-form"  id="form" >

		<input type="hidden" id="id" name="id" value="${areaCode.id}"/>
		<input type="hidden" id="pid" name="pid" value="${areaCode.parentId}"/>
		<c:if test="${type==0}">
		<div class="layui-form-item">
			<div class="layui-row">
				<label class="layui-form-label">上级：</label>
				<div class="layui-input-block">
					<div class="sTree " id="sTree" >

					</div>
					<input type="hidden" id="parent_code" name="parent_code"/>
					<input type="hidden" id="parent_id" name="parent_id"/>
					<input type="hidden" id="mergerName" name="mergerName"/>
				</div>
			</div>
		</div>
		</c:if>
		<div class="layui-form-item">
			<div class="layui-row">
				<label class="layui-form-label">名称：</label>
				<div class="layui-input-block">
					<input type="text" value="${areaCode.name}" name="name" id="name"  placeholder="请输入具体名称"
						   autocomplete="off" maxlength="32"
						   class="layui-input">
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<label class="layui-form-label">简称：</label>
				<div class="layui-input-block">
					<input type="text" value="${areaCode.shortName}" name="shortName"  placeholder="请输入简称"
						   autocomplete="off" maxlength="32"
						   class="layui-input">
				</div>
			</div>
		</div>
	<c:if test="${type==0}">
		<div class="layui-form-item">
			<div class="layui-row">
				<label class="layui-form-label">拼音：</label>
				<div class="layui-input-block">
					<input type="text" value="" name="pinyin"  placeholder="请输入拼音"
						   autocomplete="off" maxlength="32"
						   class="layui-input">
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<label class="layui-form-label">级别：</label>
				<div class="layui-input-block" name="level">
					<select  name="level">
						<option value="2">区/县</option>
						<option value="3">街/道</option>
						<option value="4">村/社区/居委会</option>
					</select>
				</div>
			</div>
		</div>
	</c:if>
	</form>
	<div class="btnbox" >
		<button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>

		<button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
	</div>
</div>


	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>

	<!--提示框-->
	<script type="text/javascript">



	$(document).ready(function(){
		var form= layui.form;
		//行政区划
        $.post("<%=basePath%>areaCode/listSubAreaCodeByParentId", {parentId: 0}, function (data) {
            var sTree = $.Stree({
                title: "${sysArea.name}",
                el: $("#sTree"),
                isSingle: true,  //单选
                data: data,
                callback: function (obj) {

                    console.log(this.arr)
                   if(this.arr){
                       $("#parent_id").val($.getString(this.arr, "id"));
                       $("#parent_code").val($.getString(this.arr, "areaCode"));
                       $("#mergerName").val($.getString(this.arr, "mergerName"));

				   }

                },
                switchCallback: function (obj) {
                    var id = obj.id;
                    if (obj.children == "") {
                        var options={
                            url:"<%=basePath%>areaCode/listSubAreaCodeByParentId",
							opt:{parentId: id},
							id:id,
							index:3
						}
                        this.addData(options)
                    }
                }
            });
            first = false;
        }, "json");

        $("#sure").on("click",function(){
            var mark= true;

			if(!mark){
                return
			}

            var data= $("form").serialize()
            $.post("<%=basePath%>areaCode/${msg}?"+data, function (data) {
                if ("success" == data.result) {
                    top.layer.msg("操作成功!",{icon:1})
					window.location.reload()
                } else if ("error" == data.result) {
                	top.layer.msg('系统异常,保存失败!', {icon: 5});
                } else if("false" == data.result){
                	top.layer.msg('相同拼音已存在!', {icon: 5});
                }
                console.log(data);
            })

		})

		$("#cancel").on("click",function(){
			parent.layer.closeAll();
		})
	});


	</script>
</body>
</html>

