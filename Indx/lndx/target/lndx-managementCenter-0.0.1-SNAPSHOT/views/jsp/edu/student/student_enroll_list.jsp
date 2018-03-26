﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>学员报名列表</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>

<div class="tableBox">
    <div class="operationBox">

        <form action="list.do" method="post" class="layui-form" name="Form" id="Form">
            <div class=" fl ">
				<input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="请输入学员姓名/身份证" class="layui-input-color layui-input fl search">
			</div>
			<div class=" fl marL-20">
                <select lay-filter='checkin_type' id="checkin_type" name="checkin_type" class="layui-input-inline">
                    <option value="">请选择报名类型</option>
                    <option value="1" <c:if test="${'1'==pd.checkin_type}"> selected="selected" </c:if> >网上报名</option>
                    <option value="2" <c:if test="${'2'==pd.checkin_type}"> selected="selected" </c:if>>线下报名</option>
                </select>
            </div>
            
            <div class=" fl marL-20">
                <select lay-filter='semester_id' id="semester_id" name="semester_id"  class="layui-input-inline" lay-search>
                   	<option value="">请选择学期</option>
                       <c:forEach var="var" items="${semesterList}" varStatus="vs">
                      		<option value="${var.id}" <c:if test="${var.id==pd.semester_id}"> selected="selected" </c:if> >${var.name}</option>
                      </c:forEach> 
                  </select>
            </div>
             <div class="fl srarchBtn" onclick="gsearch()">
                <i class="iconfont icon-sousuo"></i>
                <span>搜索</span>
            </div>
        </form>

            <button class="add-btn fl  marL-20 " id="add">
                <i  class="iconfont icon-add"></i>
                <span>学员报名</span>
            </button>

    </div>

    <!-- table -->
    <div class="layui-col-sm12">
        <table class="layui-table center" lay-skin="line" id="table">
            <colgroup>
                <col>
                <col>
                <col>
                <col width="150">
                <col>
                <col>
                <col>
                <col>
                <col width="170">
            </colgroup>
            <thead>
            <tr class="table-head-tr">
                <th>序号</th>
                <th>学员姓名</th>
                <th>身份证号</th>
                <th>报名日期</th>
                <th>学期</th>
                <th>报名班级数</th>
                <th>报名类型</th>
                <th style="border-left: 1px solid #dce3eb;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty varList}">

                    <shiro:hasPermission name="edu:enlist:select">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.xm}</td>
                                <td>${var.sfz}</td>
                                <td>${var.create_time}</td>
                                <td>${var.name}</td>
                                <td>${var.s_num}</td>
                                 <td><c:if test="${var.checkin_type == 1 }">网上报名</c:if>
                                    <c:if test="${var.checkin_type == 2 }">线下报名</c:if>
                                </td>
                                <td style="text-align: center;border-left: 1px solid #dce3eb;">
                                        <a class="table-btn chakan-btn edit" onclick="edit('${var.id}','1');">
                                            查看
                                        </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="edu:enlist:select">
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

        <div class="laypageBox">
            <div id="laypage" class="fr"></div>
        </div>
    </div>
</div>


<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
    var first = true;
    var form = layui.form;
    layui.use('laypage', function () {
        var laypage = layui.laypage;
        var layer = layui.layer;
        form.on('select(sectionId)', function (data) {
            gsearch()
        });

        //执行一个laypage实例
        laypage.render({
            elem: 'laypage',
            count: ${page.totalResult},
            curr: ${page.currentPage},
            layout: ['prev', 'page', 'next', 'count', 'skip'],
            jump: function (obj, first) {
                if (!first) {
                    window.location.href = "<%=basePath%>studentRegister/list.do?&currentPage=" + obj.curr + '&keywords=' + '${keywords}';
                }
            }
        });
    });


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

    //新增
    $("#add").on("click", function () {
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: "新增",
            type: 2,
            content: '<%=basePath%>studentEnroll/goEnroll.do?currentPage=' + ${page.currentPage}+'&checkin_type=2',
            area: ["1200px", "600px"]
        });
    });

    function edit(id) {
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: '查看',
            type: 2,
            content: '<%=basePath%>studentEnroll/goDetail.do?id=' + id + '&currentPage=${page.currentPage}',
            area: ["1200px", "550px"]
        });
    }


</script>
</body>
</html>