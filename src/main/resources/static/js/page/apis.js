/**
 * 已定义axios的全局的http接口的变量,未定义的在本目录下的文件 http.js
 * @作者 田应平
 * @创建时间 2020-05-15 22:03
 * @QQ号码 444141300
 * @官网 http://www.fwtai.com
*/

/*var protocol = window.location.protocol; //协议
var host = window.location.host; //主机
var reg = /^localhost+/;
if(reg.test(host)) {
    axios.defaults.baseURL = 'http://127.0.0.1:82/';
}else{
    axios.defaults.baseURL = protocol + "//" + host +":5000";
}*/
axios.defaults.baseURL = "http://api.fwtai.com/";
//请求拦截器,好使!!!
axios.interceptors.request.use(function(config){
    config.headers.access_token = '2020053188889999';
    config.headers.refresh_token = '2020053199998888';
    return config;
});
//响应拦截器,在实际应用中可以,好使!!!
axios.interceptors.response.use(function(data){
    return data.data;
});
ajax = {
    /*ajax.get(url,params,succeed,failure);*/
    get : function(url,params,succeed,failure){
        axios.get(url,{
            params : params
        }).then(function (data){
            if(succeed){
                succeed(data);
            }
        }).catch(function (error){
            if(failure){
                failure(error);
            }
        }).then(function(){
            // always executed
        });
    },
    download : function(url,params){
        axios.get(url,{
            responseType: 'blob',
            params:params
        }).then(res => {
            let url = window.URL.createObjectURL(new Blob([res.data]));
            let link = document.createElement("a");
            link.style.display = "none";
            link.href = url;
            link.setAttribute("download", this.$route.meta.title + ".xlsx");
            document.body.appendChild(link);
            console.log(res);
            link.click();
        });
    },
    /*ajax.post(url,params,succeed,failure);*/
    post : function(url,params,succeed,failure){
        axios.post(url,params).then(data =>{
            if(succeed){
                succeed(data);
            }
        }).catch(err =>{
            if(failure){
                failure(err);
            }
        }).then(function(){
            // always executed
        });
    },
    /*ajax.postFile(url,params,succeed,failure);*/
    postFile : function(url,params,succeed,failure){
        axios.post(url,params,{
            'Content-Type':'multipart/form-data'
        }).then(data=>{
            if(succeed){
                succeed(data);
            }
        }).catch(err =>{
            if(failure){
                failure(err);
            }
        });
    },
    /*ajax.postConfig(url,params,succeed,config,failure);*/
    postConfig : function(url,params,succeed,config,failure){
        axios.post(url,params,config).then(function(data){
            if(succeed){
                succeed(data);
            }
        }).catch(err =>{
            if(failure){
                failure(err);
            }
        }).then(function(){
            // always executed
        });
    }
};