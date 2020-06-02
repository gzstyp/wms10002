;(function($){
	thisPage = {
		init:function(){
            this.initDom();
		},
		initDom:function(){
            $('#time').text(this.getCurrentDate());
            thisPage.methods.getMaterialsList();
            thisPage.methods.statistics();
            thisPage.methods.monitor();
            thisPage.methods.floorBindMap();
		},
        getCurrentDate : function(){
            var now = new Date();
            var year = now.getFullYear();
            var month = now.getMonth() + 1;
            var day = now.getDate();
            var clock = year + "-";
            if(month < 10) clock += "0";
            clock += month + "-";
            if(day < 10) clock += "0";
            clock += day;
            var minute = now.getMinutes();
            var hour = now.getHours();
            if(minute < 10){
                minute = ":0"+minute;
            }else{
                minute = ":"+minute;
            }
            if(hour < 10){
                hour = " 0"+hour;
            }else{
                hour = " "+hour;
            }
            clock += hour;
            clock += minute;
            return clock;
        },
        methods : {
            goods_list : function(){
                var data = [
                    {
                        "goods_name" : "棉被类",
                        "goods_code" : "20200508-01",
                        "stock" : "198件",
                        "out_total" : "18件",
                        "out_time" : "2020-05-20 10:42"
                    },
                    {
                        "goods_name" : "折叠类",
                        "goods_code" : "20200508-02",
                        "stock" : "258件",
                        "out_total" : "160件",
                        "out_time" : "2020-05-26 09:20"
                    },
                    {
                        "goods_name" : "服装类",
                        "goods_code" : "20200508-03",
                        "stock" : "258件",
                        "out_total" : "160件",
                        "out_time" : "2020-06-28 12:41"
                    },
                    {
                        "goods_name" : "帐篷类",
                        "goods_code" : "20200508-04",
                        "stock" : "108件",
                        "out_total" : "18件",
                        "out_time" : "2020-06-27 10:41"
                    },
                    {
                        "goods_name" : "工作灯类",
                        "goods_code" : "20200508-04",
                        "stock" : "129件",
                        "out_total" : "108件",
                        "out_time" : "2020-06-27 10:41"
                    },
                    {
                        "goods_name" : "发电机类",
                        "goods_code" : "20200508-04",
                        "stock" : "208件",
                        "out_total" : "138件",
                        "out_time" : "2020-06-27 10:41"
                    },
                    {
                        "goods_name" : "应急包类",
                        "goods_code" : "20200508-04",
                        "stock" : "110件",
                        "out_total" : "165件",
                        "out_time" : "2020-06-27 10:41"
                    }
                ];
                return data;
            },
            getMaterialsList : function(){
                var html = '';
                var list = thisPage.methods.goods_list();
                $.each(list,function(index,data){
                    html += '<tr>';
                    html += '<td style="width:180px;height:30px;">'+data.goods_name+'</td>';
                    html += '<td style="width:160px;height:30px;">'+data.goods_code+'</td>';
                    html += '<td style="width:76px;height:30px;text-align:center;">'+data.stock+'</td>';
                    html += '<td style="width:76px;height:30px;text-align:center;">'+data.out_total+'</td>';
                    html += '<td style="width:120px;height:30px;">'+data.out_time+'</td>';
                    html += '</tr>';
                });
                $('#table_materials tbody').html(html);
            },
            /*给予jquery的进度条,三列数据*/
            initProgress : function(){
                $(".progress-part-danger").animate({width:"24%"},300);
                $(".progress-part-warning").animate({width:"28%"},400);
                $(".progress-part-security").animate({width:"48%"},500);
            },
            location : function(dom,value){
                $(dom).animate({ width:value+''},800);
            },
            materialsData : function(){
                var data = [
                    {
                        "id" : "ffffffff9dcbdcebffffffff99573f80",
                        "goods_name" : "折叠类",
                        "percentage" : "10%",
                        "danger":"0-5",
                        "warning":"6-10",
                        "security":">10",
                        "stock" : "118件"
                    },
                    {
                        "id" : "ffffffffb71281a2ffffffffd931eb95",
                        "goods_name" : "棉被类",
                        "percentage" : "30%",
                        "danger":"0-5",
                        "warning":"6-10",
                        "security":">10",
                        "stock" : "120件"
                    },
                    {
                        "id" : "ffffffffc43097b8000000003a72e62f",
                        "goods_name" : "服装类",
                        "percentage" : "26%",
                        "danger":"0-5",
                        "warning":"6-10",
                        "security":">10",
                        "stock" : "11件"
                    },
                    {
                        "id" : "ffffffffdae3cd4affffffff9894b623",
                        "goods_name" : "帐篷类",
                        "percentage" : "52%",
                        "danger":"0-5",
                        "warning":"6-10",
                        "security":">10",
                        "stock" : "158件"
                    },
                    {
                        "id" : "ffffffffddf9f51ffffffffff6157ca3",
                        "goods_name" : "工作灯类",
                        "percentage" : "15%",
                        "danger":"0-5",
                        "warning":"6-10",
                        "security":">10",
                        "stock" : "8件"
                    },
                    {
                        "id" : "ffffffffdfaf333c000000001760f4a5",
                        "goods_name" : "发电机类",
                        "percentage" : "90%",
                        "danger":"0-5",
                        "warning":"6-10",
                        "security":">10",
                        "stock" : "185件"
                    },
                    {
                        "id" : "ffffffffe56e8ef0ffffffff912af74a",
                        "goods_name" : "应急包类",
                        "percentage" : "100%",
                        "danger":"0-5",
                        "warning":"6-10",
                        "security":">10",
                        "stock" : "101件"
                    }
                ];
                return data;
            },
            monitorData : function(){
                var data = [
                    {
                        "id":"10242048",
                        "monitor_name" : "温湿度监控A区",
                        "humidity" : "66%",
                        "revolutions" : "1500转/min",
                        "temperature_indoor1" : "28℃",
                        "temperature_indoor2" : "26℃",
                        "temperature_outdoor1" : "32℃",
                        "temperature_outdoor2" : "32℃"
                    },
                    {
                        "id":"20483096",
                        "monitor_name" : "温湿度监控B区",
                        "humidity" : "64%",
                        "revolutions" : "1500转/min",
                        "temperature_indoor1" : "26℃",
                        "temperature_indoor2" : "26℃",
                        "temperature_outdoor1" : "31℃",
                        "temperature_outdoor2" : "31.5℃"
                    }
                ];
                return data;
            },
            statistics : function(){
                var html = '';
                var list = thisPage.methods.materialsData();
                $.each(list,function(index,data){
                    html += '<tr>';
                    html += '<td style="width:180px;padding-left:6px;">'+data.goods_name+'</td>';
                    html += '<td>';
                    html += '<div class="progress-part" style="margin-top:-10px;margin-left:6px;">';
                    html += '<span class="progress-part-danger">'+data.danger+'</span>';
                    html += '<span class="progress-part-warning">'+data.warning+'</span>';
                    html += '<span class="progress-part-security">'+data.security+'</span>';
                    html += '<span id="'+data.id+'" class="progress-above"></span>';
                    html += '</div>';
                    html += '</td>';
                    html += '<td style="position:relative;left:340px;">'+data.stock+'</td>';
                    html += '</tr>';
                });
                $('#table_statistics').html(html);//渲染页面
                thisPage.methods.initProgress();//初始化进度条
                $.each(list,function(index,data){
                    thisPage.methods.location("#"+data.id,data.percentage);
                });
            },
            //温度监控,当监控的数量大于2或小于2时需要注意 float:right 的值
            monitor : function(){
                var html = '';
                var list = thisPage.methods.monitorData();
                if(list.length === 1){
                    $.each(list,function(index,data){
                        html += '<div class="div-inline supervisory-right" style="float:left">';
                        html += '<div>';
                        html += '<div class="chunk"></div>';
                        html += '<span class="chk-span">'+data.monitor_name+'</span>';
                        html += '</div>';
                        html += '<table style="border-collapse:separate; border-spacing:0px 30px;">';
                        html += '<tr>';
                        html += '<td style="width:135px;padding-left:6px;font-size:16px;">湿度：'+data.humidity+'</td>';
                        html += '<td style="left:100px;font-size:16px;">风机转数：'+data.revolutions+'</td>';
                        html += '</tr>';
                        html += '<tr>';
                        html += '<td style="width:135px;padding-left:6px;font-size:16px;color:#33cc33;">温度(内):'+data.temperature_indoor1+'</td>';
                        html += '<td style="left:100px;font-size:16px;color:#33cc33;">温度(内):'+data.temperature_indoor2+'</td>';
                        html += '</tr>';
                        html += '<tr>';
                        html += '<td style="width:135px;padding-left:6px;font-size:16px;color:#33cc33;">温度(外):'+data.temperature_outdoor1+'</td>';
                        html += '<td style="left:100px;font-size:16px;color:#33cc33;">温度(外):'+data.temperature_outdoor2+'</td>';
                        html += '</tr>';
                        html += '</table>';
                        html += '</div>';
                    });
                }else if(list.length === 2){
                    $.each(list,function(index,data){
                        html += '<div class="div-inline supervisory-right" style="float:right">';
                        html += '<div>';
                        html += '<div class="chunk"></div>';
                        html += '<span class="chk-span">'+data.monitor_name+'</span>';
                        html += '</div>';
                        html += '<table style="border-collapse:separate; border-spacing:0px 30px;">';
                        html += '<tr>';
                        html += '<td style="width:135px;padding-left:6px;font-size:16px;">湿度：'+data.humidity+'</td>';
                        html += '<td style="left:100px;font-size:16px;">风机转数：'+data.revolutions+'</td>';
                        html += '</tr>';
                        html += '<tr>';
                        html += '<td style="width:135px;padding-left:6px;font-size:16px;color:#33cc33;">温度(内):'+data.temperature_indoor1+'</td>';
                        html += '<td style="left:100px;font-size:16px;color:#33cc33;">温度(内):'+data.temperature_indoor2+'</td>';
                        html += '</tr>';
                        html += '<tr>';
                        html += '<td style="width:135px;padding-left:6px;font-size:16px;color:#33cc33;">温度(外):'+data.temperature_outdoor1+'</td>';
                        html += '<td style="left:100px;font-size:16px;color:#33cc33;">温度(外):'+data.temperature_outdoor2+'</td>';
                        html += '</tr>';
                        html += '</table>';
                        html += '</div>';
                    });
                }else if(list.length > 2){
                    //前两个是 float:right，剩余后都是 float:left,且宽高度都要重新定义
                    $.each(list,function(index,data){
                        if(index <= 1){
                            html += '<div class="div-inline supervisory-right" style="float:right">';
                            html += '<div>';
                            html += '<div class="chunk"></div>';
                            html += '<span class="chk-span">'+data.monitor_name+'</span>';
                            html += '</div>';
                            html += '<table style="border-collapse:separate; border-spacing:0px 30px;">';
                            html += '<tr>';
                            html += '<td style="width:135px;padding-left:6px;font-size:16px;">湿度：'+data.humidity+'</td>';
                            html += '<td style="left:100px;font-size:16px;">风机转数：'+data.revolutions+'</td>';
                            html += '</tr>';
                            html += '<tr>';
                            html += '<td style="width:135px;padding-left:6px;font-size:16px;color:#33cc33;">温度(内):'+data.temperature_indoor1+'</td>';
                            html += '<td style="left:100px;font-size:16px;color:#33cc33;">温度(内):'+data.temperature_indoor2+'</td>';
                            html += '</tr>';
                            html += '<tr>';
                            html += '<td style="width:135px;padding-left:6px;font-size:16px;color:#33cc33;">温度(外):'+data.temperature_outdoor1+'</td>';
                            html += '<td style="left:100px;font-size:16px;color:#33cc33;">温度(外):'+data.temperature_outdoor2+'</td>';
                            html += '</tr>';
                            html += '</table>';
                            html += '</div>';
                        }
                    });
                    $.each(list,function(index,data){
                        if(index > 1){
                            html += '<div class="div-inline supervisory-left" style="float:left">';
                            html += '<div>';
                            html += '<div class="chunk"></div>';
                            html += '<span class="chk-span">'+data.monitor_name+'</span>';
                            html += '</div>';
                            html += '<table style="border-collapse:separate; border-spacing:0px 30px;">';
                            html += '<tr>';
                            html += '<td style="width:135px;padding-left:6px;font-size:16px;">湿度：'+data.humidity+'</td>';
                            html += '<td style="left:100px;font-size:16px;">风机转数：'+data.revolutions+'</td>';
                            html += '</tr>';
                            html += '<tr>';
                            html += '<td style="width:135px;padding-left:6px;font-size:16px;color:#33cc33;">温度(内):'+data.temperature_indoor1+'</td>';
                            html += '<td style="left:100px;font-size:16px;color:#33cc33;">温度(内):'+data.temperature_indoor2+'</td>';
                            html += '</tr>';
                            html += '<tr>';
                            html += '<td style="width:135px;padding-left:6px;font-size:16px;color:#33cc33;">温度(外):'+data.temperature_outdoor1+'</td>';
                            html += '<td style="left:100px;font-size:16px;color:#33cc33;">温度(外):'+data.temperature_outdoor2+'</td>';
                            html += '</tr>';
                            html += '</table>';
                            html += '</div>';
                        }
                    });
                }
                $('#monitors').html(html);
            },
            changeMap : function(url){
                $('#img_map').attr("src",url);
                $('.imageMap').maphilight({
                    //fillColor: '008800'
                    fillColor: 'ff0000'
                });
            },
            floorBindMap : function(){
                var data = [
                    {
                        "id":"ffffffffe56e8ef0ffffffff912af74a",
                        "floor_name" : "一楼一层",
                        "img_url" : "/images/ffffffffe56e8ef0ffffffff912af74a.png"
                    },
                    {
                        "id":"ffffffffe56e8ef0ffffffff912af74a",
                        "floor_name" : "一楼二层",
                        "img_url" : "/images/ffffffffe56e8ef0ffffffff912af742.png"
                    },
                    {
                        "id":"ffffffffe56e8ef0ffffffff912af74a",
                        "floor_name" : "二楼一层",
                        "img_url" : "/images/ffffffffe56e8ef0ffffffff912af743.png"
                    }
                ];
                var html = '';
                $.each(data,function(index,data){
                    if(index == 0){
                        html += '<li><button class="btn btn-primary" onclick="thisPage.methods.changeMap(\''+data.img_url+'\');">'+data.floor_name+'</button></li>';
                    }else{
                        html += '<li><button class="btn btn-default" onclick="thisPage.methods.changeMap(\''+data.img_url+'\');">'+data.floor_name+'</button></li>';
                    }
                });
                $('#floor_li').html(html);
                if(data.length > 0){
                    thisPage.methods.changeMap(data[0].img_url);
                }
                $("#floor_li button").click(function(){
                    $("#floor_li button").removeClass("btn-primary");
                    $(this).addClass("btn-primary");
                });
            }
        }
	};
	thisPage.init();
})(jQuery);