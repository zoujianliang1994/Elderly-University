<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*,com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.excelwriter.*" %>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>
<%@include file="/include.inc.jsp"%>
<%
	PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);
	poCtrl1.setServerPage(request.getContextPath()+"/poserver.zz"); //此行必须
	//添加自定义按钮
	poCtrl1.addCustomToolButton("保存","save",1);
	poCtrl1.addCustomToolButton("另保存","saveAs",1);
	poCtrl1.addCustomToolButton("加盖印章", "InsertSeal()", 2);
    poCtrl1.addCustomToolButton("签字", "AddHandSign()", 3);
    poCtrl1.addCustomToolButton("验证印章", "VerifySeal()", 5);
    poCtrl1.addCustomToolButton("修改密码", "ChangePsw()", 0);
	//poCtrl1.setJsFunction_AfterDocumentOpened("AfterDocumentOpened()"); 
	poCtrl1.setSaveFilePage(request.getContextPath()+"/views/jsp/system/office/savefile.jsp");//如要保存文件，此行必须
	//打开文件
	poCtrl1.webOpen(request.getContextPath()+"/views/jsp/system/office/sample_excel.xls", OpenModeType.xlsNormalEdit, "Administrtor");
	poCtrl1.setTagId("PageOfficeCtrl1"); //此行必须	 
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../index/top.jsp"%>
</head>
<body>
	<script type="text/javascript">
        function save() {
            document.getElementById("PageOfficeCtrl1").WebSave();
        }
        function saveAs() {
            document.getElementById("PageOfficeCtrl1").ShowDialog(3);
         }

        function setTitleText() {
            document.getElementById("PageOfficeCtrl1").DataRegionList.GetDataRegionByName("PO_Title").Value = document.getElementById("Text1").value;
        }
        function InsertSeal() {
            try {
                document.getElementById("PageOfficeCtrl1").ZoomSeal.AddSeal();
            }
            catch (e) { }
        }
        function AddHandSign() {
            document.getElementById("PageOfficeCtrl1").ZoomSeal.AddHandSign();
        }
        function VerifySeal() {
            document.getElementById("PageOfficeCtrl1").ZoomSeal.VerifySeal();
        }
        function ChangePsw() {
            document.getElementById("PageOfficeCtrl1").ZoomSeal.ShowSettingsBox();
        }
    </script>
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							火狐、谷歌浏览器请点击:<a href="<%=PageOfficeLink.openWindow(request, "excel.jsp","width=1200px;height=800px;")%>" >PageOfficeLink方式在线打开文档</a><br/>
							IE浏览器<br/>
							<div style=" width:auto; height:700px;">
								<po:PageOfficeCtrl id="PageOfficeCtrl1" />
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


		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		$(top.hangge());
	</script>
	<script type="text/javascript" src="static/ace/js/jquery.js"></script>
	
</body>
</html>