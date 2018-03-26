﻿<!-- CMS栏目列表页 -->
<%@include file="./common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>${keywords}</title>
</head>
<body>
	<!-- 引入头部 -->
	<%@include file="./head.jsp"%>
	<!--导航条-->
	<div class="wrapper" style="margin-top: 20px;">
		<div class="navs">
			<a class="nav" href="${BASEPATH}/cms/index">首页</a>
			<span class="split"></span>
			<span class="nav active">关键词:${keywords}</span>
		</div>
	</div>

	<!--文章列表-->
	<div class="wrapper" style="margin-top: 20px;">
		<div class="articles">
			<ul class="list">
				<c:choose>
					<c:when test="${not empty pageVo}">
						<c:forEach items="${pageVo}" var="pageData" varStatus="vs">
							<li class="item">
								<a class="txt" href="${BASEPATH}/article/${pageData.ENAME}/${pageData.ARTICLE_ID}?keywords=${keywords}">${pageData.TITLE}</a>
								<span class="date"> ${pageData.UPDATE_TIME} </span>
							</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<li style="text-align: center;">没有数据!</li>
					</c:otherwise>
				</c:choose>
			</ul>

			<div class="foot clearfix">
				<div class="pagination fright" id="pagination"></div>
			</div>
		</div>
	</div>
	<!-- 引入尾部 -->
	<%@include file="./foot.jsp"%>
	<script src="${BASEPATH}/static/cms/js/pagination.js"></script>
	<script type="text/javascript">
		$(function() {
			var currentPage = ${currentPage};
			var totalPage = ${totalPage};
			var keywords = '${keywords}';
			var pagination = new Pagination({
				el : $('#pagination'),
				currentPage : currentPage, //当前页数
				maxPage : totalPage, //最大页数
				jump : false
			}, function(index) {
				location.href = "${BASEPATH}/folder/searchText?currentPage="+ index + "&totalPage=" + totalPage + "&keywords=" +keywords;
			})
		})
	</script>
</body>
</html>