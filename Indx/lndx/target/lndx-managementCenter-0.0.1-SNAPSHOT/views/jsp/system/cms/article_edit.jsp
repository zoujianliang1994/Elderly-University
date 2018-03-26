<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>文章编辑</title>
    <%@ include file="../../system/index/headcss.jsp" %>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>static/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=basePath %>static/ueditor/ueditor.all.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>

<div class="edit_menu" class="disnone">
    <form action="${msg}.do" class="layui-form" name="editForm" id="editForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ARTICLE_ID" id="ARTICLE_ID" value="${pd.ARTICLE_ID}" />
		<input type="hidden" name="CREATE_TIME" id="CREATE_TIME" value="${pd.CREATE_TIME}" />
		<input type="hidden" name="UPDATE_TIME" id="UPDATE_TIME" value="${pd.UPDATE_TIME}" />
		<input type="hidden" name="ISCHECK" id="ISCHECK" value="${pd.ISCHECK}" />
		<input type="hidden" name="SUMMARY" id="SUMMARY" value="${pd.SUMMARY}" />
        <div class="layui-form-item">
            <div class="layui-row">

                <div class="form-item-inline">
                    <label class="form-label title-max"><span class="red-star">*</span>所属目录</label>
                   <div class="layui-input-block  FOLDER_ID">
                        <select lay-filter='FOLDER_ID' id="FOLDER_ID" name="FOLDER_ID" class="layui-input-inline">
                            <option value="">请选择目录</option>
                            <c:forEach var="var" items="${varList}" varStatus="vs">
								<option <c:if test="${var.FOLDER_ID == pd.FOLDER_ID }">selected</c:if> value="${var.FOLDER_ID}">${var.NAME}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                 <div class="form-item-inline">
                    <label class="form-label"><span class="red-star">*</span>文章标题</label>
                   <div class="layui-input-block ">
                        <input id="TITLE" name="TITLE" value="${pd.TITLE }" type="text" class="layui-input layui-input-color" placeholder="请输入文章标题">
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline">
                    <label class="form-label"><span class="red-star">*</span>文章来源</label>
                   <div class="layui-input-block ">
                        <input id="SOURCE_NAME" name="SOURCE_NAME" value="${pd.SOURCE_NAME }" type="text" class="layui-input layui-input-color" placeholder="请输入文章来源">
                    </div>
                </div>
                <div class="form-item-inline">
                    <label class="form-label">发布状态</label>
                    <div class="layui-input-block ">
						<html:select name="STATUS" id="STATUS" classs="layui-input-inline">
                            <html:options collection="push_status" defaultValue="${pd.STATUS}"></html:options>
                        </html:select>                    
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="form-item-inline" style="position: relative;width: 98%">
                    <label class="form-label">文章照片<span class="colon"></span></label>
                    <c:choose>
                        <c:when test="${pd.type==1}">
                           <div class="layui-input-block" style="padding-bottom: 10px;">
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
                                    <div class="file-text" style="width: 120px;">
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
        
        <div class="layui-form-item">
            <div class="layui-row">
                    <div class="form-item-inline" style="width: 98%">
                        <label class="form-label"><span class="red-star">*</span>文章内容</label>
                        <div class="layui-input-block" style="width: 100%;">
                            <c:choose>
                                <c:when test="${pd.type==1}">
                                    <div class="layui-textarea">
                                        <c:if test="${empty var.ARTICLE_ID}">${pd.CONTENT}</c:if>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <script id=container name="CONTENT" type="text/plain" ><c:if test="${empty var.ARTICLE_ID}">${pd.CONTENT}</c:if></script>
                                </c:otherwise>
                            </c:choose>
                        </div>
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

        var	contentEditor = UE.getEditor('container', {
			//关闭字数统计
			wordCount : false,
			//关闭elementPath
			elementPathEnabled : false,
			toolbars : [ [ 'anchor', //锚点
			'undo', //撤销
			'redo', //重做
			'bold', //加粗
			'indent', //首行缩进
			'snapscreen', //截图
			'italic', //斜体
			'underline', //下划线
			'strikethrough', //删除线
			'subscript', //下标
			'fontborder', //字符边框
			'superscript', //上标
			'formatmatch', //格式刷
			'blockquote', //引用
			'pasteplain', //纯文本粘贴模式
			'selectall', //全选
			'preview', //预览
			'horizontal', //分隔线
			'removeformat', //清除格式
			'unlink', //取消链接
			'insertrow', //前插入行
			'insertcol', //前插入列
			'mergeright', //右合并单元格
			'mergedown', //下合并单元格
			'deleterow', //删除行
			'deletecol', //删除列
			'splittorows', //拆分成行
			'splittocols', //拆分成列
			'splittocells', //完全拆分单元格
			'deletecaption', //删除表格标题
			'inserttitle', //插入标题
			'mergecells', //合并多个单元格
			'deletetable', //删除表格
			'cleardoc', //清空文档
			'insertparagraphbeforetable', //"表格前插入行"
			'fontfamily', //字体
			'fontsize', //字号
			'paragraph', //段落格式
			/*  'simpleupload', //单图上传 */
			'insertimage', //多图上传
			'edittable', //表格属性
			'edittd', //单元格属性
			'link', //超链接
			'emotion', //表情
			'spechars', //特殊字符
			'searchreplace', //查询替换
			'map', //Baidu地图
			'gmap', //Google地图
			'insertvideo', //视频
			'justifyleft', //居左对齐
			'justifyright', //居右对齐
			'justifycenter', //居中对齐
			'justifyjustify', //两端对齐
			'forecolor', //字体颜色
			'backcolor', //背景色
			'insertorderedlist', //有序列表
			'insertunorderedlist', //无序列表
			'fullscreen', //全屏
			'directionalityltr', //从左向右输入
			'directionalityrtl', //从右向左输入
			'rowspacingtop', //段前距
			'rowspacingbottom', //段后距
			'pagebreak', //分页
			// 'insertframe', //插入Iframe
			'imagenone', //默认
			'imageleft', //左浮动
			'imageright', //右浮动
			'attachment', //附件
			'imagecenter', //居中
			'wordimage', //图片转存
			'lineheight', //行间距
			'edittip ', //编辑提示
			'customstyle', //自定义标题
			'autotypeset', //自动排版
			'touppercase', //字母大写
			'tolowercase', //字母小写
			'background', //背景
			'scrawl', //涂鸦
			'music', //音乐
			'inserttable', //插入表格
			'drafts', // 从草稿箱加载
			'charts', // 图表
			] ]
		});

        $("#sure").on("click", function () {

            if ($("#FOLDER_ID").val() == "") {
                layer.tips('所属目录不能为空!', $(".FOLDER_ID"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $(".FOLDER_ID").focus();
                return false;
            }

            if ($("#TITLE").val() == "") {
                layer.tips('文章标题不能为空!', $("#TITLE"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#TITLE").focus();
                return false;
            }

            if ($("#SOURCE_NAME").val() == "") {
                layer.tips('文章来源不能为空!', $("#SOURCE_NAME"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#SOURCE_NAME").focus();
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
                        parent.layer.edit.location.href = "<%=basePath%>manage/article/list.do?currentPage=1";
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