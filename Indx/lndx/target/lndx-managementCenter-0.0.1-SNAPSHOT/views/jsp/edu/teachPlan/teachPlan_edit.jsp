<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>教学计划编辑</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>

<div class="edit_menu" class="disnone" style="padding-top: 1rem;">

    <form action="${msg}.do" class="layui-form" name="editForm" id="editForm" enctype="multipart/form-data">
        <input type="hidden" value="${pd.id}" name="id" id="id"/>
        <input type="hidden" value="${pd.school_id}" name="school_id" id="school_id"/>

        <blockquote class="teachPlan-title">班级信息</blockquote>

        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline teachPlan-inline">
                    <label class="teachPlan-label">班级名称</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input type="hidden" value="${pd.grade_id}" name="grade_id" id="grade_id"/>
                        <input id="grade_name" name="grade_name" value="${pd.grade_name }" type="text" class="layui-input layui-input-color" readonly>
                    </div>
                </div>

                <div class="form-item-inline teachPlan-inline">
                    <label class="teachPlan-label">教师姓名</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input type="hidden" value="${pd.teacher_id}" name="teacher_id" id="teacher_id"/>
                        <input id="teacher_name" name="teacher_name" value="${pd.teacher_name }" type="text" class="layui-input layui-input-color" readonly>
                    </div>
                </div>

            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline teachPlan-inline">
                    <label class="teachPlan-label">学期</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input type="hidden" value="${pd.xq_id}" name="xq_id" id="xq_id"/>
                        <input id="xq_name" name="xq_name" value="${pd.xq_name }" type="text" class="layui-input layui-input-color" readonly>
                    </div>
                </div>
                <div class="form-item-inline teachPlan-inline form-state">
                    <label class="teachPlan-label">状态</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <c:if test="${pd.sh_type == '0'}">
                            <input value="草稿" type="text" class="layui-input layui-input-color" readonly>
                        </c:if>
                        <c:if test="${pd.sh_type == '1'}">
                            <input value="未审核" type="text" class="layui-input layui-input-color" readonly>
                        </c:if>
                        <c:if test="${pd.sh_type == '2'}">
                            <input value="审核通过" type="text" class="layui-input layui-input-color" readonly>
                        </c:if>
                        <c:if test="${pd.sh_type == '3'}">
                            <input value="退回" type="text" class="layui-input layui-input-color" readonly>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline teachPlan-inline" style="width: 98%">
                    <label class="teachPlan-label">附件</label>
                   <div class="layui-input-block  teachPlan-input-block ">
                        <c:choose>
                            <c:when test="${not empty pd.file_url}">
                                <a onclick="window.location.href='<%=basePath%>/teachPlan/downExcel.do?file_url=${pd.file_url}'" style="color: #00b3ee;cursor:pointer;">${pd.file_name}</a>
                            </c:when>
                            <c:otherwise>
                                <div class="is-upload"></div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <blockquote class="teachPlan-title" >课程情况</blockquote>

        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline teachPlan-inline">
                    <label class="teachPlan-label">每节课长</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input id="kc" name="kc" value="${pd.kc }" type="text" class="layui-input layui-input-color" readonly>
                    </div>
                    <span class="teachPlan-span" style="color: #333;">分钟</span>
                </div>

                <div class="form-item-inline teachPlan-inline">
                    <label class="teachPlan-label">课数</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input id="ks" name="ks" value="${pd.ks }" type="text" class="layui-input layui-input-color" readonly>
                    </div>
                    <span class="teachPlan-span" style="color: #333;">节</span>
                </div>

            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline teachPlan-inline">
                    <label class="teachPlan-label">每周课数</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input id="mz_ks" name="mz_ks" value="${pd.mz_ks }" type="text" class="layui-input layui-input-color" readonly>
                    </div>
                    <span class="teachPlan-span" style="color: #333;">节</span>
                </div>

                <div class="form-item-inline teachPlan-inline">
                    <label class="teachPlan-label">行课周数</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input id="xk_zs" name="xk_zs" value="${pd.xk_zs }" type="text" class="layui-input layui-input-color" readonly>
                    </div>
                    <span class="teachPlan-span" style="color: #333;">周</span>
                </div>

            </div>
        </div>


        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline teachPlan-inline">
                    <label class="teachPlan-label ">完课预计</label>
                   <div class="layui-input-block teachPlan-input-block">
                        <input id="wk_yj" name="wk_yj" value="${pd.wk_yj }" type="text" class="layui-input layui-input-color" readonly>
                    </div>
                    <span class="teachPlan-span" style="color: #333;">周</span>
                </div>

            </div>
        </div>

        <div class="layui-form-item ">
            <div class="layui-row">
                <div class="form-item-inline teachPlan-inline" style="width:98%;">
                    <label class="teachPlan-label">备注</label>
                   <div class="layui-input-block teachPlan-input-block textarea-block">
                        <textarea class="layui-textarea " name="bz" id="bz" readonly>${pd.bz}</textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline teachPlan-inline" style="width:98%;">
                    <label class="teachPlan-label"><span class="red-star">*</span>审核意见</label>
                   <div class="layui-input-block teachPlan-input-block textarea-block">
                        <textarea class="layui-textarea" style="background-color: white" name="sh_yj" id="sh_yj"
                                  placeholder="请输入审核意见">${pd.sh_yj}</textarea>
                    </div>
                </div>
            </div>
        </div>

    </form>

    <div class="btnbox" id="btnDiv">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small" onclick="fnSubmit('2')">通过</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small" onclick="fnSubmit('3')">退回</button>
    </div>

</div>
<%@ include file="../../system/index/foot.jsp" %>
<script>
    $(function () {
        $.myType('${pd.type}');
    });

    function fnSubmit(sh_type) {
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
            data: {'sh_type': sh_type, id: '${pd.id}'},
            success: function (data) {
                var jso = JSON.parse(data);
                if ("success" == jso.result) {
                    parent.layer.edit.location.href = "<%=basePath%>teachPlan/list.do?yw_type=1&currentPage=${pd.currentPage}";
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