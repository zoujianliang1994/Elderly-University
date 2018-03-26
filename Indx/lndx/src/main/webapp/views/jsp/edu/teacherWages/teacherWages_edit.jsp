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
<body>

<div class="edit_menu" class="disnone">

    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this">工资明细信息</li>
            <li>完课情况</li>
            <li>缺课情况</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <form action="${msg}.do" class="layui-form" name="editForm" id="editForm" enctype="multipart/form-data" style="padding-top: 10px">
                    <input type="hidden" value="${pd.id}" name="id" id="id"/>

                    <div class="layui-form-item">
                        <div class="layui-row">

                            <div class="form-item-inline">
                                <label class="form-label">姓名</label>
                               <div class="layui-input-block ">
                                    <input id="name" name="name" value="${pd.name }" type="text" class="layui-input layui-input-color" readonly>
                                </div>
                            </div>

                            <div class="form-item-inline">
                                <label class="form-label">身份证号</label>
                               <div class="layui-input-block ">
                                    <input type="hidden" value="${pd.idcard}" name="old_idcard" id="old_idcard"/>
                                    <input id="idcard" name="idcard" value="${pd.idcard }" type="text" class="layui-input layui-input-color" readonly>
                                </div>
                            </div>

                        </div>
                    </div>


                    <div class="layui-form-item">
                        <div class="layui-row">

                            <div class="form-item-inline">
                                <label class="form-label">岗位性质</label>
                               <div class="layui-input-block  gw_type">
                                    <html:select id="gw_type" name="gw_type" classs="layui-input-inline" style=" lay-filter='select1' disabled">
                                        <html:options collection="GWTYPE" defaultValue="${pd.gw_type}"></html:options>
                                    </html:select>
                                </div>
                            </div>

                            <div class="form-item-inline">
                                <label class="form-label">应发工资<span class="layui-label-unit">(元)</span></label>
                               <div class="layui-input-block ">
                                    <input id="yf_wages" name="yf_wages" value="${pd.yf_wages }" type="number" class="layui-input layui-input-color"
                                           readonly>
                                </div>
                                <span class="layui-form-unit">元</span>
                            </div>

                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-row">

                            <div class="form-item-inline">
                                <label class="form-label">扣发薪资<span class="layui-label-unit">(元)</span></label>
                               <div class="layui-input-block ">
                                    <input id="kf_wages" name="kf_wages" value="${pd.kf_wages }" type="number" class="layui-input layui-input-color"
                                           readonly>
                                </div>
                                <span class="layui-form-unit">元</span>
                            </div>

                            <div class="form-item-inline">
                                <label class="form-label">实发薪资<span class="layui-label-unit">(元)</span></label>
                               <div class="layui-input-block ">
                                    <input id="sf_wages" name="sf_wages" value="${pd.sf_wages }" type="text" class="layui-input layui-input-color"
                                           readonly>
                                </div>
                                <span class="layui-form-unit">元</span>
                            </div>

                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-row">

                            <div class="form-item-inline">
                                <label class="form-label"><span class="red-star">*</span>调整薪资<span class="layui-label-unit">(元)</span></label>
                               <div class="layui-input-block ">
                                    <input id="tz_wages" name="tz_wages" value="${pd.tz_wages }" type="number" class="layui-input layui-input-color">
                                </div>
                                <span class="layui-form-unit">元</span>
                            </div>

                        </div>
                    </div>

                    <div class="layui-form-item layui-form-text" >
                            <div class="form-item-inline"style="width: 98%;">
                            <label class="form-label"><span class="red-star">*</span>调整原因</label>
                           <div class="layui-input-block ">
                                <textarea class=" layui-textarea layui-input-color layui-input-color" name="tz_bz" id="tz_bz"
                                  placeholder="请输入调整原因">${pd.tz_bz}</textarea>
                            </div>
                            </div>

                    </div>

                </form>

                <div class="btnbox" id="btnDiv" hidden="true">
                    <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
                    <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
                </div>

            </div>
            <div class="layui-tab-item">
                <table class="layui-table center " lay-skin="line" id="table1">
                    <thead>
                    <tr style="background-color: #f3f8ff;">
                        <th class="center" style="width: 50px;">序号</th>
                        <th class='center'>班级名称</th>
                        <th class='center'>上课时间</th>
                        <th class='center'>课费(元)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty zcList}">
                            <shiro:hasPermission name="edu:wage:select">
                                <c:forEach items="${zcList}" var="var" varStatus="vs">
                                    <tr>
                                        <td>${vs.index+1}</td>
                                        <td>${var.kc_name}</td>
                                        <td>${var.qk_time}</td>
                                        <td>${var.wages}</td>
                                    </tr>
                                </c:forEach>
                                <tr style="color: red">
                                    <td>合计</td>
                                    <td>${pd.zcCountKs}节课</td>
                                    <td>---</td>
                                    <td>共计${pd.zcCountKf}元</td>
                                </tr>
                            </shiro:hasPermission>
                            <shiro:lacksPermission name="edu:wage:select">
                                <tr>
                                    <td colspan="100" class="center">您无权查看</td>
                                </tr>
                            </shiro:lacksPermission>
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
            <div class="layui-tab-item">
                <table class="layui-table center " lay-skin="line" id="table2">
                    <thead>
                    <tr style="background-color: #f3f8ff;">
                        <th class="center" style="width: 50px;">序号</th>
                        <th class='center'>班级名称</th>
                        <th class='center'>上课时间</th>
                        <th class='center'>课费(元)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty qjList}">

                            <shiro:hasPermission name="edu:wage:select">
                                <c:forEach items="${qjList}" var="var" varStatus="vs">
                                    <tr>
                                        <td>${vs.index+1}</td>
                                        <td>${var.kc_name}</td>
                                        <td>${var.qk_time}</td>
                                        <td>${var.wages}</td>
                                    </tr>
                                </c:forEach>
                                <tr style="color: red">
                                    <td>合计</td>
                                    <td>${pd.qjCountKs}节课</td>
                                    <td>---</td>
                                    <td>共计${pd.qjCountKf}元</td>
                                </tr>
                            </shiro:hasPermission>
                            <shiro:lacksPermission name="edu:wage:select">
                                <tr>
                                    <td colspan="100" class="center">您无权查看</td>
                                </tr>
                            </shiro:lacksPermission>
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
        </div>
    </div>

</div>
<%@ include file="../../system/index/foot.jsp" %>
<script>
    $(function () {

        //调整金额
        $("#tz_wages").on("blur", function () {
            var val = $(this).val();
            var rel = /^-?\d+$/;
            if (rel.test(val)) {
                var sf_wages = Number($("#sf_wages").val());
                var new_wages = sf_wages + Number(val);
                $("#sf_wages").val(new_wages);
            } else {
                $(this).val(0);
                layer.tips('调整金额请输入整数!', $("#tz_wages"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
            }
        });

        $("#sure").on("click", function () {
            if ($("#kf_wages").val() == "") {
                layer.tips('扣发薪资不能为空!', $("#kf_wages"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#kf_wages").focus();
                return false;
            }

            parent.layer.load(1);
            $.post('${msg}.do', $('#editForm').serialize(), function (data) {
                if ("success" == data.result) {
                    parent.layer.edit.location.href = "<%=basePath%>teacherWages/list.do?currentPage=${pd.currentPage}";
                    parent.layer.closeAll();
                } else {
                    layer.msg('系统异常,保存失败!', {icon: 5});
                }
                parent.layer.closeAll("loading");
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