<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>查看详情</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>

<div class="edit_menu" class="disnone">

    <blockquote class="layui-elem-quote">
        月份：&nbsp;${pd.dy_month}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </blockquote>

    <table class="layui-table center " lay-skin="line" id="table1">
        <thead>
        <tr style="background-color: #f3f8ff;">
            <th class='center'>学校名称</th>
            <th class='center'>班级名称</th>
            <th class='center'>应发薪资</th>
            <th class='center'>扣除薪资</th>
            <th class='center'>实发薪资</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty varList}">
                <shiro:hasPermission name="edu:myWages:select">
                    <c:forEach items="${varList}" var="var" varStatus="vs">
                        <tr>
                            <c:if test="${fn:length(var.list)!=0}">
                                <td rowspan="${fn:length(var.list)+1}">${var.name}</td>
                                <td style="display:none;"></td>
                                <td style="display:none;"></td>
                                <td style="display:none;"></td>
                                <td style="display:none;"></td>
                            </c:if>
                        </tr>
                        <c:forEach items="${var.list}" var="listvar" varStatus="ls">
                            <tr>
                                <td>${listvar.kc_name}</td>
                                <td>${listvar.yf}</td>
                                <td>${listvar.kf}</td>
                                <td>${listvar.sf}</td>
                            </tr>
                        </c:forEach>
                    </c:forEach>
                    <tr style="color: red">
                        <td>合计</td>
                        <td>---</td>
                        <td>${pd.yf}元</td>
                        <td>${pd.kf}元</td>
                        <td>${pd.sf}元</td>
                    </tr>
                </shiro:hasPermission>
                <shiro:lacksPermission name="edu:myWages:select">
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