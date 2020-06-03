function ajaxPost(url,params,succeed,failure){
    $.ajax({
        type : "POST",
        url : url,
        dataType : "json",
        data : params,
        success : function(result){
            succeed(result);
        },
        error : function(response,err){
            if (failure != null && failure != ''){
                failure(err);
            }
        }
    });
}
function ajaxGet(url,params,succeed,failure){
    $.ajax({
        type : "GET",
        url : url,
        dataType : "json",
        data : params,
        success : function(result){
            succeed(result);
        },
        error : function(response,err){
            if (failure != null && failure != ''){
                failure(err);
            }
        }
    });
}
function result(content,time){
    time = (time == null || time.length <= 0) ? -1 : time;
    layer.open({
        title : '系统提示',
        content : content,//此处可以是任意代码
        shade : 0,
        offset : 'rb',
        anim : 2,
        btn:false,
        time:time
    });
}
function topHint(content,time){
    time = (time == null || time.length <= 0) ? -1 : time;
    return layer.open({
        title : false,
        closeBtn : 0,
        content : content,//此处可以是任意代码
        shade : 0,
        offset : 't',
        btn : false,
        time : time
    });
}
/**alert('好的,谢谢!',function(){alert('嗯,再见!')})*/
window.alert = function(msg,callback){
    var al_t = (self==top)?parent:window;
    al_t.layer.alert(msg,{
        title : '系统提示',
        area : 'auto',
        btn : ['确定'],
        cancel : function(index,layero){
            al_t.layer.close(index);
            if(callback != null && callback != ''){
                callback();
            }
        }
    },function (index) {
        al_t.layer.close(index);
        if(callback != null && callback != ''){
            callback();
        }
    });
};
/**confirm('你好,需要服务吗?',function() {alert('好的,谢谢!',function(){alert('嗯,再见!')})});*/
window.confirm = function(msg,callback){
    var conf_m = (self==top)?parent:window;
    conf_m.layer.confirm(msg,{
        title : '系统提示',
        btn : ['确定','取消'],
        area : 'auto',
    },
    function(){
        if(typeof(callback) === "function"){
            callback("ok");
        }
    });
};
/*用法:self.layerIndex = loading('正在处理……');可选值:('操作中,请稍候……','196px');|('正在处理……','179px');|*/
function loading(msg,width){
    msg = (msg == null || msg == '' || msg == undefined)?'操作中,请稍候……':msg;
    width = (width == null || width == '') ? '196px' : width;
    return top.layer.msg(msg,{icon:16,time:-1,shade:[0.3,'#000'],area:width});
}
function closeIndex(index){
    top.layer.close(index);
}
function closedAll(){
    top.layer.closeAll();
}