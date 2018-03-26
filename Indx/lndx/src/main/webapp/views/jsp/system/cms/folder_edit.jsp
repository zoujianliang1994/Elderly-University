<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>栏目编辑</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>

<div class="edit_menu" class="disnone">
    <form action="${msg}.do" class="layui-form" name="editForm" id="editForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="FATHER_ID" id="FATHER_ID" value="1" />
		<input type="hidden" name="FOLDER_ID" id="FOLDER_ID" value="${pd.FOLDER_ID}" />
		<input type="hidden" name="CREATE_TIME" id="CREATE_TIME" value="${pd.CREATE_TIME}" />
		<input type="hidden" name="ISCHECK" id="ISCHECK" value="yes" />
		<input type="hidden" name="TYPE" id="TYPE" value="${pd.type}" />
		<input id="PATH" name="PATH" value="${pd.PATH }" type="hidden">
        <div class="layui-form-item">
            <div class="layui-row">

                 <div class="form-item-inline">
                    <label class="form-label"><span class="red-star">*</span>目录名称</label>
                   <div class="layui-input-block ">
                        <input id="NAME" name="NAME" value="${pd.NAME }" type="text" class="layui-input layui-input-color" placeholder="请输入目录名称">
                    </div>
                </div>
                 <div class="form-item-inline">
                    <label class="form-label"><span class="red-star">*</span>目录序号</label>
                   <div class="layui-input-block ">
                        <input id="SORT" name="SORT" value="${pd.SORT }" type="text" class="layui-input layui-input-color" placeholder="请输入目录序号">
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
	         <div class="form-item-inline">
                	<label class="form-label">目录状态</label>
                    <div class="layui-input-block ">
						<html:select name="STATUS" id="STATUS" classs="layui-input-inline">
                            <html:options collection="push_status" defaultValue="${pd.STATUS}"></html:options>
                        </html:select>                    
                    </div>
                </div>
                     <div class="layui-row">
                <div class="form-item-inline" style="position: relative;width: 98%">
                    <label class="form-label">目录照片<span class="colon"></span></label>
                    <c:choose>
                        <c:when test="${pd.type==1}">
                           <div class="layui-input-block " style="padding-bottom: 10px;">

                               <img src="<%=basePath%>attachment/fileDownload.do?fileName=${pd.PICTURE}&filePath=${pd.filePath}">
                            </div>
                            <input type="text" name="PICTURE" value="${pd.PICTURE}" hidden>
                        </c:when>
                        <c:otherwise>
                           <div class="layui-input-block is-upload">
                                <div class="text-tip" style=" position:absolute;text-align: center;top: 6px;width: auto;">
                                    <div class="file-btn"  >
                                        选择
                                    </div>
                                    <div class="file-text" style="width: 120px;height: 150px;">
                                        <c:choose>
                                        <c:when test="${not empty pd.PICTURE}">

                                            <img src="<%=basePath%>attachment/fileDownload.do?fileName=${pd.PICTURE}&filePath=${pd.filePath}" alt="">
                                            <input type="text" name="PICTURE" value="${pd.PICTURE}" hidden>
                                        </c:when>
                                            <c:otherwise>
                                                未选择文件
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                                <input type="file" name="files" class="" id="files" style="position: absolute;top: 6px;height: 2rem;width: 8rem;cursor: pointer;opacity: 0">
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
	    </div>

    </form>

    <div class="btnbox" id="btnDiv" hidden="true">
        <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
        <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
    </div>

</div>
<%@ include file="../../system/index/foot.jsp" %>


<script>
    $(function () {
        var form = layui.form;
        $.myUploading("files",200,100)

        $("#sure").on("click", function () {

            if ($("#NAME").val() == "") {
                layer.tips('目录名称不能为空!', $("#NAME"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#NAME").focus();
                return false;
            }

            if ($("#SORT").val() == "") {
                layer.tips('目录序号不能为空!', $("#SORT"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#SORT").focus();
                return false;
            }
            var r = /^[0-9]*[1-9][0-9]*$/;
			if (!r.test($("#SORT").val())) {
				layer.tips('目录序号必须是正整数!', $("#SORT"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#SORT").focus();
                return false;
			}
			
            parent.layer.load(1);
            $("#editForm").ajaxSubmit({
                type: 'post',
                dataType: "html",
                success: function (data) {
                    parent.layer.closeAll("loading");
                    var jso = JSON.parse(data);
                    if ("success" == jso.result) {
                        parent.layer.edit.location.href = "<%=basePath%>manage/folder/list.do?currentPage=1&type=normal";
                        parent.layer.closeAll();
                    } else {
                        layer.msg('系统异常,保存失败!', {icon: 5});
                    }
                }
            });
            return false;
        });
        $("#cancel").on("click", function () {
            parent.layer.closeAll();
        });
        $.myType('${pd.type}');
    });
</script>
</body>
</html>