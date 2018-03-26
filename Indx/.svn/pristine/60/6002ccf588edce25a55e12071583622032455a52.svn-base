<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>部门管理</title>
    <%@ include file="../index/headcss.jsp" %>
</head>

<body>

<div class="menu-list">

    <!-- tree -->
    <div class="layui-col-xs3 layui-col-sm3 layui-col-md3 layui-col-lg2 h100 treeBox" style="overflow:auto">

        <div id="tree" class="tree">
        </div>
    </div>

    <div class="layui-col-xs9 layui-col-sm9 layui-col-md9 layui-col-lg10 h100 tableBox">
        <iframe border="0" frameborder="no" name="treeFrame" id="treeFrame" src="<%=basePath%>/section/list.do?currentPage=${null == pd.currentPage || '' == pd.currentPage?'1':pd.currentPage}&areaCode=${pd.areaCode}" style="margin: 0 auto; width: 100%; height: 100%;border:0"></iframe>
    </div>

</div>

<%@ include file="../index/foot.jsp" %>
<script type="text/javascript">
	$(function(){
	    console.log(${zTreeNodes})
        var tree = $.Tree({
            el: $("#tree"),
            data: ${zTreeNodes},
            callback:function(obj){
                $(".treeItem").each(function(){
                    $(this).removeClass("active")
                })
                $("#tree").find(".lev"+obj.lev).children(".treeItem").addClass("active")
                document.getElementById('treeFrame').src = "<%=basePath%>section/list.do?DEPARTMENT_ID=" + obj.id+"&areaCode="+obj.SZQY_CODE;
            },
            //下拉异步回掉
            switchCallback: function (obj) {
                if(obj.children == ""){
                    var index= obj.id;
                    getMap(index,tree)
                }

            }
        })
        $("#tree").find('.lev1 .item-switch') .click(); 

        function getMap(index,tree){
            $.post("<%=basePath%>section/listDepartmentByPid",{pid:index},function(data){
                data= eval(data)
                if(data==""){
                    return;
                }
                var pid= data[0].pid
                if(index == 0){
                    tree.refresh(data);
                    return
                }
                var parentData= tree.data;

                tree.findOne(pid,function(obj){
                    if(obj.children == ""){
                        obj.children= data;
                    }
                    tree.rec(data,function(obj,index){
                        tree.operation(obj,index);
                    },obj.lev)

                })
                console.log(tree.data)
            })
        }
	})

</script>
</body>
</html>