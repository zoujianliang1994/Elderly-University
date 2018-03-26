<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<meta http-equiv="X-UA-Compatible" content="IE=11">
<head>
    <title>登录</title>
    <%@ include file="./headcss.jsp" %>
    <link rel="shortcut icon" href="<%=basePath%>static/source/public/images/lhb.png" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/source/public/css/login.css"/>
    <style></style>
</head>
<body class="hidden">
<div class="loginbody">
    <div class="earthbg">
        <img class="wh100" src="<%=basePath%>static/source/public/images/login-book.jpg"/>
    </div>

    <div class="mapbg"></div>
    <div class="loginBox">
        <div class="input-group">
            <label class="username ">账&nbsp;&nbsp;&nbsp;&nbsp;号</label>
            <input class="login-input fl " id="user" placeholder="用户名" maxlength="20" style="font-size: 16px"/>
        </div>
        <div class="input-group">
            <label class="password">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
            <input class="login-input fl" id="password" placeholder="密码" type="password" maxlength="20"style="font-size: 16px" />
        </div>
        <div class="input-group" style="width: 16rem;float: left;">

                <label class="username ">验证码</label>
                <input class="login-input fl " id="auth-code" maxlength="20" style="width: 10rem;font-size: 16px"/>

        </div>
        <div class="layui-inline" id="code" onclick="createCode()"style="text-align: center;width: 10rem;height: 3.5rem;background-color: #f7dd2c;color: #9f8e1c;border: 0;margin-bottom: 45px;line-height: 3.5rem"></div>

        <div class="login-btn" id="login">登&nbsp;&nbsp;录</div>
        <div style="margin-top: 20px;color: #fff;font-size: 16px">
            <div style="float: left;width: 50%;text-align: left;">
                <span onclick="goPasswordReset()" style="color: #fff;cursor: pointer;padding-left: 2%;">忘记密码</span>
            </div>
            <div style="float: left;width: 50%;text-align: right;">
                <span onclick="goRegister()" style="color: #fff;cursor: pointer;">学员注册</span>
            </div>

        </div>
    </div>
</div>
<%@ include file="./foot.jsp" %>

<%--<script color="255,255,255" opacity='0.6' zIndex="0" count="120" src="<%=basePath%>static/source/public/js/canvas-nest.js"></script>--%>


<script type="text/javascript">
    function goPasswordReset() {
        window.location.href = "<%=basePath%>user/goPasswordBack.do";
    }

    function goRegister() {
        window.location.href = "<%=basePath%>studentRegister/goRegister.do";
    }
    var code;
    function createCode(){
        //首先默认code为空字符串
        code = '';
        //设置长度，这里看需求，我这里设置了4
        var codeLength = 4;
        var codeV = $('#code');
        //设置随机字符
        var random = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R', 'S','T','U','V','W','X','Y','Z');
        //循环codeLength 我设置的4就是循环4次
        for(var i = 0; i < codeLength; i++){
            //设置随机数范围,这设置为0 ~ 36
            var index = Math.floor(Math.random()*36);
            //字符串拼接 将每次随机的字符 进行拼接
            code += random[index];
        }
        //将拼接好的字符串赋值给展示的Value
        codeV.html(code);
    }

    $(function(){
        createCode();

    })

    var resize4win = LLW.later(function () {
        var $win, $box, $bg, winsize, loginsize, bgsize;
        $win = $(window);
        $box = $('.loginBox');
        $bg = $('.mapbg');
        winsize = {
            w: $win.width(),
            h: $win.height()
        };
        loginsize = {
            w: $box.width(),
            h: $box.height()
        };
        bgsize = {
            w: $bg.width(),
            h: $bg.height()
        };
        if ('undefined' === typeof resize4win.FIRST) {
            $box.css({
                top: (winsize.h / 2 - loginsize.h / 2) + 'px',
                left: (winsize.w / 2 - loginsize.w / 2) + 'px'
            });
            $bg.css({
                top: (winsize.h / 2 - bgsize.h / 2) + 'px',
                left: (winsize.w / 2 - bgsize.w / 2) + 'px'
            });
            $('body').removeClass('hidden');
            $('#user').focus();
            resize4win.FIRST = true;
        } else {
            $box.animate({
                top: (winsize.h / 2 - loginsize.h / 2) + 'px',
                left: (winsize.w / 2 - loginsize.w / 2) + 'px'
            }, 150);
            $bg.animate({
                top: (winsize.h / 2 - bgsize.h / 2) + 'px',
                left: (winsize.w / 2 - bgsize.w / 2) + 'px'
            }, 150);
        }
    }, 300);

    //避免频繁提交登录
    function isdoing(issubmit) {
        if (true === issubmit) {
            if (true === isdoing.BUSY) {
                return true;
            }
            $('#login').text('登录中...');
            isdoing.BUSY = true;
            return false;
        } else {
            $('#login').text('登录');
            isdoing.BUSY = false;
            return false;
        }
    }

    $(function () {
        function validate(){
            var oValue = $("#auth-code").val().toUpperCase();
            if(oValue ==0){
                alert('请输入验证码');
            }else if(oValue != code){
                alert('验证码不正确，请重新输入');
                oValue = ' ';
                createCode();
            }else{
                login(user, password);
            }
        }
        var layer = layui.layer;
        $("#login").on("click", function () {
            validate()
        });
        // $('#user,#password').on('keyup', function (e) {
        //     var ev = e || window.event;
        //     if (13 === ev.keyCode) {
        //         login(user, password);
        //     }
        // });

        $(function () {
            $('input:first').focus();//直接定位到当前页面的第一个文本框
            var $inp = $('input');//所有文本框
            console.log($inp);
            $inp.bind('keydown', function (e) {
                var key = e.which;
                if (key == 13) {
                    e.preventDefault();
                    var nxtIdx = $inp.index(this)+1;
                    console.log($(":input:eq(" + nxtIdx + ")"))
                    $(":input:eq(" + nxtIdx + ")").focus();
                }
            });
            $('#auth-code').on('keyup', function (e) {

                var ev = e || window.event;
                if (13 === ev.keyCode) {
                    if ($("#auth-code").val().length>3){
                        validate();
                    }
                }
            });

        });


        //服务叫校验
        function login(user, password) {
            var $user = $("#user");
            var $password = $("#password");
            var user = $user.val();
            var password = $password.val();
            if (user == "") {
                layer.tips('账号不能为空', $user);
                return
            }
            if (password == "") {
                layer.tips('密码不能为空', $password);
                return
            }
            //通过前端校验"src/main/webapp/views/jsp/system/index/headcss.jsp"
            if (isdoing(true)) {
                return;
            }

            var code = user + ",fh," + password;
            $.post("<%=basePath%>/login_login", {KEYDATA: code, tm: new Date().getTime()}, function (data) {
                if (data.result == "usererror") {
                    isdoing(false);
                    layer.msg("登陆失败,用户名或密码错误！", {icon: 2});
                } else if(data.result =="error"){
                    isdoing(false);
                    layer.msg("登陆失败,缺少参数！", {icon: 2});
                }else if (data.result == "success") {
                    window.location.href = '<%=basePath%>to_module.do?areaCode=5101&menuId=0';
                    <%--window.location.href = "<%=basePath%>to_module_list.do";--%>
                }else{
                    isdoing(false);
                    layer.msg("服务器繁忙，登陆失败！", {icon: 2});
                }
            })
        }

        $(window).resize(resize4win);       //自适应居中
        resize4win();
    })

</script>
</body>
</html>
