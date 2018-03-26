/*
浏览器内核 判断然后执行
*/

(function(){
	var NV = {};    
	var UA = navigator.userAgent.toLowerCase();    
	try    
	{    
	    NV.name=!-[1,]?'ie':    
	    (UA.indexOf("firefox")>0)?'firefox':    
	    (UA.indexOf("chrome")>0)?'chrome':    
	    window.opera?'opera':    
	    window.openDatabase?'safari':    
	    'unkonw';    
	}catch(e){
	
	};
	
	var name = NV.name;
	/*safari*/
	if(name === 'safari'){
		document.querySelector("#search").style.lineHeight = 'normal';

	}
})()