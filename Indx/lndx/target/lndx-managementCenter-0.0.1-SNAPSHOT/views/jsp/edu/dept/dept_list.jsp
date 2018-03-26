﻿    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>系别管理</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>


<div class="menu-list">

    <div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox">

        <form action="list.do" method="post" name="Form" id="Form" class="layui-form">

            <div class=" fl ">
                <input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="请输入系别名称"
                       class="layui-input fl search layui-input-color">

                </div><div class="fl srarchBtn" onclick="gsearch()"> <i class="iconfont icon-sousuo"></i> <span>搜索</span>      </div>
        </form>
        <div class="operationBox">
            <shiro:hasPermission name="edu:dept:add">
                <button class="add-btn" id="add">
                    <i class="iconfont icon-add"></i>
                    <span>新增</span>
                </button>
            </shiro:hasPermission>
        </div>


        <table class="layui-table center " lay-skin="line" id="table">

            <thead>
            <tr style="background-color: #f3f8ff;">
                <th class="center" style="width: 50px;">序号</th>
                <th class='center'>所属校区/教学点</th>
                <th class='center'>系别名称</th>
                <th class='center'>课程</th>
                <th class='center'>创建日期</th>
                <th class='center' style="width: 150px;border-left: 1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                    <shiro:hasPermission name="edu:dept:select">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.school_name}</td>
                                <td>${var.name}</td>

                                <td>
                                    <a onclick="view('${var.dept_id}','${var.school_id}');" style="color: #00b3ee;cursor:pointer;">${var.totalNum}</a>
                                </td>

                                <td>${var.createTime}</td>
                                <td style="width: 200px; text-align: center;border-left: 1px solid #dce3eb;">

                                    <a class="table-btn chakan-btn edit" onclick="edit('${var.dept_id}','1');">
                                        查看
                                    </a>

                                    <shiro:hasPermission name="edu:dept:edit">

                                        <a class="table-btn bianji-btn edit" onclick="edit('${var.dept_id}','2');">
                                            编辑
                                        </a>

                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="edu:dept:del">
                                        <a class="table-btn shanchu-btn del" onclick="del('${var.dept_id}');">
                                            删除
                                        </a>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="edu:dept:select">
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
                    window.location.href = "<%=basePath%>dept/list.do?&currentPage=" + obj.curr + '&keywords=' + '${pd.keywords}';
                }
            }
        });
    });

    $("#keywords").keydown(function (e) {
        var ev = e || window.event;
        if (ev.keyCode == "13") {
            gsearch();
        }
    });

    //检索
    function gsearch() {
        $("#Form").submit();
    }

    //新增
    $("#add").on("click", function () {
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: "新增",
            type: 2,
            content: '<%=basePath%>dept/goAdd.do?currentPage=' + ${page.currentPage},
            area: ["550px", "500px"]
        });
    });

    //操作
    function edit(dept_id, type) {
        var msg = type == '1' ? '详情' : '编辑';
        var area = type == '1' ? ["300px", "300px"] : ["550px", "500px"];
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>dept/goEditU.do?dept_id=' + dept_id + '&currentPage=${page.currentPage}' + '&type=' + type,
            area: area
        });
    }

    //课程列表
    function view(dept_id, school_id) {
        var msg = '课程列表';
        var area = ["550px", "600px"];
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>dept/goViewLesson.do?dept_id=' + dept_id + '&school_id=' + school_id,
            area: area
        });
    }

    //删除
    function del(dept_id) {
        parent.parent.layer.confirm("是否删除此系别?", {
            btn: ['确定', '取消'],
            resize: false,
            title: "提示",
            maxWidth: 800
        }, function (index) {
            var url = "<%=basePath%>dept/deleteU.do?dept_id=" + dept_id;
            $.get(url, function (data) {
                if ("success" == data.result) {
                    window.location.href = "<%=basePath%>dept/list.do?currentPage=${page.currentPage}";
                    parent.parent.layer.closeAll();
                } else {
                    layer.msg('系统异常,删除失败!', {icon: 5});
                }
            });
        });
    }

</script>
</body>
</html>