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
<script type="text/javascript" charset="utf-8" src="static/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="static/ueditor/ueditor.all.min.js"></script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="static/ueditor/lang/zh-cn/zh-cn.js"></script>
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

							<form action="manage/article/${msg }.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
								<input type="hidden" name="ARTICLE_ID" id="ARTICLE_ID" value="${pd.ARTICLE_ID}" />
								<input type="hidden" name="CREATE_TIME" id="CREATE_TIME" value="${pd.CREATE_TIME}" />
								<input type="hidden" name="UPDATE_TIME" id="UPDATE_TIME" value="${pd.UPDATE_TIME}" />
								<input type="hidden" name="ISCHECK" id="ISCHECK" value="${pd.ISCHECK}" />
								<input type="hidden" name="SUMMARY" id="SUMMARY" value="${pd.SUMMARY}" />
								<div id="zhongxin">
									<table id="table_report" class="table table-striped table-bordered table-hover">

										<tr>
											<td style="width: 90px; text-align: right; padding-top: 13px;">所属目录:</td>
											<td>
												<c:choose>
													<c:when test="${not empty varList}">
														<select style="width: 98%; text-align: center" name="FOLDER_ID">
															<c:forEach items="${varList}" var="var" varStatus="vs">
																<option <c:if test="${var.FOLDER_ID == pd.FOLDER_ID }">selected</c:if> value="${var.FOLDER_ID}">${var.NAME}</option>
															</c:forEach>
														</select>
													</c:when>
												</c:choose>
											</td>
										</tr>

										<tr>
											<td style="width: 90px; text-align: right; padding-top: 13px;">文章标题:</td>
											<td>
												<input type="text" name="TITLE" id="TITLE" value="${pd.TITLE}" maxlength="200" placeholder="这里输入文章标题" title="标题" style="width: 98%;" />
											</td>
										</tr>

										<tr>
											<td style="width: 70px; text-align: right; padding-top: 13px;">文章来源:</td>
											<td>
												<input type="text" name="SOURCE_NAME" id="SOURCE_NAME" value="${pd.SOURCE_NAME}" maxlength="50" placeholder="这里输入文章来源" title="来源" style="width: 98%;" />
											</td>
										</tr>

										<tr>
											<td style="width: 70px; text-align: right; padding-top: 13px;">文章内容:</td>
											<td>
												<div style="width: 100%;">
													<script id="container" name="CONTENT" type="text/plain" style="width: 100%; height: 260px;"><c:if test="${empty var.ARTICLE_ID}">${pd.CONTENT}</c:if></script>
												</div>
											</td>
										</tr>

										<tr>
											<td style="width: 70px; text-align: right; padding-top: 13px;">文章照片:</td>
											<td>
												<input type="hidden" name="PICTURE" id="PICTURE" value="${pd.PICTURE}" />
												<input type="hidden" name="PICTURES_FLAG" id="PICTURES_FLAG" value="0" />
												<input type="file" id="tp" name="files" onchange="fileType(this)" />
												<c:if test="${msg != 'save' }">
													<span id="PICTURES_SPAN" <c:if test="${pd.PICTURE == '' || null == pd.PICTURE}">hidden="true"</c:if>>
														<img src='<%=basePath%>${pd.PICTURE}' style="width: 35%;">
														<input type="button" style="position: absolute; right: 24px; bottom: 108px;" class="btn btn-mini btn-danger" value="删除" onclick="delPic()" />
													</span>
												</c:if>
											</td>
										</tr>

										<tr>
											<td style="width: 70px; text-align: right; padding-top: 13px;">发布状态:</td>
											<td>

												<input name="STATUS" value="display" type="radio" checked>
												显示 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input name="STATUS" value="hidden" type="radio">
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
		var contentEditor;
		contentEditor = UE.getEditor('container', {
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
			/*  'source', //源代码 */
			'blockquote', //引用
			'pasteplain', //纯文本粘贴模式
			'selectall', //全选
			/*   'print', //打印 */
			'preview', //预览
			'horizontal', //分隔线
			'removeformat', //清除格式
			'time', //时间
			'date', //日期
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
			/*  'insertcode', //代码语言 */
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

		$(function() {
			//上传
			$('#tp').ace_file_input({
				no_file : '请选择图片 ...',
				btn_choose : '选择',
				btn_change : '更改',
				droppable : false,
				onchange : null,
				thumbnail : false, //| true | large
				whitelist : 'gif|png|jpg|jpeg'
			});
		});
		//过滤类型
		function fileType(obj) {
			document.getElementById("PICTURES_FLAG").value = "1";
			document.getElementById("PICTURES_SPAN").style.display = "none";
			var picPath = '${pd.PICTURES_PATH}';
			var fileType = obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
			if (fileType != '.gif' && fileType != '.png' && fileType != '.jpg'&& fileType != '.jpeg') {
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
			document.getElementById("PICTURE").value = "";
			document.getElementById("PICTURES_FLAG").value = "0";
		}

		//保存
		function save() {
			if ($("#TITLE").val() == "") {
				$("#TITLE").tips({
					side : 3,
					msg : '请输入文章标题',
					bg : '#AE81FF',
					time : 2
				});
				$("#TITLE").focus();
				return false;
			}
			if ($("#SOURCE_NAME").val() == "") {
				$("#SOURCE_NAME").tips({
					side : 3,
					msg : '请输入文章来源',
					bg : '#AE81FF',
					time : 2
				});
				$("#SOURCE_NAME").focus();
				return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	</script>
</body>
</html>