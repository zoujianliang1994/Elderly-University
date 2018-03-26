<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>财务-工资管理列表</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>

<div class="menu-list">

    <div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox layui-form">

        <form action="list.do" method="post" name="Form" id="Form" class="layui-form">

            <div class=" fl">
                <select lay-filter='x_id' id="x_id" name="x_id" class="layui-input-inline">
                    <option value="">请选择学期</option>
                    <c:forEach var="var" items="${xqList}" varStatus="vs">
                        <option value="${var.x_id}" <c:if test="${var.x_id==pd.x_id}"> selected="selected" </c:if> >${var.x_name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class=" fl marL-20">
                <input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="输入班级名称"
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
                <th class='center'>学期</th>
                <th class='center'>班级</th>
                <th class='center'>退费</th>
                <th class='center'>其它实收</th>
                <th class='center'>应收金额</th>
                <th class='center'>实收金额</th>
                <th class='center' style="width:200px;border-left: 1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                    <shiro:hasPermission name="edu:tuitionFees:select">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.xq_name}</td>
                                <td>${var.bj_name}</td>
                                <td>${var.tf}</td>
                                <td>${var.qtss}</td>
                                <td>${var.ys}</td>
                                <td>${var.ss}</td>
                                <td style="width: 200px; text-align: center;border-left: 1px solid #dce3eb;">

                                    <c:if test="${var.tf != '0'}">
                                        <a class="table-btn chakan-btn edit" onclick="edit('${var.xq_id}','${var.bj_id}','1');">
                                            退费
                                        </a>
                                    </c:if>
                                    <c:if test="${var.tf == '0'}">
                                        <span>退费</span>
                                    </c:if>
                                    &nbsp;
                                    <c:if test="${var.qtss != '0'}">
                                        <a class="table-btn chakan-btn edit" onclick="edit('${var.xq_id}','${var.bj_id}','2');">
                                            其它实收
                                        </a>
                                    </c:if>
                                    <c:if test="${var.qtss == '0'}">
                                        <span>其它实收</span>
                                    </c:if>

                                    <a class="table-btn chakan-btn edit" onclick="edit('${var.xq_id}','${var.bj_id}','3');">
                                        实收
                                    </a>

                                </td>
                            </tr>

                        </c:forEach>
                        <tr style="color: red">
                            <td>合计</td>
                            <td>---</td>
                            <td>---</td>
                            <td>${pd.tf}</td>
                            <td>${pd.qtss}</td>
                            <td>${pd.ys}</td>
                            <td>${pd.ss}</td>
                            <td>---</td>
                        </tr>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="edu:tuitionFees:select">
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

    </div>

</div>

<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">

    var form = layui.form;

    //检索
    function gsearch() {
        $("#Form").submit();
    }

    form.on('select(x_id)', function (data) {
            gsearch();
        }
    );

    $("#keywords").keydown(function (e) {
        var ev = e || window.event;
        if (ev.keyCode == "13") {
            gsearch();
        }
    });

    //操作
    function edit(semester_id, grades_id, type_lx) {
        var msg = "";
        if ("1" == type_lx) {
            msg = "退费金额详情";
        } else if ("2" == type_lx) {
            msg = "其它实收详情";
        } else {
            msg = "实收详情";
        }
        var area = ["800px", "450px"];
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>tuitionFees/goEditU.do?semester_id=' + semester_id + '&grades_id=' + grades_id + '&type_lx=' + type_lx,
            area: area
        });
    }
</script>
</body>
</html>