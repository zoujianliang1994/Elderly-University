<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>修改密码</title>
    <%@ include file="../index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>
<div class="edit_menu">
    <form action="" class="layui-form" id="editForm" lay-filter="editForm" method="post">
        <input type="hidden" value="${pd.USERNAME}" name="USERNAME" id="USERNAME"/>
        <div class="layui-form-item">

            <label class="layui-form-label">姓名：</label>
            <div class="layui-input-block">
                <input type="text" value="${pd.NAME }" name="NAME" id="NAME" readonly style="background-color: #f2f2f2"
                       autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">

            <label class="layui-form-label">旧密码：</label>
            <div class="layui-input-block">
                <input type="password" name="PASSWORD" id="PASSWORD" required lay-verify="required" placeholder="请输入旧密码"
                       autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">

            <label class="layui-form-label">新密码：</label>
            <div class="layui-input-block">
                <input type="password" name="NEW_PASSWORD" id="NEW_PASSWORD" required lay-verify="required" placeholder="请输入新密码"
                       autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">确认密码：</label>
            <div class="layui-input-block">
                <input type="password" name="Q_NEW_PASSWORD" id="Q_NEW_PASSWORD" required lay-verify="required" placeholder="请输入确认密码"
                       autocomplete="off"
                       class="layui-input">
            </div>
        </div>

    </form>

    <div class="btnbox">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">修改</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
    </div>
</div>
<%@ include file="../index/foot.jsp" %>
<script>
    $(function () {

        $("#sure").on("click", function () {
            var PASSWORD = $("#PASSWORD").val();
            if (PASSWORD == "") {
                layer.tips('旧密码不能为空', $("#PASSWORD"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#PASSWORD").focus();
                return false;
            }

            var NEW_PASSWORD = $("#NEW_PASSWORD").val();
            if (NEW_PASSWORD == "") {
                layer.tips('新密码不能为空', $("#NEW_PASSWORD"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#NEW_PASSWORD").focus();
                return false;
            }

            if ($("#NEW_PASSWORD").val() != $("#Q_NEW_PASSWORD").val()) {
                layer.tips('新密码与确认密码不相同', $("#Q_NEW_PASSWORD"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#Q_NEW_PASSWORD").focus();
                return false;
            }
            parent.layer.load(1);
            $.post('${msg}.do', $('#editForm').serialize(), function (data) {
                parent.layer.closeAll('loading');
                if ("success" == data.result) {
                    layer.msg('修改成功!', {icon: 1});
                    parent.layer.edit.location.href = '<%=basePath%>logout.do';
                    parent.layer.closeAll();
                } else if ("fail" == data.result) {
                    layer.msg('旧密码错误,请重新输入!', {icon: 5});
                } else {
                    layer.msg('系统异常,修改失败!', {icon: 5});
                }
            });
        });
        
        $("#cancel").on("click", function () {
            parent.layer.closeAll();
        });
    });
</script>
</body>
</html>