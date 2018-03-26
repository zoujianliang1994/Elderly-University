<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

							<form action="manage/navigation/${msg}.do" name="Form" id="Form" method="post">
								<input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${pd.PARENT_ID}" />
								<input type="hidden" name="ID" id="ID" value="${pd.ID}" />
								<div id="zhongxin">
									<table id="table_report" class="table table-striped table-bordered table-hover">

										<tr>
											<td style="width: 80px; text-align: right; padding-top: 13px;">上级:</td>
											<td>
												<div class="col-xs-4 label label-lg label-light arrowed-in arrowed-right">
													<b>${null == pd.FNAME ?'(无) 此项为顶级':pd.FNAME}</b>
												</div>
											</td>
										</tr>

										<tr>
											<td style="width: 90px; text-align: right; padding-top: 13px;">目录名称:</td>
											<td>
												<input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="100" placeholder="这里输入目录名称" title="目录名称" style="width: 98%;" />
											</td>
										</tr>

										<tr <c:if test="${type == 'normal'}">hidden="true"</c:if>>
											<td style="width: 70px; text-align: right; padding-top: 13px;">目录地址:</td>
											<td>
												<input type="text" name="PATH" id="PATH" value="${pd.PATH}" maxlength="500" placeholder="这里输入目录地址" title="目录地址" style="width: 98%;" />
											</td>
										</tr>

										<tr>
											<td style="width: 70px; text-align: right; padding-top: 13px;">目录序号:</td>
											<td>
												<input type="number" name="SORT" id="SORT" value="${pd.SORT}" min="1" placeholder="这里输入目录序号" title="请输入正整数" style="width: 98%;" />
											</td>
										</tr>
										<tr>
											<td style="width: 70px; text-align: right; padding-top: 13px;">目录状态:</td>
											<td>

												<input name="STATUS" value="1" type="radio" checked>
												显示 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input name="STATUS" value="0" type="radio">
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

								<div id="zhongxin2" class="center" style="display: none">
									<br />
									<br />
									<br />
									<br />
									<br />
									<img src="static/images/jiazai.gif" />
									<br />
									<h4 class="lighter block green">提交中...</h4>
								</div>

							</form>

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

		//保存
		function save() {
			if ($("#NAME").val() == "") {
				$("#NAME").tips({
					side : 3,
					msg : '请输入目录名称',
					bg : '#AE81FF',
					time : 2
				});
				$("#NAME").focus();
				return false;
			}

			if ($("#SORT").val() == "") {
				$("#SORT").tips({
					side : 3,
					msg : '请输入目录序号',
					bg : '#AE81FF',
					time : 2
				});
				$("#SORT").focus();
				return false;
			}
			if (isNaN(Number($("#SORT").val()))) {
				$("#SORT").tips({
					side : 1,
					msg : '请输入目录序号',
					bg : '#AE81FF',
					time : 2
				});
				$("#SORT").focus();
				$("#SORT").val(1);
				return false;
			}
			var r = /^[0-9]*[1-9][0-9]*$/;
			if (!r.test($("#SORT").val())) {
				$("#SORT").tips({
					side : 1,
					msg : '目录序号必须是正整数',
					bg : '#AE81FF',
					time : 2
				});
				$("#SORT").focus();
				$("#SORT").val(1);
				return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	</script>
</body>
</html>