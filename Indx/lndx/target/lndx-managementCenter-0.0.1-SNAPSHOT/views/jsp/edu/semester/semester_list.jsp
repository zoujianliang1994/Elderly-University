﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>学期管理</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>

<div class="tableBox">
    <div class="operationBox">

        <form action="list.do" method="post" class="layui-form" name="Form" id="Form">
            <div class=" fl ">
                <input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="请输入学期名称" class="layui-input fl search layui-input-color">

                </div><div class="fl srarchBtn" onclick="gsearch()"> <i class="iconfont icon-sousuo"></i> <span>搜索</span>      </div>
        </form>

        <shiro:hasPermission name="edu:semester:add">
            <button class="add-btn fl  marL-20 " id="add">
                <i  class="iconfont icon-add"></i>
                <span>新增</span>
            </button>

        </shiro:hasPermission>
    </div>

    <!-- table -->
    <div class="layui-col-sm12">
        <table class="layui-table center" lay-skin="line" id="table">
            <colgroup>
                <col>
                <col>
                <col>
                <col >
                <col>
                <col>
                <col>
                 <col>
                <col width="170">
            </colgroup>
            <thead>
            <tr class="table-head-tr">
                <th>序号</th>
                <th>名称</th>
                <th>限报课程总数</th>
                <th>报名时间</th>
                <th>学期时间</th>
                <th style="border-left: 1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                    <shiro:hasPermission name="edu:semester:select">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.name}</td>
                                <td>${var.limite_count}</td>
                                <td>${var.reg_start}~${var.reg_end}</td>
                                <td>${var.semester_start}~${var.semester_end}</td>

                                <td style="text-align: center;border-left: 1px solid #dce3eb;">
                                    <shiro:hasPermission name="edu:semester:detail">
                                        <a class="table-btn chakan-btn edit" onclick="edit('${var.id}','1');">
                                                <%--<i class="iconfont icon-chakan"title="查看"></i>--%>
                                            查看
                                        </a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="edu:semester:edit">
                                        <a class="table-btn bianji-btn edit" onclick="edit('${var.id}','2');">
                                                <%--<i class="iconfont icon-bianji"title="编辑"></i>--%>
                                            编辑
                                        </a>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="edu:semester:del">
                                        <a class="table-btn shanchu-btn del" onclick="del('${var.id}');">
                                                <%--<i class="iconfont icon-shanchu"title="删除"></i>--%>
                                            删除
                                        </a>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="edu:semester:select">
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
                    window.location.href = "<%=basePath%>semester/list.do?&currentPage=" + obj.curr + '&keywords=' + '${keywords}';
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
            content: '<%=basePath%>semester/goAdd.do?currentPage=' + ${page.currentPage},
            area: ["800px", "550px"]
        });
    });

    function edit(id, type) {
        var msg = type == '1' ? '查看' : '编辑';
        var area = type == '1' ? ["800px", "430px"] : ["800px", "550px"];
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>semester/goEdit.do?id=' + id + '&currentPage=${page.currentPage}'+'&type='+type,
            area: area
        });
    }

    function del(id) {
        parent.parent.layer.confirm("是否删除此学校?", {
            btn: ['确定', '取消'],
            resize: false,
            title: "提示",
            maxWidth: 800
        }, function (index) {
            var url = "<%=basePath%>semester/delete.do?id=" + id;
            $.get(url, function (data) {
                if ("success" == data.result) {
                    window.location.href = "<%=basePath%>semester/list.do?currentPage=${page.currentPage}";
                    parent.parent.layer.closeAll();
                } else if("error" == data.result){
                    parent.layer.msg('当前学校还有人员存在，不能删除!', {icon: 5});
                }else {
                    parent.layer.msg('系统异常,删除失败!', {icon: 5});
                }
            });
        });
    }

</script>
</body>
</html>