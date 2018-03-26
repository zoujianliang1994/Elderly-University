(function($){
    function Tree(options){
        this.init(options);
    }

    Tree.prototype= {
        init:function(options){
            this.data=options.data;
            this.$el= options.el;
            this.$el.html("");
            this.initEl();
            this.each(this.data);
            this.callback= options.callback;
            this.switchCallback= options.switchCallback;
            this.onEvent();
        },
        initEl:function(){
            var div= $('<div class="treeBox lev0" ></div>')

            this.$el.append(div);
        },
        each:function(arr){
            for(var i=0;i<arr.length;i++){
                var lev= i+1;
                arr[i].lev= lev;

                this.operation(arr[i],lev)
                if(arr[i].children != undefined && arr[i].children != ""){
                    this.rec(arr[i].children,function(obj,index){
                        this.operation(obj,index);
                    },lev)
                }
            }
        },
        rec:function(arr,callback,index){
            for(var i=0;i<arr.length;i++){
                if(index){
                    var temp= index +"-"+(i+1)
                    arr[i].lev= temp;
                }
                if(callback)callback.call(this,arr[i],temp)
                if(arr[i].children != undefined && arr[i].children != ""){
                    this.rec(arr[i].children,callback,temp)
                }

            }
        },
        operation:function(obj,index){
            var indexArr= index.toString().split("-");
            var len= indexArr.length;
            this.create(obj);
            //第一级
            if(len == 1){
                this.$dom.find(".title").css({
                    "margin-left":20+10*(len-1)+"px",
                    // width:160-15*(len-1)+"px"
                })
                this.$el.find(".lev"+0).append(this.$dom)
                return
            }
            //之后
            this.$dom.find(".item-switch").css({
                left:7+10*(len-1)+"px"
            })
            this.$dom.find(".title").css({
                "margin-left":25+10*(len-1)+"px",
               // width:160-15*(len-1)+"px"
            })
            indexArr.pop();
            var parentIndex= indexArr.join("-");
            this.$el.find(".lev"+parentIndex).children(".itemBox").append(this.$dom)
        },
        create:function(options){
            var icon= "icon-dot";
            var len= (""+options.lev).split("-").length;

            if(len == 1){
                icon= "icon-shouye"
            }else if(len == 2){
                icon= "icon-liebiaotubiao01"
            }else if(len == 3){
                icon= "icon-quan"
            }
            this.$dom=$('<div class="itemBox lev'+options.lev+'" lev="'+options.lev+'">'+
                '<div class="treeItem '+(options.lev == 1 ? "active" : "")+'">'+

                '<span class="title" title="'+options.title+'">'+options.title+'</span>'+
                '<i  class="item-switch iconfont icon-xiala1-copy " style="'+(options.children=="" && !options.hasNext?"display:none":"")+'"></i>'+
                '</div>'+
                '<div class="itemBox" style="display:none">'+
                '</div>'+
                '</div> ')
        },
        onEvent:function(){
            this.active();
            this.switchIcon();
        },
        active:function(){
            var that= this;
            this.$el.on("click",".title",function(){
                var $this= this;
                var lev= $(this).closest(".itemBox").attr("lev");
                that.findOne(lev,function(obj){
                    if(that.callback)that.callback.call($this,obj)
                })
                var display= $(this).next().css("display")
                if(display == "block" || display == "inline"){
                    $(this).next().click();
                }

            })
        },
        switchIcon:function(){
            var that= this;
            this.$el.on("click",".item-switch",function(){
                var lev= $(this).closest(".itemBox").attr("lev");
                var $itemBox= $(this).closest(".treeItem").next();
                var $closest= $(this).closest(".itemBox ");
                $(this).toggleClass("icon-xiala1")
                $(this).toggleClass("icon-xiala1-copy")
                if($(this).hasClass("icon-xiala1")){
                    $closest.siblings().each(function(){
                        $(this).children(".treeItem").children(".item-switch").addClass("icon-xiala1-copy").removeClass("icon-xiala1")
                        $(this).children(".itemBox").slideUp(200)
                    })
                    $itemBox.slideDown(200)

                    that.findOne(lev,function(obj){
                        if(that.switchCallback)that.switchCallback.call(this,obj)
                    })
                }else{
                    $itemBox.slideUp(200)
                }
            })
        },
        findOne:function(lev,callback){
            this.rec(this.data,function(obj){
                if(lev == obj.lev || lev == obj.id || lev == obj.areaCode ){
                    if(callback)callback(obj)
                }

            })
        },
        refresh:function(data){
            this.$el.find(".lev0").html("");
            this.data= data;
            this.each(this.data);
        }
    }

    $.extend({
        Tree: function(options){
            return new Tree(options);
        }
    })

})(jQuery)