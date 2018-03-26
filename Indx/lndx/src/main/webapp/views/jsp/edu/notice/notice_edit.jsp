<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>公告编辑</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
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
    .layui-layer-setwin .layui-layer-close1 {
        background-position: 0;
        cursor: pointer;
    }
</style>

<div class="edit_menu">

    <form action="${msg}.do" class="layui-form" id="editForm" enctype="multipart/form-data" lay-filter="editForm" method="post">
        <input type="text" id="selectId" name="selectId" style="display: none">
        <input type="hidden" id="id" name="id" value="${message.id}">
        <input type="hidden" id="target" name="target" value="${message.id}">
        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline">
                    <label class="form-label"><i class="require">*</i>公告名称<span class="colon"></span></label>
                   <div class="layui-input-block ">
                        <input type="text" value="${message.title }" name="title" id="title" required lay-verify="required" placeholder="请输入公告名称"
                               autocomplete="off" maxlength="200"
                               class="layui-input layui-input-color">
                    </div>
                </div>

                <div class="form-item-inline">
                    <label class="form-label"><i class="require">*</i>创建日期<span class="colon"></span></label>
                   <div class="layui-input-block ">
                        <input type="text" value="${message.createTime }" name="createTime" id="createTime" required lay-verify="required" placeholder="请输入创建日期"
                               autocomplete="off"
                               class="layui-input layui-input-color">
                    </div>
                </div>

            </div>
        </div>

        <div class="layui-form-item" id="mimaDiv">
            <div class="layui-row">

                <div class="form-item-inline">
                    <label class="form-label"><i class="require">*</i>发布日期<span class="colon"></span></label>
                   <div class="layui-input-block ">
                        <input type="text" value="${message.publishTime }" name="publishTime" id="publishTime" required lay-verify="required" placeholder="请输入发布日期"
                               autocomplete="off"
                               class="layui-input layui-input-color">
                    </div>
                </div>
                <div class="form-item-inline">
                    <label class="form-label"><i class="require">*</i>公告类别<span class="colon"></span></label>
                   <div class="layui-input-block ">
                        <html:select id="type" name="type" classs="layui-input-inline">
                            <html:options collection="notice_class" defaultValue="${message.type}"></html:options>
                        </html:select>
                    </div>
                </div>

            </div>
        </div>

        <div class="layui-form-item">
            <div class="form-item-inline" style="width:98%;">
                <label class="form-label">发布范围</label>
               <div class="layui-input-block  input-btn" style="width: 90%;float: left;">
                    <input type="text" value="${message.publishRange }" name="publishRange" id="publishRange" required lay-verify="required" placeholder="请选择发布范围"
                           autocomplete="off" readonly class="layui-input layui-input-color">
                </div>
                <div id="btn-publish" class="layui-input-block layui-input-color" style="width: 10%;height: 38px;float: left;border: 1px solid #dce3eb;text-align: center;cursor: pointer;">选择</div>

            </div>


        </div>

        <div class="layui-form-item">

            <div class="layui-row">
                <div class="form-item-inline" style="width:98%;">
                    <label class="form-label" >通知内容<span class="colon"></span></label>
                   <div class="layui-input-block " >
                        <textarea class=" layui-textarea layui-input-color" name="content" id="content"
                            placeholder="请输入通知内容">${message.content}</textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">

            <div class="layui-row">
                <div class="form-item-inline" style="position: relative;width: 98%">
                    <label class="form-label">附件上传<span class="colon"></span></label>
                    <c:choose>
                        <c:when test="${pd.TYPE==1}">
                           <div class="layui-input-block ">
                             <a style="color: #666;" href="<%=basePath%>attachment/fileDownload.do?fileName=${message.fileUrl}&filePath=${pd.filePath}">${message.fileUrl}<br></a>
                            </div>
                            <input type="text" name="fileUrl" value="${message.fileUrl}" hidden>
                        </c:when>
                        <c:otherwise>
                           <div class="layui-input-block ">
                                <div class="text-tip" style=" position:absolute;text-align: center;top: 6px;width: auto;">
                                    <div class="file-btn"  >
                                        选择文件
                                    </div>
                                    <div class="file-text">
                                        <c:choose>
                                        <c:when test="${not empty message.fileUrl}">
                                            <a style="color: #00b3ee" href="<%=basePath%>attachment/fileDownload.do?fileName=${message.fileUrl}&filePath=${pd.filePath}">${message.fileUrl}<br></a>

                                            <input type="text" name="fileUrl" value="${message.fileUrl}" hidden>
                                        </c:when>
                                            <c:otherwise>
                                                未选择文件
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                                <input type="file" name="noticeFile" class="" id="noticeFile" style="position: absolute;top: 6px;height: 2rem;width: 8rem;cursor: pointer;opacity: 0">
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

    </form>

    <div class="btnbox" id="btnDiv" hidden="true">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
    </div>
