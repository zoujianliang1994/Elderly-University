﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>公告管理</title>
    <%@ include file="../../system/index/headcss.jsp" %>

</head>
<body>
<style>
    .layui-layer-title{
        height: 4rem;
        line-height: 4rem;
        background-color: #3779f7;
        border: solid 1px #3879f7;
        font-size: 20px;
        color: #ffffff;
    }
    .layui-layer-btn{
        text-align: center;
    }
    .layui-layer-btn .layui-layer-btn0{

        border-radius: 0px;
        width: 8rem;
        height: 38px;
        line-height: 38px;
        background-color: #3779f7;
        border: solid 1px #3879f7;
    }
</style>
<div class="tableBox">

    <!-- table -->
    <div class="layui-col-sm12">
        <table class="layui-table center" id="table">
            <ul>
            <c:choose>
                <c:when test="${not empty messageList}">
                    <c:forEach items="${messageList}" var="var" varStatus="vs">
                        <li>
                        <div class="message-list">
                            <div class="message-list-conter">
                            </div>
                            <div class="message-list-left">
                                <span <c:if test="${var.STATUS == 0}">style="color: #3779f7"</c:if>></span>
                                <div class="message-list-left-bottom">${var.PUBLISH_TIME}</div>
                                <a onclick="goDetail('${var.URL}','${var.ID}')" >${var.TITLE}</a>
                            </div>

                            <div class="message-list-right">
                                <div class="message-list-right-top">${var.SCHOOL_NAME}</div>
                            </div>
                        </div>
                        </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr class="main_info">
                        <td colspan="100" class="center">没有相关数据</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </ul>
        </table>

        <div class="laypageBox">
            <div id="laypage" class="fr"></div>
        </div>
    </div>
</div>


<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
    $(function(){
        layui.use('laypage', function () {
            var laypage = layui.laypage;
            var layer = layui.layer;

            //执行一个laypage实例
            laypage.render({
                elem: 'laypage',
                count: ${page.totalResult},
                limit:15,
                curr: ${page.currentPage},
                layout: ['prev', 'page', 'next', 'count', 'skip'],
                jump: function (obj, first) {
                    if (!first) {
                        window.location.href = "<%=basePath%>lesson/list.do?&currentPage=" + obj.curr + '&keywords=' + '${pd.keywords}';
                    }
                }
            });
        });

    })
     function goDetail(url,id) {
         parent.parent.layer.edit = window;

         // 更新消息状态
         $.ajax({
             url:'<%=basePath%>'+url,
             type:"post",
             success:function(data){
                 console.log(data)
                 parent.parent.layer.edit = window;
                 parent.parent.layer.open({
                     title: "通知公告",
                     type: 2,
                     content: '<%=basePath%>notice/goDetail.do?id=' + id,
                     area: ["600px", "430px"]
                 });
             }
         })


//        parent.parent.layer.edit = window;
//        layer.open({
//            title: title,
//            content: content,
//            area: ["600px", "450px"],
//            btnAlign: 'c'
//        });
    };
</script>

</body>
</html>