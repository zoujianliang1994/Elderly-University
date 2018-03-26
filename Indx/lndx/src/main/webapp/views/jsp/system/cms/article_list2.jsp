<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/headcss.jsp" %>
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
                        <form action="manage/article/list.do" method="post" name="Form" id="Form">
                            <table style="margin-top: 5px;">
                                <tr>
                                    <td>
                                        <div class="nav-search">
												<span class="input-icon">
													<input type="text" placeholder="这里输入文章名称" class="nav-search-input" id="keywords" name="keywords"
                                                           autocomplete="off" value="${page.pd.keywords }"/>
													<i class="ace-icon fa fa-search nav-search-icon"></i>
												</span>
                                        </div>
                                    </td>

                                    <td style="vertical-align: top; padding-left: 2px;">
                                        <select class="chosen-select form-control" name="FOLDER_ID" id="FOLDER_ID" data-placeholder="请选择所属目录"
                                                style="vertical-align: top; width: 150px;" onchange="gsearch()">
                                            <option value=""></option>
                                            <option value="">全部</option>
                                            <c:forEach items="${varLmList}" var="var" varStatus="vs">
                                                <option
                                                        <c:if test="${var.FOLDER_ID == pd.FOLDER_ID }">selected</c:if>
                                                        value="${var.FOLDER_ID}">${var.NAME}</option>
                                            </c:forEach>
                                        </select>
                                    </td>


                                    <td style="vertical-align: top; padding-left: 2px">
                                        <a class="btn btn-sm btn-add" onclick="add();">新增</a>
                                    </td>
                                </tr>
                            </table>
                            <!-- 检索  -->

                            <table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top: 5px;">
                                <thead>
                                <tr>
                                    <th class="center" style="width: 50px;">序号</th>
                                    <th class="center">文章名称</th>
                                    <th class="center">状态</th>
                                    <!-- <th class="center">审核</th> -->
                                    <th class="center">所属目录</th>
                                    <th class="center">最后更新时间</th>
                                    <th class="center">操作</th>
                                </tr>
                                </thead>

                                <tbody>
                                <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty varList}">

                                        <c:forEach items="${varList}" var="var" varStatus="vs">
                                            <tr>
                                                <td class='center' style="width: 30px;">${vs.index+1}</td>
                                                <td class='center'>
                                                    <i class="ace-icon"></i>&nbsp;${var.TITLE}
                                                </td>
                                                <td class='center'>
                                                    <c:if test="${var.STATUS=='0'}">隐藏</c:if>
                                                    <c:if test="${var.STATUS!='0'}">显示</c:if>
                                                </td>
                                                <td class='center'>${var.FNAME}</td>
                                                <td class='center'>${var.UPDATE_TIME}</td>
                                                <td class="center">

                                                    <div class="hidden-sm hidden-xs btn-group">

                                                        <a class="icon-font" title="编辑" onclick="edit('${var.ARTICLE_ID}');">
                                                            <i class="iconfont icon-bianjiedit26" title="编辑"></i>
                                                        </a>


                                                        <a class="icon-font" onclick="del('${var.ARTICLE_ID}');">
                                                            <i class="iconfont icon-shanchu-copy" title="删除"></i>
                                                        </a>

                                                    </div>
                                                    <div class="hidden-md hidden-lg">
                                                        <div class="inline pos-rel">
                                                            <button class="icon-font" data-toggle="dropdown" data-position="auto">
                                                                <i style="font-size:14px" class="iconfont icon-weibiaoti25"></i>
                                                            </button>

                                                            <ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">

                                                                <li>
                                                                        <span class="green">
                                                                            <i class="iconfont icon-bianjiedit26"></i>
                                                                        </span>
                                                                </li>


                                                                <li>
                                                                        <span class="red">
                                                                            <i class="iconfont icon-shanchu-copy"></i>
                                                                        </span>
                                                                </li>

                                                            </ul>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>

                                        </c:forEach>
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
                                        <td style="vertical-align: top;">
                                            <div class="pagination" style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div>
                                        </td>
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
<%@ include file="../../system/index/foot.jsp" %>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());//关闭加载状态

    $("#keywords").keydown(function () {
        if (event.keyCode == "13") {
            gsearch()
        }
    });

    //检索
    function gsearch() {
        top.jzts();
        $("#Form").submit();
    }

    //去此ID下子级列表
    function goSondict(ARTICLE_ID) {
        top.jzts();
        window.location.href = "<%=basePath%>manage/article/list.do?ARTICLE_ID=" + ARTICLE_ID;
    };

    //新增
    function add(ARTICLE_ID) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "新增";
        diag.URL = '<%=basePath%>manage/article/goAdd.do?ARTICLE_ID=' + ARTICLE_ID;
        diag.Width = 860;
        diag.Height = 856;
        diag.CancelEvent = function () { //关闭事件
            if ('none' == diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display) {
                window.location.href = "<%=basePath%>manage/article/list.do?ARTICLE_ID=${ARTICLE_ID}&dnowPage=${page.currentPage}";
            }
            diag.close();
        };
        diag.show();
    }

    //删除
    function del(Id) {
        bootbox.confirm("确定要删除吗?", function (result) {
            if (result) {
                top.jzts();
                var url = "<%=basePath%>manage/article/delete.do?ARTICLE_ID=" + Id + "&tm=" + new Date().getTime();
                $.get(url, function (data) {
                    if ("success" == data.result) {
                        window.location.href = "<%=basePath%>manage/article/list.do?ARTICLE_ID=${ARTICLE_ID}&dnowPage=${page.currentPage}";
                    } else if ("false" == data.result) {
                        top.hangge();
                        bootbox.dialog({
                            message: "<span class='bigger-110'>删除失败！</span>",
                            buttons: {
                                "button": {
                                    "label": "确定",
                                    "className": "btn-sm btn-success"
                                }
                            }
                        });
                    }
                });
            }
        });
    }

    //修改
    function edit(Id) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "编辑";
        diag.URL = '<%=basePath%>manage/article/goEdit.do?ARTICLE_ID=' + Id;
        diag.Width = 860;
        diag.Height = 856;
        diag.CancelEvent = function () { //关闭事件
            if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
                window.location.href = "<%=basePath%>manage/article/list.do?ARTICLE_ID=${ARTICLE_ID}&dnowPage=${page.currentPage}";
            }
            diag.close();
        };
        diag.show();
    }
</script>
</body>
</html>