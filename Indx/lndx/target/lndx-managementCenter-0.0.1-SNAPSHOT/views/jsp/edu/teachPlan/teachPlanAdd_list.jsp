﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>教学计划新增列表</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>

<div class="menu-list">

    <div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox layui-form">

        <form action="list.do?yw_type=2" method="post" name="Form" id="Form">

            <div class=" fl ">
                <input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="班级名称、计划名称" class="layui-input fl search layui-input-color">
            </div>

            <div class=" fl marL-20">
                <select lay-filter='school_id' id="school_id" name="school_id" class="layui-input-inline">
                    <option value="">请选择所属学校</option>
                    <c:forEach var="var" items="${schoolList}" varStatus="vs">
                        <option value="${var.schoolId}" <c:if test="${var.schoolId==pd.school_id}"> selected="selected" </c:if> >${var.schoolName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="fl srarchBtn" onclick="gsearch()">
                <i class="iconfont icon-sousuo"></i>
                <span>搜索</span>
            </div>

        </form>

        <div class="operationBox">
            <button class="add-btn" id="add">
                <i class="iconfont icon-add"></i>
                <span>新增</span>
            </button>
        </div>

        <table class="layui-table center " lay-skin="line" id="table">
            <thead>
            <tr style="background-color: #f3f8ff;">
                <th class="center" style="width: 40px;">序号</th>
                <th class='center' style="width: 80px;">计划名称</th>
                <th class='center'>学期</th>
                <th class='center'>所属学校</th>
                <th class='center'>班级名称</th>
                <th class='center' style="width: 80px;">上传时间</th>
                <th class='center' style="width: 60px;">状态</th>
                <th class='center' style="border-left: 1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                    <shiro:hasPermission name="edu:teachPlanAdd:select">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.jh_name}</td>
                                <td>${var.xq_name}</td>
                                <td>${var.school_name}</td>
                                <td>${var.grade_name}</td>
                                <td>${var.create_time}</td>

                                <c:if test="${var.sh_type == '0'}">
                                    <td>草稿</td>
                                </c:if>
                                <c:if test="${var.sh_type == '1'}">
                                    <td>等待审核</td>
                                </c:if>
                                <c:if test="${var.sh_type == '2'}">
                                    <td>审核通过</td>
                                </c:if>
                                <c:if test="${var.sh_type == '3'}">
                                    <td>已驳回</td>
                                </c:if>

                                <td style="width: 200px; text-align: center;border-left: 1px solid #dce3eb;">

                                    <c:if test="${var.sh_type == '0'}">
                                        <a class="table-btn chakan-btn edit" onclick="edit('${var.id}','1');">
                                            提交
                                        </a>
                                    </c:if>

                                    <a class="table-btn bianji-btn edit" onclick="edit('${var.id}','2');">
                                        查看
                                    </a>

                                    <c:if test="${var.sh_type == '0' || var.sh_type == '3'}">
                                        <a class="table-btn bianji-btn edit" onclick="edit('${var.id}','3');">
                                            修改
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="edu:teachPlanAdd:select">
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
                    window.location.href = "<%=basePath%>teachPlan/list.do?yw_type=2&currentPage=" + obj.curr + '&keywords=' + '${pd.keywords}';
                }
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


    //新增
    $("#add").on("click", function () {
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: "新增",
            type: 2,
            content: '<%=basePath%>teachPlan/goAdd.do?currentPage=' + ${page.currentPage},
            area: ["750px", "550px"]
        });
    });

    //操作
    function edit(id, type) {
        var msg = "";
        if ("1" == type) {
            msg = "提交";
        } else if ("2" == type) {
            msg = "查看";
        } else {
            msg = "修改";
        }
        var area = ["750px", "550px"];
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>teachPlan/goEditU.do?id=' + id + '&currentPage=${page.currentPage}' + '&type=' + type,
            area: area
        });
    }

</script>
</body>
</html>