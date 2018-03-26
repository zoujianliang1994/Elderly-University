<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>月实发金额详情</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>

<div class="edit_menu" class="disnone">

    <blockquote class="layui-elem-quote">
        教师类别：&nbsp;<html:selectedValue collection="GWTYPE" defaultValue="${teacherPd.gw_type}"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        教师姓名：&nbsp;${teacherPd.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        身份证号：&nbsp;${teacherPd.idcard}
    </blockquote>

    <table class="layui-table center " lay-skin="line" id="table1">
        <thead>
        <tr style="background-color: #f3f8ff;">
            <th class="center" style="width: 50px;">序号</th>
            <th class='center'>对应月份</th>
            <th class='center'>班级名称</th>
            <th class='center'>应发金额(元)</th>
            <th class='center'>扣费(元)</th>
            <th class='center'>实发金额(元)</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty varList}">

                <shiro:hasPermission name="edu:financialWages:select">
                    <c:forEach items="${varList}" var="var" varStatus="vs">
                        <tr>
                            <td>${vs.index+1}</td>
                            <td>${var.dy_month}</td>
                            <td>${var.kc_name}</td>
                            <td>${var.yf}</td>
                            <td>${var.kf}</td>
                            <td>${var.sf}</td>
                        </tr>
                    </c:forEach>
                    <tr style="color: red">
                        <td>合计</td>
                        <td>---</td>
                        <td>---</td>
                        <td>${pd.month_yf}</td>
                        <td>${pd.month_kf}</td>
                        <td>${pd.month_sf}</td>
                    </tr>
                </shiro:hasPermission>
                <shiro:lacksPermission name="edu:financialWages:select">
                    <tr>
                        <td colspan="100" class="center">您无权查看</td>
                    </tr>
                </shiro:lacksPermission>
            </c:when>
            <c:otherwise>
                <tr class="main_info">
                    <td colspan="100" class="center">没有相关数据</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>

</div>
<%@ include file="../../system/index/foot.jsp" %>
<script>
    $(function () {
    });
</script>
</body>
</html>