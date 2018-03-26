<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>请假新增</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>

<div class="edit_menu">
    <form action="${msg}.do" class="layui-form" id="editForm" enctype="multipart/form-data" lay-filter="editForm" method="post">
        <input type="hidden" value="${pd.id}" name="id" id="id"/>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline">
                    <label class="form-label"><i class="require">*</i>学校</label>
                   <div class="layui-input-block " id="school_div">
                        <input readonly="readonly" type="hidden" name="school_name" id="school_name" />
                        <select lay-filter='school_id' id="school_id" name="school_id"  class="layui-input-inline"  >
                            <option value="">请选择需要请假的学校</option>
                            <option value="all" <c:if test="${fn:length(pd.school_id) > 45}">selected</c:if>>所有</option>
                            <c:forEach var="var" items="${pd.schIds}" varStatus="vs">
                                <option value="${var}" <c:if test="${pd.school_id == var}">selected</c:if>>${pd.schNames[vs.count-1]}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-item-inline">
                    <label class="form-label"><i class="require">*</i>开始时间</label>
                   <div class="layui-input-block ">
                        <input type="text" name="start_time" id="start_time" required lay-verify="required" placeholder="请输入开始时间"
                               autocomplete="off" value="${pd.start_time}"
                               class="layui-input layui-input-color">
                    </div>
                </div>
            </div>
        </div>



        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline">
                    <label class="form-label"><i class="require">*</i>结束时间</label>
                   <div class="layui-input-block ">
                        <input type="text" name="end_time" id="end_time" required lay-verify="required" placeholder="请输入结束时间"
                               autocomplete="off" value="${pd.end_time}"
                               class="layui-input layui-input-color">
                    </div>
                </div>
                <div class="form-item-inline">
                    <label class="form-label"><i class="require">*</i>时长<span class="layui-label-unit">(天)</span></label>
                   <div class="layui-input-block ">
                        <input type="text" readonly name="duration" id="duration" required lay-verify="required" placeholder="请输入时长"
                               autocomplete="off" maxlength="200" value="${pd.duration}"
                               class="layui-input layui-input-color">
                    </div>
                    <span class="layui-form-unit">天</span>
                </div>
            </div>
        </div>



        <div class="layui-form-item">

            <div class="layui-row">
                <div class="form-item-inline" style="width: 98%">
                    <label class="form-label"><i class="require">*</i>请假事由</label>
                   <div class="layui-input-block " >
                        <textarea class=" layui-textarea layui-input-color" name="reason" id="reason" maxlength="200"
                                  placeholder="请输入请假事由">${pd.reason}</textarea>
                    </div>
                </div>

            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline">
                    <label class="form-label"><i class="require">*</i>抄送人</label>
                   <div class="layui-input-block ">
                        <span>任课老师，班委，组长</span>
                    </div>
                </div>
             </div>
        </div>

        <div class="layui-form-item" id="shDiv" hidden>
            <div class="layui-row">
                <div class="form-item-inline">
                    <label class="layui-form-label"><i class="require">*</i>审核意见</label>
                   <div class="layui-input-block ">
                        <textarea class=" layui-textarea layui-input-color" name="check_opinion" id="check_opinion">${pd.check_opinion}</textarea>
                    </div>
                </div>
            </div>
        </div>

    </form>

    <div class="btnbox" id="btnDiv">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">提交</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
    </div>
</div>
<%@ include file="../../system/index/foot.jsp" %>
<script>
    $(function () {

        var type = '${pd.type}';
        $.myType(type);
        var state = '${pd.state}';
        if ('2' == state && '2' != type) {
            $("#shDiv").show();
        } else {
            $("#shDiv").hide();
        }


        var form = layui.form;

        layui.use('laydate', function () {
            var laydate = layui.laydate;

            //执行一个laydate实例
            laydate.render({
                elem: '#start_time', //指定元素
                type:"datetime",
               // format:'yyyy-MM-dd HH:mm:ss',
                done: function(value, date, endDate){
                    var endTime = $("#end_time").val();
                    if (endTime != "") {
                        var duration = new Date(endTime).getTime() - new Date(value).getTime();
                        //计算出相差天数
                        var days = (duration / (24 * 3600 * 1000)).toFixed(1);
                        $("#duration").val(days);

                        if (days <= 0){
                            layer.tips('结束时间必须大于开始时间', $("#start_time"), {
                                tips: [3, '#D16E6C'],
                                time: 4000
                            });
                            // $("#end_time").focus();
                            return false;
                        }
                    }
                }
            });
            laydate.render({
                elem: '#end_time', //指定元素
                type:"datetime",
                // format:'yyyy-MM-dd HH:mm:ss',
                done: function(value, date, endDate){
                    var startime = $("#start_time").val();
                    if (startime != "") {
                        var duration = new Date(value).getTime() - new Date(startime).getTime();
                        //计算出相差天数
                        var days = (duration / (24 * 3600 * 1000)).toFixed(1);
                        $("#duration").val(days);

                        if (days <= 0){
                            layer.tips('结束时间必须大于开始时间', $("#end_time"), {
                                tips: [3, '#D16E6C'],
                                time: 4000
                            });
                            // $("#end_time").focus();
                            return false;
                        }
                    }
                }
            });
        });

        $(document).ready(function(){
            form.on('select(school_id)', function(data){
                $("#school_name").val(data.elem[data.elem.selectedIndex].text);
            });
        });

        $("#sure").on("click", function () {
            if ($("#school_id").val() == "") {
                layer.tips('请选择学校', $("#school_div"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#school_div").focus();
                return false;
            }
            if ($("#start_time").val() == "") {
                layer.tips('请选择开始时间', $("#start_time"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#start_time").focus();
                return false;
            }
            if ($("#end_time").val() == "") {
                layer.tips('请选择结束时间', $("#end_time"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#end_time").focus();
                return false;
            }

            if ($("#end_time").val() <= $("#start_time").val()){
                layer.tips('结束时间必须大于开始时间', $("#start_time"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#end_time").focus();
                return false;
            }

            if ($("#reason").val() == "") {
                layer.tips('请假理由不能为空', $("#reason"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#reason").focus();
                return false;
            }
            parent.layer.load(1);
//            var idStr= $.getString(sTree.arr,"id"); // 获取到权限id拼接到保存url后面
            $.post('${msg}.do', $('#editForm').serialize(), function (data) {
                parent.layer.closeAll('loading');
                if ("success" == data.result) {
                    parent.layer.edit.location.href = "<%=basePath%>student_leave/list.do?currentPage=${pd.currentPage}";
                    parent.layer.closeAll();
                } else if(("false" == data.result)){
                    layer.msg('当前没有查询到学校!', {icon: 5});
                }
                else {
                    layer.msg('系统异常,保存失败!', {icon: 5});
                }
            });

        });
        $("#cancel").on("click", function () {
            parent.layer.closeAll();
        });

        $(window).on("click",function(){
            $("#adminSelect").hide();
        });

    });

</script>
</body>
</html>