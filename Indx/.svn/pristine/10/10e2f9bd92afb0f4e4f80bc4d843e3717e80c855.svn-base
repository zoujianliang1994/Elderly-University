<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>导入结果</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>
<div class="edit_menu">
    <blockquote class="layui-elem-quote">${msg}</blockquote>

    <div class="layui-tab">

        <ul class="layui-tab-title">
            <li class="layui-this">成功数据</li>
            <li>失败数据</li>
        </ul>

        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">

                <div class="layui-col-sm12">
                    <table class="layui-table center" id="tableSuc">
                        <colgroup>
                            <col width="150">
                            <col width="120">
                            <col>
                            <col>
                            <col>
                            <col width="150">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>行政区划</th>
                            <th>行政区划代码</th>
                            <th>行政区划类别</th>
                            <th>邮编</th>
                            <th>区号</th>
                            <th>上级行政区划代码</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty sucPageData}">
                                <c:forEach items="${sucPageData}" var="var" varStatus="vs">
                                    <tr>
                                        <td>${var.name}</td>
                                        <td>${var.areaCode}</td>
                                        <td>${var.level_code}</td>
                                        <td>${var.zipCode}</td>
                                        <td>${var.cityCode}</td>
                                        <td>${var.parentCode}</td>
                                    </tr>
                                </c:forEach>
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

            </div>
            <div class="layui-tab-item">


                <div class="layui-col-sm12 clth">
                    <table class="layui-table center" id="tableErr">

                        <colgroup>
                            <col width="150">
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col width="200">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>行政区划</th>
                            <th>行政区划代码</th>
                            <th>行政区划类别</th>
                            <th>邮编</th>
                            <th>区号</th>
                            <th>上级行政区划代码</th>
                            <th>错误原因</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty errPageData}">
                                <c:forEach items="${errPageData}" var="var" varStatus="vs">
                                    <tr>
                                        <td>${var.name}</td>
                                        <td>${var.areaCode}</td>
                                        <td>${var.level_code}</td>
                                        <td>${var.zipCode}</td>
                                        <td>${var.cityCode}</td>
                                        <td>${var.parentCode}</td>
                                        <td>${var.errMsg}</td>
                                    </tr>
                                </c:forEach>
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
                <button class="layui-btn fr layui-btn-primary  marT-10" id="dowload" style="margin-left: 16px;margin-bottom: 10px">导出</button>

            </div>
        </div>
    </div>
</div>

<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
    $(function () {
        parent.layer.closeAll('loading');
    });

    //导出
    $("#dowload").on("click", function () {
        var version = '${version}';
        if (version != null && "" != version) {
            window.location.href = '<%=basePath%>areaCode/exportAreaCode.do?version=' + version;
        } else {
            layer.tips('没有错误数据,无法导出!', $("#dowload"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
        }
    });
</script>
</body>
</html>