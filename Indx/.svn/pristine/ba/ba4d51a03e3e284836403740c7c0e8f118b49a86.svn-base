<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<html>
<head>
    <title>导航</title>
    <meta http-equiv="X-UA-Compatible" content="IE=11">
    <link rel="shortcut icon" href="${basePath}/static/source/public/images/32.png" type="image/x-icon" />
    <%@ include file="./headcss.jsp"%>
</head>
<style>
    body{
        -webkit-user-select: none;
        user-select: none;
    }
    .messageBox {
        position:absolute;
        left:50%;
        top:200px;
        margin-left:-385px;
        z-index:1;
        width: 770px;
        height: 500px;
        line-height:50px;
        text-align:left
    }
    .fontBlack{
        font-size:50px;
        color:#5e5e5e;
        line-height:75px;
        letter-spacing:5px;
    }
    .fontBlue{
        text-align:center;
        font-size:28px;
        color:rgb(16, 142, 233);
        width:100%;
        z-index:1;
    }
    .fontRed{
        color:#FF5722
    }
    .button{
        padding:8px 20px;
        border-radius:5px;
        background:rgb(16, 142, 233);
        color:#fff;
        cursor: pointer;
    }
    .button:hover{
        color:#fff;
        opacity:0.8
    }
</style>
<body>
<div class="guide">
    <img class="guide-bg" src="<%=basePath%>static/source/public/images/downLoading.png"/>
    <div class="messageBox">
        <p class="fontBlack">sorry~</p>
        <p class="fontBlack" >您的浏览器暂不完全支持此系统</p>
        <p class="fontBlue " style="margin-top:30px">您当前使用的浏览器是<span id="edition"></span>&nbsp;&nbsp;为获取更流畅的体验</p>
        <p class="fontBlue" >推荐您下载<span class="fontRed">IE11</span>浏览器登陆</p>
        <p class="fontBlue marT-10" style="font-size:20px"><a  class="button" id="downLoad">立即下载</a>&nbsp;&nbsp;<a id="keepGoing" href="<%=basePath%>login_toLogin.do" class="button">继续进入</a></p>
    </div>

</div>


<%@ include file="./foot.jsp"%>
<script type="text/javascript">
    $(function(){
        $("#edition").text($.browserType())
        //判断浏览器32位  还是64位
        if($.getCPU() == "x64"){
        	$("#downLoad").attr("href","${ie64Path}");
           
        }else if($.getCPU() == "x86"){
        	$("#downLoad").attr("href","${ie32Path}");
        }

        if($.browserType().length>3){
            var num= parseInt($.browserType().substring(2,3));
            if(num < 8 && num >5){
                $("#keepGoing").hide();
            }
        }

    })
</script>

</body>
</html>