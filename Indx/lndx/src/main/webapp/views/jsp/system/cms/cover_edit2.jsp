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

							<form action="manage/cover/${msg}.do" name="Form" id="Form" method="post" enctype="multipart/form-data">

								<input type="hidden" name="ID" id="ID" value="${pd.ID}" />
								<div id="zhongxin">
									<table id="table_report" class="table table-striped table-bordered table-hover">

										<tr>
											<td style="width: 90px; text-align: right; padding-top: 13px;">封面名称:</td>
											<td>
												<input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="255" placeholder="这里输入封面名称" title="封面名称" style="width: 98%;" />
											</td>
										</tr>


										<tr>
											<td style="width: 70px; text-align: right; padding-top: 13px;">封面序号:</td>
											<td>
												<input type="number" name="SORT" id="SORT" value="${pd.SORT}" min="1" placeholder="这里输入封面序号" title="请输入正整数" style="width: 98%;" />
											</td>
										</tr>

										<tr>
											<td style="width: 70px; text-align: right; padding-top: 13px;">封面照片:</td>
											<td>
												<input type="hidden" name="PICTURES_PATH" id="PICTURES_PATH" value="${pd.PICTURES_PATH}" />
												<input type="hidden" name="PICTURES_FLAG" id="PICTURES_FLAG" value="0" />
												<input type="file" id="tp" name="files" onchange="fileType(this)" />
												<c:if test="${msg != 'save' }">
													<span id="PICTURES_SPAN" <c:if test="${pd.PICTURES_PATH == ''}">hidden="true"</c:if>>
														<img src='<%=basePath%>${pd.PICTURES_PATH}' style="width: 35%;">
														<input type="button" style="position: absolute; right: 24px; bottom: 68px;" class="btn btn-mini btn-danger" value="删除" onclick="delPic()" />
													</span>
												</c:if>
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

		$(function() {
			//上传
			$('#tp').ace_file_input({
				no_file : '请选择图片 ...',
				btn_choose : '选择',
				btn_change : '更改',
				droppable : false,
				onchange : null,
				thumbnail : false, //| true | large
				whitelist : 'gif|png|jpg|jpeg',
			//blacklist:'gif|png|jpg|jpeg'
			//onchange:''
			});
		});
		//过滤类型
		function fileType(obj) {
			document.getElementById("PICTURES_FLAG").value = "1";
			document.getElementById("PICTURES_SPAN").style.display = "none";
			var picPath = '${pd.PICTURES_PATH}';
			var fileType = obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
			if (fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg') {
				$("#tp").tips({
					side : 3,
					msg : '请上传gif,png,jpg,jpeg图片格式的文件',
					bg : '#AE81FF',
					time : 3
				});
				$("#tp").val('');
				document.getElementById("tp").files[0] = '请选择图片';
			}
		}

		//删除图片
		function delPic() {
			document.getElementById("PICTURES_SPAN").innerHTML = "";
			document.getElementById("PICTURES_PATH").value = "";
			document.getElementById("PICTURES_FLAG").value = "0";
		}

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