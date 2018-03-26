<%@ page language="java" import="java.util.*,com.zhuozhengsoft.pageoffice.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%
	//var wordPath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/test.doc";
	PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);
	//设置服务器页面
	poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
	//添加自定义按钮
	poCtrl.addCustomToolButton("保存","save",1);
	poCtrl.addCustomToolButton("另保存","saveAs",1);
	//设置保存页面
	poCtrl.setSaveFilePage("saveFile.jsp");
	//打开Word文档
	poCtrl.webOpen("sample_word.doc",OpenModeType.docNormalEdit,"Administator");
	poCtrl.setTagId("PageOfficeCtrl1");//此行必需
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <title>在线编辑文档</title>
</head>
<body>
    <script type="text/javascript">
        function save() {
            document.getElementById("PageOfficeCtrl1").WebSave();
        }
        function saveAs() {
            document.getElementById("PageOfficeCtrl1").ShowDialog(3);
         }
        function AfterDocumentOpened() {
            document.getElementById("Text1").value = document.getElementById("PageOfficeCtrl1").DataRegionList.GetDataRegionByName("PO_Title").Value;
        }

        function setTitleText() {
            document.getElementById("PageOfficeCtrl1").DataRegionList.GetDataRegionByName("PO_Title").Value = document.getElementById("Text1").value;
        }
    </script>
  	  文档标题：<input id="Text1" type="text" size="50"      />
	<input type="button" value="修改" onclick="setTitleText();" />
    <form id="form1" >
	    <div style=" width:auto; height:700px;">
	        <po:PageOfficeCtrl id="PageOfficeCtrl1"/>
	    </div>
    </form>
</body>
</html>