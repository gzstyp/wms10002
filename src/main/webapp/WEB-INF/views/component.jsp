<%--
    父组件向子组件传递数据，是通过:Xxx="数据" ,子组件接收方是通过 props:{ 数据 : null }

    父组件调用子组件(即组件的)的方法 showForm(),也就是 组件的 methods.showForm();其中的 goodsForm 是上面定义的 ref="goodsForm"

    流程:

        [父组件]传数据：
        <Preference :preferListData="listPreferData"></Preference>

        [子组件]接数据:
        props : {
            preferListData : ''
        },

        [子组件]显示数据:
        {{preferListData.msg || ''}}
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    final String path = request.getContextPath();
    final String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <base href="<%=basePath%>">
    <title>物联网应用平台-组件应用</title>
    <link href="/css/element-ui/element-ui.css" rel="stylesheet">
    <link href="/css/page/page.container.css" rel="stylesheet">
</head>
<body>
<div id="app">
    <%--
       这里是父组件!!!!!
       其中定义的 ref="xxxForm" 是方便调用子组件(也就是组件的方法,一般是 this.$refs.goodsForm.showForm();调用)
    :model="Xxx"是传值到组件里的 props.model,add-url 也是传值到在组件里的 props.addUrl,需要注意的是以驼峰命名规则,用短横线分隔命名
    组件的命名规则是在 props 的下的 aaaYyy,则在调用时就是 :aaa-yyy="变量名" | aaaXxxYyy --> :aaa-xxx-yyy="变量名",指定主键的字段,注意 id-key 是字符串,不带冒号:,所以不是变量!!!

    好使,不要删除,console.info('kid-->'+this.model[this.idKey]);//组件的封装-主键字段的作为字符串来传递,取值是 this.model[this.idKey],传值是 id-key="kid",注意没有冒号:哦!!!
    console.info('kid-->'+this.idKey);//组件的封装-主键字段的作为变量来传递,this.idKey,取值是 this.idKey,传值是 :id-key="model.主键",注意有冒号:哦!!!

    --%>
    <form-comm
        ref="goodsForm"
        :box-title="boxTitle"
        :model="goods"
        :add-url="url.add"
        :edit-url="url.edit"
        :id-key="goods.kid"
        :on-validation="onValidation"
        :on-succeed="onSucceed"
        >
        <%--添加自己的元素--%>
        <%--<template>
            <el-form>
                <el-form-item label="商品名称" prop="productName">
                    <el-input v-model="model.productName" placeholder="商品名称" clearable style="width:340px;"></el-input>
                </el-form-item>
                <el-form-item label="商品库存" prop="num">
                    <el-input v-model="model.num" placeholder="商品库存" clearable style="width:340px;"></el-input>
                </el-form-item>
                <el-form-item label="商品价格" prop="price">
                    <el-input v-model="model.price" placeholder="商品价格" clearable style="width:340px;"></el-input>
                </el-form-item>
            </el-form>
        </template>--%>
        <el-form>
            <el-form-item label="商品名称" prop="productName">
                <el-input v-model="goods.productName" placeholder="商品名称" clearable style="width:340px;"></el-input>
            </el-form-item>
            <el-form-item label="商品库存" prop="num">
                <el-input v-model="goods.num" placeholder="商品库存" clearable style="width:340px;"></el-input>
            </el-form-item>
            <el-form-item label="商品价格" prop="price">
                <el-input v-model="goods.price" placeholder="商品价格" clearable style="width:340px;"></el-input>
            </el-form-item>
        </el-form>
    </form-comm>
    <el-col style="margin-top:16px;">
        <%--好使:<el-button size="mini" type="primary" @click="boxTitle='添加'">添加</el-button>
        <el-button size="mini" type="success" @click="boxTitle='编辑'">编辑</el-button>--%>
        <el-button size="mini" type="primary" @click="addData">添加</el-button>
        <el-button size="mini" type="success" @click="editData">编辑</el-button>
    </el-col>
    <%--,好使,但会显示重复!!!<slot-data>
        <div name="header">插槽名name值的是header</div>
        <div>插槽默认要有没有name值的</div>
        <div name="footer">插槽名name值的是footer</div>
    </slot-data>--%>
    <slot-data>
        <template name="header">
            <div>插槽名name值的是header</div>
            <p>文本</p>
        </template>
        <template>
            <div>注意在多个slot插槽中可以有一个没有name值的</div>
            <p>文本</p>
        </template>
        <template name="footer">
            <div>插槽名name值的是footer</div>
            <p>文本</p>
        </template>
    </slot-data>
    <a v-bind:href="target">属性绑定,类似于jquery的atrr用法,而vue的用法是 v-bind:href="url"</a>
