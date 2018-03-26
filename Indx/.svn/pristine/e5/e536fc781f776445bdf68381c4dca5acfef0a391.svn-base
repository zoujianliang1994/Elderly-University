<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>部门管理</title>
    <%@ include file="../index/headcss.jsp" %>
</head>
<body>
<div class="operationBox">

    <form action="list.do?areaCode=${areaCode}" method="post" name="Form" id="Form">
        <input type="hidden" name="SECTION_ID" id="SECTION_ID" value="${pd.SECTION_ID}"/>
        <div class="searchBox fl">
            <input id="keywords" name="keywords" type="text" value="${keywords}" placeholder="请输入内设机构名称" class="layui-input fl search">
            <div class="fl srarchBtn" onclick="gsearch()">
                <i class="layui-icon">&#xe615;</i>
            </div>
        </div>
    </form>

    <shiro:hasPermission name="system:section:add">
    <button class="layui-btn fl  marL-20 layui-btn-blue" id="add">新增</button>
    </shiro:hasPermission>
</div>

<!-- table -->
<div class="layui-col-sm12">
    <table class="layui-table center" id="table">
        <colgroup>
            <col width="60">
            <col>
            <col>
            <col>
            <col >
            <col>
            <col>
            <col width="170">
        </colgroup>
        <thead>
        <tr>
            <th>序号</th>
            <th>内设机构名称</th>
            <th>所在机构</th>
            <th>级别</th>
            <th>负责人</th>
            <th>联系电话</th>
            <th>人数</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty varList}">
                <shiro:hasPermission name="system:section:select">
                <c:forEach items="${varList}" var="var" varStatus="vs">
                    <tr>
                        <td>${vs.index+1}</td>
                        <td>${var.NAME}</td>
                        <td>${var.DEPARTMENT_NAME}</td>
                        <td>
                            <c:if test="${var.LEVEL == '1'}">副厅级</c:if>
                            <c:if test="${var.LEVEL == '2'}">正处级</c:if>
                            <c:if test="${var.LEVEL == '3'}">副处级</c:if>
                            <c:if test="${var.LEVEL == '4'}">正科级</c:if>
                            <c:if test="${var.LEVEL == '5'}">副科级</c:if>
                        </td>
                        <td>${var.FZR}</td>
                        <td>${var.TEL}</td>
                        <td>${var.RS}</td>
                        <td style="text-align: center;">
                            <shiro:hasPermission name="system:section:select">
                            	<a class="layui-btn layui-btn-mini layui-btn-normal" onclick="edit('${var.SECTION_ID}','1');">查看</a>
                            </shiro:hasPermission>

                            <shiro:hasPermission name="system:section:edit">
	                            <a class="layui-btn layui-btn-mini edit" onclick="edit('${var.SECTION_ID}','2');">编辑</a>
                            </shiro:hasPermission>

                            <shiro:hasPermission name="system:section:delete">
                            	<c:if test="${userName=='admin'||var.TBDW!='system'}">
	                            	<a class="layui-btn layui-btn-danger layui-btn-mini del" onclick="del('${var.SECTION_ID}');">删除</a></td>
	                            </c:if>
                            </shiro:hasPermission>
                        </td>
                    </tr>
                </c:forEach>
                </shiro:hasPermission>
                <shiro:lacksPermission name="system:section:select">
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
                    window.location.href = "<%=basePath%>section/list.do?currentPage=" + obj.curr + '&SECTION_ID=' + '${SECTION_ID}' + '&keywords=' + '${keywords}'+'&areaCode=${areaCode}';
                }
            }
        });
    });

    $("#keywords").keydown(function (e){
        var ev= e || window.event
        if (ev.keyCode == "13") {
            gsearch();
        }
    });

    //检索
    function gsearch() {
        $("#Form").submit();
    }



    //新增
    $("#add").on("click", function (e) {
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: "新增",
            type: 2,
            content: '<%=basePath%>section/goAdd.do?DEPARTMENT_ID=' + '${pd.DEPARTMENT_ID}' + '&currentPage=' + ${page.currentPage}+'&areaCode=${areaCode}',
            area: ["800px", "500px"]
        });
    });

    function edit(SECTION_ID, TYPE) {
        parent.parent.layer.edit = window;
        var msg = TYPE == '1' ? '查看' : '编辑';
        var area= TYPE == '1' ? ["600px","500px"] : ["800px", "500px"];
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>section/goEdit.do?SECTION_ID=' + SECTION_ID + '&DEPARTMENT_ID=' + '${pd.DEPARTMENT_ID}' + '&currentPage=' + ${page.currentPage} +'&TYPE=' + TYPE+'&areaCode=${areaCode}',
            area: area
        });
    }

    function del(SECTION_ID) {
        parent.parent.layer.confirm("是否删除此内设机构?", {
            btn: ['确定', '取消'],
            resize: false,
            title: "提示",
            maxWidth: 800
        }, function (index) {
            var url = "<%=basePath%>section/delete.do?SECTION_ID=" + SECTION_ID;
            $.get(url, function (data) {
                if ("success" == data.result) {
                    parent.location.href = "<%=basePath%>section/listAllDepartment.do?SECTION_ID=${SECTION_ID}&DEPARTMENT_ID=${pd.DEPARTMENT_ID}&currentPage=${page.currentPage}";
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