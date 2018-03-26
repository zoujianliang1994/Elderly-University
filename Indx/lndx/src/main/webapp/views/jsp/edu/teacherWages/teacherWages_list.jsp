﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>教师工资列表</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>


<div class="menu-list">

    <div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox layui-form">

        <form action="list.do" method="post" name="Form" id="Form" class="layui-form">

            <div class=" fl ">
                <input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="教师姓名、身份证号码" class="layui-input fl search layui-input-color">
            </div>

            <div class=" fl marL-20">
                <input id="dy_month" name="dy_month" value="${pd.dy_month}" type="text" class="layui-input fl search layui-input-color" placeholder="请选择月份">
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
                <th class='center'>月份</th>
                <th class='center'>姓名</th>
                <th class='center'>身份证号码</th>
                <th class='center'>上课总数(节)</th>
                <th class='center'>缺课总数(节)</th>
                <th class='center'>实发薪资(元)</th>
                <th class='center' style="width: 150px;border-left:1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                    <shiro:hasPermission name="edu:wage:select">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.dy_month}</td>
                                <td>${var.name}</td>
                                <td>${var.idcard}</td>
                                <td>${var.yjsk}</td>
                                <td>${var.qqks}</td>
                                <td>${var.sf_wages}</td>

                                <td style="width: 200px; text-align: center;border-left: 1px solid #dce3eb;">

                                    <a class="table-btn chakan-btn edit" onclick="edit('${var.id}','1');">
                                        明细
                                    </a>
                                    <shiro:hasPermission name="edu:wage:edit">
                                        <a class="table-btn bianji-btn edit" onclick="edit('${var.id}','2');">
                                            修改
                                        </a>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="edu:wage:send">
                                        <a class="table-btn bianji-btn edit" onclick="sendWages('${var.id}')">
                                            发送
                                        </a>
                                    </shiro:hasPermission>

                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="edu:wage:select">
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

    layui.use('laypage', function () {
        var laypage = layui.laypage;
        //执行一个laypage实例
        laypage.render({
            elem: 'laypage',
            count: ${page.totalResult},
            curr: ${page.currentPage},
            layout: ['prev', 'page', 'next', 'count', 'skip'],
            jump: function (obj, first) {
                if (!first) {
                    window.location.href = "<%=basePath%>teacherWages/list.do?&currentPage=" + obj.curr + '&keywords=' + '${pd.keywords}' + '&dy_month=' + '${pd.dy_month}';
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

    //操作
    function edit(id, type) {
        var msg = type == '1' ? '查看明细' : '修改';
        var area = type == '1' ? ["750px", "500px"] : ["750px", "500px"]
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>teacherWages/goEditU.do?id=' + id + '&currentPage=${page.currentPage}' + '&type=' + type,
            area: area
        });
    }

    //发送
    function sendWages(id) {
        parent.parent.layer.confirm("确认发送此工资条给教师?", {
            btn: ['确定', '取消'],
            resize: false,
            title: "提示",
            maxWidth: 800
        }, function (index) {
            var url = "<%=basePath%>teacherWages/sendWagesToTeacher.do?id=" + id;
            $.get(url, function (data) {
                if ("success" == data.result) {
                    window.location.href = "<%=basePath%>teacherWages/list.do?currentPage=1";
                    parent.parent.layer.closeAll();
                } else {
                    layer.msg('系统异常,发送失败!', {icon: 5});
                }
            });
        });
    }
</script>
</body>
</html>