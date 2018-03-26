<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>教师编辑</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<style>

</style>
<body>

<div class="edit_menu teacher-edit" class="disnone">

    <form action="${msg}.do" class="layui-form" id="editForm" enctype="multipart/form-data" lay-filter="editForm" method="post">
        <input type="hidden" name="id" id="id" value="${pd.id}">
        <input type="hidden" name="school_id" id="school_id" value="${pd.school_id}">
        <blockquote class="layui-elem-quote">教师基础信息</blockquote>
        <div style="width: 100px;height: 120px;float: left;border: 1px solid #ccc;margin-right: 2%;position: relative;margin-top: 12px;">

            <div class="file-text" style="position: absolute;padding: 0;width:100% ;height: 120px;text-align: center;line-height: 120px;">
                <c:if test="${pd.photo_url == null && pd.photo_url == ''}">
                    <span>点击上传图片</span>
                </c:if>
                <c:if test="${pd.photo_url != null && pd.photo_url != ''}">
                    <input type="hidden" name="photo_url" id="photo_url" value="${pd.photo_url}">
                    <img class="img" src="<%=basePath %>uploadFiles/uploadImgs/${pd.photo_url}"/>
                </c:if>
            </div>

            <input type="file" name="file1" id="file1" style="position: absolute;left: 0;height: 120px;width: 100%;cursor: pointer;opacity: 0">
        </div>
        <div style="float: left;clear:none;width: 80%;margin-bottom: 0" class="layui-form-item">
            <div class="layui-form-item">

                <div class="layui-inline">
                    <label class="form-label"><i class="require">*</i>姓名<span class="colon"></span></label>
                   <div class="layui-input-block  div-max" style="width: 13rem;">
                        <input type="text" id="name" name="name" value="${pd.name }" required lay-verify="required" autocomplete="off" maxlength="200" class="layui-input layui-input-color">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="form-label">性别<span class="colon"></span></label>
                   <div class="layui-input-block  div-min" style="width: 13rem;">
                        <select name="xb" id="xb" lay-verify="required">
                            <option value="">请选择性别</option>
                            <option value="1" <c:if test="${pd.xb =='1'}">selected</c:if>>女</option>
                            <option value="2" <c:if test="${pd.xb =='2'}">selected</c:if>>男</option>
                        </select>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="form-label">民族<span class="colon"></span></label>
                   <div class="layui-input-block  div-max" style="width: 13rem;">
                        <html:select id="mz" name="mz" classs="layui-input-inline">
                            <html:options collection="Person_mz" defaultValue="${pd.mz}"></html:options>
                        </html:select>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="form-label"><i class="require">*</i>身份证号<span class="colon"></span></label>
                   <div class="layui-input-block  div-max" style="width:13rem;">
                        <input type="hidden" value="${pd.idcard}" name="old_idcard" id="old_idcard"/>
                        <input type="text" id="idcard" name="idcard" required lay-verify="required" value="${pd.idcard }" autocomplete="off" maxlength="18" class="layui-input layui-input-color">
                    </div>
                </div>

            </div>

            <div class="layui-form-item">

                <div class="layui-inline">
                    <label class="form-label">学历<span class="colon"></span></label>
                   <div class="layui-input-block  div-max" style="width: 13rem;">
                        <html:select id="xl" name="xl" classs="layui-input-inline">
                            <html:options collection="Educational" defaultValue="${pd.xl}"></html:options>
                        </html:select>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="form-label">学位<span class="colon"></span></label>
                   <div class="layui-input-block  div-min" style="width: 13rem;">
                        <html:select id="xw" name="xw" classs="layui-input-inline">
                            <html:options collection="Degree" defaultValue="${pd.xw}"></html:options>
                        </html:select>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="form-label">专业<span class="colon"></span></label>
                   <div class="layui-input-block  div-max" style="width: 13rem;">
                        <input type="text" required lay-verify="required" autocomplete="off" maxlength="20" id="zy" name="zy" value="${pd.zy }" class="layui-input layui-input-color">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="form-label"><i class="require">*</i>岗位性质</label>
                   <div class="layui-input-block  gw_type div-min" style="width:13rem;">
                        <html:select id="gw_type" name="gw_type" classs="layui-input-inline" style=" lay-filter='select1'">
                            <html:options collection="GWTYPE" defaultValue="${pd.gw_type}"></html:options>
                        </html:select>
                    </div>
                </div>

            </div>
            <div class="layui-form-item">
                <div class="layui-inline" id="xzdyDiv" hidden>
                    <label class="form-label title-max" style="width: 120px"><span>薪资待遇</span><span class="layui-label-unit">（元/月）</span></label>
                   <div class="layui-input-block  div-max" style="width:13rem;">
                        <input class="layui-input layui-input-color" type="number" id="gz" name="gz" value="${pd.gz }">
                    </div>

                </div>

                <div class="layui-inline">
                    <label class="form-label"><i class="require">*</i>手机号码</label>
                   <div class="layui-input-block  div-max" style="width: 13rem;">
                        <input type="hidden" value="${pd.tel}" name="old_tel" id="old_tel"/>
                        <input type="number" id="tel" name="tel" value="${pd.tel }" required lay-verify="required" autocomplete="off" maxlength="20" class="layui-input layui-input-color">
                    </div>
                </div>
            </div>
        </div>
    </form>

    <div class="layui-form-item my-form" style="padding-bottom: 20px;    padding-left: 100px;margin-left: 2%;">
        <div class="layui-inline citys" id="selectList">
            <label class="form-label">当前住址<span class="colon"></span></label>
           <div class="layui-input-block " style="width: 13rem;margin-right: 1rem;float: left;">
                <select id="province" name="province" class="select-linkage layui-input-color"></select>
            </div>
           <div class="layui-input-block " style="width: 13rem;     margin-right: 1rem;float: left;">
                <select id="city" name="city" class="select-linkage layui-input-color"></select>
            </div>
           <div class="layui-input-block " style="width: 13rem;     margin-right: 1rem;float: left;">
                <select id="area" name="area" class="select-linkage layui-input-color"></select>
            </div>
           <div class="layui-input-block  myaddr" style="width: 13rem;float: left;">
                <input type="text" required lay-verify="required" name="addr" id="addr" value="${pd.addr}" autocomplete="off" maxlength="100" placeholder="请输入详细地址" class="layui-input layui-input-color">
            </div>
        </div>
    </div>

    <div id="llDiv" hidden>
        <blockquote class="layui-elem-quote">教师履历信息</blockquote>
        <table class="layui-table center " lay-skin="line" id="table">

            <thead>
            <tr style="background-color: #f3f8ff;">
                <th class="center" style="width: 50px;">序号</th>
                <th class='center'>学校</th>
                <th class='center'>班级</th>
                <th class='center'>开始日期</th>
                <th class='center'>结束日期</th>
                <th class='center'>薪资类型</th>
                <th class='center'>薪资待遇</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">
                    <c:forEach items="${varList}" var="var" varStatus="vs">
                        <tr>
                            <td>${vs.index+1}</td>
                            <td>${var.shcool_name}</td>
                            <td>${var.bj_name}</td>
                            <td>${var.semester_start}</td>
                            <td>${var.semester_end}</td>
                            <td>${var.teacher_wages}</td>
                            <td><html:selectedValue collection="GWTYPE" defaultValue="${var.gw_type}"/></td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr class="main_info">
                        <td colspan="100" class="center">没有相关数据</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <div class="btnbox" id="btnDiv" hidden="true">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
    </div>

