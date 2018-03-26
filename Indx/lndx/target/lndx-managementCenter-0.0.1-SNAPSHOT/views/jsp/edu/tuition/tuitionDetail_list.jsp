<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>收费详情列表</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>

<div class="menu-list">

    <div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox layui-form">

        <blockquote class="layui-elem-quote">
            学期：&nbsp;${pd.xq_name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            班级：&nbsp;${pd.bj_name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </blockquote>

        <table class="layui-table center " lay-skin="line" id="table">

            <thead>
            <tr style="background-color: #f3f8ff;">
                <th class="center" style="width: 50px;">序号</th>

                <c:if test="${pd.type_lx != '3'}">
                    <th class='center'>时间</th>
                </c:if>

                <th class='center'>学号</th>
                <th class='center'>学员名称</th>

                <c:if test="${pd.type_lx != '3'}">
                    <th class='center'>退费事件</th>
                </c:if>

                <c:if test="${pd.type_lx == '1'}">
                    <th class='center'>退费金额</th>
                </c:if>

                <c:if test="${pd.type_lx == '2'}">
                    <th class='center'>其它实收金额</th>
                </c:if>

                <c:if test="${pd.type_lx == '3'}">
                    <th class='center'>应收金额</th>
                    <th class='center'>实收金额</th>
                </c:if>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                    <shiro:hasPermission name="edu:tuitionFees:select">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>

                                <c:if test="${pd.type_lx != '3'}">
                                    <td>${var.event_time}</td>
                                </c:if>

                                <td>${var.xh}</td>
                                <td>${var.xm}</td>

                                <c:if test="${pd.type_lx != '3'}">
                                    <td><html:selectedValue collection="event_type" defaultValue="${var.event_type}"/></td>
                                </c:if>

                                <c:if test="${pd.type_lx == '1'}">
                                    <td>${var.tf}</td>
                                </c:if>

                                <c:if test="${pd.type_lx == '2'}">
                                    <td>${var.qtss}</td>
                                </c:if>

                                <c:if test="${pd.type_lx == '3'}">
                                    <td>${var.ys}</td>
                                    <td>${var.ss}</td>
                                </c:if>
                            </tr>
                        </c:forEach>

                        <tr style="color: red">
                            <td>合计</td>

                            <c:if test="${pd.type_lx != '3'}">
                                <td>---</td>
                            </c:if>

                            <td>---</td>
                            <td>---</td>

                            <c:if test="${pd.type_lx == '1'}">
                                <td>---</td>
                                <td>${pd.tf}</td>
                            </c:if>

                            <c:if test="${pd.type_lx == '2'}">
                                <td>---</td>
                                <td>${pd.qtss}</td>
                            </c:if>

                            <c:if test="${pd.type_lx == '3'}">
                                <td>${pd.ys}</td>
                                <td>${pd.ss}</td>
                            </c:if>

                        </tr>

                    </shiro:hasPermission>
                    <shiro:lacksPermission name="edu:tuitionFees:select">
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

        <div class="laypageBox">
            <div id="laypage" class="fr"></div>
        </div>

    </div>

</div>

<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
    $(function () {
    });
</script>
</body>
</html>