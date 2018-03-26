<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>

<div class="tableBox">
    <div class="operationBox">

        <form action="list.do" method="post" class="layui-form" name="Form" id="Form">
            <div class=" fl ">
                <input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="请输入文章名称" class="layui-input fl search layui-input-color">

                </div><div class="fl srarchBtn" onclick="gsearch()"> <i class="iconfont icon-sousuo"></i> <span>搜索</span>      </div>
        </form>

            <button class="add-btn fl  marL-20 " id="add">
                <i  class="iconfont icon-add"></i>
                <span>新增</span>
            </button>
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
                <th >序号</th>
                <th>文章名称</th>
                <th >状态</th>
                <th>所属目录</th>
                <th >最后更新时间</th>
                <th style="border-left: 1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.TITLE}</td>
                                <td>
                                    <c:if test="${var.STATUS=='0'}">隐藏</c:if>
                                    <c:if test="${var.STATUS!='0'}">显示</c:if>
                                </td>
                                <td>${var.FNAME}</td>
                                <td>${var.UPDATE_TIME}</td>

                                <td style="text-align: center;border-left: 1px solid #dce3eb;">
                                        <a class="table-btn chakan-btn edit" onclick="edit('${var.ARTICLE_ID}','1');">
                                                <%--<i class="iconfont icon-chakan"title="查看"></i>--%>
                                            查看
                                        </a>
                                        <a class="table-btn bianji-btn edit" onclick="edit('${var.ARTICLE_ID}','2');">
                                                <%--<i class="iconfont icon-bianji"title="编辑"></i>--%>
                                            编辑
                                        </a>

                                        <a class="table-btn shanchu-btn del" onclick="del('${var.ARTICLE_ID}');">
                                                <%--<i class="iconfont icon-shanchu"title="删除"></i>--%>
                                            删除
                                        </a>
                                </td>
                            </tr>
                        </c:forEach>
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
                    window.location.href = "<%=basePath%>manage/article/list.do?&currentPage=" + obj.curr + '&keywords=' + '${keywords}';
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
            content: '<%=basePath%>manage/article/goAdd.do?currentPage=' + ${page.currentPage}+'&type=1',
            area: ["700px", "500px"]
        });
    });

    function edit(id, type) {
        var msg = type == '1' ? '查看' : '编辑';
        var area = type == '1' ? ["600px", "400px"] : ["700px", "500px"];
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>manage/article/goEdit.do?ARTICLE_ID=' + id + '&currentPage=${page.currentPage}'+'&type='+type,
            area: area
        });
    }

    function del(id) {
        parent.parent.layer.confirm("是否删除此文章?", {
            btn: ['确定', '取消'],
            resize: false,
            title: "提示",
            maxWidth: 800
        }, function (index) {
            var url = "<%=basePath%>manage/article/delete.do?ARTICLE_ID=" + id;
            $.get(url, function (data) {
                if ("success" == data.result) {
                    window.location.href = "<%=basePath%>manage/article/list.do?currentPage=${page.currentPage}";
                    parent.parent.layer.closeAll();
                } else {
                    parent.layer.msg('系统异常,删除失败!', {icon: 5});
                }
            });
        });
    }

</script>
</body>
</html>