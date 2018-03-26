<!-- CMS栏目列表页 -->
<%@include file="./common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>${folderName}</title>
</head>
<body>
	<!-- 引入头部 -->
	<%@include file="./head.jsp"%>
	<!--导航条-->
	<div class="wrapper" style="margin-top: 20px;">
		<div class="navs">
			<a class="nav" href="${BASEPATH}/cms/index">首页</a>
			<span class="split"></span>
			<span class="nav active">${folderName}</span>
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
								<a class="txt" href="${BASEPATH}/article/${ename}/${pageData.articleId}">${pageData.title}</a>
								<span class="date">
									<fmt:formatDate value="${pageData.updateTime}" pattern="yyyy-MM-dd" />
								</span>
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
			var pagination = new Pagination({
				el : $('#pagination'),//el
				currentPage : currentPage, //当前页数
				maxPage : totalPage, //最大页数
				jump : false
			}, function(index) {
				location.href = "${BASEPATH}/folder/${ename}?currentPage="+ index + "&totalPage=" + totalPage;
			})
		})
	</script>
</body>
</html>