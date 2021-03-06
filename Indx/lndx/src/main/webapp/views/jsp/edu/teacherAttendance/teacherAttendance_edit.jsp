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
                    <label class="form-label">学校名称</label>
                   <div class="layui-input-block  school_id">
                        <input readonly="readonly" type="hidden" name="school_name" id="school_name" value="${pd.school_name}"/>
                        <select lay-filter='school_id' id="school_id" name="school_id" class="layui-input-inline" disabled>
                            <option value="">请选择</option>
                            <c:forEach var="var" items="${schoolList}" varStatus="vs">
                                <option value="${var.schoolId}" <c:if test="${var.schoolId==pd.school_id}"> selected="selected" </c:if> >${var.schoolName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-item-inline">
                    <label class="form-label">请假类型</label>
                   <div class="layui-input-block ">
                        <html:select id="qjlx" name="qjlx" classs="layui-input-inline" style="disabled">
                            <html:options collection="QJ_TYPE" defaultValue="${pd.qjlx}"></html:options>
                        </html:select>
                    </div>
                </div>
            </div>
        </div>


        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline">
                    <label class="form-label">开始时间</label>
                   <div class="layui-input-block ">
                        <input id="begin_time" name="begin_time" value="${pd.begin_time }" type="text" class="layui-input layui-input-color"
                               placeholder="请输入开始时间" readonly>
                    </div>
                </div>
                <div class="form-item-inline">
                    <label class="form-label">结束时间</label>
                   <div class="layui-input-block ">
                        <input id="end_time" name="end_time" value="${pd.end_time }" type="text" class="layui-input layui-input-color"
                               placeholder="请输入结束时间" readonly>
                    </div>
                </div>
            </div>
        </div>


        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline">
                    <label class="form-label">耽误课数</label>
                   <div class="layui-input-block ">
                        <input id="dwkc_number" name="dwkc_number" value="${pd.dwkc_number }" type="text" class="layui-input layui-input-color"
                               placeholder="请输入耽误课数" readonly>
                    </div>
                </div>
                <div class="form-item-inline form-state">
                    <label class="form-label">状态</label>
                   <div class="layui-input-block ">
                        <c:if test="${pd.zt == '0'}">
                            <input value="未审核" type="text" class="layui-input layui-input-color" readonly>
                        </c:if>
                        <c:if test="${pd.zt == '1'}">
                            <input value="审核通过" type="text" class="layui-input layui-input-color" readonly>
                        </c:if>
                        <c:if test="${pd.zt == '2'}">
                            <input value="退回" type="text" class="layui-input layui-input-color" readonly>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline" style="width: 98%;">
                    <label class="form-label">请假理由</label>
                   <div class="layui-input-block ">
                        <textarea class=" layui-textarea layui-input-color" name="qjly" id="qjly"
                                  placeholder="请输入请假理由" readonly>${pd.qjly}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline" style="width: 98%;">
                    <label class="form-label"><i class="require">*</i>审核意见</label>
                   <div class="layui-input-block ">
                        <textarea class=" layui-textarea layui-input-color" style="background-color: white" name="shyj" id="shyj"
                                  placeholder="请输入审核意见">${pd.shyj}</textarea>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <div class="btnbox" id="btnDiv">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small" onclick="fnSubmit('1')">通过</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small" onclick="fnSubmit('2')">退回</button>
    </div>

</div>
<%@ include file="../../system/index/foot.jsp" %>
<script>
    $(function () {
        $.myType('${pd.type}');
    });

    function fnSubmit(zt) {
        if ($("#sh_yj").val() == "") {
            layer.tips('审核意见不能为空!', $("#sh_yj"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#sh_yj").focus();
            return false;
        }

        parent.layer.load(1);

        $("#editForm").ajaxSubmit({
            type: 'post',
            dataType: "html",
            data: {'zt': zt},
            success: function (data) {
                var jso = JSON.parse(data);
                if ("success" == jso.result) {
                    parent.layer.edit.location.href = "<%=basePath%>teacherAttendance/list.do?currentPage=${pd.currentPage}";
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