<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>导航菜单管理</title>
<%@ include file="../index/headcss.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">

</head>
<body>
	<div class="edit_menu" class="disnone">
		<form action="${MSG}.do" class="layui-form" id="editForm" lay-filter="editForm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="ID" id="ID" value="${pd.ID }" />
			<input type="hidden" name="PATH" id="PATH" value="${pd.PATH }" />
			<input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${null == pd.PARENT_ID ? MENU_ID:pd.PARENT_ID}" />
			 <div class="layui-form-item">
			 	 <div class="form-item-inline">
				    <label class="form-label">上级</label>
				   <div class="layui-input-block ">
				      <input type="text" readonly="readonly"  style="padding: 7px; "placeholder="${null == pd.FNAME ?'(无) 此项为顶级':pd.FNAME}" class="layui-input layui-input-color" />
				    </div>
				  </div>
				 <div class="form-item-inline">
					<label class="form-label">目录名称</label>
					<div class="layui-input-block ">
					  <input type="text" value="${pd.NAME }" name="NAME" required  lay-verify="required" placeholder="请输入目录名称" autocomplete="off" class="layui-input layui-input-color" >
					</div>
				 </div>
			  </div>
			   <div class="layui-form-item">
				   <div class="form-item-inline">
						<label class="form-label">目录序号</label>
						<div class="layui-input-block ">
							<input type="text" name="SORT" id="SORT" value="${pd.SORT }" autocomplete="off" placeholder="这里输入目录序号"  required  lay-verify="required" class="layui-input layui-input-color" />
						</div>
					</div>
					<div class="form-item-inline">
						<label class="form-label">目录状态</label>
						<div class="layui-input-block ">
							<html:select name="STATUS" id="STATUS" classs="layui-input-inline">
                            	<html:options collection="push_status" defaultValue="${pd.STATUS}"></html:options>
                       		 </html:select>   						
                        </div>
					</div>
				</div>
		</form>
		
		<div class="btnbox" >
			<button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
			<button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
		</div>
	</div>
	
	<%@ include file="../index/foot.jsp"%>
	<script>


		$(function(){
            function setType(type, value) {
                if (type == '1') {
                    $("#MENU_TYPE").val(value);
                } else {
                    $("#MENU_STATE").val(value);
                }
            }
			$("#sure").on("click",function(){
                if ($("input[name='MENU_NAME']").val() == "") {
                    layer.tips('菜单名不能为空', $("input[name='MENU_NAME']"), {
                        tips: [4, '#2795cd'],
                        time: 4000
                    });
                    $("#menuName").focus();
                    return false;
                }
                if ($("#menuUrl").val() == "") {
                    $("#menuUrl").val('#');
                }
                //类型为空默认为业务类型
                if ($("#MENU_TYPE").val() == "") {
                    $("#MENU_TYPE").val('1');
                }
                //状态值为空默认为隐藏
                if ($("#MENU_STATE").val() == "") {
                    $("#MENU_STATE").val(0);
                }
                if ($("#menuOrder").val() == "") {
                    layer.tips('请输入菜单序号',  $("#menuOrder"), {
                        tips: [4, '#2795cd'],
                        time: 4000
                    });
                    $("#menuOrder").focus();
                    return false;
                }
                if (isNaN(Number($("#menuOrder").val()))) {
                    layer.tips('请输入菜单序号',  $("#menuOrder"), {
                        tips: [4, '#2795cd'],
                        time: 4000
                    });
                    $("#menuOrder").focus();
                    $("#menuOrder").val(1);
                    return false;
                }

                if ($("input[name='MENU_NAME']").val() == "") {
                    layer.tips('菜单名不能为空', $("input[name='MENU_NAME']"), {
                        tips: [4, '#2795cd'],
                        time: 4000
                    });
                    $("#menuName").focus();
                    return false;
                }


                $.post('<%=basePath%>menu/${MSG}.do', $('#editForm').serialize(), function (data) {
                    parent.layer.closeAll();
                    parent.layer.transmit.location.href = "<%=basePath%>menu.do?MENU_ID="+data.parent_id;
                });


			});
			
			$("#cancel").on("click",function(){
				 parent.layer.closeAll();
			})
		})
		
		
	</script>
</body>
</html>