window.console = window.console || (function(){  
            var c = {}; 

            c.log = c.warn = c.debug = c.info = c.error = c.time = c.dir = c.profile  
                   = c.clear = c.exception = c.trace = c.assert = function(){};  
             return c;  
})();

$(function(){
	$("#fast").height($("#fast").parent().height())
	$("#board").height($("#content").height())
	swiper($("#banner"));
	swiper($("#sWiper"));
})

function swiper(dom){
	var index= 0;
	var $banner= dom;
	var $cicleBox= $banner.next();
	var len= $banner.children().length;
	var w= $banner.children().first().width();
	for(var i=0;i<len;i++){
		var li="<div class='cicle "+(i==0?'active':"")+"'></div>"
		$cicleBox.append(li);
	}
	
	$cicleBox.css("margin-left", $banner.width()/2 - $cicleBox.width()/2) 
	$banner.width($banner.children().length * w);
	setInterval(function(){
		index++;
		if(index>len-1){
			index= 0
		}
		moveTo(index);
		cicleTo(index)
	},5000)
	
	$cicleBox.find(".cicle").on("click",function(){
		var index= $(this).index();
		index= index;
		$(this).addClass("active").siblings().each(function(){
			$(this).removeClass("active")
		})
		moveTo(index)
	})
	function cicleTo(index){
		$cicleBox.children().each(function(i){
			if(i != index){
				$(this).removeClass("active")
			}else{
				$(this).addClass("active")
			}
		})
	}
	function moveTo(index){
		$banner.animate({"margin-left":-index*w});
	}
	

	
	
}