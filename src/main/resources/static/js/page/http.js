/**
 * @作者 田应平
 * @创建时间 2020-05-15 22:03
 * @QQ号码 444141300
 * @官网 http://www.fwtai.com
 */
var baseUri = "http://127.0.0.1:82/";
//请求拦截器,好使!!!
axios.interceptors.request.use(function(config){
    config.headers.token = '20200531888889999';
    return config;
});
//响应拦截器,在实际应用中可以 return.data.data,好使!!!
axios.interceptors.response.use(function(data){
    return data;
});
ajax = {
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
        });
    }
};