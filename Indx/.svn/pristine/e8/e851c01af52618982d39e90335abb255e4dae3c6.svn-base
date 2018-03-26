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
		.marT-60{
			margin-top:110px
		}
		.edit_menu{
			position:absolute;
			width:100%;
			height:100%;
			overflow:auto
		}
		.btnbox{
			position:absolute;
			right:20px;
			bottom:0;
		}
	</style>
</head>
<body >
<div class="edit_menu" class="disnone">

	<form  class="layui-form"  id="form" >


		<div class="layui-form-item">
			<div class="layui-row">
				<div class="layui-col-xs6">
					<label class="layui-form-label">原区域:</label>
					<div class="layui-input-block">
						<div class="sTree " id="sTree" >
						</div>
					</div>
                    <input type="hidden" id="mid" name="mid"/>
				</div>

				<div class="layui-col-xs6">
					<label class="layui-form-label">目标区域:</label>
					<div class="layui-input-block">
						<div class="sTree " id="sTree2" >

						</div>
						<input type="hidden" id="pid" name="pid"/>
					</div>
				</div>
			</div>
		</div>







	</form>
	<div class="btnbox " >
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
        var level= null;
        //行政区划
        $.post("<%=basePath%>areaCode/listSubAreaCodeByParentId", {parentId: 0}, function (data) {
            //迁移区域
            var sTree = $.Stree({
                el: $("#sTree"),
                data: data,
                iShow:true,
                callback: function (obj) {
                    if(obj.level <=2){
                        $("#sTree").find(".lev"+obj.lev).children(".treeItem").find(".item-cheaked").click();
                        layer.tips("省/市/区不允许迁移",$("#sTree"),{
                            tips: [3,"#FF5722"]
                        })
                        return
                    }
                    if(this.arr != "" && this.arr != "undefined"){
                        var lev= this.arr[0].level
                        if(level != lev){
                            console.log($("#sTree2 .active  > .item-cheaked"))
                            $("#sTree2 .lev1 >.treeItem >.item-cheaked").click();
						}
                        level= lev;
                    }

                    if(obj.level != level){
                        $("#sTree").find(".lev"+obj.lev).children(".treeItem").find(".item-cheaked").click();
                        layer.tips("必须选择同一级",$("#sTree"),{
                            tips: [3,"#FF5722"]
                        })
                        return
                    }
                  	$("#mid").val($.getString(this.arr, "id"))

                },
                switchCallback: function (obj) {
                    var id = obj.id;
                    if (obj.children == "") {
                        var options={
                            url:"<%=basePath%>areaCode/listSubAreaCodeByParentId",
                            opt:{parentId: id},
                            id:id
                        }
                        this.addData(options)
                    }
                }
            });

            $("#sTree .lev0").css("max-height",500)
            $("#sTree .lev1 > .treeItem > .item-switch").click()
        }, "json");
        //
        $.post("<%=basePath%>areaCode/listSubAreaCodeByParentId", {parentId: 0}, function (data) {
            //迁移区域
            var sTree2 = $.Stree({
                el: $("#sTree2"),
                data: data,
                isSingle:true,
				iShow:true,
                callback: function (obj) {
                    if(obj.level != level-1){
                        $("#sTree2").find(".lev"+obj.lev).children(".treeItem").removeClass("active")
                        layer.tips("必须迁入区域的上一级",$("#sTree2"),{
                            tips: [3,"#FF5722"]
                        })
                        this.arr= [];
                        return
                    }
                    $("#pid").val($.getString(this.arr, "id"))
                },
                switchCallback: function (obj) {
                    var id = obj.id;
                    if (obj.children == "") {
                        var options={
                            url:"<%=basePath%>areaCode/listSubAreaCodeByParentId",
                            opt:{parentId: id},
                            id:id
                        }
                        this.addData(options)
                    }
                }
            });
            $("#sTree2 .lev0").css("max-height",500)
            $("#sTree2 .lev1 > .treeItem > .item-switch").click()
        }, "json");


        $("#sure").on("click",function(){
            var mark= true;
            $("input").each(function(){
                if($(this).val() == ""){
                    layer.tips("不能为空",this,{
                        tips: [2,"#FF5722"]
                    })
                    mark= false
                    return false
                }
            })

            if(!mark){
                return
            }

            var data= $("form").serialize()
			layer.load(2)
            $.post("<%=basePath%>areaCode/move?"+data, function (data) {
				layer.close("loading")
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

