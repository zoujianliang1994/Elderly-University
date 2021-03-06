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
    <title>学生注册</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body class="sign-student-page" style="overflow: hidden;">
<div class="tableBox " style="height: 100%;">

    <!-- table -->
    <div class="student-info-form" >
        <div class="student-info-form-left">
            <img src="<%=basePath%>static/source/public/images/stu-left-book.png" />
        </div>
        <div class="student-info-form-right">
            <div class="student-info-form-right-wirte">
                <p>欢迎注册</p>
                <form action="${msg}.do" class="layui-form" id="editForm"  lay-filter="editForm" method="post" style="text-align: center;border-left: 1px solid #dce3eb;">
                	<input type="hidden" name="SCHOOL_ID" value="${pd.SCHOOL_ID}">
                	<input type="hidden" name="SCHOOL_NAME" value="${pd.SCHOOL_NAME}">
                	<input type="hidden" name="timestamp"  id="timestamp" value="">
                	
                    <div class="layui-form-item" style="padding-bottom: 4px;border-bottom: 1px solid #dce3eb;">
                        <div class="layui-form-item">
                            <label class="form-label">手机号<span class="colon"></span></label>
                           <div class="layui-input-block " style="width: 19rem;">
                                <input type="text" id="phone-num" required lay-verify="required" name="phone"
                                       autocomplete="off" maxlength="200"
                                       class="layui-input layui-input-color">
                            </div>
                        </div>
                        <div class="layui-form-item">

                            <label class="form-label">验证码<span class="colon"></span></label>
                           <div class="layui-input-block  ver-code" style="width: 13rem;float: left;">
                                <input type="text" id=""  required lay-verify="required" name="code"
                                       autocomplete="off" maxlength="200"
                                       class="layui-input layui-input-color">
                            </div>



                            <button id="get-btn" class="get-btn">获取验证码</button>


                        </div>
                        <div class="layui-form-item">
                            <label class="form-label">登录密码<span class="colon"></span></label>
                           <div class="layui-input-block " style="width: 19rem;">
                                <input type="password" id="PASSWORD"  required lay-verify="required" name="password"
                                       autocomplete="off" maxlength="200"
                                       class="layui-input layui-input-color">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="form-label">确定密码<span class="colon"></span></label>
                           <div class="layui-input-block " style="width: 19rem;">
                                <input type="password" id="QRPASSWORD"  required lay-verify="required" name="re_password"
                                       autocomplete="off" maxlength="200"
                                       class="layui-input layui-input-color">
                            </div>
                        </div>




                    </div>

                </form>
                <div class="btnbox" id="btnDiv" >
                    <button id="sure" class="layui-btn layui-btn-primary layui-btn-small" style="width: 8rem;height: 3rem;"  >立即注册</button>
                </div>
            </div>
        </div>
    </div>
</div>


<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
    $(function () {
        function invokeSettime(obj){
            var countdown=60;
            settime(obj);
            function settime(obj) {
                if (countdown == 0) {
                    $(obj).text("获取验证码").attr("disabled",false).css({"width":"6rem","cursor":"pointer"});
                    $(".ver-code").css({"width":"13rem"})
                    countdown = 60;
                    return;
                } else {
                    $(obj).text("(" + countdown + ") s 重新发送").attr("disabled",true).css({"width":"8rem","cursor":"not-allowed"});
                    $(".ver-code").css({"width":"11rem"})
                    countdown--;
                }
                setTimeout(function() {
                        settime(obj) }
                    ,1000)
            }
        }
        $("#get-btn").on("click",function () {
            if ($("#phone-num").val() == "") {
                layer.tips('手机号码不能为空', $("#phone-num"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#phone-num").focus();
                return false;
            }
            var  mobile=$("#phone-num").val()
            var that=this;
            $.ajax({
                url:"<%=basePath%>studentRegister/sendSms.do",
                data:{mobile:mobile},
                type:"post",
                success:function (data) {
                	if(data.msg=='success'){
                		$("#timestamp").val(data.timestamp);
                		invokeSettime(that);
                        console.log(data.msg)
                	}else{
                        layer.msg('验证码发送失败，请稍后再试!', {icon: 5});
                	}
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
            })
        })
    })
    $("#sure").on("click", function () {
        if ($("#phone-num").val() == "") {
            layer.tips('手机号码不能为空', $("#phone-num"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#phone-num").focus();
            return false;
        }

        if ($("#PASSWORD").val() == "") {
            layer.tips('登陆密码不能为空', $("#PASSWORD"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#PASSWORD").focus();
            return false;
        }
        if ($("#QRPASSWORD").val() == "") {
            layer.tips('请确定密码', $("#QRPASSWORD"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#QRPASSWORD").focus();
            return false;
        }
        if ($("#PASSWORD").val() != $("#QRPASSWORD").val()) {
            layer.tips('两次密码不相同', $("#QRPASSWORD"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#QRPASSWORD").focus();
            return false;
        }
        parent.layer.load(1);
        $.post('${msg}.do', $('#editForm').serialize(), function (data) {
            parent.layer.closeAll('loading');
            if ("success" == data.msg) {
                parent.layer.msg('注册成功', {
                    icon: 1,
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                }, function(){
                    window.location.href = "<%=basePath%>login_toLogin.do";
                });



            } else if("codeError"==data.msg){
            	$("#code").focus();
                layer.msg('验证码错误，请填写正确验证码!', {icon: 5});
            }else if("codeTimeOut"==data.msg){
            	layer.msg('验证码过期，请重新获取验证码!', {icon: 5});
            }else {
                layer.msg('系统繁忙，请稍后重试!', {icon: 5});
            }
        });
        return false; // 阻止表单自动提交事件
    });

</script>
</body>
</html>