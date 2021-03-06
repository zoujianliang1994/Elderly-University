﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>教学计划审核列表</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>


<div class="menu-list">

    <div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox layui-form">

        <form action="list.do?yw_type=1" method="post" name="Form" id="Form">

            <div class=" fl " style="width: 16rem;">
                <input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="教师姓名、班级名称、学期"
                       class="layui-input fl search layui-input-color">
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
                <th class="center" style="width: 50px;">序号</th>
                <th class='center'>班级名称</th>
                <th class='center'>教师姓名</th>
                <th class='center'>学期</th>
                <th class='center'>状态</th>
                <th class='center' style="width: 150px;border-left: 1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                    <shiro:hasPermission name="edu:teachPlan:select">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.grade_name}</td>
                                <td>${var.teacher_name}</td>
                                <td>${var.xq_name}</td>

                                <c:if test="${var.sh_type == '0'}">
                                    <td>草稿</td>
                                </c:if>
                                <c:if test="${var.sh_type == '1'}">
                                    <td>未审核</td>
                                </c:if>
                                <c:if test="${var.sh_type == '2'}">
                                    <td>审核通过</td>
                                </c:if>
                                <c:if test="${var.sh_type == '3'}">
                                    <td>退回</td>
                                </c:if>

                                <td style="width: 200px; text-align: center;border-left: 1px solid #dce3eb;">

                                    <a class="table-btn chakan-btn edit" onclick="edit('${var.id}','1');">
                                        查看
                                    </a>

                                    <c:if test="${var.sh_type == '1'}">
                                        <shiro:hasPermission name="edu:teachPlan:edit">

                                            <a class="table-btn bianji-btn edit" onclick="edit('${var.id}','3');">
                                                审核
                                            </a>
                                        </shiro:hasPermission>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="edu:teachPlan:select">
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
                    window.location.href = "<%=basePath%>teachPlan/list.do?yw_type=1&currentPage=" + obj.curr + '&keywords=' + '${pd.keywords}';
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

    form.on('select(sh_type)', function (data) {
            gsearch();
        }
    );

    //操作
    function edit(id, type) {
        var msg = type == '1' ? '详情' : '审核';
        var area = type == '1' ? ["750px", "550px"] : ["750px", "550px"]
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>teachPlan/goShEditU.do?id=' + id + '&currentPage=${page.currentPage}' + '&type=' + type,
            area: area
        });
    }
</script>
</body>
</html>