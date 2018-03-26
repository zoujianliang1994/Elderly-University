<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>请假详情</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>

<div class="edit_menu">
    <form action="" class="layui-form" id="editForm" enctype="multipart/form-data" lay-filter="editForm" method="post">
        <div class="layui-form-item">
            <div class="layui-row">

                <div>
                    <label class="form-label">请假学校:&nbsp;</label>
                   <div class="layui-input-block ">
                        <input readonly="readonly" type="text" value="${pd.school_name}" name="school_name" id="school_name" />
                    </div>

                </div>

            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-row">

                <div>
                    <label class="form-label">申请时间:&nbsp;</label>
                   <div class="layui-input-block ">
                        <input type="text" name="create_time" id="create_time" value="${pd.create_time}" required lay-verify="required"
                               autocomplete="off"
                               class="layui-input layui-input-color">
                    </div>

                </div>

            </div>
        </div>


        <div class="layui-form-item" id="mimaDiv">
            <div class="layui-row">

                <div>
                    <label class="form-label">开始时间:&nbsp;</label>
                   <div class="layui-input-block ">
                        <input type="text" name="start_time" id="start_time" value="${pd.start_time}" required lay-verify="required" placeholder="请输入开始时间"
                               autocomplete="off"
                               class="layui-input layui-input-color">
                    </div>
                </div>

            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div>
                    <label class="form-label">结束时间:&nbsp;</label>
                   <div class="layui-input-block ">
                        <input type="text" name="end_time" id="end_time" value="${pd.end_time}" required lay-verify="required" placeholder="请输入结束时间"
                               autocomplete="off"
                               class="layui-input layui-input-color">
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div>
                    <label class="form-label">抄送人:&nbsp;</label>
                   <div class="layui-input-block ">
                        <span>任课老师:${pd.teacher_name}&nbsp;班委:${pd.monitor_name}&nbsp;组长:${pd.group_leader_name}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">

            <div class="layui-row">
                <div>
                    <label class="form-label">请假事由:&nbsp;</label>
                   <div class="layui-input-block " >
                        ${pd.reason}
                    </div>
                </div>
            </div>
        </div>

    </form>

    <div class="btnbox" id="btnDiv">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
    </div>
</div>
<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
    $.formToDiv(true);
    $("#btnDiv").hide();
    $("#cancel").hide();
    $(".colon").show();
    $("input,select,radio,textarea").attr("disabled", "disabled").css("background-color", "#f2f2f2");
    $("input").removeAttr("placeholder", "");
    $("label").addClass("layui-form-label");
    $("label").removeClass("form-label");
    $(".layui-input-block").css("color","#666")

</script>
</body>
</html>