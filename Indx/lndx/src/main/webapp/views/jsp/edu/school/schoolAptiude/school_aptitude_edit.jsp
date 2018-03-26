<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>学校资质编辑</title>
    <%@ include file="../../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>
<div class="edit_menu" class="disnone">
    <form action="${msg}.do" class="layui-form" id="editForm" enctype="multipart/form-data" lay-filter="editForm" method="post">
     	 <input type="hidden" name="id" value="${pd.id}">
         <input type="hidden" name="s_id" value="${pd.s_id}">
         <input type="hidden" name="create_id" value="${pd.create_id}">
         <input type="hidden" name="options" value="${pd.options}">
	     <input type="hidden" name="rType" value="${pd.rType}">
	
		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label title-max label-max"><i class="require">*</i>名称<span class="colon"></span></label>
					<div class="layui-input-block ">
						<input  name="name" id="name" value="${pd.name}" type="text"	class="layui-input layui-input-color" placeholder="请输入学校名称" autocomplete="off" maxlength="30">
					</div>
				</div>
				<div class="form-item-inline">
					<label class="form-label title-max label-max"><i class="require">*</i>学校地址<span class="colon"></span></label>
					<div class="layui-input-block ">
						<input  name="address" id="address" value="${pd.address}" type="text"	class="layui-input layui-input-color" placeholder="请输入学校地址" autocomplete="off" maxlength="100">
					</div>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">

			<div class="form-item-inline">
					<label class="form-label title-max label-max">学校网站<span class="colon"></span></label>
					<div class="layui-input-block ">
					 <input type="text" value="${pd.website }" name="website" id="website" required lay-verify="required" placeholder="请输入学校网站"
                               autocomplete="off" maxlength="30"
                               class="layui-input layui-input-color" >
					</div>
				</div>
				<div class="form-item-inline">
					<label class="form-label title-max label-max"><i class="require">*</i>联系电话<span class="colon"></span></label>
					<div class="layui-input-block ">
					 <input type="text" value="${pd.tel }" name="tel" id="tel" required lay-verify="required" placeholder="请输入联系电话"
                               autocomplete="off" maxlength="20"
                               class="layui-input layui-input-color" >
					</div>
				</div>
			</div>
		</div>


		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label label-max"><i class="require">*</i>联系人</label>
					<div class="layui-input-block ">
							<input type="text" value="${pd.contanct_name}" name="contanct_name" id="contanct_name" required lay-verify="required" placeholder="请输入联系人"
                               autocomplete="off"  maxlength="20"
                               class="layui-input layui-input-color" >
                     </div>
				</div>
				<div class="form-item-inline">
					<label class="form-label label-max"><i class="require">*</i>联系人电话</label>
					<div class="layui-input-block ">
					 <input type="text" value="${pd.contanct_phone }" name="contanct_phone" id="contanct_phone" required lay-verify="required" placeholder="请输入联系人电话"
                               autocomplete="off"  maxlength="20"
                               class="layui-input layui-input-color" >
					</div>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label label-max"><i class="require">*</i>联系人邮箱</label>
					<div class="layui-input-block ">
					 <input type="text" value="${pd.email }" name="email" id="email" required lay-verify="required" placeholder="请输入联系人邮箱"
                               autocomplete="off"  maxlength="20"
                               class="layui-input layui-input-color" >
					</div>
				</div>
				<div class="form-item-inline">
					<label class="form-label label-max"><i class="require">*</i>学员总人数</label>
					<div class="layui-input-block ">
					 <input type="number" value="${pd.stu_total }" name="stu_total" id="stu_total" required lay-verify="required" placeholder="请输入学员总人数"
                               autocomplete="off"  maxlength="7"
                               class="layui-input layui-input-color" >
					</div>
				</div>

			</div>
		</div>


		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label  label-max"><i class="require">*</i>机构性质<span class="colon"></span></label>
					<div class="layui-input-block " id="div_stype">
					<html:select id="jg-nature" name="s_type" classs="layui-input-inline" style="lay-filter='select1'">
                              <html:options collection="Institutional_nature" defaultValue="${pd.s_type}"></html:options>
                          </html:select>
					</div>
				</div>
				<div class="form-item-inline">
					<label class="form-label label-max"><i class="require">*</i>税务登记号</label>
					<div class="layui-input-block ">
						<input type="text" value="${pd.tax_code }" name="tax_code" id="tax_code" required lay-verify="required" placeholder="请输入税务登记号"
							   autocomplete="off"  maxlength="30"
							   class="layui-input layui-input-color" >
					</div>
				</div>

			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label title-max label-max"><span><i class="require">*</i>是否存在</span><span>分校</span></label>
					<div class="layui-input-block " id="div_is_subordinate">
						<html:select id="is-subordinate" name="has_child" classs="layui-input-inline" style=" lay-filter='select1'">
							<html:options collection="sf" defaultValue="${pd.has_child}"></html:options>
						</html:select>
					</div>
				</div>
				<div class="form-item-inline">
					<label class="form-label title-max label-max"><span><i class="require">*</i>是否存在</span><span>教学点</span></label>
					<div class="layui-input-block " id="div_isteaching">
						<html:select id="is-teaching" name="has_point" classs="layui-input-inline" style=" lay-filter='select1'">
							<html:options collection="sf" defaultValue="${pd.has_point}"></html:options>
						</html:select>
					</div>
				</div>

			</div>
		</div>


		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
					<label class="form-label label-max">分校个数<span class="colon"></span></label>
					<div class="layui-input-block ">
						<input type="number" value="${pd.child_total }" name="child_total" id="child_total" required lay-verify="required" placeholder="请输入分校个数"
							   autocomplete="off"  maxlength="7"
							   class="layui-input layui-input-color" >
					</div>
				</div>
	             <div class="form-item-inline">
					 <label class="form-label title-max label-max">教学点个数</label>
					<div class="layui-input-block ">
					 <input type="number" value="${pd.child_total }" name="point_total" id="point_total" required lay-verify="required" placeholder="请输入教学点个数"
	                              autocomplete="off"  maxlength="7"
	                              class="layui-input layui-input-color" >
					</div>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-row">
				 <div class="form-item-inline">
					 <label class="form-label title-max label-max"><span><i class="require">*</i>是否民政</span><span>部注册</span></label>
                    <div class="layui-input-block " id="sel_register">
                         <html:select id="has_register" name="has_register" classs="layui-input-inline" style=" lay-filter='select1'">
                             <html:options collection="sf" defaultValue="${pd.has_register}"></html:options>
                         </html:select>
                     </div>
                 </div>
                 <div class="form-item-inline">
                 	 <label class="form-label title-max label-max"><span><i class="require">*</i>合作身份</span><span>者ID</span></label>
					<div class="layui-input-block ">
						<input type="text" value="${pd.partner }" name="partner" id="partner" required lay-verify="required" placeholder="请输入合作身份者ID，签约账号，以2088开头由16位纯数字组成的字符串"
							   autocomplete="off"  maxlength="30"
							   class="layui-input layui-input-color" >
					</div>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline">
                 	 <label class="form-label title-max label-max"><span><i class="require">*</i>收款支付</span><span>宝账号</span></label>
					<div class="layui-input-block ">
						<input type="text" value="${pd.seller_id }" name="seller_id" id="seller_id" required lay-verify="required" placeholder="请输入收款支付宝账号，以2088开头由16位纯数字组成的字符串，一般情况下收款账号就是签约账号"
							   autocomplete="off"  maxlength="30"
							   class="layui-input layui-input-color" >
					</div>
				</div>
	             <div class="form-item-inline">
                 	 <label class="form-label title-max label-max"><span><i class="require">*</i>MD5密钥</span></label>
					<div class="layui-input-block ">
					 <input type="text" value="${pd.md5_key }" name="md5_key" id="md5_key" required lay-verify="required" placeholder="请输入MD5密钥，安全检验码"
	                              autocomplete="off"  maxlength="30"
	                              class="layui-input layui-input-color" >
					</div>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-row">
				<div class="form-item-inline" style="position: relative;width: 18rem;">
					<label class="form-label label-max title-max"><span>上传营业</span><span>执照</span></label>
			  <c:choose>
			 <c:when test="${not empty pd.photo}">
			<div class="layui-input-block ">
				 <img src="<%=basePath%>attachment/fileDownload.do?fileName=${pd.photo}&filePath=${pd.filePath}"   width=90% height=80%></img>
			</div>
			 </c:when>
			 <c:otherwise>
				<div class="layui-input-block  is-upload">
					 <div class="text-tip" style=" position:absolute;text-align: center;top: 6px;width: 16rem;">
						 <div class="file-btn"  >
							 选择文件
						 </div>
						 <div class="file-text">
							 未选择文件
						 </div>
					 </div>
					 <input type="file" name="schoolFile" class="" id="schoolFile" style="position: absolute;top: 6px;height: 2rem;width: 8rem;cursor: pointer;opacity: 0">
				 </div>
			 </c:otherwise>

		 </c:choose>
		 </div>
			</div>
		</div>
		 <div class="btnbox" id="btnDiv" style="margin-top: 4rem;">
			 <button id="sure" class="layui-btn layui-btn-primary layui-btn-small" style="width: 8rem;height: 3rem;" >提交</button>
		 </div>
    </form>


