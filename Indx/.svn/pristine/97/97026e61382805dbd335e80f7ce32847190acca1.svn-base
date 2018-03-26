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

<div class="edit_menu" class="disnone" style="padding-top: 1rem">

    <form action="${msg}.do" class="layui-form" name="editForm" id="editForm" enctype="multipart/form-data">
        <input type="hidden" value="${pd.id}" name="id" id="id"/>

        <blockquote class="teachPlan-title">班级信息</blockquote>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline teachPlan-inline">
                    <label class="form-label teachPlan-label"><span class="red-star">*</span>学校名称</label>

                   <div class="layui-input-block  school_id teachPlan-input-block" style="width: 14rem">
                        <input readonly="readonly" type="hidden" name="school_name" id="school_name" value="${pd.school_name}"/>
                        <select lay-filter='school_id' id="school_id" name="school_id" class="layui-input-inline">
                            <option value="">请选择学校</option>
                            <c:forEach var="var" items="${schoolList}" varStatus="vs">
                                <option value="${var.schoolId}" <c:if test="${var.schoolId==pd.school_id}"> selected="selected" </c:if> >${var.schoolName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-item-inline teachPlan-inline">
                    <label class="form-label teachPlan-label"><span class="red-star">*</span>学期</label>
                   <div class="layui-input-block  xq_id teachPlan-input-block" style="width: 14rem">
                        <select lay-filter='xq_id' id="xq_id" name="xq_id" class="layui-input-inline">
                            <option value="">请选择学期</option>
                            <c:forEach var="var" items="${xqList}" varStatus="vs">
                                <option value="${var.x_id}" <c:if test="${var.x_id==pd.xq_id}"> selected="selected" </c:if> >${var.x_name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline teachPlan-inline">
                    <label class="form-label teachPlan-label"><span class="red-star">*</span>班级名称</label>
                   <div class="layui-input-block  grade_id teachPlan-input-block" style="width: 14rem">
                        <select lay-filter='grade_id' id="grade_id" name="grade_id" class="layui-input-inline">
                            <option value="">请选择班级</option>
                            <c:forEach var="var" items="${gradesList}" varStatus="vs">
                                <option value="${var.id}" <c:if test="${var.id==pd.grade_id}"> selected="selected" </c:if> >${var.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                </div>

                <div class="form-item-inline teachPlan-inline">
                    <label class="form-label teachPlan-label"><span class="red-star">*</span>计划名称</label>
                   <div class="layui-input-block  teachPlan-input-block" style="width: 14rem">
                        <input id="jh_name" name="jh_name" value="${pd.jh_name }" type="text" class="layui-input layui-input-color">
                    </div>
                </div>

            </div>
        </div>

        <blockquote class="teachPlan-title">课程情况</blockquote>

        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline teachPlan-inline">
                    <label class="form-label teachPlan-label"><span class="red-star">*</span>每节课长</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input id="mz_kc" name="mz_kc" value="${pd.mz_kc }" type="number" class="layui-input layui-input-color">
                    </div>
                    <span class="teachPlan-span" style="color: #333;">分钟</span>
                </div>

                <div class="form-item-inline teachPlan-inline">
                    <label class="form-label teachPlan-label"><span class="red-star">*</span>课数</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input id="ks" name="ks" value="${pd.ks }" type="number" class="layui-input layui-input-color">
                    </div>
                    <span class="teachPlan-span" style="color: #333;">周</span>
                </div>

            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline teachPlan-inline">
                    <label class="form-label teachPlan-label"><span class="red-star">*</span>每周课数</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input id="mz_ks" name="mz_ks" value="${pd.mz_ks }" type="number" class="layui-input layui-input-color">
                    </div>
                    <span class="teachPlan-span" style="color: #333;">节</span>
                </div>

                <div class="form-item-inline teachPlan-inline">
                    <label class="form-label teachPlan-label"><span class="red-star">*</span>行课周数</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input id="xk_zs" name="xk_zs" value="${pd.xk_zs }" type="number" class="layui-input layui-input-color">
                    </div>
                    <span class="teachPlan-span"style="color: #333;">周</span>
                </div>

            </div>
        </div>


        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline teachPlan-inline">
                    <label class="form-label teachPlan-label"><span class="red-star">*</span>完课预计</label>
                   <div class="layui-input-block  teachPlan-input-block">
                        <input id="wk_yj" name="wk_yj" value="${pd.wk_yj }" type="number" class="layui-input layui-input-color">
                    </div>
                    <span class="teachPlan-span" style="color: #333;">周</span>
                </div>

                <c:if test="${pd.type =='2'}">
                    <div class="form-item-inline teachPlan-inline form-state">
                        <label class="form-label teachPlan-label">状态</label>
                       <div class="layui-input-block  teachPlan-input-block ">
                            <input value="${pd.shText}" type="text" class="layui-input layui-input-color" readonly>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

        <blockquote class="teachPlan-title">班级信息</blockquote>

        <div class="layui-form-item">

            <div class="layui-row">
                <div class="form-item-inline teachPlan-inline" style="position: relative;">
                    <label class="form-label teachPlan-label">附件上传</label>
                    <input type="hidden" value="${pd.file_name}" name="old_file_name" id="old_file_name"/>
                    <input type="hidden" value="${pd.file_url}" name="old_file_url" id="old_file_url"/>
                    <c:choose>
                        <c:when test="${not empty pd.file_url}">
                           <div class="layui-input-block  teachPlan-input-block">
                                <a onclick="window.location.href='<%=basePath%>/teachPlan/downExcel.do?file_url=${pd.file_url}'" style="color: #00b3ee;cursor:pointer;">${pd.file_name}</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                           <div class="layui-input-block  teachPlan-input-block is-upload">
                                <div class="text-tip" style=" position:absolute;text-align: center;top: 9px;width: 16rem;">
                                    <div class="file-btn">
                                        选择文件
                                    </div>
                                    <div class="file-text">
                                        未选择文件
                                    </div>
                                </div>
                                <input type="file" name="file1" id="file1" style="position: absolute;top: 9px;height: 2rem;width: 8rem;cursor: pointer;opacity: 0">
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline teachPlan-inline" style="width:98%;">
                    <label class="form-label teachPlan-label">备注</label>
                   <div class="layui-input-block teachPlan-input-block textarea-block">
                        <textarea class=" layui-textarea layui-input-color" name="bz" id="bz">${pd.bz}</textarea>
                    </div>
                </div>
            </div>
        </div>

    </form>

    <div class="btnbox" id="btnDiv" hidden>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small" onclick="fnSubmit('0')">保存草稿</button>
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small" onclick="fnSubmit('1')">提交</button>
    </div>

</div>
<%@ include file="../../system/index/foot.jsp" %>
<script>
    $(function () {
        var form = layui.form;
        //根据学校获取学期和班级
        form.on('select(school_id)', function (data) {
            if (data.value == "") {
                $("#xq_id").html('');
                $("#grade_id").html('');
                form.render();
            } else {
                var urlXq = "<%=basePath%>teachPlan/getSchoolSemester.do?school_id=" + data.value;
                $.get(urlXq, function (data) {
                    var optionXq = "<option value=\"\">请选择学期</option>";
                    $.each(data, function (i) {
                        optionXq = optionXq + "<option  value='" + this.x_id + "'>" + this.x_name + "</option>"
                    });
                    $("#xq_id").html(optionXq);
                    form.render();
                });

                var urlBj = "<%=basePath%>teachPlan/getSchoolGrades.do?school_id=" + data.value;
                $.get(urlBj, function (data) {
                    var optionBj = "<option value=\"\">请选择班级</option>";
                    $.each(data, function (i) {
                        optionBj = optionBj + "<option  value='" + this.id + "'>" + this.name + "</option>"
                    });
                    $("#grade_id").html(optionBj);
                    form.render();
                });
            }
        });

        var sh_type = '${pd.sh_type}';
        $.myUploading("file1", 100, 100);
        $.myType(sh_type);
    });

    function fnSubmit(sh_type) {
        if ($("#school_id").val() == "") {
            layer.tips('学校名称不能为空!', $(".school_id"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $(".school_id").focus();
            return false;
        }

        if ($("#xq_id").val() == "") {
            layer.tips('学期不能为空!', $(".xq_id"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $(".xq_id").focus();
            return false;
        }

        if ($("#grade_id").val() == "") {
            layer.tips('班级不能为空!', $(".grade_id"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $(".grade_id").focus();
            return false;
        }

        if ($("#jh_name").val() == "") {
            layer.tips('计划名称不能为空!', $("#jh_name"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#jh_name").focus();
            return false;
        }


        if ($("#mz_kc").val() == "") {
            layer.tips('每周课长不能为空!', $("#mz_kc"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#mz_kc").focus();
            return false;
        }

        if ($("#ks").val() == "") {
            layer.tips('课数不能为空!', $("#ks"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#ks").focus();
            return false;
        }

        if ($("#mz_ks").val() == "") {
            layer.tips('每周课数不能为空!', $("#mz_ks"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#mz_ks").focus();
            return false;
        }

        if ($("#xk_zs").val() == "") {
            layer.tips('行课周数不能为空!', $("#xk_zs"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#xk_zs").focus();
            return false;
        }

        if ($("#wk_yj").val() == "") {
            layer.tips('完课预计不能为空!', $("#wk_yj"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#wk_yj").focus();
            return false;
        }

        parent.layer.load(1);

        $("#editForm").ajaxSubmit({
            type: 'post',
            dataType: "html",
            data: {'sh_type': sh_type},
            success: function (data) {
                var jso = JSON.parse(data);
                if ("success" == jso.result) {
                    parent.layer.edit.location.href = "<%=basePath%>teachPlan/list.do?yw_type=2&currentPage=${pd.currentPage}";
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