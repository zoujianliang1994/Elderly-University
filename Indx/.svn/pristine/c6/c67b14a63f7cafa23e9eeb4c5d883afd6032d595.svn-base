<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>组织机构编辑</title>
    <%@ include file="../index/headcss.jsp" %>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>static/source/public/css/list.css">
</head>
<body>
<div class="edit_menu">

        <%--编辑--%>
        <form action="${msg}.do" class="layui-form" id="editForm" lay-filter="editForm" method="post">
            <input type="hidden" name="DEPARTMENT_ID" id="DEPARTMENT_ID" value="${pd.DEPARTMENT_ID}"/>
            <input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${null == pd.PARENT_ID ? DEPARTMENT_ID:pd.PARENT_ID}"/>
            <div class="layui-form-item">

                <div class="layui-row">

                    <div class="layui-col-xs6 layui-col-sm6 layui-col-md6">
                        <label class="layui-form-label">上级机构：</label>
                        <div class="layui-input-block">
                            <blockquote class="layui-elem-quote" >${null == pds.NAME ?'(无) 此机构为顶级':pds.NAME}</blockquote>
                        </div>
                    </div>
                    <div class="layui-col-xs6 layui-col-sm6 layui-col-md6">
                        <label class="layui-form-label">机构名称：</label>
                        <div class="layui-input-block">
                            <input type="text" value="${pd.NAME }" name="NAME" id="NAME" required lay-verify="required" placeholder="请输入机构名称"
                                   autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                </div>

            </div>

            <div class="layui-form-item">

                <div class="layui-row">
                    <div class="layui-col-xs6 layui-col-sm6 layui-col-md6">
                        <label class="layui-form-label">机构级别：</label>
                        <div class="layui-input-block">

                            <html:select name="JGJB" classs="layui-input-inline" >
                                <html:options collection="Institutional_level" defaultValue="${pd.JGJB}"></html:options>
                            </html:select>

                        </div>
                    </div>

                    <div class="layui-col-xs6 layui-col-sm6 layui-col-md6">
                        <label class="layui-form-label">所在区域：</label>
                        <input type="hidden" name="SZQY_CODE" id="SZQY_CODE" value="${pd.SZQY_CODE}"/>
                        <input type="hidden" value="${pd.SZQY }" name="SZQY" id="SZQY"/>
                        <div class="layui-input-block sTree" id="sTree">
                         <%--   <input type="text" value="${pd.SZQY }" name="SZQY" id="SZQY" required lay-verify="required" placeholder="请选择所在区域"
                                   autocomplete="off"
                                   class="layui-input" style="cursor:pointer;">--%>

                        </div>
                    </div>
                </div>

            </div>

            <div class="layui-form-item">

                <div class="layui-row">
                    <div class="layui-col-xs6 layui-col-sm6 layui-col-md6">
                        <label class="layui-form-label">机构性质：</label>
                        <div class="layui-input-block">
                            <html:select name="JGXZ" classs="layui-input-inline" >
                                <html:options collection="Institutional_nature" defaultValue="${pd.JGXZ}"></html:options>
                            </html:select>
                        </div>
                    </div>

                    <div class="layui-col-xs6 layui-col-sm6 layui-col-md6">
                        <label class="layui-form-label">机构地址：</label>
                        <div class="layui-input-block">
                            <input type="text" value="${pd.ADDRESS }" name="ADDRESS" id="ADDRESS" required lay-verify="required" placeholder="请输入机构地址"
                                   autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>

                </div>

            </div>

            <div class="layui-form-item">

                <div class="layui-row">
                    <div class="layui-col-xs6 layui-col-sm6 layui-col-md6">
                        <label class="layui-form-label">编制人数：</label>
                        <div class="layui-input-block">
                            <input type="text" value="${pd.BZRS }" name="BZRS" id="BZRS" required lay-verify="required" placeholder="请输入编制人数"
                                   autocomplete="off" maxlength=10
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-col-xs6 layui-col-sm6 layui-col-md6">
                        <label class="layui-form-label">领导职数：</label>
                        <div class="layui-input-block">
                            <input type="text" value="${pd.LDZS }" name="LDZS" id="LDZS" required lay-verify="required" placeholder="请输入领导职数"
                                   autocomplete="off" maxlength=10
                                   class="layui-input">
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="btnbox" id="btnDiv" hidden="true">
            <button id="sure" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
            <button id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
        </div>
</div>
<%@ include file="../index/foot.jsp" %>
<script>
    $(function () {
        $.formToDiv(${pd.TYPE == '1'});

        var TYPE = '${pd.TYPE}';
        if (1 == TYPE) {
            $("#btnDiv").hide();
            $("input,select,radio,textarea").attr("disabled", "disabled").css("background-color", "#f2f2f2");
            $("input").removeAttr("placeholder", "");
        } else {
            $("#btnDiv").show();
        }

        //所在区域
        $.post("<%=basePath%>areaCode/listSubAreaCodeByParentId",{parentId:0},function(data){
            var sTree = $.Stree({
                title:"${pd.SZQY}",
                type:${pd.TYPE == '1'},
                el: $("#sTree"),
                oldData:['${pd.SZQY_CODE}'],
                isSingle: true,  //单选
                data:data,
                callback:function(){
                    $("#SZQY").val($.getString(this.arr,"title"))
                    $("#SZQY_CODE").val($.getString(this.arr,"areaCode"))
                },
                switchCallback: function (obj) {
                    var id = obj.id;
                    if(obj.children == ""){
                        getAddress(id, sTree)
                    }
                }
            });
        },"json")

        function getAddress(id, sTree) {
            $.post("<%=basePath%>areaCode/listSubAreaCodeByParentId", {parentId: id}, function (data) {
                //数据
                sTree.findOne(id, function (obj) {
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

        $("#sure").on("click", function () {
            if ($("#NAME").val() == "") {
                layer.tips('机构名称不能为空', $("#NAME"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#NAME").focus();
                return false;
            }

            if ($("#SZQY").val() == "") {
                layer.tips('所在区域不能为空', $("#SZQY"), {
                    tips: [3, '#D16E6C'],
                    time: 4000
                });
                $("#SZQY").focus();
                return false;
            }
			parent.layer.load(1);
            $.post('${msg}.do', $('#editForm').serialize(), function (data) {
            	parent.layer.closeAll('loading');
                if ("success" == data.result) {
                    parent.layer.edit.location.href = "<%=basePath%>department/listAllDepartment.do?DEPARTMENT_ID=${DEPARTMENT_ID}&currentPage=${pd.currentPage}";
                    parent.layer.closeAll();
                } else {
                    layer.msg('系统异常,保存失败!', {icon: 5});
                }
            });
        });
        $("#cancel").on("click", function () {
            parent.layer.closeAll();
        });
    });
</script>
</body>
</html>