<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<title>主页2</title>
	<meta http-equiv="X-UA-Compatible" content="IE=11">
	<link rel="shortcut icon" href="${basePath}/static/source/public/images/32.png" type="image/x-icon" />
</head>
<style>
</style>
<body>
	<div class="wrap">
		<%@ include file="./header.jsp"%>
		<div class="contentBox">

			<div class="menu" >
				<div id="menu" class="treeView"></div>
			</div>
			<div class="contentBody" >
				<iframe border="0" id="iframe" frameborder="no" src="<%=basePath%>views/jsp/system/index/modul_item.jsp" class="iframe" id="iframe"></iframe>
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
//			  ,content: '<div style="padding: 20px 80px;">内容</div>'
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
			      window.location.href="${basePath}personalpanel/to_personalpanel.do";
					return false;
				}
			});
		}
	//推送离线消息
	function sendOffLineMessage(count,data) {
		data=eval('${waitApproverMsg}');
		console.log(data);
		
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
						content: '<%=basePath%>'+opt.url+'&msgId='+opt.id,
						area: ["900px", "500px"]
					});
			},
            btn2 : function(index, layero) {
                window.location.href="${basePath}/personalpanel/to_personalpanel.do";
                return false
				//layer.close(index);
			}
		});
	}
	
	var areaCode= ${pd.areaCode};

	function getMenuList(){
		return eval('${menuList}');
	}
	
    $(function () {
        LLW.setnav('module');
    
        //console.log(eval('${areaJson}'));
        //左边导航条
		//getMap()
       //默认展示

        var treeView = $.TreeView({
            el: $("#menu"),
            data: [],
            callback:function(obj){
                areaCode = obj.areaCode;
                $("#menu").find(".treeItem").each(function() {
                    $(this).removeClass("active")
                });
                $(this).closest(".treeItem").addClass("active");

                var obj= $("#menu").find(".lev"+obj.lev);


                $("#menu").find(".treeItem").each(function(){
                    $(this).children(".title").css("color","#000");
                    $(this).children(".icon-icon").css("color","#000");
                });
                $(obj).parents(".itemBox").each(function(index){
                    var calssArr=this.className.split(" ");
                    if(calssArr.length>=2 && index >=1){
                        $("."+calssArr[1]).children(".treeItem").children(".title").css("color","#108ee9");
                        $("."+calssArr[1]).children(".treeItem").children(".icon-icon ").css("color","#108ee9")
                    }
                });

                $(obj).children(".treeItem").children(".icon-icon").css("color","#fff");
                $(obj).children(".treeItem").children(".title").css("color","#fff");
                //刷新iframe
                //$('#iframe').attr('src', $('#iframe').attr('src'));
            },
            //下拉异步回掉
            switchCallback: function (obj) {
                if(obj.children == ""){
                    var index= obj.id;
                    getMap(index,treeView)
                }

            }
        });
        getMap(0,treeView)

    });

    function logOut(){
    	window.location.href="<%=basePath%>logout";
    }

     function getMap(index,treeView){
         $.post("<%=basePath%>areaCode/listSubAreaCodeByParentId",{parentId:index},function(data){
             if(data==""){
                 return;
             }
             var pid= data[0].pid;
			 if(index == 0){
                 treeView.refresh(data);
                 $("#menu .lev1 .item-switch").click();
                 return
			 }
             var parentData= treeView.data;

             treeView.findOne(pid,function(obj){

                 if(obj.children == ""){
                     obj.children= data;
                 }
                 treeView.rec(data,function(obj,index){
                     treeView.operation(obj,index);
                 },obj.lev)

             });
			//当areaCode==四川的时候 子类不选中
			 if(areaCode == 510000000000){
                 return
			 }
			 //默认选中城市
			 if(index == "545532"){
                 treeView.findOne(areaCode, function(obj) {
                     var $title = $(".lev" + obj.lev).children(".treeItem ").children(".title");
                     var top = $title.offset().top;
                     $title.click();
                     console.log(top)

                 })
			 }
         })
     }

     /*treeView.findOne(areaCode, function(obj) {
         var $title = $(".lev" + obj.lev).children(".treeItem ").children(".title");
         var top = $title.offset().top
         $title.click();
         console.log(top)
         $title.parents(".itemBox").each(function(i) {
             if (i != 0) {
                 $(this).children(".treeItem ").children(".item-switch").click();
             }
         })
     })*/
   /* function getMap(){
		$.post("<%=basePath%>areaCode/findLevel2.do", {}, function(data) {
			console.log(data)
			var treeView = $.TreeView({
				el : $("#menu"),
				data : data,
				callback : function(obj) {
					areaCode = obj.areaCode;
					$("#menu").find(".treeItem").each(function() {
						$(this).removeClass("active")
					})
					$(this).closest(".treeItem").addClass("active");

					var obj= $("#menu").find(".lev"+obj.lev);


                    $("#menu").find(".treeItem").each(function(){
                        $(this).children(".title").css("color","#000");
                        $(this).children(".icon-icon").css("color","#000");
                    })
                    $(obj).parents(".itemBox").each(function(index){
                        var calssArr=this.className.split(" ")
                        if(calssArr.length>=2 && index >=1){
                            $("."+calssArr[1]).children(".treeItem").children(".title").css("color","#108ee9")
                            $("."+calssArr[1]).children(".treeItem").children(".icon-icon ").css("color","#108ee9")
                        }
                    })

                    $(obj).children(".treeItem").children(".icon-icon").css("color","#fff");
                    $(obj).children(".treeItem").children(".title").css("color","#fff");
					//刷新iframe
					//$('#iframe').attr('src', $('#iframe').attr('src'));
				},
			})
			//icon-shouye
			//$(".lev1 ").children(".treeItem").children(".iconfont").addClass("icon-shouye")

			//默认选中
			treeView.findOne(areaCode, function(obj) {
				var $title = $(".lev" + obj.lev).children(".treeItem ").children(".title");
				var top = $title.offset().top
				$title.click();
				console.log(top)
				$title.parents(".itemBox").each(function(i) {
					if (i != 0) {
						$(this).children(".treeItem ").children(".item-switch").click();
					}
				})
			})

		}, "json")
	}*/

	function getAreaCode() {
		return areaCode;
	}
</script>
</body>
</html>