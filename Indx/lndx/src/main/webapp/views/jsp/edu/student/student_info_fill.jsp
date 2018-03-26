﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>我的(学员)资料管理</title>
    <%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>

<div class="tableBox">

    <!-- table -->
    <div class="layui-col-sm12">
        <form action="${msg}.do" class="layui-form" id="editForm" enctype="multipart/form-data" lay-filter="editForm" method="post" name="editForm">
        	<input type="hidden" name="id" id="id" value="${pd.id}">
        	<input type="hidden" name="nl" value="${pd.nl}">
        	<input type="hidden" name="tel" value="${pd.tel}">
        	<input type="hidden" name="isgo" value="${pd.isgo}">
            <p class="student-info-title">1. 请填写您的基本资料（以下资料打*号为必填）</p>
            <div style="width: 120px;height: 150px;float: left;border: 1px solid #ccc;margin-right: 20px;margin-top: 12px;position: relative;">

                        <div class="file-text" style="position: absolute;padding: 0;width:100%;height: 150px;text-align: center;line-height: 150px;">
                            <c:if test="${pd.photo_url == null && pd.photo_url == ''}">
                                <span>点击上传图片</span>
                            </c:if>
                            <c:if test="${pd.photo != null && pd.photo != ''}">
                                <input type="hidden" name="photo" id="photo" value="${pd.photo}">
                                <img class="img" src="<%=basePath %>uploadFiles/file/${pd.photo}"/>
                            </c:if>
                        </div>

                <input type="file" name="studentFile" class="" id="studentFile" style="position: absolute;left: 0;height: 150px;width: 100%;cursor: pointer;opacity: 0">
             </div>
            <div style="float: left;clear:none;width: 80%;margin-bottom: 0" class="layui-form-item">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="form-label"><i class="require">*</i>姓名<span class="colon"></span></label>
                       <div class="layui-input-block " style="width: 10rem;">
                            <input type="text" id="xm" required lay-verify="required" name="xm" value="${pd.xm}"
                                   autocomplete="off" maxlength="200"
                                   class="layui-input layui-input-color">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="form-label"><i class="require">*</i>性别<span class="colon"></span></label>
                       <div class="layui-input-block " style="width: 10rem;" id="div_sex">
                            <html:select name="xb" id="xb" classs="layui-input-inline">
		                        <html:options collection="SEX" defaultValue="${pd.xb}"></html:options>
		                    </html:select>
                        </div>
					</div>
                    <div class="layui-inline">
                        <label class="form-label"><i class="require">*</i>出生日期<span class="colon"></span></label>
                       <div class="layui-input-block " style="width: 16rem;">
                            <input type="text" id="birth_day"   required lay-verify="required" placeholder="请选择日期" value="${pd.birth_day}" name="birth_day"
                                   autocomplete="off" maxlength="20"
                                   class="layui-input layui-input-color">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="form-label"><i class="require">*</i>身份证号<span class="colon"></span></label>
                       <div class="layui-input-block " style="width:16rem;">
                            <input type="text" id="sfz"  name="sfz"  required lay-verify="required" value="${pd.sfz}"
                                   autocomplete="off" maxlength="18"
                                   class="layui-input layui-input-color">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="form-label">籍贯<span class="colon"></span></label>
                       <div class="layui-input-block " style="width: 10rem;">
                            <input type="text"  required lay-verify="required" name="hjdz" id="hjdz" value="${pd.hjdz}"
                                   autocomplete="off" maxlength="200"
                                   class="layui-input layui-input-color">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="form-label">民族<span class="colon"></span></label>
                       <div class="layui-input-block " style="width: 10rem;">
                            <html:select name="mz" id="mz" classs="layui-input-inline">
		                        <html:options collection="Person_mz" defaultValue="${pd.mz}"></html:options>
		                    </html:select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="form-label"><i class="require">*</i>手机号码<span class="colon"></span></label>
                       <div class="layui-input-block " style="width: 16rem;"  >
                            <input type="text" id="phone" required lay-verify="required" name="phone" value="${pd.phone}"
                                   autocomplete="off" maxlength="20"
                                   class="layui-input layui-input-color">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="form-label"><i class="require">*</i>疾病史<span class="colon"></span></label>
                       <div class="layui-input-block " style="width:16rem;">
                            <input type="text" id="disease"  name="disease"  required lay-verify="required"  value="${pd.disease}"
                                   autocomplete="off" maxlength="200"
                                   class="layui-input layui-input-color">
                        </div>
                    </div>
                </div>

            </div>
        </form>
        <div class="layui-form-item" style="border-bottom: 1px solid #dce3eb;padding-bottom: 20px;padding-left:140px;">
                <div class="layui-inline citys" id="selectList">
                    <label class="form-label">当前住址<span class="colon"></span></label>
                   <div class="layui-input-block " style="width: 10rem; margin-right: 15px;float: left;">
                            <select name="province" id="province" class="select-linkage layui-input-color"></select>
                    </div>
                   <div class="layui-input-block " style="width: 10rem; margin-right: 15px;float: left;">
                            <select name="city" id="city" class="select-linkage layui-input-color"></select>
                    </div>
                   <div class="layui-input-block " style="width: 16rem; margin-right: 15px;float: left;">
                            <select name="area" id="country" class="select-linkage layui-input-color"></select>
                    </div>

                   <div class="layui-input-block " style="width: 16rem;float: left;">
                        <input type="text"  required lay-verify="required" name="address" id="address" value="${pd.address}"
                               autocomplete="off" maxlength="100" placeholder="请输入详细地址"
                               class="layui-input layui-input-color">
                    </div>

                </div>
            </div>
        <form class="layui-form" id="editForm2" lay-filter="editForm" method="post">
            <p class="student-info-title">2. 请填写您家人的联系方式（以下资料打*号为必填）</p>
            <div class="layui-form-item" >
                <div class="layui-inline">
                    <label class="form-label"style="width: 80px"><i class="require">*</i>家庭联系人<span class="colon"></span></label>
                   <div class="layui-input-block " style="width: 10rem;">
                        <input type="text" id="family_con_name"  required lay-verify="required" name="family_con_name" value="${pd.family_con_name}"
                               autocomplete="off" maxlength="20" 
                               class="layui-input layui-input-color">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="form-label"style="width: 80px"><i class="require">*</i>联系人电话<span class="colon"></span></label>
                   <div class="layui-input-block " style="width: 16rem;">
                        <input type="text" id="family_con_tel"   required lay-verify="required" name="family_con_tel" value="${pd.family_con_tel}"
                               autocomplete="off" maxlength="20"
                               class="layui-input layui-input-color">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="form-label" style="width: 92px">第二家庭联系人<span class="colon"></span></label>
                   <div class="layui-input-block " style="width: 10rem;">
                        <input type="text"  required lay-verify="required" name="sec_con" value="${pd.sec_con}"
                               autocomplete="off" maxlength="20" id="sec_con"
                               class="layui-input layui-input-color">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="form-label">联系人电话<span class="colon"></span></label>
                   <div class="layui-input-block " style="width: 16rem;">
                        <input type="text"    required lay-verify="required" name="sec_con_tel" value="${pd.sec_con_tel}"
                               autocomplete="off" maxlength="20" id="sec_con_tel"
                               class="layui-input layui-input-color">
                    </div>
                </div>
            </div>
        </form>
          <div class="btnbox" id="btnDiv" style="text-align: left;">
                <button id="sure" class="layui-btn layui-btn-primary layui-btn-small" >提交</button>
          </div>
          <div id="hint" style="display: none">
		    <div class="hint-content">操作成功！</div>
		    <div class="btnbox">
		        <button id="hintSure" class="layui-btn layui-btn-primary layui-btn-small" style="width: 13rem;">立即报名</button>
		    </div>
		</div>
    </div>

