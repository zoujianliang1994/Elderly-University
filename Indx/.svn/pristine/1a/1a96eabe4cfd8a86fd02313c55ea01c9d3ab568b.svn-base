<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
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

							<!-- 检索  -->
							<form action="manage/indexHref/list.do" method="post" name="Form" id="Form">
								<input type="hidden" name="menuId" id="menuId" value="${menuId}" />

								<c:if test="${QX.cha == '1'}">
									<table style="margin-top: 5px;">
										<tr>
											<td>
												<div class="nav-search">
													<span class="input-icon">
														<input type="text" placeholder="这里输入链接名称" class="nav-search-input" id="keywords" name="keywords" autocomplete="off"
															value="${page.pd.keywords }" />
														<i class="ace-icon fa fa-search nav-search-icon"></i>
													</span>
												</div>
											</td>

											<c:if test="${QX.add == 1 && QX.cha == 1}">
												<td style="vertical-align: top; padding-left: 2px">
													<a class="btn btn-sm btn-add" onclick="addHref();">新增</a>
												</td>
											</c:if>

										</tr>
									</table>
								</c:if>

								<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top: 5px;">
									<thead>
										<tr>
											<th class="center" style="width: 50px;">序号</th>
											<th class="center">链接名称</th>
											<th class="center">链接地址</th>
											<th class="center">链接状态</th>
											<td class='center'>操作</td>
										</tr>
									</thead>

									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty varList}">
												<c:if test="${QX.cha == 1 }">
													<c:forEach items="${varList}" var="var" varStatus="vs">
														<tr>
															<td class='center' style="width: 30px;">${vs.index+1}</td>
															<td class='center'>
																<i class="ace-icon "></i> &nbsp;${var.NAME}
															</td>
															<td class='center'>${var.URL}</td>
															<td class='center'>
																<c:if test="${var.FLAG == '1'}">显示</c:if>
																<c:if test="${var.FLAG == '0'}">隐藏</c:if>
															</td>

															<td class="center">
																<c:if test="${QX.edit != 1 && QX.del != 1 }">
																	<span class="label label-large label-grey arrowed-in-right arrowed-in">
																		<i class="ace-icon fa fa-lock" title="无权限"></i>
																	</span>
																</c:if>

																<c:if test="${QX.edit == 1 || QX.del == 1 }">
																	<div class="hidden-sm hidden-xs btn-group">
																		<c:if test="${QX.edit == 1 }">
																			<a class="icon-font" title="编辑" onclick="toUpdate('${var.ID}','${var.NAME}','${var.URL}','${var.FLAG}');">
																				<i class="iconfont icon-bianjiedit26" title="编辑"></i>
																			</a>
																		</c:if>

																		<c:if test="${QX.del == 1 }">
																			<a class="icon-font" onclick="delHref('${var.ID}','${var.NAME}');">
																				<i class="iconfont icon-shanchu-copy" title="删除"></i>
																			</a>
																		</c:if>
																	</div>
																	<div class="hidden-md hidden-lg">
																		<div class="inline pos-rel">
																			<button class="icon-font" data-toggle="dropdown" data-position="auto">
																				<i style="font-size:14px" class="icon-weibiaoti25 iconfont"></i>
																			</button>
																			<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																				<li>
																					<a class="icon-font" title="编辑" onclick="toUpdate('${var.ID}','${var.NAME}','${var.URL}','${var.FLAG}');" data-rel="tooltip">
																						<span>
																							<i style="opacity: 0.5" class="iconfont icon-bianjiedit26" title="编辑"></i>
																						</span>
																					</a>
																				</li>
																				<li>
																					<a class="icon-font" onclick="delHref('${var.ID}','${var.NAME}');" data-rel="tooltip">
																						<span>
																							<i style="opacity: 0.5" class="iconfont  icon-shanchu-copy" title="删除"></i>
																						</span>
																					</a>
																				</li>
																			</ul>
																		</div>
																	</div>
																</c:if>
															</td>
														</tr>
													</c:forEach>
												</c:if>
												<c:if test="${QX.cha != 1 }">
													<tr class="main_info">
														<td colspan="100" class="center">您无权查看!</td>
													</tr>
												</c:if>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="100" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								<div class="page-header position-relative">
									<table style="width: 100%;">
										<tr>
											<c:if test="${QX.cha == 1 }">
												<td style="vertical-align: top;">
													<div class="pagination" style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div>
												</td>
											</c:if>
										</tr>
									</table>
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
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		
		$("#keywords").keydown(function() {
			if (event.keyCode == "13") {
				gsearch()
			}
		});
		
		//检索
		function gsearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		//新增
		function addHref(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>manage/indexHref/addHref';
			 diag.Width = 660;
			 diag.Height = 550;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//修改
		function toUpdate(id,name,url,flag){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>manage/indexHref/toUpdate?ID='+id+'&NAME='+name+'&URL='+url+'&FLAG='+flag;
			 diag.Width = 660;
			 diag.Height = 550;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		
		//删除
		function delHref(id,name){
			bootbox.confirm("确定要删除链接名称为:["+name+"]吗?", function(result) {
				if(result) {
					var url = "<%=basePath%>manage/indexHref/delHref?ID="+id;
					top.jzts();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
	</script>
</body>
</html>