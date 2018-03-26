<!-- CMS文章详情页 -->
<%@include file="./common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>${article.title}</title>
</head>
<body>
	<!-- 引入头部 -->
	<%@include file="./head.jsp"%>

	<!--导航条-->
	<div class="wrapper" style="margin-top: 20px;">
		<div class="navs">
			<a class="nav" href="${BASEPATH}/cms/index">首页</a>
			<span class="split"></span>
			<c:if test="${keywords!=null && keywords!=''}">
				<a class="nav" href="${BASEPATH}/folder/searchText?keywords=${keywords}">关键词:${keywords}</a>
			</c:if>
			<c:if test="${keywords==null || keywords==''}">
				<a class="nav" href="${BASEPATH}/folder/${folder.ename}">${folder.name}</a>
			</c:if>
			<span class="split"></span>
			<span class="nav active">${article.title}</span>
		</div>
	</div>

	<!--文章内容-->
	<div class="wrapper" style="margin-top: 20px;">
		<div class="article">
			<div class="tit">${article.title}</div>
			<div class="date">
				<span style="margin-right: 15px;">
					<fmt:formatDate value="${article.updateTime}" pattern="yyyy-MM-dd" />
				</span>
				<span>来源：${article.sourceName}</span>
			</div>
			<div class="main">
				<!-- 正文begin -->
				${article.content}
				<!-- 正文end -->
			</div>
		</div>
	</div>
	<!-- 引入尾部 -->
	<%@include file="./foot.jsp"%>
</body>
</html>