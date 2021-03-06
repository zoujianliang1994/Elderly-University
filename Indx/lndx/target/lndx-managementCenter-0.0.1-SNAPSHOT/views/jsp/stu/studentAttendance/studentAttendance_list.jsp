﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>缺勤管理列表</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>

<div class="menu-list">

    <div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox layui-form">

        <form action="list.do" method="post" name="Form" id="Form" class="layui-form">

            <div class=" fl">
                <input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="请输入学员姓名" class="layui-input fl search layui-input-color">
            </div>

            <div class=" fl marL-20">
                <select lay-filter='state' id="state" name="state" class="layui-input-inline">
                    <option value="">请选择审核状态</option>
                    <option value="0" <c:if test="${var.state==0}"> selected="selected" </c:if> >未审核</option>
                    <option value="1" <c:if test="${var.state==1}"> selected="selected" </c:if> >通过</option>
                    <option value="2" <c:if test="${var.state==2}"> selected="selected" </c:if> >驳回</option>
            </select>
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
                <th class="center" style="width: 30px;">序号</th>
                <th class='center'>请假人</th>
                <th class='center'>请假开始时间</th>
                <th class='center'>请假结束时间</th>
                <th class='center'>请假天数(天)</th>
                <th class='center'>状态</th>
                <th class='center'>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                    <shiro:hasPermission name="edu:teacherAttendance:select">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.name}</td>
                                <td>${var.start_time}</td>
                                <td>${var.end_time}</td>
                                <td>${var.duration}</td>
                                <td>
                                <c:if test="${var.state == '0'}">
                                    未审核
                                </c:if>
                                <c:if test="${var.state == '1'}">
                                    通过
                                </c:if>
                                <c:if test="${var.state == '2'}">
                                    驳回
                                </c:if>
                                </td>
                                <td style="width:130px; text-align: center;border-left: 1px solid #dce3eb;">
                                    <a class="table-btn chakan-btn edit" onclick="edit('${var.id}','1');">
                                        查看
                                    </a>
                                    <shiro:hasPermission name="edu:stuLeave:check">
                                        <c:if test="${var.state == '0'}">
                                            <a class="table-btn chakan-btn edit" onclick="edit('${var.id}','3');">
                                                审核
                                            </a>
                                        </c:if>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="edu:stuLeave:select">
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
                    window.location.href = "<%=basePath%>teacherAttendance/list.do?&currentPage=" + obj.curr;
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

    //操作
    function edit(id, type) {
        var msg = type == '1' ? '详情' : '审核';
        var area = type == '1' ? ["550px", "500px"] : ["550px", "650px"]
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>studentAttendance/goEditU.do?id=' + id + '&currentPage=${page.currentPage}' + '&type=' + type,
            area: area
        });
    }
</script>
</body>
</html>