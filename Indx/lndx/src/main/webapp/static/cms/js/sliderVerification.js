/*
sliderVerification
滑块验证组件
*/

(function($){

	function SliderVerification(options){
		this.init(options);
	}

	SliderVerification.prototype= {
		//是否验证成功
		state: 'normol',
		x: 0,
		//初始化
		init: function(options){
			this.$el= options.el;
			this.callback= options.callback;
			this.$bar= this.$el.find('.bar');
			this.$sbar= this.$el.find('.sbar');
			this.mousedown();
		},
		//鼠标按下后
		mousedown: function(){
			var that= this;
			//down
			this.$bar.mousedown(function(e){
				that.state= 'start';
				var starX= e.pageX;
				var maxX= $(this).parent().width() - $(this).width();
				//move
				$(document).mousemove(function(e){
					that.changeState();
					//文字不可选中
					$('body').addClass('selectNone');
					document.body.onselectstart = document.body.ondrag = function(){
						return false;
					}
					//当前鼠标位置
					that.x = e.pageX - starX;
					if(that.x < -1){
						that.x = -1
					}else if(that.x > maxX){
						that.state= 'success';
						that.x = maxX;
						that.changeState();
						if(that.callback)that.callback();
					}
					that.setBarX();
				})
				
				//up
				$(document).mouseup(function(){
					//可以选中文字
					$('body').removeClass('selectNone');
					document.body.onselectstart = document.body.ondrag = function(){
						return true;
					}

					$(document).off('mousemove');
					if(that.state == 'success'){
						that.$bar.off('mousedown');
						$(document).off('mouseup');
						return
					}
					

					that.state= 'fail';
					that.changeState()
					setTimeout(function(){
						that.x= -1;
						that.moveStart();
						$(document).off('mouseup')
					},1000)
					
				})
			})

		},
		setBarX:function(){
			this.$bar.css('left',this.x)
			this.$sbar.css('width',this.x)
		},
		moveStart:function(){
			var that= this;
			this.$bar.animate({'left':this.x})
			this.$sbar.animate({'width':this.x},function(){
				$(this).css("opacity",0);
				that.$bar.css({
					background:'#fff',
					color:'#111'
				})
			})
		},
		changeState: function(){
			if(this.state == 'start'){
				this.$bar.css({
					'background-color':'#2284e6',
					borderRadius:'0 5px 5px 0',
					color:'#fff'
				});
				this.$sbar.css({
					opacity:1,
					borderRadius:'5px 0 0 5px',
					background:"#b9d2ea"

				})
			}else if(this.state == 'fail'){
				this.$bar.css({
					'background-color':'#e87450',
					borderRadius:'5px'
				});
				this.$sbar.css({
					background:'#f7b29d'
				})
			}else if(this.state == 'success'){
				this.$bar.css({
					'background-color':'#52ccba',
					borderRadius:'5px',
					color:'#fff'
				});
				this.$sbar.css({
					background:"#afded7"
				})
				$(document).off('mousemove');
			}
		},
		refresh:function(){
			this.x= -1;
			this.moveStart();
			this.mousedown();
		}

	}	

	$.extend({
		sliderVerification: function(options){
			return new SliderVerification(options);
		}
	})

})(jQuery)