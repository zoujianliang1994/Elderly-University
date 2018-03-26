<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>主页</title>
	<meta http-equiv="X-UA-Compatible" content="IE=11">
	<link rel="shortcut icon" href="${basePath}/static/source/public/images/lhb.png" type="image/x-icon" />


</head>
<body>
	<div class="wrap">
		<%@ include file="./header.jsp"%>

		<div class="contentBox">
			<%--<hr class="line" id="line"/>--%>
			<div class="menu" >
				<%--<c:if test="${user.USERNAME!='superAdmin'}">--%>
				<%--<a class="back" href="<%=basePath%>to_module_list">--%>
					<%--<span><i style="vertical-align: middle;margin-right:5px;font-size:13px" class="iconfont icon-fanhui"></i></span>返回--%>
				<%--</a>--%>
				<%--</c:if>--%>
				<div id="menu" class="treeView"></div>
			</div>
			<div class="contentBody">
				<div class="layui-tab wh100" lay-allowClose="true" lay-filter="table">
					<ul class="layui-tab-title" id="layui-tab-title">

					</ul>
					<div class="layui-tab-content wh100">

						<%--<a class="chakan-btn del" data_id="${menu.MENU_ID }">--%>
							<%--<i class="iconfont icon-chakan"></i>--%>
						<%--</a>--%>
					</div>
				</div>
			</div>

			<div class="suspensionBox" id="suspensionBox">
				<div class="layui-layer-title" style="text-align:center">
					<i class="layui-icon layui-unselect layui-tab-close fl" style="cursor:pointer" id="closeSuspensionBox">ဆ</i> <span class="title"></span>
				</div>
				<div class="layui-tab-content wh100">
					<iframe src=""  class="iframe"  frameBorder="0"></iframe>
				</div>
			</div>


		</div>

	</div>

	<%@ include file="./foot.jsp"%>
	<script>
        //连接消息服务器
        var socket =  io.connect('${msgUrl}');
        socket.on('connect', function(data) {
            var messageCount = "${waitApproverCount}";
            data = '${waitApproverMsg}';
            if(messageCount != 0){
                //发送离线消息提醒
                sendOffLineMessage(messageCount,data);
            }
        });

        //监听消息
        socket.on('chatevent', function(data) {
            //console.log("监听消息");
            //console.log(data);
            sendMessage(data);
        });

        //接收服务器消息数据
        socket.on('messageEvent', function(data) {
            sendMessage(data);
        });
        //监听断开连接
        socket.on('disconnect', function() {
            console.log("The client has disconnected!");
        });

        //在线推送消息
        function sendMessage(data){
            console.log(data);

            layer.open({
                type: 0
                ,title:"消息"
                ,offset: 'rb' //具体配置参考：offset参数项
                ,content: "待处理消息"
                ,shade: 0 //不显示遮罩
                //,time: 5000//关闭时间5s
                ,btn: ['查看详情', '更多']
                ,yes: function(index){
                    parent.parent.layer.open({
                        title: data.title,
                        type: 2,
                        content: '<%=basePath%>'+data.url,
                        area: ["900px", "500px"]
                    });
                },
                btn2 : function(index, layero) {
                    parent.parent.layer.edit = window;
                    parent.parent.layer.open({
                        title: "个人消息",
                        type: 2,
                        content: '<%=basePath%>personalpanel/to_personalpanel.do',
                        area: ["1000px", "800px"]
                    });
                    return false;
                }
            });
        }
        //推送离线消息
        function sendOffLineMessage(count,data) {
            data=eval('${waitApproverMsg}');
            // console.log(data);

            $.each(data,function(i){
                var opt={
                    title:this.TITLE,
                    id:this.BUSINESS_ID,
                    url:this.URL,
                    content:this.CONTENT,
                };
                layerOpen(opt)
            })
        }

        function layerOpen(opt){
            layer.open({
                type : 0,
                title :'消息',
                offset : 'rb' //具体配置参考：offset参数项
                ,
                content : opt.content,
                shade : 0 //不显示遮罩
                //,time: 5000//关闭时间5s
                ,
                btn : [ '查看详情', '更多' ],
                yes : function(index,data) {
                    var waitApproverMsg=eval('${waitApproverMsg}');
                    parent.parent.layer.open({
                        title: opt.title,
                        type: 2,
                        content: '<%=basePath%>'+opt.url,
                        area: ["900px", "500px"]
                    });
                },
                btn2 : function(index, layero) {
                    parent.parent.layer.edit = window;
                    parent.parent.layer.open({
                        title: "个人消息",
                        type: 2,
                        content: '<%=basePath%>personalpanel/to_personalpanel.do',
                        area: ["1000px", "800px"]
                    });
                    return false
                    //layer.close(index);
                }
            });
        }
        $(function () {
        var element  = layui.element;
        var data= eval('${menuList}');

        //左边导航条
        treeView = $.TreeView({
            el: $("#menu"),
            show: true,
            data: data,
            //导航回掉
            callback: function (obj) {
                var title = obj.title;
                var url = obj.url;
                //没有链接跳出
                addTab(title,url,this)
            }
        });

		
		var obj=rec(data[0]);

        $("#menu .lev"+obj.lev).find(".title").click();
        //getMap(0,treeView)

        function addTab(title,url,obj){
            var mark = true; //tab是否已有
            if(url =="#"){
                return
            }
            closeSuspensionBox();
            var $title = $("#layui-tab-title").find("li");

            //active选中
           $("#menu").find(".treeItem").each(function(){
                $(this).removeClass("active")
			});
			$(obj).closest(".treeItem").addClass("active");
			//如果已有跳转到
			$title.each(function () {
				if (url == $(this).attr("lay-id")) {
					element.tabChange('table', url);
					mark = false;
					return false
				}
			});
			//初始化左边导航栏颜色
			$("#menu").find(".treeItem").each(function(){
                $(this).children(".title").css("color","#393838");
                // $(this).children(".icon-icon").css("color","#b9c1cc");
			});
			//初始化左边导航选中
            // $(obj).prev().css("color","#fff");
            // $(obj).css("color","#fff");

            $(obj).parents(".itemBox").each(function(index){
				var calssArr=this.className.split(" ");

				if(calssArr.length>=2 && index >=2){
                    $("."+calssArr[1]).children(".treeItem").children(".title").css("color","#108ee9");
                    // $("."+calssArr[1]).children(".treeItem").children(".icon-icon ").css("color","#108ee9")
				}
			});

            //table 已经有了刷新
            if (!mark) {
                var $iframe= $(".layui-tab .layui-show iframe");

                $iframe.attr("src",$iframe.attr("src"));
                return;
            }
            //新增
            element.tabAdd("table", {
                title: title
                , content: '<iframe src="<%=basePath%>'+url+'"  class="iframe"  frameBorder="0"></iframe>' //支持传入html
                , id: url
            });
            element.tabChange('table', url);

        }
        window.addTab= addTab;

        $("#closeSuspensionBox").on("click",function(){
            closeSuspensionBox();
		})
    });


        $(function(){
            var arrTitle=[];
            var parentTitle;
            arrTitle.push($("li.layui-this").text())
            // $("#layui-tab-title").on('click',"li", function(){
            //     var title=$(this).text();
            // 	var titlePrev=$(this).prev().text();
            //     myNavStyle(title,titlePrev);
            // });

            layui.element.on('tab(table)', function(data){
                var title=$("#layui-tab-title li:nth-child("+(parseInt(data.index)+1)+")").text();
                var dataId=$("#layui-tab-title li:nth-child("+(parseInt(data.index)+1)+")").attr("data-id");
                if(!dataId){
                    dataId="";
				}
				var  titlePrev=arrTitle[arrTitle.length - 1];
                $("li:nth-last-child(1)").attr("data-id",parentTitle);
                console.log();
                myNavStyle(title,titlePrev,dataId);
                arrTitle.push(title)
            });
            $(".treeItem").on("click",".title",function(){
                parentTitle=$(this).parent().parent().parent().prev().text()
			})

            function myNavStyle(title,titlePrev,dataId){
                title=title.slice(0,title.length-1);
                titlePrev=titlePrev.slice(0,titlePrev.length-1);
                if($(".treeItem span[title="+title+"]").length==1){
                    $(".treeItem span").parent().removeClass("active");
                    $(".treeItem span[title="+title+"]").parent().addClass("active");
                }else if($(".treeItem span[title="+title+"]").length>1){
                    $(".treeItem span[title="+title+"]").each(function(){
                        if($(this).parent().parent().parent().prev().text()==dataId){
                            $(".treeItem span").parent().removeClass("active");
                            $(this).parent().addClass("active");
                        }
					})
				}else{
                    $(".treeItem span").parent().removeClass("active");
                    $(".treeItem span[title="+titlePrev+"]").parent().addClass("active");
                }
			}

		})


	function closeSuspensionBox(){
        $("#suspensionBox").css("right",'-80%')
	}

	function showSuspensionBox(url,title){
        $("#suspensionBox").find(".title").text(title);
        $("#suspensionBox").find("iframe").attr("src",url);
		layer.load(2);
		var timer= setTimeout(function(){
            $("#suspensionBox").css("right",0);
            layer.closeAll("loading")
		},300)

	}
    function rec(obj){
    	if(obj.children == "" ){
    		return obj
    	}else{
    		$("#menu .lev"+obj.lev).children(".treeItem").children(".item-switch").click();
    		return rec(obj.children[0])    	
    	}
    }

    function logOut() {
        window.location.href = "<%=basePath%>logout";
    }

    function getMap(index, treeView) {
        $.post("<%=basePath%>areaCode/findLevel2", {
				parentId : index
			}, function(data) {
			for (var i = 0; i < data.length; i++) {
				data[i].title = data[i].name;
				data[i].url = data[i].id;
			}
			treeView.callback = function(id) {
			};
			treeView.refresh(data)
		})
	}



	</script>
</body>
</html>