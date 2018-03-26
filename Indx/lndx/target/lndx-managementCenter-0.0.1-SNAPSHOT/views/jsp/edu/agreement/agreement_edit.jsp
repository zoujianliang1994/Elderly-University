<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>报名协议编辑</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>

<div class="edit_menu" class="disnone">

    <form action="${msg}.do" name="editForm" id="editForm" method="post">
        <input type="hidden" value="${pd.id}" name="id" id="id"/>
        <input type="hidden" value="${pd.editor_id}" name="editor_id" id="editor_id"/>
        <input type="hidden" value="${pd.s_id}" name="s_id" id="s_id"/>
        
        <div class="layui-form-item">
            <div class="layui-row">
                <div>
                    <label class="form-label"><span class="red-star">*</span>标题</label>
                   <div class="layui-input-block ">
                        <input id="title" name="title" value="${pd.title }" type="text" class="layui-input layui-input-color" placeholder="请输入协议标题">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row">
            <div>
                <label class="form-label"><i class="require">*</i>协议内容</label>
               <div class="layui-input-block ">
                    <textarea class=" layui-textarea layui-input-color" name="content" id="content"
                     style="height: 300px;"  placeholder="请输入协议内容">${pd.content}</textarea>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div>
                    <label class="form-label"><span class="red-star">*</span>编辑日期</label>
                   <div class="layui-input-block ">
                        <input id="edit_date" name="edit_date" value="${pd.edit_date }" type="text" class="layui-input layui-input-color" readonly="readonly">
                    </div>
                </div>
            </div>
        </div>
    </form>

    <div class="btnbox" id="btnDiv">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
    </div>

</div>
<%@ include file="../../system/index/foot.jsp" %>


<script>
    $(function () {
        layui.form;
        $("#sure").on("click", function () {

            if ($("#title").val() == "") {
                layer.tips('协议标题不能为空!', $("#title"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#title").focus();
                return false;
            }

            if ($("#content").val() == "") {
                layer.tips('协议内容不能为空!', $("#content"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#content").focus();
                return false;
            }
            parent.layer.load(1);
            $.post('${msg}.do', $('#editForm').serialize(), function (data) {
                parent.layer.closeAll('loading');
                if ("success" == data.result) {
                    layer.msg('操作成功!', {icon: 1});
                } else {
                    layer.msg('系统异常,保存失败!', {icon: 5});
                }
            });
        });
    });
</script>
</body>
</html>