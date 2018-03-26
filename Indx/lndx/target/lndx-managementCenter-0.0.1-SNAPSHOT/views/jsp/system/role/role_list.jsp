<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>角色管理</title>
<%@ include file="../index/headcss.jsp"%>
</head>
<body>
	<div class="tableBox">
		<div class="operationBox">
			<form action="list.do" method="post" name="Form" id="Form" class="layui-form">
				<div class=" fl">
					<input value="${pd.keywords }"  id="keywords" name="keywords"   type="text" placeholder="请输入要搜索内容" class="layui-input fl search layui-input-color">
				</div>
				<div class="fl srarchBtn">
					<i class="iconfont icon-sousuo"></i>
					<span>搜索</span>
				</div>
			</form>

			<button class="add-btn f1" id="add">
				<i  class="iconfont icon-add"></i>
				<span>新增</span>
			</button>


		</div>


		<table class="layui-table center" lay-skin="line" id="table">
			<colgroup>
				<col width="60">
				<col>
				<col>
				<col width="400">
			</colgroup>
			<thead>
				<tr class="table-head-tr">
					<th>序号</th>
					<th>角色</th>
					<th>级别</th>

					<th style="border-left: 1px solid #dce3eb;">操作</th>
				</tr>
			</thead>
			<tbody>


			<c:choose>
				<c:when test="${not empty roleList_z}">
					<shiro:hasPermission name="system:role:select">

						<c:forEach items="${roleList_z}" var="var" varStatus="">

							<tr>
								<td class='center' style="width: 25px;">${var.index+1}</td>
								<td id="ROLE_NAMETd${var.ROLE_ID }" >${var.ROLE_NAME }</td>
								<td ><html:selectedValue collection="role_level" defaultValue="${var.roleLevel }"></html:selectedValue></td>
								<td style="width: 160px; text-align: center;border-left: 1px solid #dce3eb;">

										<a class="table-btn yonghu-btn setUser" data_id="${var.ROLE_ID }">
											<%--<i class="iconfont icon-yonghu" title="用户"></i>--%>
											用户
										</a>
										<a class="table-btn shezhi-btn set" data_id="${var.ROLE_ID }">
											<%--<i class="iconfont icon-shezhi" title="设置"></i>--%>
											设置
										</a>
										<shiro:hasPermission name="system:role:update">
											<a class="table-btn bianji-btn edit"  data_name="${var.ROLE_NAME }"  data_id="${var.ROLE_ID }">
												<%--<i class="iconfont icon-bianji" title="编辑"></i>--%>
												编辑
											</a>
										</shiro:hasPermission>
										<c:choose>
											<c:when test="${var.ROLE_ID == '2' or var.ROLE_ID == '1'}">
											</c:when>
											<c:otherwise>
												<shiro:hasPermission name="system:role:delete">
													<a class="table-btn shanchu-btn del" data_id="${var.ROLE_ID }">
														<%--<i class="iconfont" title="删除">删除</i>--%>
														删除
													</a>

												</shiro:hasPermission>
											</c:otherwise>
										</c:choose>
								</td>
							</tr>
						</c:forEach>
					</shiro:hasPermission>

					<shiro:lacksPermission name="system:role:select">
						<tr>
							<td class='center' style="width: 25px;">--</td>
							<td class="center">您无权查看</td>
							<td class='center' style="width: 25px;">--</td>
						</tr>
					</shiro:lacksPermission>

				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="100" class="center">没有相关数据</td>
					</tr>
				</c:otherwise>
			</c:choose>

			</tbody>
		</table>

		<div class="laypageBox ">
			<div id="laypage" class="fr"></div>
		</div>
	</div>

<%--	<div class="layui-form">
		<div class="layui-form-item" pane="">
			<label class="layui-form-label">原始复选框</label>
			<div class="layui-input-block ">
				 复选框值源于数据库字典，根据父级英文名查询所得 默认样式(样式问题询问佳杰)
				<html:checkbox name="type" defaultValue="1,3,5,2" collection="personnel_categories" ></html:checkbox>

			</div>
		</div>
	</div>--%>

	<%@ include file="../index/foot.jsp"%>
	<script type="text/javascript">

        function gsearch() {
            $("#Form").submit();
        }

		layui.use('laypage', function() {
			var laypage = layui.laypage;
			var layer = layui.layer;
			var form = layui.form;


            //执行一个laypage实例
            laypage.render({
                elem: 'laypage',
                count: ${page.totalResult},
                curr: ${page.currentPage},
                layout: ['prev', 'page', 'next', 'count', 'skip'],
                jump: function (obj, first) {
                    if (!first) {
                        window.location.href = "<%=basePath%>role/list.do?currentPage=" + obj.curr + '&keywords=' + '${keywords}';
                    }
                }
            });
			//搜索
			$("#keywords").on("keyup",function(e){
			    var ev= e || window.event;
			    if(ev.keyCode == 13){
                    gsearch();
				}
			});
			//新增

			$("#add").on("click", function() {
                parent.layer.open({
                    title:"编辑角色",
                    type: 2,
                    content:'<%=basePath%>role/toAdd.do?IS_PARTY=${IS_PARTY}'+'&currentPage=${page.currentPage}',
                    area: ["400px","300px"]
                });
                transmit(window);
			});
			//设置
			$("#table").on("click", ".set", function() {
                var id =  $(this).attr("data_id");
                parent.layer.open({
                    title:"设置权限",
                    type: 2,
                    content:'<%=basePath%>role/menuqx.do?ROLE_ID='+id,
                    area: ["400px","300px"]
                });
                transmit(window);
			});
			//设置用户
            $("#table").on("click", ".setUser", function() {
                var id =  $(this).attr("data_id");
                parent.layer.open({
                    title:"设置用户",
                    type: 2,
                    content:'<%=basePath%>role/setUser.do?ROLE_ID='+id,
                    area: ["400px","300px"]
                });
                transmit(window);
            });
			//编辑
			$("#table").on("click", ".edit", function() {
                var id =  $(this).attr("data_id");
                parent.layer.open({
                    title:"编辑角色",
                    type: 2,
                    content:'<%=basePath%>role/toEdit.do?ROLE_ID='+id+'&currentPage=${page.currentPage}',
                    area: ["400px","300px"]
                });
                transmit(window);
			});

			//删除
			$("#table").on("click", ".del", function() {

                var ROLE_ID =  $(this).attr("data_id");
                parent.layer.confirm("是否确认删除此角色", {
					btn : [ '确定', '取消' ] //按钮
					,resize : false
					,title : "提示"
					,maxWidth : 800
				}, function(index) {
                    var url = "<%=basePath%>role/delete.do?ROLE_ID=" + ROLE_ID + "&guid=" + new Date().getTime();
                    $.get(url, function (data) {
                        if ("success" == data.result) {
                            window.location.href = "<%=basePath%>role/list.do?currentPage=${page.currentPage}";
                            parent.parent.layer.closeAll();
                        } else if ("false" == data.result) {
                            parent.layer.msg('删除失败，请先删除下级角色!', {icon: 5});
                        } else if ("false2" == data.result){
                            parent.layer.msg('删除失败，此角色已被使用!', {icon: 5});
						}
                    });
				});

			})

		});


        function transmit(obj){
            parent.layer.transmit= obj;
        }
	</script>
</body>
</html>