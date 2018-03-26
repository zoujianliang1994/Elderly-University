﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>我的申请列表</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>

<div class="menu-list">

    <div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox layui-form">

        <form action="list.do" method="post" name="Form" id="Form" class="layui-form">

            <div class=" fl">
                <select lay-filter='school_id' id="school_id" name="school_id" class="layui-input-inline">
                    <option value="">请选择请假的学校</option>
                    <c:forEach var="var" items="${schoolList}" varStatus="vs">
                        <option value="${var.schoolId}" <c:if test="${var.schoolId==pd.school_id}"> selected="selected" </c:if>>${var.schoolName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class=" fl marL-20">
                <html:select id="qjlx" name="qjlx" classs="layui-input-inline" style=" lay-filter='qjlx'">
                    <html:options collection="QJ_TYPE" defaultValue="${pd.qjlx}"></html:options>
                </html:select>
            </div>

            <div class="fl srarchBtn" onclick="gsearch()">
                <i class="iconfont icon-sousuo"></i>
                <span>搜索</span>
            </div>

        </form>

        <div class="operationBox">
            <shiro:hasPermission name="edu_teacherApply_add">
                <button class="add-btn" id="add">
                    <i class="iconfont icon-add"></i>
                    <span>新增</span>
                </button>
            </shiro:hasPermission>
        </div>

        <table class="layui-table center " lay-skin="line" id="table">
            <thead>
            <tr style="background-color: #f3f8ff;">
                <th class="center" style="width: 30px;">序号</th>
                <th class='center'>申请时间</th>
                <th class='center'>请假类型</th>
                <th class='center'>所属学校</th>
                <th class='center' style="width: 150px;">开始时间</th>
                <th class='center' style="width: 150px;">结束时间</th>
                <th class='center'>状态</th>
                <th class='center' style="border-left: 1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                    <shiro:hasPermission name="edu:teacherApply:select">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td><fmt:formatDate value="${var.create_time}" pattern="yyyy-MM-dd"/></td>
                                <td><html:selectedValue collection="QJ_TYPE" defaultValue="${var.qjlx}"/></td>
                                <td>${var.school_name}</td>
                                <td>${var.begin_time}</td>
                                <td>${var.end_time}</td>

                                <c:if test="${var.zt == '0'}">
                                    <td>未审核</td>
                                </c:if>
                                <c:if test="${var.zt == '1'}">
                                    <td>审核通过</td>
                                </c:if>
                                <c:if test="${var.zt == '2'}">
                                    <td>退回</td>
                                </c:if>
                                <td style="width:60px; text-align: center;border-left: 1px solid #dce3eb;">
                                    <a class="table-btn chakan-btn edit" onclick="edit('${var.id}','1');">
                                        查看
                                    </a>

                                    <c:if test="${var.zt == '2'}">
                                        <a class="table-btn chakan-btn edit" onclick="edit('${var.id}','2');">
                                            修改
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="edu:teacherApply:select">
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

    layui.use('laypage', function () {
        var laypage = layui.laypage;
        var layer = layui.layer;

        //执行一个laypage实例
        laypage.render({
            elem: 'laypage',
            count: ${page.totalResult},
            curr: ${page.currentPage},
            layout: ['prev', 'page', 'next', 'count', 'skip'],
            jump: function (obj, first) {
                if (!first) {
                    window.location.href = "<%=basePath%>teacherApply/list.do?&currentPage=" + obj.curr;
                }
            }
        });
    });

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

    form.on('select(school_id)', function (data) {
            gsearch();
        }
    );

    form.on('select(qjlx)', function (data) {
            gsearch();
        }
    );

    //新增
    $("#add").on("click", function () {
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: "新增",
            type: 2,
            content: '<%=basePath%>teacherApply/goAdd.do?currentPage=' + ${page.currentPage},
            area: ["550px", "550px"]
        });
    });

    //操作
    function edit(id, type) {
        var msg = type == '1' ? '详情' : '编辑';
        var area = type == '1' ? ["550px", "500px"] : ["550px", "550px"]
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>teacherApply/goEditU.do?id=' + id + '&currentPage=${page.currentPage}' + '&type=' + type,
            area: area
        });
    }
</script>
</body>
</html>