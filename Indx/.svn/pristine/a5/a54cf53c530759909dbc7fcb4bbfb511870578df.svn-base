<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<base href="<%=basePath%>">

<style>
    #banner {
        height: 370px;
    }

    .banner-item {
        float: left
    }

    #sWiper {
        height: 290px;
        overflow: hidden;
        position: absolute;
        left: 0;
        top: 0
    }
</style>

<!-- CMS首页-主体 -->
<div class="banner" >
     <div class="wrapper"  style="height: 344px;overflow: hidden;">
        <div class="swiper-wrapper" id="banner"  >
            <c:forEach items="${coverList}" var="data" varStatus="vs">
                <div class="banner-item"  >
                    <img class="imglink"  src="<%=basePath%>uploadFiles/file/${data.PICTURES_PATH}"/>
                </div>
            </c:forEach>
        </div>
		<div class="cicleBox">
			
		</div>
    </div> 
</div> 

<div class="wrapper" style="margin-top:20px;overflow:hidden">
    <!--左结构-->
    <div class="cell-10" id="content">
        <!--第一排-->
        <div class="section section-notice" style="margin-right:15px;">
            <div style="width:260px;float:left;overflow:hidden;position:relative;height:290px">
                <div class="swiper-wrapper" id="sWiper" style="height:290px;">
                    <c:forEach items="${normalDataList}" var="data" varStatus="vs">
                        <c:if test="${vs.index=='0'}">
                            <c:forEach items="${data.articleList}" var="dataList" varStatus="vsList">
                                <c:if test="${vsList.index <='4'}">
                                    <div class="swiper-slide" style="left:left">
                                        <a class="item" href="${BASEPATH}/article/${data.ename}/${dataList.articleId}" target="_blank">
                                            <img class="board-img" src='<%=basePath%>uploadFiles/file/${dataList.picture}'>
                                        </a>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </div>
                 <div class="cicleBox">
                 </div>
            </div>

            <div class="news">
                <div class="tabs">
                    <c:forEach items="${normalDataList}" var="data" varStatus="vs">
                        <c:if test="${vs.index <= '1'}">
                            <a class="tab" idx="${vs.index +1 }" href="${BASEPATH}/folder/${data.ename}" target="_blank">${data.name}</a>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="paneBox">

                    <c:forEach items="${normalDataList}" var="data" varStatus="vs">
                        <!-- 第一个 -->
                        <c:if test="${vs.index=='0'}">
                            <div class="paneBox-item" idx="1" href="#">
                                <ul class="list">
                                    <c:forEach items="${data.articleList}" var="dataList" varStatus="vsList">
                                        <li class="item">
                                            <a href="${BASEPATH}/article/${data.ename}/${dataList.articleId}" target="_blank">${dataList.title}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>

                        <!-- 第二个 -->
                        <c:if test="${vs.index=='1'}">
                            <div class="paneBox-item" idx="2"  id="text" href="#" style="border-left: 1px solid #efefef;">
                                <ul class="list">
                                   <c:forEach items="${data.articleList}" var="dataList" varStatus="vsList">
                                        <li class="item">
                                            <a href="${BASEPATH}/article/${data.ename}/${dataList.articleId}" target="_blank">${dataList.title}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                    </c:forEach> 
                </div>
            </div>
        </div>


        <!--第二排-->
        <div class="section-notice second">
            <div class="section-board cell-2" id="fast" style="width:15%;background:#fff;padding-left:0">
                <h2 class="tit">快速通道</h2>
                <ul>
                    <c:forEach items="${quickDataList}" var="importantData" varStatus="vs">
                        <li class="entry">
                            <a href="${importantData.path}" target="_blank"> ${importantData.name} </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <div class="cell-10" style="background:#fff">
                <!-- 栏目管理-->
                <div style="overflow:hidden;margin-left:10px" id="textbox">
                    <c:forEach items="${normalDataList}" var="columnData" varStatus="vs">
                        <c:if test="${vs.index >= '2'}">
                            <div class="cell-4 module">
                                <div class="section lborder" style="border-bottom:1px solid #efefef">
                                    <h2 class="tit">
                                    	 <c:if test="${columnData.ename == 'shyk'}">
                                    	 	<a href="${BASEPATH}/cms/meetingRecords" target="_blank">${columnData.name}</a>
                                    	 </c:if>
                                    	 <c:if test="${columnData.ename != 'shyk'}">
                                        	<a href="${BASEPATH}/folder/${columnData.ename}" target="_blank">${columnData.name}</a>
                                    	 </c:if>
                                    </h2>
                                    <!-- 加载内容 -->
                                    <ul class="list">
                                        <c:forEach items="${columnData.articleList}" var="columnDataList" varStatus="vsList">
                                            <li class="item">
                                            	<c:if test="${columnData.ename == 'shyk'}">	
                                            		<c:if test="${columnDataList.summary == 'meeting'}">
                                            		<!--href="javascript:void(0);"  -->
	                                            		<a class="txt" style="cursor: pointer;" data-title="${columnDataList.title}" data-id="${columnDataList.sourceName }" style="width: 180px;" target="_blank">${columnDataList.title}</a>
                                            		</c:if>	
                                            		<c:if test="${columnDataList.summary != 'meeting'}">
	                                            		<a href="${BASEPATH}/article/${columnData.ename}/${columnDataList.articleId}" style="width: 180px;" target="_blank">${columnDataList.title}</a>
                                            		</c:if>	
		                                    	 </c:if>
		                                    	 <c:if test="${columnData.ename != 'shyk'}">
		                                    	 	<a href="${BASEPATH}/article/${columnData.ename}/${columnDataList.articleId}" style="width: 180px;" target="_blank">${columnDataList.title}</a>
		                                    	 </c:if>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

                <!--重点工作入口-->
                <div class="section section-icon points" style="margin-top:20px">
                    <h2 class="tit" style="color:#278dcd">重点工作入口</h2>
                    <div class="row">
                        <c:forEach items="${pageDataList}" var="importantData" varStatus="vs">
                            <div class="cell-4">
                                <div class="icon-box">
                                    <a id="import${vs.index+1}" class="btn-board " href="${importantData.path}" target="_blank">
                                        <img class="board board-img" src='<%=basePath%>${importantData.picturesPath}'>
                                        <div class="shadowText">${importantData.name}</div>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--看板管理-->
    <div class="cell-2" id="board">
        <div class="section section-board">
            <h2 class="tit">教务动态</h2>
            <c:forEach items="${lookDataList}" var="importantData" varStatus="vs">
                <a class="btn-board " href="${importantData.path}" target="_blank">
                    <img class="board-img" src='<%=basePath%>${importantData.picturesPath}'>
                    <div class="shadowText">${importantData.name} </div>
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<!--友情链接板块-->
<div class="wrapper" style="margin-top: 20px;">
    <div class="section section-links">
        <h2 class="tit">友情链接</h2>
        <c:forEach items="${urlList}" var="var" varStatus="vs">
            <c:if test="${var.FLAG =='1'}">
                <a class="link" href="${var.URL}" target="_blank">${var.NAME}</a>
            </c:if>
        </c:forEach>
    </div>
</div>
<%-- <script type="text/javascript" src="${BASEPATH}/layer/layer.js"></script>
<script type="text/javascript">
	$(".item").on("click",".txt",function(){
	    var id= $(this).data("id");
	    var title= $(this).data("title");
	    parent.layer.open({
			  type: 2,
			  title: '查看会议详情',
			  shadeClose: true,
			  shade: 0.8,
			  area: ["1000px","800px"],
			  content: "${BASEPATH}/cms/meetingRecordsDetail?meeting.id="+id+"&meeting.title="+title 
			}); 
	})
</script> --%>