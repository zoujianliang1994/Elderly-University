﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>公告管理</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>
<div class="tableBox">
    <div class="operationBox">

        <form action="list.do" method="post" class="layui-form" name="Form" id="Form">
            <%--<div class=" fl ">--%>
                <%--<input type="hidden" name="selDepId" id="selDepId" value="${pd.selDepId}"/>--%>
                <%--<input type="hidden" name="xzqh_code" id="xzqh_code" value="${pd.xzqh_code}"/>--%>
                <%--<input type="hidden" name="selDepName" id="selDepName" value="${pd.selDepName}"/>--%>
                <%--<div class="sTree fl" id="sTree" style="width:200px">--%>
                <%--</div>--%>
                <%--&lt;%&ndash;<div class="fl srarchBtn">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<i class="layui-icon">&#xe715;</i>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
            <%--</div>--%>
                <div class="fl">
                    <input value="${pd.keywords }"  id="keywords" name="keywords"   type="text" placeholder="请输入公告名称" class="layui-input fl search layui-input-color">
                    </div>
                <div class="fl srarchBtn" onclick="gsearch()"> <i class="iconfont icon-sousuo"></i> <span>搜索</span>      </div>
        </form>

        <shiro:hasPermission name="edu:notice:add">
            <button class="add-btn" id="add">
                <i  class="iconfont icon-add"></i>
                <span>新增</span>
            </button>
        </shiro:hasPermission>
    </div>

    <!-- table -->
    <div class="layui-col-sm12">
        <table class="layui-table center" lay-skin="line" id="table">
            <colgroup>
                <col width="80">
                <col>
                <col>
                <col>
                <col width="170">
            </colgroup>
            <thead>
            <tr class="table-head-tr">
                <th>序号</th>
                <th>公告名称</th>
                <th>发布时间</th>
                <th>发布范围</th>
                <th class='table-left-line' style="width: 150px;border-left: 1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty noticeList}">

                    <shiro:hasPermission name="edu:notice:select">
                        <c:forEach items="${noticeList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.TITLE}</td>
                                <td>${var.CREATE_TIME}</td>
                                <td>${var.PUBLISH_RANGE}</td>
                                <td class="table-left-line" style="border-left: 1px solid #dce3eb; text-align: center;width: 200px;">
                                    <shiro:hasPermission name="edu:notice:select">
                                        <a class="table-btn chakan-btn " onclick="edit('${var.ID}','1');">
                                            查看
                                        </a>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="edu:notice:edit">
                                        <a class="table-btn bianji-btn edit" onclick="edit('${var.ID}','2');">
                                            编辑
                                        </a>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="edu:notice:del">
                                        <a class="table-btn shanchu-btn del" onclick="del('${var.ID}');">
                                            删除
                                        </a>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="edu:notice:select">
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
                    window.location.href = "<%=basePath%>notice/list.do?currentPage=" + obj.curr + '&keywords=' + '${keywords}';
                }
            }
        });
    });
    console.log(${pd.json})

    first = false;

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
            title: "新增",
            type: 2,
            content: '<%=basePath%>notice/goAdd.do?currentPage=' + ${page.currentPage},
            area: ["800px", "680px"]
        });
    });

    function edit(ID, TYPE) {
        var msg = TYPE == '1' ? '查看' : '编辑';
        var area = TYPE == '1' ? ["600px", "400px"] : ["800px", "550px"];
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>notice/goEdit.do?id=' + ID + '&currentPage=' + ${page.currentPage} +'&TYPE=' + TYPE,
            area: area
        });
    }

    function del(ID) {
        parent.parent.layer.confirm("是否删除此公告?", {
            btn: ['确定', '取消'],
            resize: false,
            title: "提示",
            maxWidth: 800
        }, function (index) {
            var url = "<%=basePath%>notice/delete.do?id=" + ID;
            $.get(url, function (data) {
                if ("success" == data.result) {
                    window.location.href = "<%=basePath%>notice/list.do?currentPage=${page.currentPage}";
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