<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<link type="text/css" rel="stylesheet" href="plugins/zTree/2.6/zTreeStyle.css" />
<script type="text/javascript" src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
<style type="text/css">
footer {
	height: 50px;
	position: fixed;
	bottom: 0px;
	left: 0px;
	width: 100%;
	text-align: center;
}
</style>
<body>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<div id="zhongxin">
								<div style="overflow: scroll; scrolling: yes; height: 450px; width: 335px;">
									<ul id="tree" class="tree" style="overflow: auto;"></ul>
								</div>
							</div>
							<div id="zhongxin2" class="center" style="display: none">
								<br />
								<br />
								<br />
								<br />
								<img src="static/images/jiazai.gif" />
								<br />
								<h4 class="lighter block green">正在保存...</h4>
							</div>
						</div>
						<!-- /.col -->
					</div>
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->

	<!-- <div style="width: 100%;padding-top: 5px;" class="center">
			<a class="btn btn-mini btn-primary" onclick="save();">确定</a>
			<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
		</div> -->

	<script type="text/javascript">
		$(top.hangge());
		var zTree;
		$(document).ready(function() {
			var setting = {};
			var zn = '${zTreeNodes}';
			var zTreeNodes = eval(zn);
			zTree = $("#tree").zTree(setting, zTreeNodes);
		});
	</script>
</body>
</html>