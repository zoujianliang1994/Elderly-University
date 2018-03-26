﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>我的活动</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title">
        <li class="layui-this">发布的活动</li>
        <li id="my_activity" data-id="0">我的活动</li>
    </ul>
    <div class="layui-tab-content tableBox">

        <div class="operationBox">
            <form action="listByUser.do" class="layui-form" method="post" name="Form" id="Form">

                <div class=" fl">

                    <select lay-filter='school_id' id="school_id" name="school_id"  class="layui-input-inline" lay-search>
                        <option value="">请选择请假学校</option>
                        <c:forEach var="var" items="${schoolList}" varStatus="vs">
                            <option value="${var.id}" <c:if test="${var.id==pd.school_id}"> selected="selected" </c:if> >${var.name}</option>
                        </c:forEach>
                    </select>

                </div>

                <div class=" fl marL-20">
                    <select lay-filter='school_child_id' id="school_child_id" name="school_child_id"  class="layui-input-inline">
                        <option value="">请选择请假校区、教学点</option>
                        <c:forEach var="var" items="${childSchools}" varStatus="vs">
                            <option class="childSchool" value="${var.id}" <c:if test="${var.id==pd.school_child_id}"> selected="selected" </c:if> >${var.name}</option>
                        </c:forEach>
                    </select>
                </div>


                <div class=" fl marL-20">
                    <input id="activityDate" name="activityDate" type="text" value="${pd.activityDate}" placeholder="请选择活动开始时间"  class="layui-input fl search layui-input-color">
                </div>
                <div class=" fl marL-20">
                    <input  name="keywords" type="text" value="${pd.keywords}" placeholder="请输入活动名称/荣誉名称" class="layui-input fl search layui-input-color">

                </div>

                <div class="fl srarchBtn" onclick="gsearch()">
                    <i class="iconfont icon-sousuo"></i>
                    <span>搜索</span>
                </div>

            </form>
        </div>
        <div class="layui-tab-item info layui-show">

                <c:choose>
                    <c:when test="${not empty list}">
                        <c:forEach items="${list}" var="var" varStatus="vs1">
                            <div class="activity-item">
                                <div class=" item-left">
                                    <div class="activity-name ">活动名称：${var.name}</div>
                                    <div>
                                        <div class="my-activity-firstList">所属学校：${var.school_name}</div>
                                        <div class="my-activity-firstList">活动时间：${var.activity_start_time}~${var.activity_end_time}</div>
                                        <div>责 任 人：${var.leader_names}</div>

                                    </div>
                                    <div>
                                        <div class="my-activity-firstList">活动地点：${var.activity_location}</div>
                                        <div>活动内容：${var.content}</div>
                                    </div>
                                    <div class="btnbox" style="margin: 0;position: absolute;right: 10px;bottom: 10px;">
                                        <bottom onclick="apply('${var.id}')" class="layui-btn layui-btn-primary layui-btn-small go-join">我要报名</bottom>
                                    </div>
                                </div>
                            </div>

                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center;padding: 10px 0;border: 1px solid #999;margin-top: 20px;">没有相关数据</div>
                    </c:otherwise>
                </c:choose>


            <div class="laypageBox">
                <div id="laypage1" class="fr"></div>
            </div>
        </div>

        <div class="layui-tab-item">
            <div id="newActivity"></div>
            <div class="laypageBox">
                <div id="laypage2" class="fr"></div>
            </div>
        </div>

    </div>
</div>