</div>

<div id="publish" style="display: none" class="edit_menu">
    <form action="${msg}.do" class="layui-form" id="editForm1" enctype="multipart/form-data" lay-filter="editForm" method="post">
        <div class="layui-form-item" style="margin: 0;">
            <div class="form-item-inline">
                <label class="layui-form-label" >目标对象</label>
               <div class="layui-input-block " style="float: left;">
                    <select lay-verify="">
                        <option value="">请选择</option>
                        <option value="0">所有人</option>
                        <option value="1">所有老师</option>
                        <option value="2">所有学员</option>
                        <option value="3">校区</option>
                        <option value="4">班级</option>
                        <option value="5">人员</option>
                    </select>
                </div>
            </div>
            <div class="form-item-inline">
                <label class="layui-form-label" >对象</label>
               <div class="layui-input-block " style="float: left;">
                    <input type="text" name="publishObj" id="publishObj" required lay-verify="required"
                           autocomplete="off"
                           class="layui-input layui-input-color">
                </div>
            </div>
        </div>

    </form>

    <div style="margin-left: 1.5%;display: none" id="school-show" class="layui-col-sm12">

        <div class="operationBox">
            <form action="list.do" method="post" class="layui-form" name="FormSchool" id="FormSchool" style="margin: 20px 0;">
                <div class=" fl" >
                    <input value="${pd.keywords }"  id="schoolwords" name="keywords"   type="text" placeholder="请输入学校名称" class="layui-input fl search layui-input-color">

                </div>
                <div class="fl srarchBtn" onclick="gsearchSchool()">
                    <i class="iconfont icon-sousuo"></i>
                    <span>搜索</span>
                </div>
            </form>
        </div>
        <table class="layui-table center" id="schoolTable">
            <colgroup>
                <col width="80">
                <col>
                <col>
                <col>
                <col width="170">
            </colgroup>
            <thead>
            <tr class="table-head-tr">
                <th>
                    <input type="checkbox" id="all-school">
                </th>
                <th>序号</th>
                <th>学校名称</th>
            </tr>
            </thead>
            <tbody class="school-list">

            </tbody>
        </table>
        <div class="laypageBox">
            <div id="laypage-school" class="fr"></div>
        </div>

    </div>

    <div style="margin-left: 1.5%;display: none" id="class-stu" class="layui-col-sm12" style="padding-left: 1.5%">
        <div class="operationBox">
        <form action="list.do" method="post" class="layui-form" name="FormClass" id="FormClass"style="margin: 20px 0;">
            <div class=" fl" >
                <input value="${pd.keywords }"  id="classwords" name="keywords"   type="text" placeholder="请输入班级" class="layui-input fl search layui-input-color">

            </div>
            <div class="fl srarchBtn" onclick="gsearchClass()">
                <i class="iconfont icon-sousuo"></i>
                <span>搜索</span>
            </div>
        </form>
        </div>
        <table class="layui-table center" id="table">
            <colgroup>
                <col width="80">
                <col>
                <col>
                <col>
                <col width="170">
            </colgroup>
            <thead>
            <tr class="table-head-tr">
                <th>
                    <input type="checkbox" id="all-class">
                </th>
                <th>序号</th>
                <th>班级名称</th>
                <th>对应课程</th>
            </tr>
            </thead>
            <tbody class="class-list">

            </tbody>
        </table>
        <div class="laypageBox">
            <div id="laypage" class="fr"></div>
        </div>
    </div>


    <div style="margin-left: 1.5%;display: none" id="stu-list" class="layui-col-sm12" style="padding-left: 1.5%">
        <div class="operationBox">
        <form action="list.do" method="post" class="layui-form" name="FormStu" id="FormStu"style="margin: 20px 0;">
            <div class=" fl" >
                <input value="${pd.keywords }"  id="stuwords" name="stuwords"   type="text" placeholder="请输入名字" class="layui-input fl search layui-input-color">
            </div>
            <div class="fl srarchBtn" onclick="gsearchStu()">
                <i class="iconfont icon-sousuo"></i>
                <span>搜索</span>
            </div>
        </form>
        </div>
        <table class="layui-table center" id="stu-table">
            <colgroup>
                <col width="80">
                <col>
                <col>
                <col>
                <col width="170">
            </colgroup>
            <thead>
            <tr class="table-head-tr">
                <th>
                    <input type="checkbox" id="all-checked">
                </th>
                <th>序号</th>
                <th>姓名</th>
                <th>身份证号</th>
                <th>类型</th>
            </tr>
            </thead>
            <tbody class="stu-list">

            </tbody>
        </table>
        <div class="laypageBox">
            <div id="laypage-stu" class="fr"></div>
        </div>
    </div>

    <div class="btnbox" id="sonBtn">
        <button id="sonSure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
        <button id="sonCancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
    </div>

