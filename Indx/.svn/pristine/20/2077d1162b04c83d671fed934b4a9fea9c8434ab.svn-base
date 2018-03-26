<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>组织机构管理</title>
    <%@ include file="../index/headcss.jsp" %>
</head>
<body>
<div class="operationBox">

    <form action="list.do?areaCode=${areaCode}" method="post" name="Form" id="Form">
        <input type="hidden" name="DEPARTMENT_ID" id="DEPARTMENT_ID" value="${pd.DEPARTMENT_ID}"/>
        <div class="searchBox fl">
            <input id="keywords" name="keywords" type="text" value="${keywords}" placeholder="请输入机构名称" class="layui-input fl search">
            <div class="fl srarchBtn" onclick="gsearch()">
                <i class="layui-icon">&#xe615;</i>
            </div>
        </div>
    </form>
    <c:if test="${null != pd.DEPARTMENT_ID && pd.DEPARTMENT_ID != ''&& (pId != pd.DEPARTMENT_ID)}">
        <button class="layui-btn fl  marL-20 layui-btn-blue" id="add">新增</button>
    </c:if>

    <c:if test="${null != pd.DEPARTMENT_ID && pd.DEPARTMENT_ID != ''&& (pId != pd.DEPARTMENT_ID)}">
        <button class="layui-btn fl layui-btn-primary marL-20" id="return" onclick="refreshIfream('${pd.PARENT_ID}')">返回</button>
    </c:if>
</div>


<!-- table -->
<div class="layui-col-sm12">
    <table class="layui-table center" id="table">
        <colgroup>
            <col width="60">
            <col >
            <col >
            <col >
            <col >
            <col >
            <col >
            <col width="170">
        </colgroup>
        <thead>
        <tr>
            <th>序号</th>
            <th>所在区域</th>
            <th>机构名称</th>
            <th>机构级别</th>
            <th>机构性质</th>
            <th>领导职数</th>
            <th>编制人数</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty varList}">
                <shiro:hasPermission name="system:department:select">
                    <c:forEach items="${varList}" var="var" varStatus="vs">
                        <tr>
                            <td>${vs.index+1}</td>
                            <td>${var.SZQY}</td>
                            <td>
                                <a href="javascript:refreshIfream('${var.DEPARTMENT_ID }')" style="color: #0C64B5"> ${var.NAME}
                                </a>
                            </td>
                            <td>
                                <c:if test="${var.JGJB == '1'}">副厅级</c:if>
                                <c:if test="${var.JGJB == '2'}">正处级</c:if>
                                <c:if test="${var.JGJB == '3'}">副处级</c:if>
                                <c:if test="${var.JGJB == '4'}">正科级</c:if>
                                <c:if test="${var.JGJB == '5'}">副科级</c:if>
                            </td>
                            <td><c:if test="${var.JGXZ == '1'}">行政单位</c:if>
                                <c:if test="${var.JGXZ == '2'}">事业单位(参公)</c:if>
                                <c:if test="${var.JGXZ == '3'}">事业单位</c:if>
                            </td>

                            <td>${var.LDZS}</td>
                            <td>${var.BZRS}</td>
                            <td style="text-align: center;">
                                <shiro:hasPermission name="system:department:select">
                                    <a class="layui-btn layui-btn-mini layui-btn-normal" onclick="edit('${var.DEPARTMENT_ID}','1');">查看</a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="system:department:update">
                                    <a class="layui-btn layui-btn-mini edit" onclick="edit('${var.DEPARTMENT_ID}','2');">编辑</a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="system:department:delete">
                                <a class="layui-btn layui-btn-danger layui-btn-mini del" onclick="del('${var.DEPARTMENT_ID}');">删除</a></td>
                            </shiro:hasPermission>
                            </td>
                        </tr>
                    </c:forEach>
                </shiro:hasPermission>
                <shiro:lacksPermission name="system:department:select">
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

<%@ include file="../index/foot.jsp" %>
<script type="text/javascript">

    layui.use('laypage', function () {
        var laypage = layui.laypage;
        var layer = layui.layer;
        var form = layui.form;
        var editHtml = $("#editHtml").html();
        $("#editHtml").remove();

        //执行一个laypage实例
        laypage.render({
            elem: 'laypage',
            count: ${page.totalResult},
            curr: ${page.currentPage},
            layout: ['prev', 'page', 'next', 'count', 'skip'],
            jump: function (obj, first) {
                if (!first) {
                    window.location.href = "<%=basePath%>department/list.do?currentPage=" + obj.curr + '&DEPARTMENT_ID=' + '${DEPARTMENT_ID}' + '&keywords=' + '${keywords}'+'&areaCode=${areaCode}';
                }
            }
        });
    });

    $("#keywords").keydown(function (e) {
        var ev= e || window.event;
        if (ev.keyCode == "13") {
            gsearch();
        }
    });

    //检索
    function gsearch() {
        $("#Form").submit();
    }


    //下一级/返回
    function refreshIfream(DEPARTMENT_ID) {
        window.location.href = "<%=basePath%>department/list.do?DEPARTMENT_ID=" + DEPARTMENT_ID;
    }

    //新增
    $("#add").on("click", function () {
        parent.parent.layer.edit = parent;
        parent.parent.layer.open({
            title: "新增",
            type: 2,
            content: '<%=basePath%>department/goAdd.do?DEPARTMENT_ID=' + '${DEPARTMENT_ID}' + '&currentPage=' + ${page.currentPage},
            area: ["800px", "500px"]
        });
    });

    function edit(DEPARTMENT_ID, TYPE) {
        var msg = TYPE == '1' ? '查看' : '编辑';
        var area = TYPE == '1' ? ["600px","500px"] : ["800px", "500px"];
        parent.parent.layer.edit = parent;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>department/goEdit.do?DEPARTMENT_ID=' + DEPARTMENT_ID + '&currentPage=' + ${page.currentPage} +'&TYPE=' + TYPE,
            area: area
        });
    }

    function del(DEPARTMENT_ID) {
        parent.parent.layer.confirm("是否删除此组织机构?", {
            btn: ['确定', '取消'],
            resize: false,
            title: "提示",
            maxWidth: 800
        }, function (index) {
            var url = "<%=basePath%>department/delete.do?DEPARTMENT_ID=" + DEPARTMENT_ID;
            $.get(url, function (data) {
                if ("success" == data.result) {
                    parent.location.href = "<%=basePath%>department/listAllDepartment.do?DEPARTMENT_ID=${DEPARTMENT_ID}&currentPage=${page.currentPage}";
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