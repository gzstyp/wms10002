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
}
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
}