<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">

    var form = layui.form;

    form.on('select(school_id)', function (data) {
        if(data.value){
            $("option").remove(".childSchool")
            //根据学校查询分校及教学点
            var url = "<%=basePath%>school/findSchoolBySid.do?id=" + data.value;
            $.get(url, function (res) {
                if(res.data){
                    for(var i=0;i<res.data.length;i++){
                        $("#school_child_id").append('<option class="childSchool" value="'+res.data[i].id+'">'+res.data[i].name+'</option>');
                    }
                    form.render('select');
                }
            });

        }else{
            $("option").remove(".childSchool");
            form.render('select');
        }
    });

    layui.use('laypage', function () {
        var laypage = layui.laypage;
        var layer = layui.layer;
        //执行一个laypage实例
        laypage.render({
            elem:'laypage1' ,
            count:${page.totalResult},
            curr: ${page.currentPage},
            layout: ['prev', 'page', 'next', 'count', 'skip'],
            jump: function (obj, first) {
                if (!first) {
                    window.location.href = "<%=basePath%>activityGroup/listByUser?&currentPage=" + obj.curr  + '&keywords=' + '${pd.keywords}';
                }
            }
        });
    });
    function laypage(elem,count,curr){
        layui.use('laypage', function () {
            var laypage = layui.laypage;
            var layer = layui.layer;
            //执行一个laypage实例
            laypage.render({
                elem:elem ,
                count: count,
                curr: curr,
                layout: ['prev', 'page', 'next', 'count', 'skip'],
                jump: function (obj, first) {
                    if (!first) {
                        myActivity("<%=basePath%>activityGroup/listRegisteredActi?&currentPage=" + obj.curr+'&totalResult='+obj.count + '&keywords=' + '${pd.keywords}')
                    }
                }
            });
        });
    }
    $("#my_activity").on("click",function () {

        myActivity("<%=basePath%>activityGroup/listRegisteredActi")
    })
    $("li").on("click",function () {
        $("li").attr("data-id","0")
        $(this).attr("data-id","1")
    })
    function myActivity(url,data){
        $("#newActivity").empty();
        console.log(url)
        $.ajax({
            url:url,
            type:"post",
            success:function (data) {
                var page=JSON.parse(data.page)
                console.log(page)
                var html='';
                if(data.data){
                    var data=JSON.parse(data.data);
                    for (i in data){
                        html+='<div class="activity-item">' +
                            ' <div class="item-left">'+
                            '<div class="activity-name"><span>活动名称：</span>'+data[i].name+'  </div>' +
                            '<div><div class="my-activity-firstList"><span>发布者：</span>'+data[i].school_name+'</div>' +
                            '<div class="my-activity-firstList"><span>活动时间：</span>'+data[i].activity_start_time+'~'+data[i].activity_end_time+'</div>' +
                            '<div ><span>责 任 人：</span>'+data[i].leader_names+'</div></div>' +
                            '<div><div class="my-activity-firstList"><span>活动地点：</span>'+data[i].activity_location+'</div>' +
                            '<div><span>活动内容：</span>'+data[i].content+' </div></div>' +
                            '</div></div>'
                    }
                }
                $("#newActivity").append(html);
                laypage("laypage2",page.totalResult,page.currentPage)
            },
            error:function (err) {
                console.log(err)
            }
        })
    }
    <%--var form = layui.form;--%>

    <%--form.on('li(my_activity)', function (data) {--%>
            <%--//根据学校查询分校及教学点--%>
            <%--var url = "<%=basePath%>activityGroup/listByUser.do?id=" + data.value;--%>
            <%--$.get(url, function (res) {--%>
                <%--if(res.data){--%>
                    <%--for(var i=0;i<res.data.length;i++){--%>
                        <%--$("#school_child_id").append('<option class="childSchool" value="'+res.data[i].id+'">'+res.data[i].name+'</option>');--%>
                    <%--}--%>
                    <%--form.render('li');--%>
                <%--}--%>
            <%--});--%>
    <%--});--%>



    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#activityDate' //指定元素
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
        var dataId =  $("#my_activity").attr("data-id");
        console.log(dataId)
        if(dataId=="0"){
            document.Form.action="listByUser.do"
            $("#Form").submit();
        }else{
            myActivity("<%=basePath%>activityGroup/listRegisteredActi?"+$('#Form').serialize())
        }
    }

    function apply(id) {
        parent.layer.open({
            title: "报名",
            type: 2,
            content: '<%=basePath%>activityGroup/goApply.do?id=' + id,
            area: ["700px", "480px"]
        });
        transmit(window);
    }
    function transmit(obj){
        parent.layer.transmit= obj;
    }
</script>
</body>
</html>