</div>
<%@ include file="../../system/index/foot.jsp" %>
<script>
    $(function () {

        var form = layui.form;
        $.myUploading("file1", 100, 100, 2);

        var types = '${pd.type}';
        if ("1" == types) {
            $("#llDiv").show();
        } else {
            $("#llDiv").hide();
        }

        if ('${pd.province}' == "" || '${pd.province}' == "undefined") {
            $('#selectList').citys({valueType: 'name', required: false});
        } else {
            $('#selectList').citys({valueType: 'name', province: '${pd.province}', city: '${pd.city}', area: '${pd.area}'});
        }

        if (1 == types) {
            var data = {province: '${pd.province}', city: '${pd.city}', area: '${pd.area}'}
            $(".my-form select").each(function () {
                setVal($(this), '.layui-input-block', data)
            })
            $(".myaddr").css({"width": "auto", "margin": "0", "line-height": "38px"});
        }

        function setVal(obj, parent, data) {
            var id = $(obj).attr("id");
            $(obj).closest(parent).css({"width": "auto", "margin": "0", "line-height": "38px"});
            $(obj).closest(parent).html(data[id]);
        }
        $.myType(types);

        //身份证blur 年龄 性别
        $("#idcard").on("blur", function () {
            var val = $(this).val();
            if (val.length == 18) {
                var sex = parseInt(val.substr(16, 1)) % 2 == 0;
                if (sex) {
                    $("#xb option[value='1']").attr("selected", true);
                } else {
                    $("#xb option[value='2']").attr("selected", true);
                }
                form.render('select');
            }
        });

        var gw_type = '${pd.gw_type}';

        function showXzDiv(value) {
            if (value == '1') {
                $("#xzdyDiv").show();
            } else {
                $("#xzdyDiv").hide();
                $("#gz").val('');
            }
        }

        form.on("select(select1)", function (data) {
            var value = data.value;
            showXzDiv(value);
        });

        showXzDiv(gw_type);

        $("#sure").on("click", function () {

            if ($("#name").val() == "") {
                layer.tips('姓名不能为空!', $("#name"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#name").focus();
                return false;
            }

            var card = $.trim($("#idcard").val()).toUpperCase();
            if (card == "") {
                layer.tips('身份证不能为空', $("#idcard"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#idcard").focus();
                return false;
            }
            if (!card || !isCardNo(card) || !checkProvince(card) || !checkBirthday(card) || !checkParity(card)) {
                layer.tips('请输入正确的身份证号码', $("#idcard"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#idcard").focus();
                return false;
            }

            if ($("#gw_type").val() == "") {
                layer.tips('岗位性质不能为空!', $(".gw_type"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $(".gw_type").focus();
                return false;
            }
            if ($("#tel").val() == "") {
                layer.tips('手机号码不能为空', $("#tel"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#tel").focus();
                return false;
            }

            if (!$.isPoneAvailable($("#tel").val())) {
                layer.tips('请填写手机正确格式', $("#tel"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#tel").focus();
                return false;
            }

            parent.layer.load(1);

            $("#editForm").ajaxSubmit({
                data: {'province': $("#province").val(), 'city': $("#city").val(), 'area': $("#area").val(), 'addr': $("#addr").val()},
                type: 'post',
                dataType: "html",
                success: function (data) {
                    var jso = JSON.parse(data);
                    if ("success" == jso.result) {
                        parent.layer.edit.location.href = "<%=basePath%>teacher/list.do?currentPage=${pd.currentPage}";
                        parent.layer.closeAll();
                    } else if ("fail" == jso.result) {
                        layer.msg('当前学校存在身份证相同的教师!', {icon: 5});
                    } else if ("hasaccount" == jso.result) {
                        layer.msg('当前手机号码已被其他老师注册使用!', {icon: 5});
                    } else {
                        layer.msg('系统异常,保存失败!', {icon: 5});
                    }
                    parent.layer.closeAll("loading");
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