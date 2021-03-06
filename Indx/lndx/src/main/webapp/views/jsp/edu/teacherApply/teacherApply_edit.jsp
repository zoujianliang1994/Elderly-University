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
                    <label class="layui-form-label"><span class="red-star">*</span>学校名称</label>
                   <div class="layui-input-block  school_id">
                        <input readonly="readonly" type="hidden" name="school_name" id="school_name" value="${pd.school_name}"/>
                        <select lay-filter='school_id' id="school_id" name="school_id" class="layui-input-inline">
                            <option value="">请选择</option>
                            <c:forEach var="var" items="${schoolList}" varStatus="vs">
                                <option value="${var.schoolId}" <c:if test="${var.schoolId==pd.school_id}"> selected="selected" </c:if> >${var.schoolName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-item-inline">
                    <label class="layui-form-label"><span class="red-star">*</span>请假类型</label>
                   <div class="layui-input-block  qjlx">
                        <html:select id="qjlx" name="qjlx" classs="layui-input-inline">
                            <html:options collection="QJ_TYPE" defaultValue="${pd.qjlx}"></html:options>
                        </html:select>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline">
                    <label class="layui-form-label"><span class="red-star">*</span>开始时间</label>
                   <div class="layui-input-block ">
                        <input id="begin_time" name="begin_time" value="${pd.begin_time }" type="text" class="layui-input layui-input-color" placeholder="请输入请假时间">
                    </div>
                </div>
                <div class="form-item-inline">
                    <label class="layui-form-label"><span class="red-star">*</span>结束时间</label>
                   <div class="layui-input-block ">
                        <input id="end_time" name="end_time" value="${pd.end_time }" type="text" class="layui-input layui-input-color" placeholder="请输入结束时间">
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline">
                    <label class="layui-form-label">耽误课程<span class="layui-label-unit">(节)</span></label>
                   <div class="layui-input-block ">
                        <input id="dwkc_number" name="dwkc_number" value="${pd.dwkc_number }" type="text" class="layui-input layui-input-color" readonly>
                    </div>
                    <span class="layui-form-unit">节</span>
                </div>

                <div class="form-item-inline">
                    <label class="form-label btn-label"></label>
                   <div class="layui-input-block  age-min-block" style="width: 46%;float: left;">
                        <div id="viewLesson" class="layui-btn layui-btn-primary">查看课程情况</div>
                    </div>
                </div>
            </div>

        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline" style="width: 98%">
                    <label class="layui-form-label"><i class="require">*</i>请假理由</label>
                   <div class="layui-input-block ">
                        <textarea class=" layui-textarea layui-input-color" name="qjly" id="qjly" placeholder="请输入请假理由">${pd.qjly}</textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item" id="shDiv" hidden>
            <div class="layui-row">
                <div class="form-item-inline" style="width: 98%">
                    <label class="layui-form-label"><i class="require">*</i>审核意见</label>
                   <div class="layui-input-block ">
                        <textarea class=" layui-textarea layui-input-color" name="shyj" id="shyj">${pd.shyj}</textarea>
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
<script>
    $(function () {
        var form = layui.form;
        var type = '${pd.type}';
        var zt = '${pd.zt}';
        if ('2' == zt && '2' != type) {
            $("#shDiv").show();
        } else {
            $("#shDiv").hide();
        }

        layui.use('laydate', function () {
            var laydate = layui.laydate;
            laydate.render({
                elem: '#begin_time',
                type: 'datetime',
                min: '${minDate}',
                done: function (value) {
                    $("#begin_time").val(value);
                    getCountNumber();
                }
            });
            laydate.render({
                elem: '#end_time',
                type: 'datetime',
                min: '${minDate}',
                done: function (value) {
                    $("#end_time").val(value);
                    getCountNumber();
                }
            });
        });

        form.on('select(school_id)', function (data) {
            if (data.value != "") {
                getCountNumber();
            }
        });

        //统计缺课总数
        function getCountNumber() {
            var school_id = $("#school_id").val();
            if (school_id == "") {
                return;
            }
            var begin_time = $("#begin_time").val();
            if (begin_time == "") {
                return;
            }
            var end_time = $("#end_time").val();
            if (end_time == "") {
                return;
            }
            var urlBj = "<%=basePath%>teacherApply/getDwPkCount.do?school_id=" + school_id + '&begin_time=' + begin_time + '&end_time=' + end_time;
            $.get(urlBj, function (data) {
                var jsObject = JSON.parse(data);
                $("#dwkc_number").val(jsObject.dwkc_number);
            });
        }

        $("#sure").on("click", function () {

            if (checkDate()) {

                if ($("#qjlx").val() == "") {
                    layer.tips('请假类型不能为空!', $(".qjlx"), {
                        tips: [3, '#D16E6C'],
                        time: 4000
                    });
                    $(".qjlx").focus();
                    return false;
                }

                if ($("#qjly").val() == "") {
                    layer.tips('请假理由不能为空!', $("#qjly"), {
                        tips: [3, '#D16E6C'],
                        time: 4000
                    });
                    $("#qjly").focus();
                    return false;
                }
                parent.layer.load(1);

                $("#editForm").ajaxSubmit({
                    type: 'post',
                    dataType: "html",
                    success: function (data) {
                        var jso = JSON.parse(data);
                        if ("success" == jso.result) {
                            parent.layer.edit.location.href = "<%=basePath%>teacherApply/list.do?currentPage=${pd.currentPage}";
                            parent.layer.closeAll();
                        } else {
                            layer.msg('系统异常,保存失败!', {icon: 5});
                        }
                        parent.layer.closeAll("loading");
                    }
                });
            }
        });

        //查看课程情况
        $("#viewLesson").on("click", function () {
            if (checkDate()) {

                var begin_time = $("#begin_time").val();
                if (begin_time == undefined || begin_time == '' || begin_time == null) {
                    begin_time = '${pd.begin_time}';
                }

                var end_time = $("#end_time").val();
                if (end_time == undefined || end_time == '' || end_time == null) {
                    end_time = '${pd.end_time}';
                }

                var school_id = $("#school_id").val();
                if (school_id == undefined || school_id == '' || school_id == null) {
                    school_id = '${pd.school_id}';
                }

                parent.parent.parent.layer.viewLesson = window;
                parent.parent.parent.layer.open({
                    title: "查看课程情况",
                    type: 2,
                    content: '<%=basePath%>teacherApply/goViewLesson.do?begin_time=' + begin_time + '&end_time=' + end_time + '&school_id=' + school_id,
                    area: ["900px", "650px"]
                });
            }
        });

        function checkDate() {

            if ($("#school_id").val() == "") {
                layer.tips('学校名称不能为空!', $(".school_id"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $(".school_id").focus();
                return false;
            }

            var begin_time = $("#begin_time").val();
            if ($("#begin_time").val() == "") {
                layer.tips('请假开始时间不能为空!', $("#begin_time"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#begin_time").focus();
                return false;
            }

            var end_time = $("#end_time").val();
            if ($("#end_time").val() == "") {
                layer.tips('请假结束不能为空!', $("#end_time"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#end_time").focus();
                return false;
            }

            if (begin_time > end_time) {
                layer.tips('请假结束时间不能小于开始时间!', $("#end_time"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#end_time").focus();
                return false;
            }
            return true;
        }

        $("#cancel").on("click", function () {
            parent.layer.closeAll();
        });

        $.myType('${pd.type}');
    });

</script>
</body>
</html>