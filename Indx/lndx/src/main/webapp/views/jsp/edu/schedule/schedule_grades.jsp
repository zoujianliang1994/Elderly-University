<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/headcss.jsp"%>

    <style>
		.imgBox{
			position:relative;
		}
		#imgfile{
			position:absolute;
			z-index: -1;
			top: 0px;
			left:0
		}
		.layui-upload-drag{
			background-size:cover;
		}

		.form-label {
			text-align: justify;
			/* text-align-last: justify; */
			/* text-align: left; */
			/* display: block; */
			padding: 9px 16px 9px 0;
			/* width: 66px; */
			font-size: 1rem;
			letter-spacing: 0rem;
			color: #333333;
			height: 20px;
			/* text-shadow: 0 0 black; */
		}
		.sss{
			display: inline; width: auto;
		}
	</style>
</head>
<body >
<div class="edit_menu" class="disnone">

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="sss form-label" style="">班级名称 :</label>
					<label class="sss form-label">${pd.teachPlan.grades_name} <c:if test="${pd.teachPlan.grades_name == null}">无</c:if></label>

				</div>


				<div class="form-item-inline">
					<label class="sss  form-label">教学计划总课长 :</label>
					<label class="sss form-label">${pd.teachPlan.ks} <c:if test="${pd.teachPlan.grades_name == null}">0</c:if></label>

				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="sss form-label">学期周数 :</label>
					<label class="sss form-label">${pd.teachPlan.xk_zs}<c:if test="${pd.teachPlan.grades_name == null}">0</c:if></label>
				</div>


				<div class="form-item-inline">
					<label class="sss form-label">教学计划每周节数 :</label>
					<label class="sss form-label">${pd.teachPlan.mz_ks}<c:if test="${pd.teachPlan.grades_name == null}">0</c:if></label>
				</div>

			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-row">

				<div class="form-item-inline">
					<label class="sss form-label">每周已排课时 :</label>
					<label class="sss form-label">${pd.teachPlan.ypks}<c:if test="${pd.teachPlan.grades_name == null}">0</c:if></label>

				</div>


				<div class="form-item-inline">
					<label class="sss form-label">预计完成课时 :</label>
					<label class="sss form-label">${pd.teachPlan.ypks * pd.teachPlan.xk_zs}</label>

				</div>

			</div>
		</div>



	<table class="layui-table center "  id="table">

		<thead>

		<tr style="background-color: #f3f8ff;">
			<th class="center" style="width: 100px;">开课时间</th>
			<th class='center'>时间</th>
			<th class='center'>老师</th>
		</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${not empty pd.all}">

					<c:forEach items="${pd.all}" var="var" varStatus="vs">
						<tr>
							<td><c:if test="${var.week == 1 }">星期一</c:if>
								<c:if test="${var.week == 2 }">星期二</c:if>
								<c:if test="${var.week == 3 }">星期三</c:if>
								<c:if test="${var.week == 4 }">星期四</c:if>
								<c:if test="${var.week == 5 }">星期五</c:if>
							</td>
							<td>${var.start_time} - ${var.end_time}</td>
							<td>${var.teacher_name}</td>

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


</div>


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--提示框-->
	<script type="text/javascript">


        var form = layui.form;

        <%--var type = '${pd.type}';--%>
        <%--$.myType(type);--%>

        $(document).ready(function(){


            $("#cancel").on("click",function(){
                parent.layer.closeAll();
            })
        });

        function test(file_name,symbol){
            var result = file_name.split(symbol);
            return result[result.length-1];
        }
	</script>
</body>
</html>

