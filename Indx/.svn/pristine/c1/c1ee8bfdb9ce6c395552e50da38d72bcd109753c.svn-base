<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>学员管理</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>
<style>

</style>

<div class="tableBox">
    <div class="my-apply btn-right">
        我要报名
    </div>
    <div class="my-yet btn-left">
        查看已报班级
    </div>
    <!-- table -->
    <div class="layui-col-sm12">
        <table class="layui-table center" lay-skin="line" id="table">
            <colgroup>
                <col>
                <col>
                <col>
                <col width="100">
                <col>
                <col>
                <col>
                <col>
                <col width="170">
            </colgroup>
            <thead>
            <tr class="table-head-tr">
            		<th>序号</th>
                    <th>班级名称</th>
                    <th>所属学校</th>
                    <th>任课老师</th>
                    <th>教室</th>
                    <th>上课时间</th>
                    <th>人数</th>
                    <th>学费（元）</th>
                    <th>状态</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.g_name}</td>
                                <td>${var.school_name}</td>
                                <td>${var.teacher_name}</td>
                                <td>${var.classroom_name}</td>
                                <td>${var.course_time.replaceAll('!','<br>')}</td>
                                <td>${var.is_all}</td>
                                <td>${var.money}</td>
                                <td><c:if test="${var.money_status == 1 }">已缴费</c:if>
                                    <c:if test="${var.money_status == 2 }">未缴费</c:if>
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
        <p style="font-size: 14px;color:#999;">注：已缴费的班级如需退班，请自行联系所属学校解决。</p>
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

        //执行一个laypage实例
        laypage.render({
            elem: 'laypage',
            count: ${page.totalResult},
            curr: ${page.currentPage},
            layout: ['prev', 'page', 'next', 'count', 'skip'],
            jump: function (obj, first) {
                if (!first) {
                    window.location.href = "<%=basePath%>school/list.do?&currentPage=" + obj.curr + '&keywords=' + '${keywords}';
                }
            }
        });
    });
    $(".my-apply").on("click",function () {
        window.location.href = "<%=basePath%>studentEnroll/goGrades.do?checkin_type=${pd.checkin_type}&user_id=${pd.user_id}";
    })

</script>
</body>
</html>