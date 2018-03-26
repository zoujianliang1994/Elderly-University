<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
    <%@ include file="../system/index/headcss.jsp" %>

</head>
<body>

<div style="padding: 20px;">
    <div class="sTreeBox" style="width: 100%">
        <div id="sTree" class="sTree"></div>
    </div>
    <div class="btnbox">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">确认</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
    </div>
</div>
<%@ include file="../system/index/foot.jsp" %>
<script type="text/javascript">

    $(document).ready(function () {
        var idArr= $.toArr(parent.layer.transmit.$("#SZQY_CODE").val());
        console.log(idArr)

        var sTree = $.Stree({
            el: $("#sTree"),
            oldData:idArr,
            isSingle: true,  //单选
            data:${zTreeNodes},
            switchCallback: function (obj) {
                var id = obj.id;
                if(obj.children == ""){
                  getAddress(id, sTree)
                }
               
            }
        });
        $("#sure").on("click", function () {
            var selData = sTree.arr;
            parent.layer.transmit.$("#SZQY").val(selData[0].title);
            parent.layer.transmit.$("#SZQY_CODE").val(selData[0].areaCode);
            parent.layer.close(parent.layer.index);
        });

        $("#cancel").on("click", function () {
            parent.layer.close(parent.layer.index);
        })
    });

    function getAddress(id, sTree) {
        $.post("<%=basePath%>areaCode/listSubAreaCodeByParentId", {parentId: id}, function (data) {
            //数据
            sTree.findOne(id, function (obj) {
                if (obj.children == "") {
                    obj.children = data;
                }

                sTree.rec(data, function (obj, index) {
                    sTree.operation(obj, index);
                }, obj.lev)
            })
			//默认选中
			
            sTree.cheakedOldData()
            //展示

        })
    }
    //myFrame.window.
</script>
</body>
</html>