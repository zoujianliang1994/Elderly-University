(function(win) {
    var LLW = {
        //降频函数
        later: function(fn, delay, immediate) {
            var timer;
            return function() {
                var context, args, callnow, handler;
                context = this;
                args = arguments;
                callnow = immediate && !timer;
                handler = function() {
                    timer = null;
                    if (!immediate) {
                        fn.apply(context, args);
                    }
                };
                clearTimeout(timer);
                timer = setTimeout(handler, delay);
                if (callnow) {
                    fn.apply(context, args);
                }
            };
        },
        //时间段问候语
        getsayhi: function() {
            var nowdate, nowhour;
            nowdate = new Date(),
            nowhour = nowdate.getHours();
            if (nowhour < 6) {
                return '凌晨好';
            } else if (nowhour < 9) {
                return '早上好';
            } else if (nowhour < 12) {
                return '上午好';
            } else if (nowhour < 14) {
                return '中午好';
            } else if (nowhour < 17) {
                return '下午好';
            } else if (nowhour < 19) {
                return '傍晚好';
            } else if (nowhour < 22) {
                return '晚上好';
            } else {
                return '你好';
            }
        },
        //右上角用户昵称头像，默认隐藏，有数据才显示
        showavatar: function() {
            var $avatar = $('.header .avatar');
            if( 0 < $avatar.length && $avatar.data('uid') ){
                LLW.show($avatar);
                var $sayhi = $('.avatar .sayhi');                               //显示问候语
                if( 0 < $sayhi.length ){
                    $sayhi.find('.time').text( LLW.getsayhi()+', ' );
                }
            }
        },
        //控制隐藏
        hideavatar: function() {
            LLW.hide('.header .avatar');
        },
        //设置顶部导航，当前所在
        setnav: function( type ) {
            $navs = $('.header .navs');
            if( 0 < $navs.length ){
                $navs.find('.current').removeClass('current');
                $navs.find('[data-type='+ type +']').addClass('current');
            }
        },
        //显示隐藏
        show: function( selector ) {
            $(selector).removeClass('hide');
        },
        //显示隐藏
        hide: function( selector ) {
            $(selector).addClass('hide');
        }
    };
    win.LLW = LLW;
})(window);
