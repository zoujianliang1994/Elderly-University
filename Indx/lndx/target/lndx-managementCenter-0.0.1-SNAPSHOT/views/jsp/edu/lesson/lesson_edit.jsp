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
        <input type="hidden" value="${pd.id}" name="id" id="id"/>

        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline">
                    <label class="form-label title-max"><span><span class="red-star">*</span>所属校区</span><span>/教学点</span></label>
                   <div class="layui-input-block  school_id">
                        <input readonly="readonly" type="hidden" name="school_name" id="school_name"/>
                        <select lay-filter='school_id' id="school_id" name="school_id" class="layui-input-inline">
                            <option value="">请选择学校</option>
                            <c:forEach var="var" items="${schoolList}" varStatus="vs">
                                <option value="${var.schoolId}" <c:if test="${var.schoolId==pd.school_id}"> selected="selected" </c:if> >${var.schoolName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-item-inline">
                    <label class="form-label"><span class="red-star">*</span>所在系别</label>
                    <div id="deptList" class="layui-input-block dept_id">
                        <select lay-filter='dept_id' id="dept_id" name="dept_id" class="layui-input-inline">
                            <option value="">请选择系别</option>
                            <c:forEach var="var" items="${deptList}" varStatus="vs">
                                <option value="${var.dept_id}" <c:if test="${var.dept_id==pd.dept_id}"> selected="selected" </c:if> >${var.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">


                <div class="form-item-inline">
                    <label class="form-label"><span class="red-star">*</span>课程名称</label>
                   <div class="layui-input-block ">
                        <input type="hidden" value="${pd.name}" name="old_name" id="old_name"/>
                        <input id="name" name="name" value="${pd.name }" type="text" class="layui-input layui-input-color" placeholder="请输入课程名称">
                    </div>
                </div>

                <div class="form-item-inline">
                    <label class="form-label">招收年龄</label>
                   <div class="layui-input-block  age-min-block" style="width: 46%;float: left;">
                        <input name="age_begin" id="age_begin" value="${pd.age_begin}" type="text" style="" class="layui-input layui-input-color" placeholder="请输入起始年龄">
                    </div>
                    <span class="layui-form-unit">岁</span>
                   <div class="layui-input-block  age-min-block" style="width: 8%;float: left;    text-align: center;">
                        <span style="display: inline-block;">-</span>
                    </div>

                   <div class="layui-input-block  age-max-block" style="width: 46%;float: left;">
                        <input name="age_end" id="age_end" value="${pd.age_end}" type="text" style="" class="layui-input layui-input-color" placeholder="请输入截止年龄">
                    </div>
                    <span class="layui-form-unit">岁</span>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline">
                    <label class="form-label">期数</label>
                   <div class="layui-input-block ">
                        <input id="qs" name="qs" value="${pd.qs}" type="number" min="1" class="layui-input layui-input-color" placeholder="请输入期数">
                    </div>
                </div>

                <div class="form-item-inline">
                    <label class="form-label">创建日期</label>
                   <div class="layui-input-block ">
                        <input id="createTime" name="createTime" value="${pd.createTime }" type="text" class="layui-input layui-input-color" placeholder="请输入创建日期">
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

        form.on('select(school_id)', function (data) {
            $("#school_name").val(data.elem[data.elem.selectedIndex].text);
        });

        form.on('select(dept_id)', function (data) {
            $("#xb_name").val(data.elem[data.elem.selectedIndex].text);
        });

        layui.use('laydate', function () {
            var laydate = layui.laydate;
            laydate.render({
                elem: '#createTime'
            });
        });

        //根据学校获取系别
        form.on('select(school_id)', function (data) {
            if (data.value == "") {
                $("#dept_id").html('');
                form.render();
            } else {
                var url = "<%=basePath%>lesson/getSchoolDept.do?school_id=" + data.value;
                $.get(url, function (data) {
                    var option = "<option value=\"\">请选择系别</option>";
                    $.each(data, function (i) {
                        option = option + "<option  value='" + this.dept_id + "'>" + this.name + "</option>"
                    });
                    $("#dept_id").html(option);
                    form.render();
                });
            }
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

            if ($("#dept_id").val() == "") {
                layer.tips('系别不能为空!', $(".dept_id"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $(".dept_id").focus();
                return false;
            }

            if ($("#name").val() == "") {
                layer.tips('课程名不能为空!', $("#name"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#name").focus();
                return false;
            }

            var age_begin = $("#age_begin").val();
            if (age_begin != "" && age_begin < 1) {
                layer.tips('招收起始年龄请大于0岁!', $("#age_begin"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#age_begin").focus();
                return false;
            }

            var age_end = $("#age_end").val();
            if (age_end != "" && age_end < 1) {
                layer.tips('招收截止年龄请大于0岁!', $("#age_end"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#age_end").focus();
                return false;
            }

            var qs = $("#qs").val();
            if (qs != "" && qs < 1) {
                layer.tips('期数不能小于1!', $("#qs"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#qs").focus();
                return false;
            }

            parent.layer.load(1);
            $.post('${msg}.do', $('#editForm').serialize(), function (data) {
                parent.layer.closeAll('loading');
                if ("success" == data.result) {
                    console.log(parent.layer)
                    parent.layer.edit.location.href = "<%=basePath%>lesson/list.do?currentPage=${pd.currentPage}";
                    parent.layer.closeAll();
                } else if ("fail" == data.result) {
                    layer.msg('当前学校存在重名的课程名!', {icon: 5});
                } else {
                    layer.msg('系统异常,保存失败!', {icon: 5});
                }
            });
        });
        $("#cancel").on("click", function () {
            parent.layer.closeAll();
        });
        $.myType('${pd.type}');
    });
</script>
</body>
</html>