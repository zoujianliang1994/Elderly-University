<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>人员管理</title>
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

            <!--
            <div class="searchBox fl marL-20">
                <div class="layui-form-item ">
                    <select name="status" lay-verify="required" lay-filter='selectStatus'>
                        <option value="">请选择人员状态</option>
                        <option value="0" <c:if test="${pd.status == '0'}">selected</c:if>>正常</option>
                        <option value="1" <c:if test="${pd.status == '1'}">selected</c:if>>退休</option>
                        <option value="2" <c:if test="${pd.status == '2'}">selected</c:if>>离职</option>
                    </select>
                </div>
            </div>
            -->
        </form>

        <shiro:hasPermission name="system:user:add">
            <button class="layui-btn fl  marL-20 layui-btn-blue" id="add">新增</button>
        </shiro:hasPermission>
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
                <col width="170">
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

                    <shiro:hasPermission name="system:user:select">
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
                                    <shiro:hasPermission name="system:user:select">
                                        <a class="layui-btn layui-btn-mini layui-btn-normal" onclick="edit('${var.USER_ID}','1');">查看</a>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="system:user:edit">
                                   		<c:if test="${var.IS_PARTY == '0'||userName=='admin'}">
                                          	<a class="layui-btn layui-btn-mini edit" onclick="edit('${var.USER_ID}','2');">编辑</a>
                                        </c:if>
                                    </shiro:hasPermission>

                                    <shiro:hasPermission name="system:user:delete">
                                        <c:if test="${var.IS_PARTY == '0'||userName=='admin'}">
                                            <a class="layui-btn layui-btn-danger layui-btn-mini del" onclick="del('${var.USER_ID}');">删除</a>
                                        </c:if>
                                    </shiro:hasPermission>
                                    <!--
                                    <shiro:hasPermission name="system:user:retired">
                                        <a class="layui-btn layui-btn-mini layui-btn-normal" onclick="updateStatus('${var.USER_ID}','1')">退休</a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="system:user:resign">
                                        <a class="layui-btn layui-btn-mini layui-btn-warm" onclick="updateStatus('${var.USER_ID}','2')">离职</a>
                                    </shiro:hasPermission>
                                    -->
                                </td>
                            </tr>
                        </c:forEach>
                    </shiro:hasPermission>
                    <shiro:lacksPermission name="system:user:select">
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
                    window.location.href = "<%=basePath%>user/listUsers.do?selDepId=${pd.selDepId}&selDepName=${pd.selDepName}&sectionId="+$("#sectionId").val()+"&currentPage=" + obj.curr + '&keywords=' + '${keywords}' + '&xzqh=${areaCode}';
                }
            }
        });
    });
    console.log(${pd.json})

    var sTree = $.Stree({
        title: "${pd.selDepName}",
        el: $("#sTree"),
        isSingle: true,  //单选
        data:${pd.json},
        callback: function () {
            $("#selDepName").val($.getString(this.arr, "title"));
            $("#selDepId").val($.getString(this.arr, "id"));

            if (!first) {
                gsearch();
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

    //新增
    $("#add").on("click", function () {
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: "新增",
            type: 2,
            content: '<%=basePath%>user/goAddU.do?currentPage=' + ${page.currentPage},
            area: ["800px", "550px"]
        });
    });

    function edit(USER_ID, TYPE) {
        var msg = TYPE == '1' ? '查看' : '编辑';
        var area = TYPE == '1' ? ["800px", "430px"] : ["800px", "550px"];
        parent.parent.layer.edit = window;
        parent.parent.layer.open({
            title: msg,
            type: 2,
            content: '<%=basePath%>user/goEditU.do?USER_ID=' + USER_ID + '&currentPage=' + ${page.currentPage} +'&TYPE=' + TYPE,
            area: area
        });
    }

    function del(USER_ID) {
        parent.parent.layer.confirm("是否删除此用户?", {
            btn: ['确定', '取消'],
            resize: false,
            title: "提示",
            maxWidth: 800
        }, function (index) {
            var url = "<%=basePath%>user/deleteU.do?USER_ID=" + USER_ID;
            $.get(url, function (data) {
                if ("success" == data.result) {
                    window.location.href = "<%=basePath%>user/listUsers.do?currentPage=${page.currentPage}";
                    parent.parent.layer.closeAll();
                } else {
                    layer.msg('系统异常,删除失败!', {icon: 5});
                }
            });
        });
    }


    function updateStatus(USER_ID, STATUS) {
        var msg = STATUS == '1' ? '退休' : '离职';
        parent.parent.layer.confirm("当前用户是否变更为" + msg + "状态?", {
            btn: ['确定', '取消'],
            resize: false,
            title: "提示",
            maxWidth: 800
        }, function (index) {
            var url = "<%=basePath%>user/updateStatus.do?USER_ID=" + USER_ID + "&STATUS=" + STATUS;
            $.get(url, function (data) {
                if ("success" == data.result) {
                    window.location.href = "<%=basePath%>user/listUsers.do?currentPage=${page.currentPage}";
                    parent.parent.layer.closeAll();
                } else {
                    layer.msg('系统异常,修改失败!', {icon: 5});
                }
            });
        });
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