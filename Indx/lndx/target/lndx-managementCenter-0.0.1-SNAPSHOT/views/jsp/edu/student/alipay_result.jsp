<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>支付结果</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>
<%@ include file="../../system/index/foot.jsp" %>

<script>
console.log("缴费完成！");
window.close();

</script>
</body>

</html>