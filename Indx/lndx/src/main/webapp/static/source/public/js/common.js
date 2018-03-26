$.extend({
    //判断身份证号码是否合格
    isCardId:function (card) {
         // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if(reg.test(card)){
            return true;
        } else {
            return false;
        }
    },
//判断是否为合格邮箱
    isEmail:function (mail) {
        var myreg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
        if (myreg.test(mail)) {
            return true;
        } else {
            return false;
        }
    },
    // 判断是否为手机号
    isPoneAvailable: function (pone) {
        var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
        if (myreg.test(pone)) {
            return true;
        } else {
            return false;
        }
    },
    // 判断是否为电话号码
    isTelAvailable: function (tel) {
        var myreg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
        if (!myreg.test(tel)) {
            return false;
        } else {
            return true;
        }
    },
    // 日期时间比较
    compareDate: function (d1,d2)
    {
        return ((new Date(d1.replace(/-/g,"\/"))) > (new Date(d2.replace(/-/g,"\/"))));
    },

    //数组对象中的某个字段转字符串，都好分割
	getString: function(arr,str){
		var len= arr.length;
		var data=[];
		for(var i=0;i<len;i++){
			data.push(arr[i][str])
		}
		return data.join(",")
	},//字符串转数组
	toArr:function(str){
		var arr=[];
		var strArr= str.split(",");
		for(var i=0;i<strArr.length;i++){
			if(strArr[i] != ""){
				arr.push(strArr[i])
			}
		}
		return arr;
	},//form表单变div
	formToDiv:function(mark,TYPE){
		var that= this;
		if(mark){
			$(".layui-form input,.my-form input").each(function(){
				switch($(this).attr("type")){
					case "text":
                        that.setVal($(this),'.layui-input-block')
						break;
                    case "password":
                        that.setVal($(this),'.layui-input-block')
                        break;
                    case "number":
                        that.setVal($(this),'.layui-input-block')
                        break;
                    case "checkbox":
                        if($(this)[0].checked){
                            var $block= $(this).next()
                            var title= $block.children("span").text();
                            $block.children("i").remove();
                        }else{
                            $(this).next().remove()
                        }
                        break;
                    case "radio":
                        var $next= $(this).next();
                        console.log($next)
                        if(!$next.hasClass("layui-form-radioed")){
                            $next.hide();
                        }else{
                            $next.find("i").hide();
                        }

				}

			});
			$("#sonTable input").each(function(){
                switch($(this).attr("type")) {
                    case "text":
                        that.setVal($(this), 'td')
                        break;
                }
            })
            if(1==TYPE){
                $(".layui-form textarea").each(function(){
                    that.setVal($(this),'.layui-input-block')
                })
            }



		}
	},//给最近的父类class赋值

	setVal:function(obj,parent){
        var val= $(obj).val();
        $(obj).closest(parent).html(val);
	},//layTree选中active事件
	treeActive:function(dom){
        dom.find("a").first().addClass("active");
        dom.on("click","a",function(){
            dom.find("a").each(function(){
                $(this).removeClass("active")
            })
            $(this).addClass("active");
        })
	},
	//判断当前浏览器
    browserType:function(){
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
        var isOpera = userAgent.indexOf("Opera") > -1; //判断是否Opera浏览器
        var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera; //判断是否IE浏览器
        var isEdge = userAgent.indexOf("Windows NT 6.1; Trident/7.0;") > -1 && !isIE; //判断是否IE的Edge浏览器
        var isFF = userAgent.indexOf("Firefox") > -1; //判断是否Firefox浏览器
        var isSafari = userAgent.indexOf("Safari") > -1 && userAgent.indexOf("Chrome") == -1; //判断是否Safari浏览器
        var isChrome = userAgent.indexOf("Chrome") > -1 && userAgent.indexOf("Safari") > -1; //判断Chrome浏览器
        if (isIE) {
            var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
            reIE.test(userAgent);
            var fIEVersion = parseFloat(RegExp["$1"]);
            if(fIEVersion == 7)
            { return "IE7";}
            else if(fIEVersion == 8)
            { return "IE8";}
            else if(fIEVersion == 9)
            { return "IE9";}
            else if(fIEVersion == 10)
            { return "IE10";}
            else if(fIEVersion == 11)
            { return "IE11";}
            else
            { return "0"}//IE版本过低
        }//isIE end
        return false;
    },
    getCPU:function(){
        var agent=navigator.userAgent.toLowerCase();
        if(agent.indexOf("win64")>=0||agent.indexOf("wow64")>=0) return "x64";
        return navigator.cpuClass;
    },
    myType: function (TYPE){
        console.log(TYPE)
        if (1 == TYPE ) {//查看
            $(".layui-textarea").parent().addClass("textarea");
            $.formToDiv(true,TYPE);
            $("#btnDiv").hide();
            $("#cancel").hide();
            $(".require").hide();
            $(".colon").show();
            $("input,select,radio,textarea").attr("disabled", "disabled").css("background-color", "#f2f2f2");
            $("input").removeAttr("placeholder", "");
            $("label").addClass("layui-form-label");
            $("label").removeClass("form-label");
            $(".layui-input-block").css("color","#333");
            $("#btn-publish").hide();
            $(".input-btn").css({"width":"auto"});
            $("#addList").hide();
            $(".text-max").css({"width":"120px"})
            $(".form-item-inline").css("top","0");
            $("#sonTable .del").hide();
            $(".title-max>span").css("display","block");
            $(".title-max").css("width","54px");
            $(".layui-form .layui-input-block ").css("float","left");
            $(".layui-form-item ").css("margin-bottom","0");
            $(".red-star").hide();
            $(".teachPlan-label").css("width","58px");
            $(".layui-form-unit").css("display","block");
            $(".is-upload").html("没有上传");
            $(".layui-label-unit").hide();
            $(".age-min-block").css({"width":"auto",})
            $(".age-max-block").css({"width":"auto",})
            $(".form-state").show();
            $(".isPasswordLook").hide();
            $(".label-max").css("width","70px")
            $(".layui-form-radio").css("cursor","auto")
            $(".btn-label").hide()
            $(".teacher-edit .div-min").css("width","4rem");
            $(".teacher-edit .div-max").css("width","10rem");
            $(".studentInfo .div-max").css("width","8rem");
            $(".textarea").each(function(){
                if($(this).width()/$(this).parent().width()>0.99){
                    $(this).css({"line-height":"24px"})
                }
            })

        } else if (3==TYPE){//审核
            $.formToDiv(true,TYPE);
            $("#btnDiv").show();
            $(".colon").show();
            $(".require").hide();
            $("input,select,radio").css("background-color", "#f2f2f2");
            $("input").removeAttr("placeholder", "");
            $("label").addClass("layui-form-label");
            $("label").removeClass("form-label");
            $(".layui-input-block").css("color","#666");
            $(".form-item-inline").css("top","0");
            $(".textarea-block").css("width","80%");
            $(".title-max>span").css("display","block");
            $(".layui-form-item ").css("margin-bottom","0")
            $(".teachPlan-label").css("width","58px");
            $(".red-star").hide();
            $(".layui-form-unit").css("display","block");
            $(".is-upload").html("没有上传");
            $(".layui-label-unit").hide();
            $(".form-state").show();


        }else if(2==TYPE){//教师计划新增
            $("#btnDiv").show();
            $(".colon").hide();
            $(".layui-input-block").css("color","#000");
            $(".teachPlan-input-block").css("padding-left","0px")
            $(".textarea-block").css("width","100%");
            $(".isEdit").hide();
            $(".imgUpload").css("height","200px");
            $(".text-tip").each(function(){//修改页面有上传照片功能
                var height=$(this).height();
                $(this).parent().css("height",height);
            });
        }else{
            $("#btnDiv").show();
            $(".form-state").hide()
            $(".colon").hide();
            $("label").removeClass("layui-form-label");
            $("label").addClass("form-label");
            $(".layui-input-block").css("color","#000");
        }
    },
    //上传文件显示文件名，上传图片这显示图片，参数一为id，参数二为图片宽，参数三为图片高度。
    myUploading:function (dom,width,height,type) {
        $("#" + dom).on('change', function () {
            var file = $(this).val();
            var strFileName = file.replace(/^.+?\\([^\\]+?)(\.[^\.\\]*?)?$/gi, "$1");  //正则表达式获取文件名，不带后缀
            var FileExt = file.replace(/.+\./, "");   //正则表达式获取后缀
            var fil = this.files;

            for (var i = 0; i < fil.length; i++) {
                if (FileExt == "jpg" || FileExt == "png" || FileExt == "gif" || FileExt == "bmp" || FileExt == "jpeg") {
                    reads(fil[i], width, height, type);

                } else {
                    $(".file-text").text(strFileName);
                    $(".file-text").parent().parent().parent().css({"height": 38 + "px", "width": "48%"})
                    $(".file-text").css({"height": 2 + "rem"})
                }
            }
        });

        function reads(fil, width, height, type) {
            var reader = new FileReader();
            reader.readAsDataURL(fil);
            reader.onload = function () {
                if (type == 2) {
                    $(".file-text").css({'padding': "0"});
                    $(".file-text").html("<img src='" + reader.result + "'>");
                } else {
                    $(".file-text").css({"height": height + "px"})
                    $(".file-text").parent().parent().parent().css({
                        "width": width + "px",
                        "height": height + parseInt(100) + "px"
                    })
                    $(".file-text").html("<img src='" + reader.result + "'>");
                }

            };

        }
    }


});
