<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*,com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*" %>
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
    
    //poCtrl1.addCustomToolButton("痕迹编辑", "docRevisionOnly", 3);
    //poCtrl1.addCustomToolButton("显示痕迹", "ShowRevisions", 5);
    //poCtrl1.addCustomToolButton("隐藏痕迹", "HiddenRevisions", 5);
    //poCtrl1.addCustomToolButton("手写批注", "StartHandDraw", 3);
    
    poCtrl1.setFileTitle("sample_word");//文件另存为名称
    //poCtrl1.setBorderStyle(BorderStyleType.BorderNone);//控件边框样式
    //显示隐藏栏目
    //poCtrl1.setTitlebar(false); //隐藏标题栏
	//poCtrl1.setMenubar(false); //隐藏菜单栏
	//poCtrl1.setOfficeToolbars(false);//隐藏Office工具条
	//poCtrl1.setCustomToolbar(false);//隐藏自定义工具栏
    //设置栏目值
    poCtrl1.setCaption("文档在线编辑");//设置标题栏文本
    //poCtrl1.setTheme(ThemeType.Office2010);//改变控件窗口的界面样式。有自定义界面、Office2007界面和Office2010界面共三种主题可选。
	//poCtrl1.setJsFunction_AfterDocumentOpened("AfterDocumentOpened()"); 
	poCtrl1.setSaveFilePage(request.getContextPath()+"/views/jsp/system/office/savefile.jsp");//如要保存文件，此行必须
	//打开文件
	poCtrl1.webOpen(request.getContextPath()+"/views/jsp/system/office/sample_word.doc", OpenModeType.docNormalEdit, "Administrtor");//普通编辑模式
	
	//poCtrl1.webOpen(request.getContextPath()+"/views/jsp/system/office/sample_word.doc", OpenModeType.docReadOnly, "Administrtor");//只读方式打开
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
      	//痕迹编辑模式
     	function docRevisionOnly()
    	{
     		document.getElementById("PageOfficeCtrl1").Close(); 
     		document.getElementById("PageOfficeCtrl1").webOpen(request.getContextPath()+"/views/jsp/system/office/sample_word.doc", OpenModeType.docRevisionOnly, "Administrtor");
        }
        function AfterDocumentOpened() {
            document.getElementById("Text1").value = document.getElementById("PageOfficeCtrl1").DataRegionList.GetDataRegionByName("PO_Title").Value;
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
							火狐、谷歌浏览器请点击: <a href="<%=PageOfficeLink.openWindow(request, "word.jsp","width=1200px;height=800px;")%>" >PageOfficeLink方式在线打开文档</a><br/>
							IE浏览器<br/>
							<form id="form1">
								<div style=" width:auto; height:700px;">
									<po:PageOfficeCtrl id="PageOfficeCtrl1" />
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