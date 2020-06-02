/**
 * @作者 田应平
 * @创建时间 2020-05-15 22:03
 * @QQ号码 444141300
 * @官网 http://www.fwtai.com
 */
var baseUri = "/";
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
        url = baseUri + url;
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
        url = baseUri + url;
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
        url = baseUri + url;
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
        url = baseUri + url;
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
        url = baseUri + url;
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