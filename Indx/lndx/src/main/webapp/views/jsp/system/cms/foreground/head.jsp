<!-- CMS首页-头部 -->
<div class="header">
    <div class="topbar">
        <div class="wrapper" style="position: relative;">
            <h1 class="logo">
                <a href="${BASEPATH}/cms/index">
                    <img src="${BASEPATH}/static/cms/images/614logo-bih.png"/>
                    <span>xx老年大学</span>
                </a>
            </h1>

            <div class="menubar">
                <div class="menu">
                    <a  href="${BASEPATH}/cms/index">首页</a>
                </div>
                <c:forEach items="${pageList}" var="data" varStatus="vs">
                    <div class="menu">
                        <a href="${data.PATH}" target="_blank">${data.NAME} </a>
                        <ul class="hoverBox hoverBox1">
                            <c:forEach items="${data.sonList}" var="sonData" varStatus="vs">
                                <li class="item">
                                    <a href="${sonData.PATH}" target="_blank">${sonData.NAME}</a>
                                    <ul class="hoverBox hoverBox2">
                                            <c:forEach items="${sonData.sonList}" var="sonData" varStatus="vs">
                                                <li class="item">
                                                    <a href="${sonData.PATH}" target="_blank">${sonData.NAME}</a>
                                                    <ul class="hoverBox hoverBox3">
                                                            <c:forEach items="${sonData.sonList}" var="sonData" varStatus="vs">
                                                                <li class="item">
                                                                    <a href="${sonData.PATH}" target="_blank"> ${sonData.NAME}</a>
                                                                    <ul class="hoverBox hoverBox4">
                                                                            <c:forEach items="${sonData.sonList}" var="sonData" varStatus="vs">
                                                                                <li class="item">
                                                                                    <a href="${sonData.PATH}" target="_blank">${sonData.NAME}</a>
                                                                                    <ul class="hoverBox hoverBox5">
                                                                                        <c:forEach items="${sonData.sonList}" var="sonData" varStatus="vs">
                                                                                            <li class="item">
                                                                                                <a href="${sonData.PATH}"
                                                                                                   target="_blank">${sonData.NAME} </a>
                                                                                                <ul class="hoverBox hoverBox6">
                                                                                                        <c:forEach items="${sonData.sonList}" var="sonData" varStatus="vs">
                                                                                                            <li class="item">
                                                                                                                <a href="${sonData.PATH}" ></a>
                                                                                                                   target="_blank">${sonData.NAME}
                                                                                                                    <ul class="hoverBox hoverBox7">

                                                                                                                    </ul>

                                                                                                            </li>
                                                                                                        </c:forEach>
                                                                                                    </ul>

                                                                                            </li>
                                                                                        </c:forEach>
                                                                                    </ul>

                                                                                </li>
                                                                            </c:forEach>
                                                                        </ul>

                                                                </li>
                                                            </c:forEach>
                                                        </ul>

                                                </li>
                                            </c:forEach>
                                        </ul>

                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>

                <div class="search">

                    <div class="linkbar">
                        <shiro:authenticated>
                            <a class="btn-link" href="${BASEPATH}/main/index">返回后台</a>
                            <span class="split"></span>
                            <a class="btn-link">${sessionScope.sessionUser["USERNAME"]}</a>
                            <span class="split"></span>
                            <a class="btn-link" href="${BASEPATH}/logout">注销</a>
                            <span class="split"></span>
                        </shiro:authenticated>

                        <shiro:notAuthenticated>
                            <a class='btn-link login' href='javascript:void(0);'>登录</a>
                            <span class="split"></span>
                        </shiro:notAuthenticated>
                    </div>

                    <div class="inputbox">
                        <input id="search" placeholder="请输入搜索内容" onchange="searchText()" value="${keywords}"/>
                        <div class="sousuo">
                            <i  class="iconfont icon-sousuo"></i>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
    $("#search").keydown(function () {
        if (event.keyCode == "13") {
            searchText();
        }
    });
    function searchText() {
        var keywords = $.trim($("#search").val());
        if (keywords == '' || keywords == null) {
            return alert('请输入有效的信息进行查询!');
        }
        window.location.href = "${BASEPATH}/folder/searchText?keywords=" + keywords;
    }
	function checkBrower() {
	    var Sys = {};
	    var ua = navigator.userAgent.toLowerCase();
	    if (window.ActiveXObject) {
	        Sys.ie = ua.match(/msie ([\d.]+)/)[1];
	        //获取版本
	        var ie_version = 6;
	        if (Sys.ie.indexOf("7") > -1) {
	            ie_version = 7;
	        }
	        if (Sys.ie.indexOf("8") > -1) {
	            ie_version = 8;
	        }
	        if (Sys.ie.indexOf("9") > -1) {
	            ie_version = 9;
	        }
	        if (Sys.ie.indexOf("10") > -1) {
	            ie_version = 10;
	        }
	        if (Sys.ie.indexOf("11") > -1) {
	            ie_version = 11;
	        }
	       
	    }
	    else if (ua.indexOf("firefox") > -1)
	        Sys.firefox = ua.match(/firefox\/([\d.]+)/)[1];
	    else if (ua.indexOf("chrome") > -1)
	        Sys.chrome = ua.match(/chrome\/([\d.]+)/)[1];
	    else if (window.opera)
	        Sys.opera = ua.match(/opera.([\d.]+)/)[1];
	    else if (window.openDatabase)
	        Sys.safari = ua.match(/version\/([\d.]+)/)[1];
	    return Sys;
	}
	
	var browser = checkBrower()
	console.log(browser.ie)
	
	$(function(){
		if(browser.ie != "8.0" && browser.ie != "7.0"){
			$("#banner").parent().css("position","relative");
			$(".hoverBox").each(function(){
				$(this).css("margin-top","-35px")
			})
		}
		
		$(".menu").on("mouseenter ",function(e){
			$(this).children(".hoverBox").show()
		})
		$(".menu").on("mouseleave ",function(){
			$(this).children(".hoverBox").hide()
		})
		$(".menu .item").on("mouseenter",function(){
			$(this).children("a").css("color","#eaeaea");
			$(this).children(".hoverBox").show()
		})
		$(".menu .item").on("mouseleave",function(){
			$(this).children("a").css("color","#fff");
			$(this).children(".hoverBox").hide()
		})
	})
	
</script>