</div>


<%@ include file="../../system/index/foot.jsp" %>
<script>
        $(function () {

        var form = layui.form;
        var TYPE = '${pd.TYPE}';

        $.myType(TYPE)

        layui.use('laydate', function () {
            var laydate = layui.laydate;

            //执行一个laydate实例
            laydate.render({
                elem: '#createTime' //指定元素
            });
            laydate.render({
                elem: '#publishTime' //指定元素
            });
        });
        layui.use('layedit', function(){
            var layedit = layui.layedit;
            layedit.build('content',{
                height:100,
                hideTool:[
                    // 'strong' //加粗
                    // ,'italic' //斜体
                    // ,'underline' //下划线
                    // ,'del' //删除线
                    // ,'|' //分割线
                    // ,'left' //左对齐
                    // ,'center' //居中对齐
                    // ,'right' //右对齐
                    ,'link' //超链接
                    ,'unlink' //清除链接
                    ,'face' //表情
                    ,'image' //插入图片
                    ,'help' //帮助
                ],

            }); //建立编辑器
        });

        $("#noticeFile").change(function (e) {

            name = test(this.value, ".");
            $("#name").text(test(this.value, "\\"));
            $("#test10").find("i").html("&#xe60a;");
        });
        function test(file_name, symbol) {
            var result = file_name.split(symbol);
            return result[result.length - 1];
        }

        $("#sure").on("click", function () {
            if ($("#title").val() == "") {
                layer.tips('公告名称不能为空', $("#title"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#title").focus();
                return false;
            }
            if ($("#createTime").val() == "") {
                layer.tips('创建日期不能为空', $("#createTime"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#createTime").focus();
                return false;
            }
            if ($("#publishTime").val() == "") {
                layer.tips('发布日期不能为空', $("#publishTime"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#publishTime").focus();
                return false;
            }
            if ($("#type").val() == "") {
                layer.tips('请选择公告类别', $("#type"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#type").focus();
                return false;
            }
            if ($("#content").val() == "") {
                layer.tips('通知内容不能为空', $("#content"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#content").focus();
                return false;
            }

            parent.layer.load(1);

            $("#editForm").ajaxSubmit({
                type: 'post',
                dataType: "html",
                success: function (data) {
                    var jso = JSON.parse(data);
                    if ("success" == jso.result) {
                        parent.layer.edit.location.href = "<%=basePath%>notice/list.do?currentPage=${currentPage}";
                        parent.layer.closeAll();
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

        $(window).on("click",function(){
            $("#adminSelect").hide();
        });

        $("#publishRange,#btn-publish").on("click", function () {
            var layer = layui.layer;
            $("#publish").css("display","block")
            layer.open({
                title:"选择发布",
                type: 1,
                content: $("#publish"),
                area: ["600px", "500px"],
                cancel: function(index, layero){
                    $("#publish").css("display","none")
                }


            })
        });

    });

        function eventBind() {
            $("#publish dd").on("click",function(){
                var str=$(this).text();
                $("#target").val(str);
                $("#publishRange").val(str);
                $(".school-list").html("");
                $(".class-list").html("");
                $(".stu-list").html("")
                $("#publishObj").val(str);
                if(str=="班级"){
                    $("#class-stu").css("display","block");
                    $("#school-show").css("display","none");
                    $("#stu-list").css("display","none");
                    getClass()
                }else if(str=="校区"){
                    $("#school-show").css("display","block");
                    $("#class-stu").css("display","none");
                    $("#stu-list").css("display","none");
                    getShool()
                }else if(str=="人员"){
                    $("#stu-list").css("display","block")
                    $("#school-show").css("display","none");
                    $("#class-stu").css("display","none");
                    getStudent()
                }else{
                    $("#stu-list").css("display","none");
                    $("#school-show").css("display","none");
                    $("#class-stu").css("display","none");
                }
            })
            $("#sonCancel").on("click", function () {
                layer.closeAll();
                $("#publish").css("display","none")
            });
            $("#all-checked,#all-class,#all-school").click(function(){
                if(this.checked){
                    $(" :checkbox").prop("checked", true);
                }else{
                    $(" :checkbox").prop("checked", false);
                }
            });
            $("#sonSure").live("click",function () {
                var str='';
                var id='';
                $("input[name='checkbox']").each(function(){
                    if($(this).is(":checked")){
                        if ($(this).attr("title")!=undefined){
                            str+=$(this).attr("title")+",";

                        }
                        if($(this).attr("data-id")!="undefined"){
                            id+=$(this).attr("data-id")+",";
                        }
                    }
                });
                id = id.split(",")[0];
                id = id.replace("/", ",");
                $("#selectId").val(id);
                if($("input[name='checkbox']").length>0){
                    $("#publishRange").val(str);
                }
                $("#publish").css("display","none")
                layer.closeAll();
            });
            $.myUploading("noticeFile",200,100)

            }


        eventBind()
        function getClass(data) {
            $.ajax({
                url:"<%=basePath %>grades/findBySchool",
                type:"post",
                data:data,
                success:function(data){

                    if(JSON.stringify(data)!="{}"){
                        var classData=JSON.parse(data.data);
                        // console.log(classData)
                        var html="";
                        for (var i=0;i<classData.length;i++){
                            html+="<tr><td><input type='checkbox'data-id="+classData[i].user_id+"  name='checkbox' title="+classData[i].name+" lay-skin='school'/></td>"+
                                "<td>"+(i+1)+"</td>"+
                                "<td>"+classData[i].name+"</td>"+
                                "<td>"+classData[i].name+"</td></tr>"
                        }

                        $(".class-list").append(html);
                        layui.use('laypage', function(){
                            var laypage = layui.laypage;

                            //执行一个laypage实例
                            laypage.render({
                                elem: 'laypage' //注意，这里的 test1 是 ID，不用加 # 号
                                ,count: classData.length  //数据总数，从服务端得到
                            });
                        });
                    }
                }
            })
        }
        function getShool(data) {
            $.ajax({
                url:"<%=basePath %>school/findSchoolById",
                type:"post",
                data:data,
                success:function(data){

                    if (JSON.stringify(data)!="{}"){

                        var classData=JSON.parse(data.data);

                        var html="";
                        for (var i=0;i<classData.length;i++){
                            console.log(classData[i])
                            html+="<tr><td><input type='checkbox' data-id="+classData[i].user_id+"  name='checkbox' title="+classData[i].name+" lay-skin='school'/></td>"+
                                "<td>"+(i+1)+"</td>"+
                                "<td>"+classData[i].name+"</td></tr>"
                        }
                        // html+="</form>"
                        $(".school-list").append(html);

                        layui.use('laypage', function(){
                            var laypage = layui.laypage;
                            laypage.render({
                                elem: 'laypage-school' //注意，这里的 test1 是 ID，不用加 # 号
                                ,count: classData.length //数据总数，从服务端得到
                            });
                        });
                    }
                }
            })
        }
        function getStudent(data) {
            $.ajax({
                url:"<%=basePath %>notice/findPersonBySid",
                type:"post",
                data:data,
                success:function(data){

                    if(JSON.stringify(data)!="{}"){
                        var classData=JSON.parse(data.data)
                        // console.log(classData)
                        var html="";
                        for (var i=0;i<classData.length;i++){
                            html+="<tr><td><input type='checkbox'  name='checkbox' title="+classData[i].name+" lay-skin='school'data-id="+classData[i].user_id+"></td>"+
                                "<td>"+(i+1)+"</td>"+
                                "<td>"+classData[i].name+"</td>"+
                                "<td>"+classData[i].sfz+"</td>"+
                                "<td>"+classData[i].type+"</td></tr>"
                        }

                        $(".stu-list").append(html);
                        layui.use('laypage', function(){
                            var laypage = layui.laypage;
                            laypage.render({
                                elem: 'laypage-stu' //注意，这里的 test1 是 ID，不用加 # 号
                                ,count: classData.length //数据总数，从服务端得到
                            });
                        });
                    }
                }
            })
        }

        function gsearchClass() {
            $(".class-list").html("");
            var keywords=$("#classwords").val()
            var data={"keywords":keywords}
            getClass(data);
        }

        function gsearchSchool() {
            $(".school-list").html("");
            var keywords=$("#schoolwords").val()
            var data={"keywords":keywords}
            getShool(data);
        }

        function gsearchStu() {
            $(".stu-list").html("")
            var keywords=$("#stuwords").val();
            var data={"keywords":keywords};
            getStudent(data);
        }

</script>
</body>
</html>