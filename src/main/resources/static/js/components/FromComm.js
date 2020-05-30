/**
 * 组件名:form-comm,其命名规则：单文件组件的文件名应该要么始终是单词大写开头 (PascalCase)，要么始终是横线连接 (kebab-case)。(推荐使用短横线分隔命名)
 * 在使用时，就像普通的标签一样的使用即可,也就是: <form-comm></form-comm>
 * 组件的传值可以通过不带冒号:的来传递字符串,如 id-key="userId";也可以通过带冒号:来传递变量,如 :id-key="userId"
 * https://www.jianshu.com/p/99f490b76b03
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
        }
    },
    /*通过 props 传递数据 (推荐)*/
    props : {
        // 表单的模型
        model : {},
        idKey : null,
        //后端新增添加的api接口url,注意驼峰命名规则,即当组件定义成驼峰命名的 addUrl时,那在调用该组件时必须以 add-url 这样的写法，否则获取不到值,即把大写的字母换成-
        //组件的命名规则是 aaaXxxYyy,则在调用时就是 :aaa-xxx-yyy="变量名"
        addUrl : null,
        editUrl : null,
        boxTitle : null,
        formType : null,
        //方法和属性一样,都是用冒号:来传值,即
        onValidation : {
            type : Function,
            default : null
        }
    },
    created : function(){
        console.info('add-->'+this.addUrl);//好使!!!
        console.info('edit-->'+this.editUrl);//好使!!!
        console.info('model-->'+this.model.price);//好使!!!
        //好使,不要删除,console.info('kid-->'+this.model[this.idKey]);//组件的封装-主键字段的作为字符串来传递,取值是 this.model[this.idKey],传值是 id-key="kid",注意没有冒号:哦!!!
        console.info('kid-->'+this.idKey);//组件的封装-主键字段的作为变量来传递,this.idKey,取值是 this.idKey,传值是 :id-key="model.主键",注意有冒号:哦!!!
    },
    /*方法*/
    methods : {
        submits : function(){
            var kid = this.idKey;
            if(this.onValidation){
                if(this.onValidation(this.model)){
                    if(kid == null || kid.length <= 0){
                        this.add();
                    }else{
                        this.edit();
                    }
                }
            }else{
                if(kid == null || kid.length <= 0){
                    this.add();
                }else{
                    this.edit();
                }
            }
            /*if(this.model != null && this.model != undefined){
                //var kid = this.model.kid;//好使!!!
                var kid = this.idKey;
                console.info('----->'+kid);
                if(kid == null || kid.length <= 0){
                    if(this.onValidation){
                        if(this.onValidation(this.model)){
                            this.add();
                        }
                    }
                }else{
                    if(this.onValidation){
                        if(this.onValidation(this.model)){
                            this.edit();
                        }
                    }
                }
            }else{
                alert('你保存的model对象模型没有定义或为空');
            }*/
        },
        add : function(){
            if(this.addUrl != null && this.addUrl != undefined){
                //获取到值,是从调用本组件那使用 :model="goods" 传值过来的
                console.info('add执行成功!-->'+this.addUrl);
                /*console.info('-->'+this.model.price);
                ajax.get('ichnography/listData',{pageSize : 10,current : 1},function(data){
                    console.info('data-->'+data.data.code);
                },function(err){
                    console.info('err-->'+err);
                });*/
            }else{
                alert('请设置add-url的访问接口');
            }
        },
        edit : function(){
            if(this.editUrl != null && this.editUrl != undefined){
                console.info('edit执行成功-->'+this.editUrl);
            }else{
                alert('请设置edit-url的访问接口');
            }
        },
        closeForm : function(){
        }
    }
});
