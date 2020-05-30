/**
 * 组件名称:form-comm,v-if="isShow || formType > 0"
 * 在使用时，就像普通的标签一样的使用即可,也就是: <form-comm></form-comm>
*/
Vue.component("form-comm",{
    /*模版*/
    template:`
        <div class="model_form">
            <div class="button_group line">
                <label>{{boxTitle}}</label>
                <span v-if="formType < 1 || !formType" @click="closeForm"></span>
            </div>
            <!--slot插槽-->
            <slot>
                <div style="margin:10px;line-height:20px;height:20px;text-align:center">
                    在此是添加表单的具体元素,你还未添加任何元素
                </div>
            </slot>
            <div class="button_group">
                <el-button @click="submits">提交</el-button>
                <el-button @click="closeForm">取消</el-button>
            </div>
        </div>
    `,
    /*数据*/
    data : function() {
        return {
            //定义组件内的参数
            boxTitle : '编辑',
            formType : 1
        }
    },
    /*通过 props 传递数据 (推荐)*/
    props : {
        model : {

        }
    },
    created : function(){

    },
    /*方法*/
    methods : {
        submits : function(){
            //获取到值,是从调用本组件那使用 :model="goods" 传值过来的
            console.info('-->'+this.model);
            console.info('-->'+this.model.price);
            ajax.post('show/listData',{pageSize : 10,current : 1},function(data){
                console.info('data-->'+data.data.code);
            },function(err){
                console.info('err-->'+err);
            });
        },
        closeForm : function(){
        }
    }
});
