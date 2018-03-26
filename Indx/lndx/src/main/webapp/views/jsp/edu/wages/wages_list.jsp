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

            <div class=" fl ">
                <input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="教师姓名、身份证号码"
                       class="layui-input fl search layui-input-color">
            </div>

            <div class=" fl marL-20">
                <input id="dy_month" name="dy_month" value="${pd.dy_month}" type="text" class="layui-input fl search layui-input-color">
            </div>

            <div class="fl srarchBtn" onclick="gsearch()">
                <i class="iconfont icon-sousuo"></i>
                <span>搜索</span>
            </div>

        </form>

        <div class="operationBox">

        </div>

        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this">单月工资</li>
                <li>全年工资</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <table class="layui-table center " lay-skin="line" id="table1">
                        <thead>
                        <tr style="background-color: #f3f8ff;">
                            <th class="center" style="width: 50px;">序号</th>
                            <th class='center'>当前月份</th>
                            <th class='center'>教师姓名</th>
                            <th class='center'>身份证号</th>
                            <th class='center'>教师类别</th>
                            <th class='center'>应发薪资(元)</th>
                            <th class='center'>扣发薪资（元）</th>
                            <th class='center'>实发薪资(元)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty dyList}">

                                <shiro:hasPermission name="edu:financialWages:select">
                                    <c:forEach items="${dyList}" var="var" varStatus="vs">
                                        <tr>
                                            <td>${vs.index+1}</td>
                                            <td>${pd.dy_month}</td>
                                            <td>${var.name}</td>
                                            <td>${var.idcard}</td>
                                            <td><html:selectedValue collection="GWTYPE" defaultValue="${var.gw_type}"/></td>
                                            <td>${var.yf_wages}</td>
                                            <td>${var.kf_wages}</td>
                                            <c:if test="${var.gw_type == '1'}">
                                                <td>${var.sf_wages}</td>
                                            </c:if>
                                            <c:if test="${var.gw_type == '2'}">
                                                <td><a onclick="edit('${var.teacher_id}','1')"
                                                       style="color: #00b3ee;cursor:pointer;">${var.sf_wages}</a>
                                                </td>
                                            </c:if>
                                        </tr>
                                    </c:forEach>
                                    <tr style="color: red">
                                        <td>合计</td>
                                        <td>---</td>
                                        <td>---</td>
                                        <td>---</td>
                                        <td>---</td>
                                        <td>${pd.d_yf}</td>
                                        <td>${pd.d_kf}</td>
                                        <td>${pd.d_sf}</td>
                                    </tr>
                                </shiro:hasPermission>
                                <shiro:lacksPermission name="edu:financialWages:select">
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
                <div class="layui-tab-item">
                    <table class="layui-table center " lay-skin="line" id="table2">
                        <thead>
                        <tr style="background-color: #f3f8ff;">
                            <th class="center" style="width: 50px;">序号</th>
                            <th class='center'>当前年份</th>
                            <th class='center'>教师姓名</th>
                            <th class='center'>身份证号</th>
                            <th class='center'>教师类别</th>
                            <th class='center'>应发薪资(元)</th>
                            <th class='center'>扣发薪资(元)</th>
                            <th class='center'>实发薪资(元)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty qnList}">
                                <shiro:hasPermission name="edu:financialWages:select">
                                    <c:forEach items="${qnList}" var="var" varStatus="vs">
                                        <tr>
                                            <td>${vs.index+1}</td>
                                            <td>${fn:substring(pd.dy_month, 0,4)}</td>
                                            <td>${var.name}</td>
                                            <td>${var.idcard}</td>
                                            <td><html:selectedValue collection="GWTYPE" defaultValue="${var.gw_type}"/></td>
                                            <td>${var.yf_wages}</td>
                                            <td>${var.kf_wages}</td>
                                            <c:if test="${var.gw_type == '1'}">
                                                <td>${var.sf_wages}</td>
                                            </c:if>
                                            <c:if test="${var.gw_type == '2'}">
                                                <td><a onclick="edit('${var.teacher_id}','2')"
                                                       style="color: #00b3ee;cursor:pointer;">${var.sf_wages}</a>
                                                </td>
                                            </c:if>
                                        </tr>
                                    </c:forEach>
                                    <tr style="color: red">
                                        <td>合计</td>
                                        <td>---</td>
                                        <td>---</td>
                                        <td>---</td>
                                        <td>---</td>
                                        <td>${pd.q_yf}</td>
                                        <td>${pd.q_kf}</td>
                                        <td>${pd.q_sf}</td>
                                    </tr>
                                </shiro:hasPermission>
                                <shiro:lacksPermission name="edu:financialWages:select">
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
        </div>
    </div>

</div>

<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">

    var form = layui.form;

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

    layui.use('element', function () {
        var element = layui.element;
        //一些事件监听
        element.on('tab(demo)', function (data) {
            var index = data.index;
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
    function edit(teacher_id, type) {
        var dy_month = $("#dy_month").val();
        var msg = type == '1' ? '月实发金额详情' : '年实发金额详情';
        var area = type == '1' ? ["750px", "450px"] : ["750px", "450px"]
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>wages/goEditU.do?teacher_id=' + teacher_id + '&type=' + type + '&dy_month=' + dy_month,
            area: area
        });
    }
</script>
</body>
</html>