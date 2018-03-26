<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>我的申请编辑</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>

<div class="edit_menu" class="disnone">

    <form action="${msg}.do" class="layui-form" name="editForm" id="editForm">
        <input type="hidden" value="${pd.id}" name="id" id="id"/>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline">
                    <label class="form-label">请假人</label>
                   <div class="layui-input-block ">
                        <input id="name" name="name" value="${pd.name}" type="text" class="layui-input layui-input-color" readonly>
                    </div>
                </div>


            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-row">
        <div class="form-item-inline" style="width: 98%;">
            <label class="form-label ">请假时间</label>
           <div class="layui-input-block ">
                <input type="hidden" name="start_time" id="startTime">
                <input type="hidden" name="end_time" id="endTime">
                <input id="start_time" name="" <c:if test="${pd.start_time !=null}">value="${pd.start_time }~${pd.end_time }"</c:if>  type="text" class="layui-input layui-input-color"
                       placeholder="请输入请假时间" readonly>
            </div>
        </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline">
                    <label class="form-label title-max"><span>请假时长</span><span class="layui-label-unit">(天)</span></label>
                   <div class="layui-input-block">
                        <input id="duration" name="duration" value="${pd.duration}" type="text" class="layui-input layui-input-color" readonly>
                    </div>
                    <span class="layui-form-unit">天</span>
                </div>
                <div class="form-item-inline">
                    <label class="form-label">状态</label>
                   <div class="layui-input-block ">
                        <input  name="state" id="state"  type="text" value="<c:if test="${pd.state == '0'}">
                                    未审核
                                </c:if>
                                <c:if test="${pd.state == '1'}">
                                    通过
                                </c:if>
                                <c:if test="${pd.state == '2'}">
                                    驳回
                                </c:if>"
                                class="layui-input layui-input-color" readonly>
                    </div>
                </div>
            </div>
        </div>


        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline" style="width:98%">
                    <label class="form-label">请假理由</label>
                   <div class="layui-input-block ">
                        <textarea class=" layui-textarea layui-input-color" name="reason" id="reason"
                                  placeholder="请输入请假理由" readonly>${pd.reason}</textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline" style="width:98%">
                    <label class="form-label"><i class="require">*</i>审核意见</label>
                   <div class="layui-input-block ">
                        <textarea class=" layui-textarea layui-input-color" style="background-color: white" name="check_opinion" id="check_opinion"
                                  placeholder="请输入审核意见">${pd.check_opinion}</textarea>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <div class="btnbox" id="btnDiv" hidden="true">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small" onclick="fnSubmit('1')">通过</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small" onclick="fnSubmit('2')">退回</button>
    </div>

</div>
<%@ include file="../../system/index/foot.jsp" %>
<script>
    $(function () {
        layui.use('laydate', function () {
            var laydate = layui.laydate;
            //执行一个laydate实例
            laydate.render({
                elem: '#start_time'//指定元素
                ,range: '~'
            });


        });
        $.myType('${pd.type}');
    });

    function fnSubmit(state) {
        if ($("#check_opinion").val() == "") {
            layer.tips('审核意见不能为空!', $("#check_opinion"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#check_opinion").focus();
            return false;
        }

        parent.layer.load(1);
//        var reg=$("#start_time").val().split("~");
//        $("#startTime").val(reg[0].replace(/(^\s*)|(\s*$)/g, ""))
//        $("#endTime").val(reg[1].replace(/(^\s*)|(\s*$)/g, ""))

        $("#editForm").ajaxSubmit({
            type: 'post',
            dataType: "html",
            data: {'state': state},
            success: function (data) {
                var jso = JSON.parse(data);
                if ("success" == jso.result) {
                    parent.layer.edit.location.href = "<%=basePath%>studentAttendance/list.do?currentPage=${pd.currentPage}";
                    parent.layer.closeAll();
                } else {
                    layer.msg('系统异常,保存失败!', {icon: 5});
                }
                parent.layer.closeAll("loading");
            }
        });
    }

</script>
</body>
</html>