</div>
<!-- import Vue before Element -->
<script src="/js/element-ui/vue.min.js"></script>
<!-- import JavaScript -->
<script src="/js/element-ui/index.js"></script>
<script src="/js/element-ui/axios.min.js"></script>
<script src="/js/page/http.js"></script>
<script src="/js/element-ui/lib.element.js"></script>
<script src="/js/components/FormBox.js"></script>
<script>
    new Vue({
        el : '#app',
        //方法才返回才有return,属性就不需要return返回
        data : {
            boxTitle : '添加',
            goods : {
                kid : null,
                productName : '',
                num : null,
                price : ''
            },
            url : {
                add : 'ichnography/add',
                edit : 'ichnography/edit'
            },
            target : 'http://www.yinlz.com'
        },
        created() {
            //this.getProductById();
        },
        methods : {
            addData : function(){
                this.goods = {};
                this.boxTitle = '添加';
                //父组件调用子组件(即组件的)的方法 showForm(),也就是 组件的 methods.showForm();其中的 goodsForm 是上面定义的 ref="goodsForm"
                //父组件向子组件传递数据，是通过:Xxx="数据" ,子组件接收方是通过 props:{ 数据 : null }
                this.$refs.goodsForm.showForm();
            },
            editData : function(){
                this.getProductById();//模拟数据
                this.boxTitle = '编辑';
                //父组件调用子组件(即组件的)的方法 showForm(),也就是 组件的 methods.showForm();其中的 goodsForm 是上面定义的 ref="goodsForm"
                this.$refs.goodsForm.showForm();
            },
            getProductById : function(){
                this.goods = {
                    kid : 1024585,
                    productName : 'apple充电器',
                    num : '152',
                    price : '100.20'
                }
                //this.boxTitle =`编辑商品\${this.goods.productName}`;//这里需要注意的是,如果是在html页面下是不需要加转义符\的
                this.boxTitle =`编辑商品\${this.goods.productName}`;//因为是在jsp页面环境里$的jsp的特殊的标识,所以要转义符\处理,而在html下是不需要做转义符处理的
            },
            //这里是父组件,这里的model是从子组件(组件[名])的 this.onValidation(this.model) 的this.model的数据,最后需要注意的是必须返回true才能执行表单的提交!!!
            onValidation : function(model){
                var productName = model.productName;
                var num = model.num;
                if(productName == null || productName.length <= 0){
                    elementFn.fnMsgError('请输入商品名称!');return false;
                }
                if(num == null || num.length <= 0){
                    elementFn.fnMsgError('请输入库存数量');return false;
                }
                return true;
            },
            onSucceed : function(data){
                console.info(data);
            }
        }
    });
    // slot-data是组件名,注意在多个slot插槽中可以有一个没有name值的,不推荐使用多个插槽???,因为会重复
    Vue.component('slot-data',{
        template : `
            <div>
                <slot name="header">
                    <div>插槽名name值的是header</div>
                </slot>
                <slot>
                    <div>注意在多个slot插槽中可以有一个没有name值的</div>
                </slot>
                <slot name="footer">
                    <div>插槽名name值的是footer</div>
                </slot>
            </div>
        `
    });
</script>
</body>
</html>