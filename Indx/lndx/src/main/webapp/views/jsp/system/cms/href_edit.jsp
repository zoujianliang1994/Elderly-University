<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<link rel="stylesheet" type="text/css" href="plugins/webuploader/webuploader.css" />
<link rel="stylesheet" type="text/css" href="plugins/webuploader/style.css" />
</head>
<body class="no-skin">
	<div class="main-container" id="main-container">
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">

							<form action="manage/indexHref/${msg}.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
								<input type="hidden" name="ID" id="ID" value="${pd.ID}" />
								<div id="zhongxin">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width: 90px; text-align: right; padding-top: 13px;">链接名称:</td>
											<td>
												<input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="100" placeholder="这里输入链接名称" title="链接名称" style="width: 98%;" />
											</td>
										</tr>
										<tr>
											<td style="width: 90px; text-align: right; padding-top: 13px;">链接地址:</td>
											<td>
												<input type="text" name="URL" id="URL" value="${pd.URL}" maxlength="500" placeholder="这里输入链接地址" title="链接地址" style="width: 98%;" />
											</td>
										</tr>
										<tr>
											<td style="width: 70px; text-align: right; padding-top: 13px;">链接状态:</td>
											<td>

												<input name="FLAG" value="1" type="radio" <c:if test="${pd.FLAG==1 || pd.FLAG =='' || pd.FLAG == null}">checked</c:if> />
												显示 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input name="FLAG" value="0" type="radio" <c:if test="${pd.FLAG==0}">checked</c:if> />
												隐藏
											</td>

										</tr>

										<tr>
											<td class="center" colspan="10">
												<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
												<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
											</td>
										</tr>
									</table>
								</div>

							</form>

							<div id="zhongxin2" class="center" style="display: none">
								<img src="static/images/jzx.gif" style="width: 50px;" />
								<br />
								<h4 class="lighter block green"></h4>
							</div>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 上传控件 -->
	<script src="static/ace/js/ace/elements.fileinput.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		$(function() {

		});
		//保存
		function save() {
			//校验...
			if ($("#NAME").val() == "") {
				$("#NAME").tips({
					side : 3,
					msg : '请输入链接名称',
					bg : '#AE81FF',
					time : 2
				});
				$("#NAME").focus();
				return false;
			}
			if ($("#URL").val() == "") {
				$("#URL").tips({
					side : 3,
					msg : '请输入链接地址',
					bg : '#AE81FF',
					time : 2
				});
				$("#URL").focus();
				return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	</script>
</body>
</html>