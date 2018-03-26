<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        td span{
            display: block;
        }
    </style>
</head>
<body>


<div class="menu-list">

    <div class="layui-col-xs layui-col-sm layui-col-md layui-col-lg tableBox operationBox">

        <div class="operationBox">
            <form action="list.do" class="layui-form" method="post" name="Form" id="Form">

                <div class=" fl" style="width: 12rem;">

                    <select lay-filter='school_id' id="school_id" name="school_id"  class="layui-input-inline" lay-search>
                        <option value="">请选择学校</option>
                        <c:forEach var="var" items="${schoolList}" varStatus="vs">
                            <option value="${var.id}" <c:if test="${var.id==pd.school_id}"> selected="selected" </c:if> >${var.name}</option>
                        </c:forEach>
                    </select>

                </div>
                <div class=" fl marL-20"style="width: 12rem;">

                    <select lay-filter='school_child_id' id="school_child_id" name="school_child_id"  class="layui-input-inline">
                        <option value="">请选择校区、教学点</option>
                        <c:forEach var="var" items="${childSchools}" varStatus="vs">
                            <option class="childSchool" value="${var.id}" <c:if test="${var.id==pd.school_child_id}"> selected="selected" </c:if> >${var.name}</option>
                        </c:forEach>
                    </select>

                </div>

                <div class=" fl marL-20"style="width: 12rem;">

                    <select lay-filter='teacher_name' id="teacher_name" name="teacher_name" class="layui-input-inline">
                        <option value="">请选择教师</option>
                        <c:forEach var="var" items="${teachers}" varStatus="vs">
                            <option value="${var}" <c:if test="${var==pd.teacher_name}"> selected="selected" </c:if> >${var}</option>
                        </c:forEach>
                    </select>

                </div>


                <div class=" fl marL-20">
                    <input  name="keywords" type="text" value="${pd.keywords}" placeholder="请输入课程名称" class="layui-input fl search layui-input-color">
                </div>

                <div class="fl srarchBtn" onclick="gsearch()">
                    <i class="iconfont icon-sousuo"></i>
                    <span>搜索</span>
                </div>

            </form>
        </div>

        <table class="layui-table center"lay-skin="row" id="table">
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
                <th  class="new_month" style="background-color: #fff;"></th>
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



    $(function () {
        var html;
        var num=1;
            console.log(${data})
            $.each(${data}[0],function (key,val) {
                console.log(key,val);
                var maxLength=0;
                if(JSON.stringify(val)!="{}"){
                    $.each(val,function (day,data) {
                        if(maxLength<data.length){
                            maxLength=data.length
                        }
                    })
                    if (key == "am" && maxLength>0) {
                        html += "<tr style='border-top:1px solid #dce3eb;'><td style='background-color: #f4f8ff;' rowspan=" + maxLength + ">上午</td>";
                    }
                    if (key == "pm" && maxLength>0 ) {
                        html += "<tr style='border-top:1px solid #dce3eb;'><td style='background-color: #f4f8ff;' rowspan=" + maxLength + ">下午</td>";
                    }
                    console.log(maxLength)
                    for(var i=0;i<maxLength;i++){
                        if ( i> 0) {
                           html+="<tr>"
                        }
                        console.log(((val.Monday[i] !=undefined) ? val.Monday[i]:''))
                        html+= "<td >" + ((val.Monday[i] !=undefined) ? '<div data-num=' + Math.random() + '><span>'+val.Monday[i].kc_name +'</span><span>'+val.Monday[i].start_time+'-'+val.Monday[i].end_time+'</span><span>'+val.Monday[i].shcool_name+'</span><span>'+val.Monday[i].teacher_name+'</span><span>'+val.Monday[i].classroom_name+'</span><span></div>':'') + "</td>" +
                            "<td >" + ((val.Tuesday[i] !=undefined) ?  '<div data-num=' + Math.random() + '><span>'+val.Tuesday[i].kc_name +'</span><span>'+val.Tuesday[i].start_time+'-'+val.Tuesday[i].end_time+'</span><span>'+val.Tuesday[i].shcool_name+'</span><span>'+val.Tuesday[i].teacher_name+'</span><span>'+val.Tuesday[i].classroom_name+'</span><span></div>':'') + "</td>" +
                            "<td >" + ((val.Wednesday[i] !=undefined) ?  '<div data-num=' + Math.random() + '><span>'+val.Wednesday[i].kc_name +'</span><span>'+val.Wednesday[i].start_time+'-'+val.Wednesday[i].end_time+'</span><span>'+val.Wednesday[i].shcool_name+'</span><span>'+val.Wednesday[i].teacher_name+'</span><span>'+val.Wednesday[i].classroom_name+'</span><span></div>':'') + "</td>" +
                            "<td >" + ((val.Thursday[i] !=undefined) ?  '<div data-num=' + Math.random() + '><span>'+val.Thursday[i].kc_name +'</span><span>'+val.Thursday[i].start_time+'-'+val.Thursday[i].end_time+'</span><span>'+val.Thursday[i].shcool_name+'</span><span>'+val.Thursday[i].teacher_name+'</span><span>'+val.Thursday[i].classroom_name+'</span><span></div>':'') + "</td>" +
                            "<td >" + ((val.Friday[i] !=undefined) ?  '<div data-num=' + Math.random() + '><span>'+val.Friday[i].kc_name +'</span><span>'+val.Friday[i].start_time+'-'+val.Friday[i].end_time+'</span><span>'+val.Friday[i].shcool_name+'</span><span>'+val.Friday[i].teacher_name+'</span><span>'+val.Friday[i].classroom_name+'</span><span></div>':'') + "</td></tr>"
                    }
                }

            })

        $("tbody").append(html)
        $("td div").each(function () {
            if ($(this).attr("data-num") > 0.5) {
                $(this).addClass("lesson-list1")
            } else {
                $(this).addClass("lesson-list2")
            }
        })
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


</script>
</body>
</html>