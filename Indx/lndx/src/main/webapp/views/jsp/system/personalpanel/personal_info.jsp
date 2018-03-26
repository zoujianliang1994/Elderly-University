<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
<title></title>
	<meta http-equiv="X-UA-Compatible" content="IE=11">
	<link rel="shortcut icon" href="${basePath}/static/source/public/images/32.png" type="image/x-icon" />
	<%@ include file="../index/headcss.jsp" %>
</head>
<body>
	<div class="wrap">
		<%--<%@ include file="../index/header.jsp"%>--%>

		<div class="contentBox" style="top: 0;">
			<%--<hr class="line" id="line"/>--%>
			<div class="menu" style="display: none" >

				<div id="menu" class="treeView"></div>
			</div>
			<div class="contentBody" style="left:0px;">
				<div class="layui-tab wh100" lay-allowClose="true" lay-filter="table">
					<ul class="layui-tab-title" id="layui-tab-title" style="display: none">

					</ul>
					<div class="layui-tab-content wh100">

					</div>
				</div>
			</div>
		</div>

	</div>

	<%@ include file="../index/foot.jsp"%>
	<script>

    $(function () {
        var element  = layui.element;

        var treeView = $.TreeView({
            el : $("#menu"),
            data : [{"id":"","title":"个人信息","level":"1","areaCode":"",url:"personalpanel/list.do?STATUS=0","hasNext":false,"children":[],"pid":""}],
            callback : function(obj) {
                addTab(obj.title,obj.url,obj)
            }
        });

        function addTab(title,url,obj){
            var mark = true; //tab是否已有
            if(url =="#"){
                return
            }
            var $title = $("#layui-tab-title").find("li");

            //如果以有跳转到
            $title.each(function () {
                if (url == $(this).attr("lay-id")) {
                    element.tabChange('table', url);
                    mark = false;
                    return false
                }
            });

            $(obj).parents(".itemBox").each(function(index){
                var calssArr=this.className.split(" ");
                if(calssArr.length>=2 && index >=2){
                    $("."+calssArr[1]).children(".treeItem").children(".title").css("color","#108ee9");
                    $("."+calssArr[1]).children(".treeItem").children(".icon-icon ").css("color","#108ee9")
                }
            });

            //table 已经有了刷新
            if (!mark) {
                var $iframe= $(".layui-tab .layui-show iframe");
                $iframe.attr("src",$iframe.attr("src"));
                return;
            }
            //新增
            element.tabAdd("table", {
                title: title
                , content: '<iframe src="<%=basePath%>'+url+'"  class="iframe"  frameBorder="0"></iframe>' //支持传入html
                , id: url
            });

            element.tabChange('table', url);
        }

        $(".avatar").removeClass("hide");
        $("#menu").find(".lev1 .title").click()
    });


    function logOut() {
        window.location.href = "<%=basePath%>logout";
    }



	</script>
</body>
</html>