</div>


<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">
	if('${pd.isgo}'=='true'){
        parent.layer.alert('请先完善个人资料信息后再报名！', {icon: 5});
	}
    if('${pd.province}'==""||'${pd.province}'=="undefined"){
        $('#selectList').citys({valueType:'name',required: false});
    }else{
        $('#selectList').citys({valueType:'name',province:'${pd.province}',city:'${pd.city}',area:'${pd.country}'});
    }


    $.myUploading("studentFile",100,150,2);

    layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#birth_day'

        });
    });
    
    $("#sure").on("click", function () {
        if ($("#name").val() == "") {
            layer.tips('姓名不能为空', $("#name"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#name").focus();
            return false;
        }
        if ($("#xb").val() == "") {
            layer.tips('性别不能为空', $("#div_sex"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#div_sex").focus();
            return false;
        }
      /*   if ($("#age").val() == "") {
            layer.tips('年龄不能为空', $("#age"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#age").focus();
            return false;
        } */

        if ($("#birth_day").val()==""){
            layer.tips('出生日期不能为空', $("#birth_day"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#birth_day").focus();
            return false;
        }
        if ($("#sfz").val() == "") {
            layer.tips('身份证号不能为空', $("#sfz"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#sfz").focus();
            return false;
        }
        if ($("#phone").val() == "") {
            layer.tips('手机号码不能为空', $("#phone"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#phone").focus();
            return false;
        }

        if (!$.isPoneAvailable($("#phone").val())) {
            layer.tips('请填写手机正确格式', $("#phone"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#phone").focus();
            return false;
        }
        if ($("#disease").val() == "") {
            layer.tips('疾病史不能为空', $("#disease"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#disease").focus();
            return false;
        }
        if ($("#family_con_name").val() == "") {
            layer.tips('家庭联系人不能为空', $("#family_con_name"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#family_con_name").focus();
            return false;
        }
        if ($("#family_con_tel").val() == "") {
            layer.tips('联系人电话不能为空', $("#family_con_tel"), {
                tips: [3, '#D16E6C'],
                time: 4000
            });
            $("#family_con_tel").focus();
            return false;
        }
       // var formData=$('#editForm,#editForm2').serialize()+'&province='+$("#s_province").val()+'&city='+$("#s_city").val()+'&country='+$("#s_county").val()+'&address='+$("#address").val();
        var formData = new FormData();
        formData.append('studentFile', $('#studentFile')[0].files[0]);
        formData.append('id',$('#id').val());  
        formData.append('xm',$('#xm').val());  
        formData.append('xb',$("#xb").val());
        formData.append('birthDay',$("#birth_day").val());
        formData.append('sfz',$("#sfz").val());
        formData.append('hjdz',$("#hjdz").val());
        formData.append('mz',$("#mz").val());
        formData.append('phone',$("#phone").val());
        formData.append('disease',$("#disease").val());
        formData.append('familyConName',$("#family_con_name").val());
        formData.append('familyConTel',$("#family_con_tel").val());
        formData.append('secCon',$("#sec_con").val());
        formData.append('secConTel',$("#sec_con_tel").val());
        formData.append('province',$("#province").val());
        formData.append('city',$("#city").val());
        formData.append('country',$("#country").val());
        formData.append('address',$("#address").val());
        formData.append('photo',$("#photo").val());
        console.log(formData);
        parent.layer.load(1);
        $.ajax({
            url: '${msg}.do',
            type: 'POST',
            cache: false,
            data: formData,
            processData: false,
            contentType: false
        }).done(function(data) {
        	 parent.layer.closeAll('loading');
             if ("success" == data.msg) {
             	if("${pd.isgo}"=='true'){
             		 $("#hint").css("display","block");
                      layer.open({
                          skin: 'demo-class',
                          title:"提示",
                          type: 1,
                          content: $("#hint"),
                          closeBtn: 0,
                          area: ["300px", "200px"],
                      })
             	}else{
             		layer.msg('操作成功!', {icon: 1});
             		parent.layer.edit.location.reload();
                     parent.layer.closeAll();
             	}
             } else {
                 layer.msg('系统异常,保存失败!', {icon: 5});
             }
        	
        }).fail(function(res) {
        	 parent.layer.closeAll('loading');
             layer.msg('系统异常,保存失败!', {icon: 5});
        });
        return false; // 阻止表单自动提交事件
    });
    
    $("#hintSure").on("click",function () {
        $("#hint").css("display","none");
        window.location.href = "<%=basePath%>studentEnroll/goAdd";
        layer.closeAll();
    })


</script>







</body>
</html>