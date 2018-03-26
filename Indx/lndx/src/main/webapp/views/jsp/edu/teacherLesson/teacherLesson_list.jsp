﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>我的课程列表</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <style>
        td span {
            display: block;
        }
    </style>
</head>
<body>

<div class="menu-list">

    <div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox">

        <div class="operationBox">
            <form action="list.do" class="layui-form" method="post" name="Form" id="Form">

                <div class=" fl">

                    <select lay-filter='school_id' id="school_id" name="school_id" class="layui-input-inline">
                        <option value="">请选择学校</option>
                        <c:forEach var="var" items="${schoolList}" varStatus="vs">
                            <option value="${var.schoolId}" <c:if test="${var.schoolId==pd.school_id}"> selected="selected" </c:if> >${var.schoolName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class=" fl marL-20">
                    <input id="keywords" name="keywords" value="${pd.keywords}" type="text" placeholder="请输入课程名称"
                           class="layui-input fl search layui-input-color">
                </div>

                <div class="fl srarchBtn" onclick="gsearch()">
                    <i class="iconfont icon-sousuo"></i>
                    <span>搜索</span>
                </div>

            </form>
        </div>

        <table class="layui-table center " lay-skin="row" id="table">
            <colgroup>
                <col width="10%">
                <col width="18%">
                <col width="18%">
                <col width="18%">
                <col width="18%">
                <col width="18%">
            </colgroup>
            <thead>
            <tr style="background-color: #f3f8ff;">
                <th class="new_month" style="background-color: #fff;">上下午</th>
                <th class="center">周一</th>
                <th class="center">周二</th>
                <th class="center">周三</th>
                <th class="center">周四</th>
                <th class="center">周五</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
</div>

<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
    var date=new Date;
    var month=date.getMonth()+1;
    $(".new_month").text(month+"月份")
    var form = layui.form;
    var form = layui.form;

    $(function () {
        var html;
        var num = 1;
        $.each(${data}[0], function (key, val) {

            var maxLength = 0;
            if (JSON.stringify(val) != "{}") {
                $.each(val, function (day, data) {
                    if (maxLength < data.length) {
                        maxLength = data.length
                    }
                })
                if (key == "am" && maxLength>0) {
                    html += "<tr style='border-top:1px solid #dce3eb;'><td style='background-color: #f4f8ff;' rowspan=" + maxLength + ">上午</td>";
                }
                if (key == "pm" && maxLength>0) {
                    html += "<tr style='border-top:1px solid #dce3eb;'><td style='background-color: #f4f8ff;' rowspan=" + maxLength + ">下午</td>";
                }

                for (var i = 0; i < maxLength; i++) {
                    if (i > 0) {
                        html += "<tr>"
                    }
                    html += "<td >" + ((val.Monday[i] != undefined) ? '<div data-num=' + Math.random() + '><span>' + val.Monday[i].kc_name + '</span><span>' + val.Monday[i].start_time + '-' + val.Monday[i].end_time + '</span><span>' + val.Monday[i].shcool_name + '</span><span>' + val.Monday[i].classroom_name + '</span></div>' : '') + "</td>" +
                        "<td >" + ((val.Tuesday[i] != undefined) ? '<div data-num=' + Math.random() + '><span>' + val.Tuesday[i].kc_name + '</span><span>' + val.Tuesday[i].start_time + '-' + val.Tuesday[i].end_time + '</span><span>' + val.Tuesday[i].shcool_name + '</span><span>' + val.Tuesday[i].classroom_name + '</span></div>' : '') + "</td>" +
                        "<td >" + ((val.Wednesday[i] != undefined) ? '<div data-num=' + Math.random() + '><span>' + val.Wednesday[i].kc_name + '</span><span>' + val.Wednesday[i].start_time + '-' + val.Wednesday[i].end_time + '</span><span>' + val.Wednesday[i].shcool_name + '</span><span>' + val.Wednesday[i].classroom_name + '</span></div>' : '') + "</td>" +
                        "<td >" + ((val.Thursday[i] != undefined) ? '<div data-num=' + Math.random() + '><span>' + val.Thursday[i].kc_name + '</span><span>' + val.Thursday[i].start_time + '-' + val.Thursday[i].end_time + '</span><span>' + val.Thursday[i].shcool_name + '</span><span>' + val.Thursday[i].classroom_name + '</span></div>' : '') + "</td>" +
                        "<td >" + ((val.Friday[i] != undefined) ? '<div data-num=' + Math.random() + '><span>' + val.Friday[i].kc_name + '</span><span>' + val.Friday[i].start_time + '-' + val.Friday[i].end_time + '</span><span>' + val.Friday[i].shcool_name + '</span><span>' + val.Friday[i].classroom_name + '</span></div>' : '') + "</td></tr>"
                }
            }
        })
        $("tbody").append(html);
        $("td div").each(function () {
            if ($(this).attr("data-num") > 0.5) {
                $(this).addClass("lesson-list1")
            } else {
                $(this).addClass("lesson-list2")
            }
        })
    });

    form.on('select(school_id)', function (data) {
            gsearch();
        }
    );

    $("#keywords").keydown(function (e) {
        var ev = e || window.event;
        if (ev.keyCode == "13") {
            gsearch();
        }
    });

    //检索
    function gsearch() {
        $("#Form").submit();
    }

</script>
</body>
</html>