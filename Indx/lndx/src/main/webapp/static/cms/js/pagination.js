/**
 * Created by Gatsby on 2017/3/22.
 */

function Pagination(options,fuc){
    this.init(options,fuc);
}

Pagination.prototype={
    /*重要参数都在opt里*/
    opt:{
        el:null,         	/*dom  必填*/
        currentPage:1,		/*当前页面*/
        showsPage:7,		/*一行显示多少页*/
        maxPage:20,			/*最大页数*/
        jump:true,			/*是否开始JUMP跳转*/
        jumpPage:3,			/*每次跳转多少页*/
        isFirst:0

    },
    init:function(options,fuc){
        this.fuc=fuc;
        var opt=this.opt;
        opt=$.extend(opt,options);
        this.opt=opt;
        this.create();
        this.setCurrentPage();
        this.prev();
        this.next();
        this.prevJump();
        this.nextJump();
    },
    /*创建*/
    create:function(){
        var HTML='<a href="javascript:;" class="prev"></a><ul class="btns"></ul><a href="javascript:;" class="next"></a>';
        this.opt.el.append(HTML);
        this.update(this.opt.currentPage);

        /*是否添加跳转*/
        if(this.opt.jump){
            this.opt.el.append($("<span>前往<input type='number'/>页</span>"));
            this.jump();
        }

    },
    /*刷新*/
    update:function(currentPage,none){
        //currentPage 必传
        this.opt.isFirst++;
        var liHTML="";
        var halfShowsPage=parseInt(this.opt.showsPage/2)
        var times=parseInt(currentPage)+halfShowsPage;
        if(this.opt.showsPage%2!=0){
            times=times+1;
        }
        this.opt.el.children("ul").html("");
        for(var i=currentPage-halfShowsPage;i<times;i++){
            if(currentPage==i){
                liHTML+="<li class='active'>"+i+"</li>"
            }else if(i>0&&i<this.opt.maxPage+1){
                liHTML+="<li>"+i+"</li>"
            }else if(i<=0){
                times++;
            }else if(i>=this.opt.maxPage){
                var number=i-this.opt.showsPage;
                if(number<=0){
                    continue;
                }
                this.opt.el.children("ul").append($("<li>"+number+"</li>"))
            }
        }
        this.opt.el.children("ul").append(liHTML)
        /*一次性跳转多页 显示最后一次是多少*/
        var prevHTML="<li>1</li><i class='prevJump ellipsis'></i>"
        var nextHTML="<i class='ellipsis nextJump'></i><li>"+this.opt.maxPage+"</li>"
        if(this.opt.currentPage>halfShowsPage+2&&this.opt.maxPage>this.opt.showsPage){
            this.opt.el.find("ul").prepend(prevHTML)
        }
        if(this.opt.currentPage<this.opt.maxPage-halfShowsPage-1&&this.opt.maxPage>this.opt.showsPage){
            this.opt.el.find("ul").append(nextHTML)
        }

        /*回调函数 重中之重*/
        if(none){
            return
        }
        this.callback(this.opt.currentPage);
    },
    prev:function(){
        var $this=this;
        this.opt.el.on("click",".prev",function(){
            if($this.opt.currentPage<=1){
                return
            }
            $this.opt.currentPage--;
            $this.update($this.opt.currentPage);

        })
    },
    next:function(){
        var $this=this;
        this.opt.el.on("click",".next",function(){
            if($this.opt.currentPage>=$this.opt.maxPage){
                $this.opt.currentPage>=$this.opt.maxPage
                return
            }
            $this.opt.currentPage++;
            $this.update($this.opt.currentPage);

        })
    },
    prevJump:function(){
        var $this=this;
        this.opt.el.on("click",".prevJump",function(){
            var currentPage=$this.opt.currentPage;
            currentPage-=$this.opt.jumpPage;
            currentPage < 1 ? currentPage = 1 : currentPage;
            $this.opt.currentPage=currentPage;
            $this.update(currentPage);
        });

        this.hover(".prevJump","icon-kuaitui-copy");
    },
    nextJump:function(){
        var $this=this;
        this.opt.el.on("click",".nextJump",function(){
            var currentPage=$this.opt.currentPage;
            currentPage+=$this.opt.jumpPage;
            currentPage > $this.opt.maxPage ? currentPage = $this.opt.maxPage : currentPage;
            $this.opt.currentPage=currentPage;
            $this.update(currentPage);
        })
        this.hover(".nextJump","icon-kuaijin");
    },
    hover:function(domstr,clas){
        this.opt.el.on("mouseenter",domstr,function(){
            $(this).toggleClass("icon-shenglvehao")
            $(this).toggleClass(clas)
        });

        this.opt.el.on("mouseleave",domstr,function(){
            $(this).toggleClass("icon-shenglvehao")
            $(this).toggleClass(clas)
        });
    },
    setCurrentPage:function(){
        var $this=this;
        this.opt.el.children("ul").on("click","li",function(){
            if($(this).hasClass("active")){
                return;
            }
            var index=parseInt($(this).text());
            $this.opt.currentPage=index;
            $this.update(index);
        })
    },
    callback:function(index){
        if(this.fuc&&this.opt.isFirst!=1){
            this.fuc(index);
        }
    },
    jump:function(){
        var $this=this;
        this.opt.el.find("input").on("keyup",function(){
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if(e && e.keyCode==13){ // enter 键
                var index = parseInt($(this).val());
                if(index<=0){
                    index=1
                }
                else if(index>$this.opt.maxPage){
                    index=$this.opt.maxPage;
                }
                $(this).val(index)
                $this.opt.currentPage=index;
                $this.update(index);
                $this.callback(index);
            }
        })
    },
    changeMaxPage:function(num,none){
        this.opt.maxPage=num;
        this.opt.currentPage=1;
        this.update(1,none);
    }

}
