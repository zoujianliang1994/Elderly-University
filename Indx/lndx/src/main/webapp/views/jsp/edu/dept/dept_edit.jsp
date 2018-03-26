<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>系别编辑</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>

<div class="edit_menu" class="disnone">

    <form action="${msg}.do" class="layui-form" name="editForm" id="editForm" method="post">
        <input type="hidden" value="${pd.dept_id}" name="dept_id" id="dept_id"/>

        <div class="layui-form-item">
            <div class="layui-row">

                <div >
                    <label class="form-label title-max"><span><span class="red-star">*</span>所属校区</span><span>/教学点</span></label>
                   <div class="layui-input-block  school_id">
                        <input readonly="readonly" type="hidden" name="school_name" id="school_name" value="${pd.school_name}"/>
                        <select lay-filter='school_id' id="school_id" name="school_id" class="layui-input-inline">
                            <option value="">请选择学校</option>
                            <c:forEach var="var" items="${schoolList}" varStatus="vs">
                                <option value="${var.schoolId}" <c:if test="${var.schoolId==pd.school_id}"> selected="selected" </c:if> >${var.schoolName}</option>
                            </c:forEach>
                        </select>

                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div>
                    <label class="form-label"><span class="red-star">*</span>系别名称</label>
                   <div class="layui-input-block ">
                        <input type="hidden" value="${pd.name}" name="old_name" id="old_name"/>
                        <input id="name" name="name" value="${pd.name }" type="text" class="layui-input layui-input-color" placeholder="请输入系别名称">
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div>
                    <label class="form-label"><span class="red-star">*</span>创建日期</label>
                   <div class="layui-input-block ">
                        <input id="createTime" name="createTime" value="${pd.createTime }" type="text" class="layui-input layui-input-color">
                    </div>
                </div>
            </div>
        </div>
    </form>

    <div class="btnbox" id="btnDiv" hidden="true">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
    </div>

</div>
<%@ include file="../../system/index/foot.jsp" %>


<script>
    $(function () {
        var form = layui.form;

        layui.use('laydate', function () {
            var laydate = layui.laydate;
            laydate.render({
                elem: '#createTime'
            });
        });

        form.on('select(school_id)', function (data) {
            $("#school_name").val(data.elem[data.elem.selectedIndex].text);
        });

        $("#sure").on("click", function () {

            if ($("#school_id").val() == "") {
                layer.tips('学校名称不能为空!', $(".school_id"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $(".school_id").focus();
                return false;
            }

            if ($("#name").val() == "") {
                layer.tips('系名不能为空!', $("#name"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#name").focus();
                return false;
            }
            if ($("#createTime").val() == "") {
                layer.tips('创建日期不能为空', $("#createTime"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#createTime").focus();
                return false;
            }
            parent.layer.load(1);
            $.post('${msg}.do', $('#editForm').serialize(), function (data) {
                parent.layer.closeAll('loading');
                if ("success" == data.result) {
                    parent.layer.edit.location.href = "<%=basePath%>dept/list.do?currentPage=${pd.currentPage}";
                    parent.layer.closeAll();
                } else if ("fail" == data.result) {
                    layer.msg('当前学校存在重名的系名!', {icon: 5});
                } else {
                    layer.msg('系统异常,保存失败!', {icon: 5});
                }
            });
        });
        $("#cancel").on("click", function () {
            parent.layer.closeAll();
        });

        $.myType('${pd.type}')
    });
</script>
</body>
</html>