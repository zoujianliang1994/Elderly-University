<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>离退休人员查询</title>
    <%@ include file="../index/headcss.jsp" %>
</head>
<body>
<div class="tableBox">
    <div class="operationBox">

        <form action="listUsers.do" method="post" class="layui-form" name="Form" id="Form">
            <div class="searchBox fl ">
                <input type="hidden" name="selDepId" id="selDepId" value="${pd.selDepId}"/>
                <input type="hidden" name="xzqh_code" id="xzqh_code" value="${pd.xzqh_code}"/>
                <input type="hidden" name="selDepName" id="selDepName" value="${pd.selDepName}"/>
                <div class="sTree fl" id="sTree" style="width:200px">
                </div>
                <div class="fl srarchBtn">
                    <i class="layui-icon">&#xe715;</i>
                </div>
            </div>

            <div class="searchBox fl marL-20">
                <select name="sectionId" id="sectionId" lay-filter='sectionId'>
                    <option value="">请选择内设机构</option>
                    <c:forEach items="${pd.section}" var="var" varStatus="vs">
                        <option value="${var.SECTION_ID}"
                                <c:if test="${var.SECTION_ID==pd.sectionId}">selected</c:if> >${var.NAME}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="searchBox fl marL-20">
                <input id="keywords" name="keywords" type="text" value="${pd.keywords}" placeholder="请输入姓名、政治面貌" class="layui-input fl search">
                <div class="fl srarchBtn" onclick="gsearch()">
                    <i class="layui-icon">&#xe615;</i>
                </div>
            </div>

            <div class="searchBox fl marL-20">
                <div class="layui-form-item ">
                    <select name="status" lay-verify="required" lay-filter='selectStatus'>
                        <option value="">请选择人员状态</option>
                        <option value="1" <c:if test="${pd.status == '1'}">selected</c:if>>退休</option>
                        <option value="2" <c:if test="${pd.status == '2'}">selected</c:if>>离职</option>
                    </select>
                </div>
            </div>
        </form>

    </div>

    <!-- table -->
    <div class="layui-col-sm12">
        <table class="layui-table center" id="table">
            <colgroup>
                <col width="50">
                <col>
                <col>
                <col width="60">
                <col>
                <col>
                <col>
                <col width="270">
            </colgroup>
            <thead>
            <tr>
                <th>序号</th>
                <th>姓名</th>
                <th>登陆账号</th>
                <th>性别</th>
                <th>政治面貌</th>
                <th>学历</th>
                <th>所在内设机构</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty userList}">

                    <shiro:hasPermission name="system:user:retiredQuery">
                        <c:forEach items="${userList}" var="var" varStatus="vs">
                            <tr>
                                <td>${vs.index+1}</td>
                                <td>${var.NAME}</td>
                                <td>${var.USERNAME}</td>
                                <td><c:if test="${var.SEX == 1 }">女</c:if>
                                    <c:if test="${var.SEX != 1 }">男</c:if>
                                </td>
                                <td>
                                    <html:selectedValue collection="Political_status" defaultValue="${var.ZZMM}"></html:selectedValue>
                                </td>
                                <td>
                                    <html:selectedValue collection="Educational" defaultValue="${var.XL}"></html:selectedValue>
                                </td>
                                <td>${var.SECTION_NAME}</td>
                                <td style="text-align: center;">
                                    <a class="layui-btn layui-btn-mini layui-btn-normal" onclick="edit('${var.USER_ID}','1');">查看</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="system:user:retiredQuery">
                        <tr>
                            <td colspan="100" class="center">您无权查看</td>
                        </tr>
                    </shiro:lacksPermission>
                </c:when>
                <c:otherwise>
                    <tr class="main_info">
                        <td colspan="100" class="center">没有相关数据</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

        <div class="laypageBox">
            <div id="laypage" class="fr"></div>
        </div>
    </div>
</div>


<%@ include file="../index/foot.jsp" %>
<script type="text/javascript">
    var first = true;
    var form = layui.form;
    layui.use('laypage', function () {
        var laypage = layui.laypage;
        var layer = layui.layer;

        var editHtml = $("#editHtml").html();
        $("#editHtml").remove();

        form.on('select(sectionId)', function (data) {
            gsearch()
        });

        //执行一个laypage实例
        laypage.render({
            elem: 'laypage',
            count: ${page.totalResult},
            curr: ${page.currentPage},
            layout: ['prev', 'page', 'next', 'count', 'skip'],
            jump: function (obj, first) {
                if (!first) {
                    window.location.href = "<%=basePath%>user/listUserRetired.do?currentPage=" + obj.curr + '&keywords=' + '${keywords}' + '&xzqh=${areaCode}';
                }
            }
        });
    });

    var sTree = $.Stree({
        title: "${pd.selDepName}",
        el: $("#sTree"),
        isSingle: true,  //单选
        data:${pd.json},
        callback: function () {
            $("#selDepName").val($.getString(this.arr, "title"));
            $("#selDepId").val($.getString(this.arr, "id"));
            if (!first) {
                getSectionByDep($.getString(this.arr, "id"))
            }
        },
        switchCallback: function (obj) {
            console.log(obj)
            var index = obj.id;
            if(obj.children == ""){
                getMap(index, sTree)
            }
        }
    });
    first = false;

    $("#keywords").keydown(function (e) {
        var ev = e || window.event;
        if (ev.keyCode == "13") {
            gsearch();
        }
    });

    form.on('select(selectStatus)', function (data) {
            gsearch();
        }
    );

    //检索
    function gsearch() {
        $("#Form").submit();
    }


    function getMap(index,tree){
        $.post("<%=basePath%>section/listDepartmentByPid",{pid:index},function(data){
            data= eval(data)
            //数据
            sTree.findOne(index, function (obj) {
                if (obj.children == "") {
                    obj.children = data;
                }

                sTree.rec(data, function (obj, index) {
                    sTree.operation(obj, index);
                }, obj.lev)
            })
            //默认选中

            sTree.cheakedOldData()
            //展示

        })
    }

    function getSectionByDep(ids) {
        $.post("<%=basePath%>user/getSectionByDep", {depId: ids}, function (data) {

            $("#sectionId").html("");
            var option = "<option value=''>请选择内设机构</option>";
            $.each(data.list, function (i) {
                option = option + "<option value='" + this.section_ID + "'>" + this.name + "</option>"
            });
            $("#sectionId").html(option);
            form.render('select');
        }, "json")

    }
</script>
</body>
</html>