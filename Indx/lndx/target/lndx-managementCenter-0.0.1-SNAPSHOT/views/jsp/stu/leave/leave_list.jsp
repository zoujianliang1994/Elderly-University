﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>请假管理</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>
<div class="tableBox">
    <div class="operationBox">

        <form action="list.do" method="post" class="layui-form" name="Form" id="Form">
                <div class=" fl">
                    <select lay-filter='school_id' id="school_id" name="school_id"  class="layui-input-inline"  >
                        <option value="">请选择请假的学校</option>
                        <c:forEach var="var" items="${pd.schIds}" varStatus="vs">
                            <option value="${var}" <c:if test="${pd.school_id eq var}">selected</c:if>>${pd.schNames[vs.count-1]}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class=" fl" style="padding-left: 10px">
                    <input type="text" name="create_time" id="create_time" value="${pd.create_time}" placeholder="请选择申请时间" class="layui-input layui-input-color">
                </div>

                <div class=" fl" style="padding-left: 10px">
                    <input value="${pd.keywords }"  id="keywords" name="keywords"   type="text" placeholder="请输入请假事由" class="layui-input fl search layui-input-color">
                    </div><div class="fl srarchBtn" onclick="gsearch()"> <i class="iconfont icon-sousuo"></i> <span>搜索</span>      </div>
        </form>

        <shiro:hasPermission name="stu:leave:add">
            <button class="add-btn" id="add">
                <i  class="iconfont icon-add"></i>
                <span>申请</span>
            </button>
        </shiro:hasPermission>
    </div>

    <!-- table -->
    <div class="layui-col-sm12">
        <table class="layui-table center"lay-skin="line" id="table">
            <colgroup>
                <col width="80">
                <col width="200">
                <col width="270">
                <col width="200">
                <col width="200">
                <col width="180">
                <col width="250">
                <col width="100">
            </colgroup>
            <thead>
            <tr class="table-head-tr">
                <th>序号</th>
                <th>申请时间</th>
                <th>请假学校</th>
                <th>开始时间</th>
                <th>结束时间</th>
                <th>抄送人</th>
                <th>请假事由</th>
                <th class='table-left-line' style="border-left: 1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty leaveList}">

                    <shiro:hasPermission name="stu:leave:select">
                        <c:forEach items="${leaveList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td><fmt:formatDate value="${var.create_time}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td>${var.school_name}</td>
                                <td>${var.start_time}</td>
                                <td>${var.end_time}</td>
                                <td>任课老师，班委，组长<%--${var.teacher_name}&nbsp;${var.monitor_name}&nbsp;${var.group_leader_name}--%></td>
                                <td>${var.reason}</td>
                                <td class="table-left-line" style="border-left: 1px solid #dce3eb; text-align: center;width: 200px;">
                                    <shiro:hasPermission name="stu:leave:select">
                                        <a class="table-btn chakan-btn " onclick="goDetail('${var.id}','1');">
                                            查看
                                        </a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="stu:leave:add">
                                        <c:if test="${var.state == '2'}">
                                            <a class="table-btn chakan-btn edit" onclick="goDetail('${var.id}','2');">
                                                修改
                                            </a>
                                        </c:if>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="stu:leave:select">
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
    var first = true;
    var form = layui.form;
    layui.use('laypage', function () {
        var laypage = layui.laypage;
        var layer = layui.layer;

        var editHtml = $("#editHtml").html();
        $("#editHtml").remove();

        form.on('select(sectionId)', function (data) {
            gsearch()
        });

        //执行一个laypage实例
        laypage.render({
            elem: 'laypage',
            count: ${page.totalResult},
            curr: ${page.currentPage},
            layout: ['prev', 'page', 'next', 'count', 'skip'],
            jump: function (obj, first) {
                if (!first) {
                    window.location.href = "<%=basePath%>student_leave/list.do?&currentPage=" + obj.curr + '&keywords=' + '${keywords}';
                }
            }
        });
    });

    first = false;

    layui.use('laydate', function () {
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#create_time' //指定元素
        });
    });

    $("#keywords").keydown(function (e) {
        var ev = e || window.event;
        if (ev.keyCode == "13") {
            gsearch();
        }
    });

    form.on('select(selectStatus)', function (data) {
            gsearch();
        }
    );

    //检索
    function gsearch() {
        $("#Form").submit();
    }

    //新增
    $("#add").on("click", function () {
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: "请假申请",
            type: 2,
            content: '<%=basePath%>student_leave/goAdd.do?currentPage=' + ${page.currentPage},
            area: ["500px", "550px"]
        });
    });

    // 查看详情
    function goDetail(id,type) {
        parent.parent.layer.edit = window;
        var msg = type == '1' ? '详情' : '编辑';
        var area = type == '1' ? ["550px", "400px"] : ["500px", "550px"];
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>student_leave/goDetail.do?id=' + id + '&currentPage=' + ${page.currentPage} + '&type=' + type,
            area: area
        });
    }

</script>
</body>
</html>