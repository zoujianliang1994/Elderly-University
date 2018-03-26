<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="BASEPATH" value="${pageContext.request.contextPath}" />
<%-- <%
	String path = request.contextPath;
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>  --%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<title>${article.title}</title>
<link rel="stylesheet" href="${BASEPATH}/static/ace/css/bootstrap.css">
<link rel="stylesheet" href="${BASEPATH}/static/ace/css/treeView.css">
 <link rel="stylesheet" href="${BASEPATH}/static/cms/css/normalize.css">
<link rel="stylesheet" href="${BASEPATH}/static/cms/css/614.css">
<link rel="stylesheet" href="${BASEPATH}/static/cms/css/pointsMain.css">
<link rel="stylesheet" href="${BASEPATH}/static/login/matrix-login.css" />
<link rel="stylesheet" href="${BASEPATH}/static/login/sliderVerification.css">
<script src="${BASEPATH}/static/cms/js/jquery-1.8.3.min.js"></script>
<script src="${BASEPATH}/static/cms/js/sliderVerification.js"></script> 
</head>
<style>
.layui-layer-content{
	max-height:650px;
}
</style>
<body style="background:#fff">
	<!-- header -->
	<%@include file="./head.jsp"%> 


	<div class="wrapper" >
		<div class="navbox">
			<div class="nav fl" id="nav">
				<div class="navitem active" type="1">
					集团要点
				</div>
				<div class="navitem" type="2">
					所级要点
				</div>
			</div>
			
			<div class="fr selectYear" id="mainPoints">
			 	<div class="input-group">
				  <input type="text" class="form-control" placeholder="选择要点" value='' aria-describedby="basic-addon1">
				</div>
				
				<div class="year-shadow">
					<ul>
						
					</ul>
				</div>
			</div>
			
			
			<div class="fr selectYear" id="selectYear" style="margin-right:20px">
			 	<div class="input-group">
				  <input type="text" class="form-control" placeholder="选择年份" value='2017' aria-describedby="basic-addon1">
				</div>
				
				<div class="year-shadow">
					<ul>
						
					</ul>
				</div>
			</div>
			
			
		</div>
	</div>
	<div class="wrapper" style="margin-top:20px" id="wrap">
		<!-- åå®¹ -->
		<div class="menu2">
			<div id="title" style="line-height: 32px;color:#596980;text-align:left;padding:0 20px 0 10px">  </div>
			<div class="treeView" id="treeView">
			
			</div>
		</div>	

		<div class="content" id="content">
		</div>
	</div>
	<!-- å¼å¥å°¾é¨ -->
	<%@ include file="foot.jsp"%>
	
	<script src="${BASEPATH}/static/ace/js/treeView.js"></script>
	<script src="${BASEPATH}/layer/layer.js"></script>
	<script>
		$(function(){
			var otherH= $(".header").height() + $(".footer").height() + $(".navbox").height()  + 40;
			var h=  window.innerHeight || $(document).height();
			$("#content").css('height',h - otherH);
			$(".menu2").css('height',h - otherH);
		
			$(window).resize(function(){
				var otherH= $(".header").height() + $(".footer").height() + $(".navbox").height()  + 40;
				var h=  window.innerHeight || $(document).height();
				$("#content").css('height',h - otherH);
				$(".menu2").css('height',h - otherH);
			})

			var index= 0;
			var treeView= new $.TreeView({
				el:$("#treeView"),
				data:{},
				allClick:true,
				showLev:true,
				callback:function(){
					var lev= $(this).closest(".itemBox").attr("lev")
					$("#content").find(".lev"+lev)[0].scrollIntoView();
				}
			})
		
			$("#treeView").on("click",".le",function(){
				var id=$(this).closest('.treeItem').attr("id");
				var title= $(this).closest('.treeItem').find(".title").text();
				var type= $("#nav .active").attr("type");
				if(type == 2){
					getPlan("/managementCenter/cms/queryPlanByPointId",{businessId:id})
				}else{
					getPlan("/managementCenter/cms/queryChildrenPoints",{pid:id})
				}
				
				
			})
			
			$(document).on("click",".tableBox .suojiSwitch",function(){
				var $this= $(this);
				var $tr= $(this).closest('tr');
				var pid= $tr.attr('pid');
				$.post("/managementCenter/cms/queryPlanByPid",{pid:pid},function(data){
					if(data.state == 1){
						if($this.hasClass("glyphicon-minus")){
							$this.removeClass("glyphicon-minus")
							$tr.next().hide();
						}else{
							$this.addClass("glyphicon-minus")
							$tr.next().show();
						}
						if($this.hasClass("hasChildren")){
							return
						}
						$this.addClass("hasChildren");
						var $td= $tr.next().children("td");
						$tr.next().show();
						var indent= $tr.children(".title").css("text-indent");
						indent= parseInt(indent)+15;
						var table= '<table class="table table-striped table-bordered table-hover" style="margin-bottom:0;border: 0;">'+
									 	'<tbody>'
						var content="";
						for(var i=0;i<data.data.length;i++){
							var tr= '<tr pid="'+data.data[i].id+'">'+
									    '<td class="title" style="text-indent:'+indent+'px">'+(data.data[i].type == 1? '<span class="glyphicon  glyphicon-plus switch-icon " aria-hidden="true"></span>' : '')+data.data[i].title+'</td>'+
									    '<td class="probability">'+data.data[i].process+'%</td>'+
									    '<td style="white-space: normal;">'+data.data[i].content+'</td>'+
									  '</tr>'+
									  '<tr style="display:none">'+
									  	'<td colspan="3" style="padding:0;border: 0;">'+
									  	'</td>'+
									  '</tr>'
							content+= tr;		  
						}
									  		
							var end=   '</tbody>'+				 	 
							'</table>'
							$td.append(table+content+end)
							$(document).resize();
					}
				})
			})
			
			$("#selectYear input").on("focus",function(){
				$("#selectYear .year-shadow").slideDown(300);
			})
			
			$("#selectYear .input-group-addon").on("focus",function(){
				$("#selectYear .year-shadow").slideDown(300);
			})
			$("#selectYear").on("click",function(e){
				e.stopPropagation();
			})
			$("#selectYear").on("click",'li',function(e){
				$("#selectYear input").val($(this).text());
				$("#selectYear .year-shadow").slideUp(300);
				index= 0;
				getData(true);
			})
			
			$("#mainPoints input").on("focus",function(){
				$("#mainPoints .year-shadow").slideDown(300);
			})
			$("#mainPoints").on("click",'li',function(e){
				$("#mainPoints input").val($(this).text());
				$("#mainPoints .year-shadow").slideUp(300);
				index= $(this).index();
				getData();
			})
			$("#mainPoints").on("click",function(e){
				e.stopPropagation();
			})
			
			$(document).on('click',function(){
				$("#selectYear .year-shadow").slideUp(300);
				$("#mainPoints .year-shadow").slideUp(300);
			})
			
			$("#nav .navitem").on("click",function(){
				$(this).addClass("active").siblings().each(function(){
					$(this).removeClass("active")
				})	
				index= 0;
				getData(true)
			})
			//获取年份
			findYears();
			//获取年份
			function findYears(){
				$.post("${BASEPATH}/cms/findYears",function(data){
					if(data.state == 1){
						for(var i=0;i<data.data.length;i++){
							if(i==0){
								//$("#selectYear input").val(data.data[i])
								getData(true)
							}
							var li= "<li>"+data.data[i]+"</li>";
							$("#selectYear ul").append(li)
						}
					}else if(data.state == 0){
						layer.msg(data.info,{icon:2})
					}
				})
			}
			//获取要点
			function getData(first){
				var type= $("#nav .active").attr("type");
				var year= $("#selectYear input").val();
				$.post("${BASEPATH}/cms/queryPointsToCms",{type:type,year:year},function(data){
					console.log(data)
					if(data.msg != "error"){
						$("#mainPoints ul").html("");
						for(var i=0;i<data.data.length;i++){
							var title= data.data[i].title;
							$("#mainPoints ul").append('<li>'+data.data[i].title+'</li>')
						}
						
				
						if(data.data.length != 0){
							$(".content").html('')
							$("#title").text(data.topData.title);
							treeView.refresh([data.data[index]][0].children);
							rec(data.data[index]);
							if(first){
								$("#mainPoints input").val(data.data[0].title)
							}
							$("#content").css('height',h - otherH);
							
						}else{
							layer.msg("暂没有数据",{icon:2})
						}
					}
					
				})
			}
			//获取计划
			function getPlan(url,options){
				$.post(url,options,function(data){
					if(data.state==1){
						if(url=="/managementCenter/cms/queryPlanByPointId"){
							var title= "所级计划要点";
							var table= '<div class="tableBox" >'+
											'<table class="table table-striped table-bordered table-hover" >'+
												'<thead class="thead">'+  
													'<tr>'+
													    '<th class="first">相关计划</th>'+
													    '<th>完成效率</th>'+
													    '<th>计划详情</th>'+
													  '</tr>'+
											 	 '</thead>'+
											 	 '<tbody>'
								var content="";
								for(var i=0;i<data.data.length;i++){
									var tr=   '<tr pid="'+data.data[i].id+'">'+
											    '<td class="title">'+(data.data[i].type == 1? '<span class="glyphicon  glyphicon-plus switch-icon " aria-hidden="true"></span>' : '')+data.data[i].title+'</td>'+
											    '<td class="probability">'+data.data[i].process+'%</td>'+
											    '<td style="white-space: normal;">'+data.data[i].content+'</td>'+
											  '</tr>'+
											  '<tr style="display:none">'+
											  	'<td colspan="3" style="padding:0;border: 0;">'+
											  	'</td>'+
											  '</tr>'
									content+=tr;
								}			 	 
								
								var end=   '</tbody>'+				 	 
											'</table>'+	 	 	
										'</div>'
						}else if(url=="/managementCenter/cms/queryChildrenPoints"){
							var title= "所级要点";
							var table= '<div class="tableBox" >'+
											'<table class="table table-striped table-bordered table-hover" >'+
												'<thead class="thead">'+  
													'<tr>'+
													    '<th class="first">名称</th>'+
													    '<th>内容</th>'+
													  '</tr>'+
											 	 '</thead>'+
											 	 '<tbody>'
								var content="";
								for(var i=0;i<data.data.length;i++){
									var tr=   '<tr pid="'+data.data[i].id+'">'+
											    '<td class="title">'+(data.data[i].type == 1? '<span class="glyphicon  glyphicon-plus switch-icon suojiSwitch" aria-hidden="true"></span>' : '')+data.data[i].title+'</td>'+
											    '<td style="white-space: normal;">'+data.data[i].content+'</td>'+
											  '</tr>'+
											  '<tr style="display:none">'+
											  	'<td colspan="3" style="padding:0;border: 0;">'+
											  	'</td>'+
											  '</tr>'
									content+=tr;
								}			 	 
								
								var end=   '</tbody>'+				 	 
											'</table>'+	 	 	
										'</div>'
						}
						

						
						layer.alert(table+content+end,{
							title:title,
							maxWidth:900,
							maxHeight:800
						});
					}else if(data.state==0){
						layer.msg(data.info,{icon:2})
					}
				})
			}
			
			
			
			//递归
			function rec(obj){
				for(var key in obj){
					if(typeof(obj[key]) == 'object'&& obj[key]!=""){
						rec(obj[key])
					}else{
						setIteam(obj,key)
					}
				}
			}
			//操作
			function setIteam(obj,key){
				if(key == 'lev'){
					var lev= obj[key];
					if(lev == ""){
						appendHtmL(0,obj['title'],lev);
					}else{
						var levarr= lev.toString().split("-");
						var num= levarr.length;
						if(num > 3){
							num = 3
						}
						if(num != 3){
							appendHtmL(num,obj['title'],lev);
						}
						
					}
					if(num == 3){
						var html= $('<div class="text-content lev'+lev+'" >'+obj['title']+obj['content']+'</div>');
						$(".content").append(html);
						var top= html.offset().top - otherH +90;
					}
					appendHtmL(3,obj['content']);
					
				}
			}
			
			function appendHtmL(num,text,lev){
				var html="";
				switch(num){
					case 0:
						html= '<h3 class="title1"></h3>';
						break;
					case 1:
						html= '<p class="title2"></p>';
						break;
					case 2:
						html= '<p class="title3"></p>';
						break;
					case 3:
						html= '<div class="text-content"></div>';
						break;	
					
				}
				var html= $(html).text(text).addClass("lev"+lev);
				$(".content").append(html);
				//html.attr('top',html.offset().top);
			}
				
		})
	</script>
</body>
</html>