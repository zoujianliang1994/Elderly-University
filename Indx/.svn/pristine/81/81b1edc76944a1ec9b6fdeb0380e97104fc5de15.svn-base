var locat = (window.location+'').split('/');

$(function () {
    if ('head' == locat[3]) {
        locat = locat[0] + '//' + locat[2];
    } else {
        locat = locat[0] + '//' + locat[2] + '/' + locat[3];
    }
});
//模拟客户端
var clientid="test_client_01";
var targetClientId= 'test_client_02'; 

//连接服务器
var socket =  io.connect('http://127.0.0.1:9092?clientid='+clientid);

socket.on('connect', function() {
	console.log('socketio client connected');
});

//监听消息
socket.on('chatevent', function(data) {
	console.log("监听消息");
	console.log(data);
	sendMessage(data);
});

//接收服务器消息数据
socket.on('messageEvent', function(data) {
	console.log("接收服务器消息数据");
	console.log(data);
	sendMessage(data);
});
//监听断开连接
socket.on('disconnect', function() {
	//alert("The client has disconnected!");
});

//  WEBSOCKET
//	if(typeof(WebSocket) == "undefined") {
//		layer.msg("您的浏览器不支持WebSocket");
//	    return;
//	}
//	var webSocket = new WebSocket('ws://localhost:8080/managementCenter/websocket');
//    webSocket.onerror = function(event) {
//    	layer.msg(event.data);
//    };
//    webSocket.onopen = function(event) {
//    	 //layer.msg("已建立连接");
//        //webSocket.send('hello');
//    };
//    webSocket.onmessage = function(event) {
//    	sendMessage(event.data);
//    };
//    webSocket.onclose = function(event) {
//    	webSocket.close();
//    };
//推送消息
function sendMessage(data)
{
	console.log("url:"+locat);
	layer.open({
		  type: 0
		  ,titile : data.title
		  ,offset: 'rb' //具体配置参考：offset参数项
//		  ,content: '<div style="padding: 20px 80px;">内容</div>'
		  ,content: data.content
		  ,shade: 0 //不显示遮罩
		  //,time: 5000//关闭时间5s
		  ,btn: ['审核', '取消']
		  ,yes: function(index){
				 var diag = new top.Dialog();
				 diag.Drag=true;
				 diag.Title = data.title;
				 diag.URL = data.url;
				 diag.Width = 800;
				 diag.Height = 610;
				 diag.CancelEvent = function(){ //关闭事件
					diag.close();
				 };
				 diag.show();
				 layer.close(index);
		  }
		  ,cancel: function(index, layero){ 
			  //return false; 
		  }    
		});
}