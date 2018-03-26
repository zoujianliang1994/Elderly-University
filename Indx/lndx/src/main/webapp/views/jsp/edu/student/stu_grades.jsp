<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>学员报名选班</title>
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
    <form action="goGrades.do" method="post" class="layui-form layui-col-sm12" name="Form" id="Form">
        <p class="class-info-title">选择报名班级</p>

        <div class="layui-form">
            <div class="layui-inline">
               <div class="layui-input-block ">
                    <select lay-filter='school_id' id="school_id" name="school_id"  class="layui-input-inline" lay-search>
                     	<option value="">请选择学校</option>
                        <c:forEach var="var" items="${schoolList}" varStatus="vs">
                        	<option value="${var.s_id}" <c:if test="${var.s_id==pd.school_id}"> selected="selected" </c:if> >${var.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
             <div class="layui-inline marL-20">
               <div class="layui-input-block ">
                   <select lay-filter='school_child_id' id="school_child_id" name="school_child_id"  class="layui-input-inline" >
                        <option value="">请选择校区、教学点</option>
                        <c:forEach var="var" items="${schoolChildList}" varStatus="vs">
                        	<option value="${var.id}" <c:if test="${var.id==pd.school_child_id}"> selected="selected" </c:if> >${var.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div> 
            <div class="layui-inline marL-20">
                <div class=" fl" style="margin: 20px 0;">
                    <input value="${pd.keywords}"  id="keywords" name="keywords" placeholder="课程/班级/教师"  type="text" class="layui-input fl search layui-input-color">
                </div>
            </div>
             <div class="layui-inline marL-20">
               <div class="layui-input-block ">
                	<input name="now_time" id="now_time" value="${pd.now_time}" type="text" class="layui-input layui-input-color" placeholder="请选择时间">
                </div>
            </div>
            <div class="layui-inline">
                <div class="fl srarchBtn" onclick="gsearch()"> <i class="iconfont icon-sousuo"></i> <span>搜索</span>      </div>
                </div>

        </div>
    </form>

        <div class="layui-col-sm12">
            <p class="class-info-title">
                筛选结果
            </p>
            <table class="layui-table center" lay-skin="line" id="table">
                <colgroup>
                    <col width="100px">
                    <col>
                    <col>
                    <col>
                    <col>
                    <col width="100px">
                    <col width="100px">
                    <col>
                    <col>
                </colgroup>
                <thead>
                <tr class="table-head-tr">
                    <th>班级名称</th>
                    <th>所属学校</th>
                    <th>上课时间</th>
                    <th>教室</th>
                    <th>任课老师</th>
                    <th>人数</th>
                    <th>学费（元）</th>
                    <th style="border-left: 1px solid #dce3eb;">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty varList}">
                            <c:forEach items="${varList}" var="var" varStatus="vs">
                                <tr class=${var.id}>
                                    <td>${var.g_name}</td>
                                    <td>
                                        <c:if test="${var.a_name!=null}">
                                           ${var.a_name}<br>
                                        </c:if>
                                            ${var.school_name}

                                    </td>
                                    <td>
                                    	${var.course_time.replaceAll('!','<br>')}
                                    </td>
                                    <td>${var.classroom_name}</td>
                                    <td>${var.teacher_name}</td>
                                    <td>${var.zt}</td>
                                    <td>${var.money}</td>
                                    
                                    <td style="text-align: center;border-left: 1px solid #dce3eb;">
                                           <%--这两个选项按钮只能有一个--%>
                                           <a class="table-btn-max chakan-btn edit"  onclick="getCourse('${var}')" >
                                               选择该课程
                                           </a>
                                    </td>
                                </tr>
                            </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr class="main_info">
                            <td colspan="100" class="center">没有相关数据</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>

            <div class="laypageBox">
                <div id="laypage" class="fr"></div>
            </div>
        </div>

        <div class="layui-col-sm12">
            <p class="class-info-title">
                您已选择的班级
            </p>
            <table class="layui-table center" lay-skin="line" id="selected_table">
                <colgroup>
                   <col>
                    <col width="100px">
                    <col>

                    <col>
                    <col >
                    <col width="100px">
                    <col width="100px">
                    <col>
                </colgroup>
                <thead>
                <tr class="table-head-tr">
                    <th>
                        <input type="checkbox" id="all-checked">
                    </th>
                    <th>班级名称</th>
                    <th>所属学校</th>
                    <th>上课时间</th>
                    <th>教室</th>
                    <th>任课老师</th>
                    <th>人数</th>
                    <th>学费（元）</th>
                    <th style="border-left: 1px solid #dce3eb;">操作</th>
                </tr>
                </thead>
                <tbody class="select-class">


                </tbody>
            </table>
            <div class="btnbox" id="btnDiv" >
	            <c:if test="${pd.checkin_type=='1'}"> <button id="sure" class="layui-btn layui-btn-primary layui-btn-small" style="width: 9rem;">去缴费</button></c:if>
	            <c:if test="${pd.checkin_type=='2'}"> <button id="sure" class="layui-btn layui-btn-primary layui-btn-small" style="width: 9rem;">完成报名</button></c:if>
            </div>
        </div>




</div>


<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
  

  var interval,orderNo;
  layui.use('laydate', function () {
         var laydate = layui.laydate;
         laydate.render({
             elem: '#now_time',
             type: 'time'
         });
   });
	var form = layui.form;
	form.on('select(school_id)', function (data) {
		if(data.value){
			 //根据学校查询分校及教学点
			 var url = "<%=basePath%>/school/findSchoolBySid.do?id=" + data.value;
			 $.get(url, function (res) {
				 //清空下拉选项
				 $("#school_child_id").html('');
				 if(res.data){
		      		   for(var i=0;i<res.data.length;i++){
			        		$("#school_child_id").append('<option value="'+res.data[i].id+'">'+res.data[i].name+'</option>');
			        	}
		      	   }
	      		   form.render();
			 });
		}
	});
	
	/* form.on('select(school_child_id)', function (data) {
		 if(data.value){
			$("#keywords").val(data.value);
		} 
    }); */
	
    $(function(){
        $(".my-yet").on("click",function () {
       		 window.location.href = "<%=basePath%>studentEnroll/listGrades?user_id=${pd.user_id}&checkin_type=${pd.checkin_type}&type=1";
        })
    })
    function gsearch(){
        $("#Form").submit()
    }
    var classList={};
    function getCourse(data){
        // console.log(data)
        var arr=data.replace("{","").replace("}","").split(",");
        // console.log(arr);
        var obj={};
        for (var i=0;i<arr.length;i++){
            arr[i]=arr[i].split("=");
            var str='';
            for(var j=1;j<arr[i].length;j++){
                str+=arr[i][j]
            }
            var key=arr[i][0].replace(/(^\s*)|(\s*$)/g, "")
            obj[key]=str;
        }

        var time=obj.course_time.split("!");

        function toArr(time){
            var timeobj=[];
            for(var j=0;j<time.length;j++){
                timeobj.push(time[j].split("-"))
            }
            return timeobj;
        }
        var timeobj=toArr(time)
        console.log(timeobj)

        //判断课程是否存在时间冲突
        // console.log(JSON.stringify(classList)!="{}")

        if (JSON.stringify(classList)!="{}"){
            var b=0;
            var a=0;
            $.each(classList,function(key,val){
                // console.log(val)
                var times=val.course_time.split("!");
                var timeobjs=toArr(times);
                for(var t=0;t<timeobjs.length;t++){
                    for(var j=0;j<timeobj.length;j++){
                        // console.log(timeobj.length)

                        if(timeobjs[t][0].substring(0,2)==timeobj[j][0].substring(0,2)){
                            timeobjs[t][0]=timeobjs[t][0].substring(2,timeobjs[t][0].length)
                            timeobj[j][0]=timeobj[j][0].substring(2,timeobj[j][0].length)
                            if( timeobj[j][0]>timeobjs[t][1] || timeobj[j][1]<timeobjs[t][0] ){
                                console.log(b)
                                b++
                            }
                        }else{
                            b++
                        }
                        a++;
                    }

                }

            })
            console.log(a,b)
            if (b==a){
                getDom()
            }else{
                layer.msg("课程冲突")
            }
        }else{
            getDom()
        }

        function getDom() {
            classList[obj.g_id]=obj;
            var html="<tr>";
            html+="<td><input type='checkbox'  name='checkbox' title="+obj.g_id+" lay-skin='school'/></td>"+
                "<td>"+obj.g_name+"</td>"
            if(obj.hasOwnProperty("a_name")){
                html+= "<td>"+obj.a_name+"<br>"+obj.school_name+"</td><td>"+obj.course_time.replace(/!/g,'<br>')+"</td>"
            }else{
                html+= "<td>"+obj.school_name+"</td><td>"+obj.course_time.replace(/!/g,'<br>')+"</td>"
            }

            html+="<td>"+obj.classroom_name+"</td><td>"+obj.teacher_name+"</td><td>"+obj.zt+"</td><td>"+obj.money+"</td>"+
                "<td style='text-align: center;border-left: 1px solid #dce3eb;'>"+" <a class='table-btn chakan-btn cancel' data-id="+obj.g_id+" >取消</a>"+
                "</td></tr>"
            // $("."+obj.id+" a").addClass("disabled")
            $(".select-class").append(html);
        }
    }

    $(document).on("click",".cancel",function(){
        var id=$(this).attr("data-id");
        $("."+id+" a").removeClass("disabled");
        $(this).parent().parent().remove();
        delete classList[id];
    })
    $("#all-checked").click(function(){
        if(this.checked){
            $(" :checkbox").prop("checked", true);
        }else{
            $(" :checkbox").prop("checked", false);
        }
    });
  var checkedList={};
  var checkedListArray=[];
   $("#sure").on("click",function () {
       checkedList={};
       checkedListArray=[];
       $("input[name='checkbox']").each(function(){
           if($(this).is(":checked")){
               var id=$(this).attr("title")
               if (id!=undefined){
                    checkedList[id]=classList[id];
                   checkedListArray.push(classList[id]);
               }
           }
       });
       
       
       // console.log(checkedListArray);
        
       if(checkedListArray.length>0){
    	   var b=false;
           var aid=checkedListArray[0].a_id;
           console.log(checkedListArray);
console.log(aid);
           $.each(checkedListArray, function(){     
        	    if(this.a_id!=aid){
        	    	b=true;
        	    	return;
        	    }    
        	});  
           if(b){
        	   layer.msg('请选择同一学校的班级缴费!', {icon: 5});
        	   return;
           }
           //alert(3);
           //return;
    	   parent.layer.load(1);
    	   $.ajax({
               url: "${msg}.do",
               type: "POST",
               datatype:"JSON",
               data: {selData:JSON.stringify(checkedListArray),user_id:'${pd.user_id}',checkin_type:'${pd.checkin_type}'},
               success: function (data) {
            	   if(data.msg=="success"){
            		   if("1"==data.checkinType&&"no"==data.result){
            			   orderNo=data.orderNo;
            			   interval= setInterval("getOrderStatus()","1000");
                          <%--  parent.layer.open({
                               title:"支付",
                               type: 2,
                               content:"<%=basePath%>alipay/alipayInitPay?orderNo="+data.orderNo+"&checkin_type="+data.checkinType,
                               area: ["1100px","700px"],

                           }); --%>
                           // console.log(checkedList,checkedListArray)
							console.log(checkedListArray[0].a_id+"====");
            	    	   window.open("<%=basePath%>alipay/alipayInitPay?orderNo="+data.orderNo+"&checkin_type="+data.checkinType+"&s_id="+checkedListArray[0].a_id, '_blank');
            		   }else if("no"==data.result){
                           parent.layer.edit.location.href = "<%=basePath%>studentEnroll/list.do?currentPage=1";
            			   //刷新列表页面
                    	   parent.parent.layer.closeAll();
            	    	   layer.msg('保存成功!', {icon: 1});
            		   }else if("yes"==data.result){
                      	   parent.layer.closeAll('loading');
            	    	   layer.msg('所选班级与在读班级冲突!', {icon: 5});
            		   }
            	   }else{
                  	   parent.layer.closeAll('loading');
                	   layer.msg('数据异常!', {icon: 5});
            	   }
               },
               error: function () {
            	   layer.msg('提交失败!', {icon: 5});
               }
           }); 
       }else{
    	   layer.msg('请选择要缴费项目!', {icon: 5});
       }
   })


   //获取订单状态
   function getOrderStatus(){
	   	$.get("<%=basePath%>/alipay/getOrderStatus.do?orderNo="+orderNo, function (res) {
            console.log(res.msg)

	   		 if(res.msg=='1'){
          	   	   parent.parent.layer.closeAll();
          	   	   console.log(111)
				   clearInterval(interval);
          	   	   layer.msg('缴费成功!', {icon: 1});
                     $(".cancel").each(function(){
                         for (var i=0;i<checkedListArray.length;i++){
                             if (checkedListArray[i].g_id==$(this).attr("data-id")){
                                 $(this).parent().parent().remove();
                                 delete classList[$(this).attr("data-id")];
                                 checkedListArray=[];
                             }
                         }
                     })

	   	       }else if(res.msg=='2'){
            	   parent.parent.layer.closeAll();
	  			   clearInterval(interval);
	          	   layer.msg('缴费异常!', {icon: 5});
	   	       }else{
	   	    	   //继续
	   	       }
	   	 });
   }
   
   
   

</script>
</body>
</html>