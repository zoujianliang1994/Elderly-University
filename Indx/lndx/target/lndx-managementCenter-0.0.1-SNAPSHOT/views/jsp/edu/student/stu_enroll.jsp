<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>我要报名</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>

<div class="tableBox">
    <div class="my-apply btn-left">
        我要报名
    </div>
    <div class="my-yet btn-right">
        查看已报班级
    </div>
    <div class="layui-col-sm12 student-know">
        <p >老年大学招生学员须知</p>
        <ul class="enrollment-list" >
            <li>一、报名时间：1月7日-10日、2月27日-28日、3月1日</li>
            <li>二、报名地点：成都市金牛区老年办</li>
            <li>三、所需证件：本人身份证(二代)</li>
            <li>四、报名条件：</li>
            <li>1、周一至周五班，女年满45周岁、男年满50周岁以上，由本人持本人身份证报名。</li>
            <li>2、参加周一至周五晚班学习者，要求年龄在70周岁以下。</li>
            <li>3、报名者需有完全行为能力、身心健康。入学后，在校期间如因自身原因或突发疾病导致意外事件发生，后果自负。</li>
            <li>4、学校建议学员购买“老年人意外伤害险”（10元/年）。</li>
            <li>5、填写《学员登记表》时，内容要填写齐全，字迹工整，确认无误后，本人签字，方可予以报名。(温馨提示：为了便于处理应急事件，请您务必准确填写家属电话)。</li>
            <li>6、请认真阅读招生简章，慎重选择好学科、专业及上课时间。报名注册后，一经交费，一律不予退费、转班（极特殊情况按学校有关规定办理）。</li>
            <li>五、咨询电话：招生管理处58567809 收发室58567810</li>
        </ul>

        <div class="btnbox" id="btnDiv">
            <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small"style="width: 13rem;border: 0px;background-color: #e3e4e5;color: #999;">取消</button>
            <button id="sure" class="layui-btn layui-btn-primary layui-btn-small" style="width: 13rem;">同意以上协议并报名</button>
        </div>

    </div>



</div>
<div id="hint" style="display: none">
    <div class="hint-content">请完善个人信息之后再报名</div>
    <div class="btnbox">
        <button id="hintSure" class="layui-btn layui-btn-primary layui-btn-small" style="width: 13rem;">完善个人信息</button>
    </div>
</div>

<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">

    $(function(){
        console.log('${isgo}')
        if('${isgo}'=="true"){
            $("#hint").css("display","block");
            layer.open({
                skin: 'demo-class',
                title:"提示",
                type: 1,
                content: $("#hint"),
                closeBtn: 0,
                area: ["300px", "200px"],
            })
            
        }
        $("#hintSure").on("click",function () {
            $("#hint").css("display","none");
            window.location.href = "<%=basePath%>student/goDataFinish?isgo=${isgo}";
            layer.closeAll();
        })
        $(".my-yet").on("click",function () {
        	 window.location.href = "<%=basePath%>studentEnroll/listGrades";
        })


        $("#sure").on("click",function(){
            window.location.href = "<%=basePath%>studentEnroll/goGrades.do";
        })
    })



</script>
</body>
</html>