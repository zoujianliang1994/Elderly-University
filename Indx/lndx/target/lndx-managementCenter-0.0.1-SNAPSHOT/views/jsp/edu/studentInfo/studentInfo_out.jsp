<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>学校管理</title>
	<%@ include file="../../system/index/headcss.jsp" %>
</head>
<body>

<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
	<div class="layui-tab-content">
		<div class="layui-tab-item layui-show">
			<div class="tableBox">

				<!-- table -->
				<div style="padding:0px 20px;">
					<form action="<%=basePath%>studentInfo/out.do" method="post" class="layui-form" name="Form" id="Form">
						<div class="layui-form-item">
							<div class="form-item-inline1">
								<label class="form-label" style="width: auto;"><i class="require">*</i>请选择操作类型</label>
								<div class="layui-input-block " style="width: 20rem">
									<input class="layui-input" type="radio" name="event_type" value="1" title="退学" checked>
									<input class="layui-input" type="radio" name="event_type" value="2" title="休学">
									<input class="layui-input" type="radio" name="event_type" value="3" title="退班" >
									<input type="hidden" name="checkedList" id="checkedList" value="">
									<input type="hidden" name="income" id="income" value="0">
									<input type="hidden" name="student_id" id="student_id" value="${pd.id}">
									<input type="hidden" name="xm" id="xm" value="${pd.xm}">
									<input type="hidden" name="stu_number" id="stu_number" value="${pd.stu_number}">
									<input type="hidden" name="semester_id" id="semester_id" value="${pd.semester_id}">

								</div>
							</div>

							<div class="form-item-inline">
								<label class="form-label" style="width: auto"><i class="require">*</i>请选择退学时间</label>
								<div class="layui-input-block " style="width: 16rem">
									<input type="text" name="event_time"  id="event_time" style="float: left; width: 16rem;"  required lay-verify="required" placeholder="请选择时间"
										   autocomplete="off" maxlength="200"
										   class="layui-input layui-input-color">
								</div>
							</div>
						</div>
					<table class="layui-table center" lay-skin="line" id="table">
						<colgroup>
							<col>
							<col>
							<col>
							<col width="100">
							<col>
							<col>
							<col>
							<col width="170">
						</colgroup>
						<thead>
						<tr class="table-head-tr">
							<th></th>
							<th>序号</th>
							<th>课程名称</th>
							<th>班级名称</th>
							<th>报名时间</th>
							<th>任课教师</th>
							<th>开课时间</th>
							<th>已读学时</th>
							<th>学费</th>
						</tr>
						</thead>
						<tbody>





						</tbody>
					</table>
					<div class="layui-form-item">
						<div class="form-item-inline1">
							<label class="form-label" style="width: auto"><i class="require">*</i>退学费用</label>
							<div class="layui-input-block " style="width: 16rem;">
								<input type="text" readonly  id="return_money" style="width: 16rem;"  required lay-verify="required"
									   autocomplete="off" maxlength="200"
									   class="layui-input layui-input-color">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="form-label" style="width: 110px">请输入退学理由</label>
						<div class="layui-input-block " style="width: 98%" >
							<textarea name="reason" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea>
						</div>
					</div>

					</form>
					<div class="btnbox" id="sonBtn">
						<button id="sonSure" class="layui-btn layui-btn-primary layui-btn-small">确定</button>
						<button id="sonCancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
					</div>
				</div>

			</div>

		</div>

	</div>
</div>



