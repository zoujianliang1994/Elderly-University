﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html lang="en">
<meta http-equiv="X-UA-Compatible" content="IE=11">

<head>

    <title>地图</title>
   <%--  <base href="<%=basePath%>"> --%>
    <!-- jsp文件头和头部 -->
    <link rel="shortcut icon" href="${basePath}/static/source/public/images/32.png" type="image/x-icon" />

</head>
<body>
    <div class="wrap wrap-map" >
        <%@ include file="./header.jsp"%>

        <div class="mapBox" >
            <div class="map" id="map" ></div>
            <div class="sichuan hide">
                <p><span class="title">四川省60岁以上老年人口总数</span><span class="num age60"></span>人</p>
                <p><span class="title">四川省65岁以上老年人口总数</span><span class="num age65"></span>人</p>
            </div>
        </div>
    </div>
</body>
<%@ include file="./foot.jsp" %>
<script type="text/javascript" src="<%=basePath%>static/source/public/js/map/sichuan.js"></script>
<script>
    $(function(){
        //ie8页面渲染比函数慢  定时器
        var timer= setInterval(function(){
            if($(".avatar")[0] != undefined){
                console.log(1);
                LLW.setnav('map');
                LLW.hideavatar();
                if(timer)clearInterval(timer)
            }
        },300);


        LLW.show('.mapBox .sichuan');
        var fontSize= 15;
        if(document.body.clientWidth < 1300){
            fontSize= 13
        }

        var myChart = echarts.init(document.getElementById('map'));
        var option={
            series:[
                {
                    type:'map',
                    name:'四川',
                    map:'sichuan',
                    top: 20,
                    roam: false,                            //是否开启鼠标缩放和平移漫游
                    scaleLimit:{                            //设置最大最小zoo
                        min:1                               //最小zoo
                    },
                    aspectScale: 1,
                    zoom: 1.05,
                    // top:"middle",
                    nameMap:{
                        'sichuan':"四川"
                    },
                    selectedMode:false,
                    label: {
                        normal:{
                            show: true,
                            fontSize: fontSize,
                            // offset: [30, 40],
                            textStyle: {
                                color: '#fff'
                            }
                        },
                        emphasis: {
                            show: true,
                            fontSize: fontSize,
                            textStyle: {
                                color: '#222'
                            }
                        }
                    },
                    itemStyle: {
                        normal: {
                            borderColor: '#00f6ff',
                            areaColor: '#fff',
                            areaColor  :"#044681"
                        },
                        emphasis: {
                            areaColor: '#00f6ff',
                            borderWidth: 0
                        }
                    },
                    data:[]
                }
            ]
        };
        myChart.setOption(option);

        $.post("<%=basePath%>indexMap/mapPeopleNumber",{},function(data){
            console.log(data);
                var total60=0;
                var total65=0;
                for(var i=0;i<data.length;i++){
                    if(!data[i].age_60){
                        data[i].age_60=0
                    }
                    if(!data[i].age_65){
                        data[i].age_65=0
                    }
                    total60+= data[i].age_60;
                    total65+= data[i].age_65;
                }
                $(".age60").text(total60);
                $(".age65").text(total65);

                var option={
                    tooltip: {
                        trigger: 'item',
                        formatter:function(params, ticket, callback) {
                            if(params.data.age_60 == undefined)params.data.age_60 = 0;
                            if(params.data.age_65 == undefined)params.data.age_65 = 0;
                            return params.data.name+":<br />60岁以上的人: "+params.data.age_60+"<br />65岁以上的人: "+params.data.age_65;
                        }
                    },
                    backgroundColor:"transparent",
                    series:[
                        {
                            type:'map',
                            name:'四川',
                            map:'sichuan',
                            top: 20,
                            roam: false,                            //是否开启鼠标缩放和平移漫游
                            scaleLimit:{                            //设置最大最小zoo
                                min:1                               //最小zoo
                            },
                            aspectScale: 1,
                            zoom: 1.05,
                            // top:"middle",
                            nameMap:{
                                'sichuan':"四川"
                            },
                            selectedMode:false,
                            label: {
                                normal:{
                                    show: true,
                                    fontSize: fontSize,
                                    // offset: [30, 40],
                                    textStyle: {
                                        color: '#fff'
                                    }
                                },
                                emphasis: {
                                    show: true,
                                    fontSize: fontSize,
                                    textStyle: {
                                        color: '#222'
                                    }
                                }
                            },
                            itemStyle: {
                                normal: {
                                    borderColor: '#00f6ff',
                                    areaColor: '#fff',
                                    areaColor  :"#044681"
                                },
                                emphasis: {
                                    areaColor: '#00f6ff',
                                    borderWidth: 0
                                }
                            },
                            data:data
                        }
                    ]
                };
                myChart.setOption(option);

                myChart.on('click', function (param) {
                    window.location.href= "<%=basePath%>to_module_list.do?areaCode="+param.data.area_code
                });
            });

        $(window).resize(function(){
            myChart.resize();
        });

    })
</script>
</html>
