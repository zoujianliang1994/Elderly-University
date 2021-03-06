<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>找回密码</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body class="password-reset" style="overflow: hidden;">
<div class="tableBox " style="height: 100%;">

    <!-- table -->
    <div class="password-reset-tab" >
        <p class="password-reset-title">忘记密码</p>
        <div class="password-reset-content">
            <div id="sfle03" class="stepflex">
                <dl class="first doing">
                    <dt class="password-reset-line"></dt>
                    <div style=" float: left;width: 2rem;">
                        <dt class="s-num">
                            <i class="iconfont icon-1" style="font-size: 30px"></i>
                        </dt>
                        <dt class="s-text" >填写账号信息</dt>
                    </div>

                    <dt class="password-reset-line"></dt>
                </dl>
                <dl class="normal">
                    <dt class="password-reset-line"></dt>
                    <div style=" float: left;width: 2rem;">
                        <dt class="s-num">
                            <i class="iconfont icon-2" style="font-size: 30px"></i>
                        </dt>
                        <dt class="s-text" >设置新密码</dt>
                    </div>

                    <dt class="password-reset-line"></dt>
                </dl>
                <dl class="normal">
                    <dt class="password-reset-line"></dt>
                    <div style=" float: left;width: 2rem;">
                        <dt class="s-num">
                            <i class="iconfont icon-chenggong2" style="font-size: 30px"></i>
                        </dt>
                        <dt class="s-text" >成功</dt>
                    </div>

                    <dt class="password-reset-line"></dt>
                </dl>
            </div>
            <div class="form formno" style="width: 65%;margin:auto;">
                <div class="layui-form form-id" style=" padding-top: 100px;">
                    <div class="layui-form-item" style="width: 23rem;margin: auto;">
                        <label class="layui-form-label" style="width: 3rem;margin-right: 1rem">账号</label>
                       <div class="layui-input-block " style="width: 300px;float: left;">
                            <input type="text" id="user_id" class="layui-input-color layui-input" nmae="USERNAME">
                        </div>
                    </div>
                    <div class="btnbox" style="text-align: center;border-left: 1px solid #dce3eb;">
                        <button id="next" class="layui-btn layui-btn-primary layui-btn-small" >下一步</button>
                    </div>
                </div>
                <div class="layui-form form-reset" style=" padding-top: 100px;">
                    <div class="layui-form-item reset-item" >
                        <label class="layui-form-label" style="width: 5rem;margin-right: 1rem">验证码</label>
                       <div class="layui-input-block " style="width: 300px;float: left;">
                            <input type="text" id="auth_code" class="layui-input-color layui-input" name="code">
                        </div>
                    </div>
                    <div class="layui-form-item reset-item">
                        <label class="layui-form-label" style="width: 5rem;margin-right: 1rem">新密码</label>
                       <div class="layui-input-block " style="width: 300px;float: left;">
                            <input type="password" id="new_password" class="layui-input-color layui-input" name="NEW_PASSWORD">
                        </div>
                    </div>
                    <div class="layui-form-item reset-item" >
                        <label class="layui-form-label" style="width: 5rem;margin-right: 1rem">确定新密码</label>
                       <div class="layui-input-block " style="width: 300px;float: left;">
                            <input type="password" id="sure_password" class="layui-input-color layui-input">
                        </div>
                    </div>
                    <div class="btnbox" id="btnDiv" style="text-align: center;border-left: 1px solid #dce3eb;">
                        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small" >确定</button>
                    </div>
                </div>
                <div class="layui-form succsee-reset" style=" padding-top: 100px;">
                    <div class="success-content">
                        <div class="success-icon">
                            <i class="iconfont icon-chenggong"></i>
                        </div>
                        <div class="success-text">
                            <p>密码修改成功</p>
                            <div class="time-hint">
                                <span class="time-down">5</span>
                                <span>s 秒后将自动跳转登录</span>
                            </div>
                        </div>
                        <div class="btnbox btn-login">
                            <button id="go_login" class="layui-btn layui-btn-primary layui-btn-small" >去登录</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
    $(function () {
        var timestamp='';
        $("#next").on("click", function () {

            function nextStep() {
                $(".form-reset").css("display","block");
                $(".form-id").css("display","none");
                $("#sfle03 dl:nth-child(1)").removeClass("doing");
                $("#sfle03 dl:nth-child(2)").addClass("doing");
            }

            if ($("#user_id").val() == "") {
                layer.tips('账号不能为空', $("#user_id"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#user_id").focus();
                return false;
            }
            parent.layer.load(1);
           $.ajax({
               url:"<%=basePath%>/user/validateUserName.do?USERNAME="+$("#user_id").val(),
               type:"post",
               success:function(data){
            	   parent.layer.close(1);
                   console.log(data);
                   timestamp=data.timestamp;
                   if(data.result=="noneUsers"){
                       layer.msg('用户不存在');
                       layer.close(1);
                       return false;

                   }
                   if(data.result=="error"){
                       layer.msg("系统错误");
                       layer.close(1);
                       return false;
                   }
                   nextStep();
               },
               error:function(err){
                    console.log(err)
             	   parent.layer.close(1);

               }
           })
        });
        $("#sure").on("click",function () {


            // invokeSettime()
            function invokeSettime(){

                $(".succsee-reset").css("display","block");
                $(".form-reset").css("display","none");
                $("#sfle03 dl:nth-child(2)").removeClass("doing");
                $("#sfle03 dl:nth-child(3)").addClass("doing");
                var countdown=5;
                settime();
                function settime() {
                    if (countdown == 0) {

                        //跳转登录
                        window.location.href = "<%=basePath%>login_toLogin.do";
                        return;
                    } else {
                        $(".time-down").text(countdown);
                        countdown--;
                    }
                    setTimeout(function() {
                            settime() }
                        ,1000)
                }
            }

            if ($("#auth_code").val() == "") {
                layer.tips('验证码不能为空', $("#auth_code"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#auth_code").focus();
                return false;
            }
            if ($("#new_password").val() == "") {
                layer.tips('新密码不能为空', $("#new_password"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#new_password").focus();
                return false;
            }
            if ($("#sure_password").val() == "") {
                layer.tips('确定新密码不能为空', $("#sure_password"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#sure_password").focus();
                return false;
            }
            if ($("#sure_password").val() != $("#new_password").val()) {
                layer.tips('两次输入密码不同', $("#sure_password"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#sure_password").focus();
                return false;
            }
            console.log("<%=basePath%>/user/resetPwd.do?code="+$("#auth_code").val()+"&NEW_PASSWORD="+$("#sure_password").val()+"&USERNAME="+$("#user_id").val()+"&timestamp="+timestamp)
            parent.layer.load(1);
            $.ajax({
                url:"<%=basePath%>/user/resetPwd.do?code="+$("#auth_code").val()+"&NEW_PASSWORD="+$("#sure_password").val()+"&USERNAME="+$("#user_id").val()+"&timestamp="+timestamp,
                type:"post",
                success:function (data) {
                    parent.layer.close(1);
                    if(data.result=="codeError"){
                        layer.msg('验证码不对');
                        return false

                    }
                    if(data.result=="codeTimeOut"){
                        layer.msg('验证码超时');
                        return false
                    }
                    if(data.result=="error"){
                        layer.msg('系统错误');
                        return false
                    }
                    invokeSettime()
                },
                error:function (err) {
                    parent.layer.close(1);
                    layer.msg('系统错误');
                    console.log(err)
                }
            })


        });
        $("#go_login").on("click",function () {
            window.location.href = "<%=basePath%>login_toLogin.do";
        });
    })

</script>
</body>
</html>