<%@ include file="../../system/index/foot.jsp" %>
<script type="text/javascript">

    $(function () {
        layui.use('laydate', function(){
            var laydate = layui.laydate;
            laydate.render({
                elem: '#event_time',
                done: function(value){
                    update('${pd.id}',value);

                }
            });
        });
        function update(id,date) {
             $.ajax({
             	url:'<%=basePath%>studentInfo/getStuGrades.do?id='+id+'&outDate='+date,
             	type:"post",
             	data:"data",
             	success:function(data){
                    $("tbody").html("");
                    moneyList={};
                    moneyQuitClass={};
                    checkedList=[];
                    getDom(data.grades);
                    changeType();

             	}
             })
        }


		var moneyList={};
		var moneyQuitClass={};
		var checkedList=[];
        //动态添加元素
		function getDom(data){
		    var html="";
		    var index=1;
		    if(data.length!=0){
		        for (var i=0;i<data.length;i++){
		            html+="<tr><td><input type='checkbox' name='checkbox' data-id="+data[i].id+" lay-skin='school' class='isShow'/></td>"+
						"<td>"+index+"</td><td>"+data[i].course_name+"</td><td>"+data[i].class_name+"</td><td>"+data[i].entry_time+"</td>"+
						"<td>"+data[i].course_teacher+"</td><td>"+data[i].course_time+"</td><td>"+data[i].finish_work+"</td>"+
						"<td><input type='text'  value="+data[i].tuition_fee+" lay-skin='school' data-id="+data[i].id+" class='tuition_fee'/></td></tr>"
					index++;
                    moneyList[data[i].id]=data[i];
				}
			}else{
		        html='<tr class="main_info">' +
                    '<td colspan="100" class="center">没有相关数据</td>' +
                    '</tr>'
			}
            $("tbody").append(html);
            computeMoney(moneyList);
		}
		//点击单选时，
        $(document).on("click",".layui-form-radio",function(){
            changeType();
		});changeType()
        //点击到退班时。
		function changeType() {
            $("input[name='event_type']").each(function(){

                if($(this).is(":checked")){
                    if($(this).prop("title")=="退班"){
                        $(".isShow").css("display","block");
                        computeMoney(moneyQuitClass);
                        //修改学费
                        $(document).on("change",".tuition_fee",function () {
                            console.log($(this).attr("data-id"))
                            moneyList[$(this).attr("data-id")].tuition_fee=$(this).val();
                            computeMoney(moneyQuitClass);
                            quitClassMoney();
                        })
					}else{
                        $(".isShow").css("display","none");
                        computeMoney(moneyList);
                        $(document).on("change",".tuition_fee",function () {
                            console.log($(this).attr("data-id"))
                            moneyList[$(this).attr("data-id")].tuition_fee=$(this).val();
                            computeMoney(moneyList);
                            quitClassMoney();
                        })
                    }
                }
            });
        };
		//计算退学费用
		function computeMoney(data) {
            var money=0;
            checkedList=[];
            if(JSON.stringify(data)!="{}"){
                $.each(data,function (key,val) {
                    money+=parseInt(val.tuition_fee);
                    checkedList.push(val);
                })
                $("#return_money").val(money);

			}else{
                $("#return_money").val(0)
			}

        }
        //点击复选框时
        $(document).on("click","input[name='checkbox']",function(){
            $("#return_money").val(0)
            quitClassMoney();
            computeMoney(moneyQuitClass);
        });
		//计算选中的是那些课程
		function quitClassMoney() {
            moneyQuitClass={}
            $("input[name='checkbox']").each(function(){
                if($(this).is(":checked")){
                    moneyQuitClass[$(this).attr("data-id")]=moneyList[$(this).attr("data-id")];
                }
            });
        }



		$("#sonSure").on("click",function () {
            if($("#event_time").val() == ""){
                layer.tips('请选择退课时间',  $("#event_time"), {
                    tips: [4, '#D16E6C'],
                    time: 4000
                });
                $("#event_time").focus();
                return false;
            }

		    if(checkedList==null||checkedList.length==0){

                layer.msg('请确认是否退课', {icon: 5});
                return false;
			}

			$("#checkedList").val(JSON.stringify(checkedList));

            var page ="${pd.currentPage}&keywords=${pd.keywords}";
            var sum ="";

            //提交
            $("#Form").ajaxSubmit({
                type: 'post',
                dataType:"html",
                success: function(data) {
                    var jso = JSON.parse(data);
                    if ("success" == jso.msg) {
                        parent.layer.transmit.location.href = "<%=basePath%>studentInfo/list.do?currentPage="+page;
                        parent.layer.closeAll();
                    } else if ("error" == jso.msg) {
                        layer.msg('系统异常,保存失败!', {icon: 5});
                    }
                }
            });



        })
		$("#sonCancel").on("click",function () {
            parent.layer.closeAll();
        })

    })







</script>
</body>
</html>