</div>
<%@ include file="../../../system/index/foot.jsp" %>
<script>
    $(function () {

        $.myUploading("schoolFile",200,100);
        var optype = '${pd.optype}';
        $.myType(optype);
        if(optype=="2"){
            $("#name,#tax_code").attr("disabled","disabled").css("background-color", "#f2f2f2");
            $("#sel_register dl").css({"display":"none"})
            $("#sel_register i").css({"display":"none"})
        }
        $("#sure").on("click", function () {
            if ($("#name").val() == "") {
                layer.tips('学校名不能为空', $("#name"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#name").focus();
                return false;
            }
            if ($("#address").val() == "") {
                layer.tips('学校地址不能为空', $("#address"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#address").focus();
                return false;
            }
            if ($("#tel").val() == "") {
                layer.tips('联系电话不能为空', $("#tel"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#tel").focus();
                return false;
            }

            if ($("#contanct_name").val()==""){
                layer.tips('联系人不能为空', $("#contanct_name"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#contanct_name").focus();
                return false;
            }
            if ($("#contanct_phone").val() == "") {
                layer.tips('联系人电话号码不能为空', $("#contanct_phone"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#contanct_phone").focus();
                return false;
            }
            if ($("#email").val() == "") {
                layer.tips('联系人邮箱不能为空', $("#email"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#email").focus();
                return false;
            }
            if ($("#stu_total").val() == "") {
                layer.tips('学员总数不能为空', $("#stu_total"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#stu_total").focus();
                return false;
            }
            if ($("#jg-nature").val() == "") {
                layer.tips('机构性质不能为空', $("#div_stype"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#div_stype").focus();
                return false;
            }
            if ($("#is-subordinate").val() == "") {
                layer.tips('是否存在分校不能为空', $("#div_is_subordinate"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#div_is_subordinate").focus();
                return false;
            }
            
            if ($("#is-teaching").val() == "") {
                layer.tips('是否存在教学点不能为空', $("#div_isteaching"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#div_isteaching").focus();
                return false;
            }
            if ($("#tax_code").val() == "") {
                layer.tips('税务登记号不能为空', $("#tax_code"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#tax_code").focus();
                return false;
            }
            if ($("#has_register").val() == "") {
                layer.tips('是否民政部注册不能为空', $("#sel_register"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#sel_register").focus();
                return false;
            }
            parent.layer.load(1);
            $("#editForm").ajaxSubmit({
                type: 'post',
                dataType: "html",
                success: function (data) {
                	parent.layer.closeAll("loading");
                    var jso = JSON.parse(data);
                    if ("success" == jso.msg) {
                    	 parent.layer.edit.location.href = "<%=basePath%>schoolaptitude/list.do?currentPage=${currentPage}";
                         parent.layer.closeAll();
                    } else {
                        layer.msg('系统繁忙，请稍后重试!', {icon: 5});
                    }
                }
            });
            return false; // 阻止表单自动提交事件
        });
        $("#cancel").on("click", function () {
            parent.layer.closeAll();
        });

        
    });

</script>
</body>
</html>