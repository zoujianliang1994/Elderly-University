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


</head>
<body >
<div class="edit_menu" class="disnone">
    <div style="text-align: center">
        <p style="color: #333333;font-size: 20px">${message.title}</p>
        <p style="color: #666666;font-size: 12px;padding-top: 10px">${message.publishTime}   ${pd.schoolName}</p>
        <div style="color: #666666;font-size: 14px;padding-top: 30px;text-indent: 2em;text-align: left;">${message.content}</div>
    </div>

</div>


<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp"%>
<!--提示框-->
<script type="text/javascript">


</script>
</body>
</html>

