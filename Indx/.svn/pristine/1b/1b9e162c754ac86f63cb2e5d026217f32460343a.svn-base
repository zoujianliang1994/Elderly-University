<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../index/headcss.jsp"%>
</head>
<body>

<div class="edit_menu" class="disnone">
	<form action="dictionaries/${msg}.do" class="layui-form" name="Form" id="Form" lay-filter="editForm" method="post">
		<input type="hidden" name="DICTIONARIES_ID" id="DICTIONARIES_ID" value="${pd.DICTIONARIES_ID}" />
		<input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${null == pd.PARENT_ID ? DICTIONARIES_ID:pd.PARENT_ID}" />
		<div class="layui-form-item">
			<label class="layui-form-label">上级</label>
			<div class="layui-input-block">
				<blockquote class="layui-elem-quote" style="padding: 7px;">${null == pds.NAME ?'(无) 此项为顶级菜单':pds.NAME}</blockquote>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">名称</label>
			<div class="layui-input-block">
				<input type="text" value="${pd.NAME }" name="NAME" id="NAME" required  lay-verify="required" placeholder="请输入名称" autocomplete="off" class="layui-input">
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">英文</label>
			<div class="layui-input-block">
				<input type="text" value="${pd.NAME_EN }" name="NAME_EN" id="NAME_EN" required  lay-verify="required" placeholder="请输入英文名称" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">编码值</label>
			<div class="layui-input-block">
				<input type="text" value="${pd.BIANMA }" name="BIANMA" id="BIANMA" required  lay-verify="required" placeholder="请输入编码值" autocomplete="off" class="layui-input">
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">排序</label>
			<div class="layui-input-block">
				<input type="number" value="${pd.ORDER_BY }" name="ORDER_BY" id="ORDER_BY" required  lay-verify="required" placeholder="请输入排序" autocomplete="off" class="layui-input">
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">备注</label>
			<div class="layui-input-block">
				<textarea class="layui-textarea"  name="BZ" id="BZ" placeholder="这里输入备注" title="备注" style="width: 98%;">${pd.BZ}</textarea>
			</div>
		</div>
	</form>


	<div class="btnbox" >
		<button id="sure" class="layui-btn layui-btn-primary layui-btn-small">确认</button>
		<button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
	</div>

</div>


	<%@ include file="../index/foot.jsp"%>


	<script type="text/javascript">
		//保存
        $(function(){
            $("#sure").on("click",function(){
                if ($("#NAME").val() == "") {

                    layer.tips('请输入名称', $("#NAME"), {
                        tips: [4, '#2795cd'],
                        time: 4000
                    });
                    $("#NAME").focus();
                    return false;
                }
                if ($("#NAME_EN").val() == "") {
                    layer.tips('请输入英文', $("#NAME_EN"),{
                        tips: [4, '#2795cd'],
                        time: 4000
                    });
                    $("#NAME_EN").focus();
                    return false;
                }
                if ($("#BIANMA").val() == "") {

                    layer.tips('请输入编码', $("#BIANMA"),{
                        tips: [4, '#2795cd'],
                        time: 4000
                    });

                    $("#BIANMA").focus();
                    return false;
                }
                if ($("#ORDER_BY").val() == "") {
                    layer.tips('请输入排序', $("#ORDER_BY"),{
                        tips: [4, '#2795cd'],
                        time: 4000
                    });
                    $("#ORDER_BY").focus();
                    return false;
                }

                $.post('<%=basePath%>dictionaries/${msg}.do', $('#Form').serialize(), function (data) {
                    parent.layer.closeAll();
                    parent.layer.transmit.location.href = "<%=basePath%>dictionaries/list.do?DICTIONARIES_ID=${DICTIONARIES_ID}&currentPage=${currentPage}";
                });
			})


            $("#cancel").on("click",function(){
                parent.layer.closeAll();
            })
        })
	</script>
</body>
</html>