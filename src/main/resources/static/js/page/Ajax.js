/**
 * 示例代码,学习之用
 * class 是ES6的写法
 * @作者 田应平
 * @创建时间 2020-05-28 1:33
 * @QQ号码 444141300
 * @官网 http://www.fwtai.com
*/
class Ajax{
    vueObj = null;
    baseUrl = "http://127.0.0.1:83/";
    constructor(vueObj){
        this.vueObj = vueObj;
    }
    get(api,params,succeed,failure){
        var url = this.baseUrl + api;
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
    }
    post(api,params,succeed,failure){
        var url = this.baseUrl + api;
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
}