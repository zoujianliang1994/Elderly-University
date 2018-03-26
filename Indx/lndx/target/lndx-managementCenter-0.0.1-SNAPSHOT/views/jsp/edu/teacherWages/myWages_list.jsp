﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>我的工资列表</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>


<div class="menu-list">

    <div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox layui-form">

        <form action="myWagesList.do" method="post" name="Form" id="Form">

            <div class=" fl">
                <select lay-filter='school_id' id="school_id" name="school_id" class="layui-input-inline">
                    <option value="">请选择学校</option>
                    <c:forEach var="var" items="${schoolList}" varStatus="vs">
                        <option value="${var.schoolId}" <c:if test="${var.schoolId==pd.school_id}"> selected="selected" </c:if> >${var.schoolName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class=" fl marL-20">
                <input id="dy_month" name="dy_month" value="${pd.dy_month}" type="text" class="layui-input fl search layui-input-color"
                       placeholder="请选择月份">
            </div>

            <div class="fl srarchBtn" onclick="gsearch()">
                <i class="iconfont icon-sousuo"></i>
                <span>搜索</span>
            </div>

        </form>

        <div class="operationBox">

        </div>

        <table class="layui-table center " lay-skin="line" id="table">
            <thead>
            <tr style="background-color: #f3f8ff;">
                <th class="center" style="width: 100px;">月份</th>
                <th class='center'>所属学校</th>
                <th class='center'>应发薪资</th>
                <th class='center'>扣除薪资</th>
                <th class='center'>实发薪资</th>
                <th class='center' style="border-left: 1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                    <shiro:hasPermission name="edu:myWages:select">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td rowspan="${fn:length(var.list)+1}">${var.dy_month}</td>
                                <td style="display:none;"></td>
                                <td style="display:none;"></td>
                                <td style="display:none;"></td>
                                <td style="display:none;"></td>
                                <td style="display:none;"></td>
                            </tr>
                            <c:forEach items="${var.list}" var="listvar" varStatus="ls">
                                <tr>
                                    <td>${listvar.name}</td>
                                    <td>${listvar.yf_wages}</td>
                                    <td>${listvar.kf_wages}</td>
                                    <td>${listvar.sf_wages}</td>
                                    <td style="width: 200px; text-align: center;border-left: 1px solid #dce3eb;">
                                        <a class="table-btn chakan-btn edit" onclick="edit('${listvar.school_id}','${listvar.dy_month}');">
                                            查看
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                        <tr style="color: red">
                            <td>合计</td>
                            <td>---</td>
                            <td>${pd.yf}元</td>
                            <td>${pd.kf}元</td>
                            <td>${pd.sf}元</td>
                            <td>---</td>
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

        <div class="laypageBox">
            <div id="laypage" class="fr"></div>
        </div>
    </div>

</div>

<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
    var form = layui.form;
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#dy_month',
            type: 'month',
            done: function (value) {
                $("#dy_month").val(value);
                gsearch();
            }
        });
    });

    form.on('select(school_id)', function (data) {
            gsearch();
        }
    );

    //检索
    function gsearch() {
        $("#Form").submit();
    }

    $("#keywords").keydown(function (e) {
        var ev = e || window.event;
        if (ev.keyCode == "13") {
            gsearch();
        }
    });

    //操作
    function edit(school_id, dy_month) {
        var msg = '查看';
        var area = ["750px", "450px"];
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>teacherWages/myWagesDetail.do?school_id=' + school_id + '&dy_month=' + dy_month,
            area: area
        });
    }
</script>
</body>
</html>