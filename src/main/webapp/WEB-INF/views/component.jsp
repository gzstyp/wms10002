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
    <%-- :model="Xxx"是传值到组件里的 props.model,add-url 也是传值到在组件里的 props.addUrl,需要注意的是以驼峰命名规则,用短横线分隔命名
    组件的命名规则是在 props 的下的 aaaYyy,则在调用时就是 :aaa-yyy="变量名" | aaaXxxYyy --> :aaa-xxx-yyy="变量名"  --%>
    <form-comm :model="goods" :add-url="url.add" :edit-url="url.edit">
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
</div>
<!-- import Vue before Element -->
<script src="/js/element-ui/vue.min.js"></script>
<!-- import JavaScript -->
<script src="/js/element-ui/index.js"></script>
<script src="/js/element-ui/axios.min.js"></script>
<script src="/js/page/http.js"></script>
<script src="/js/components/FromComm.js"></script>

<script>
    new Vue({
        el : '#app',
        data : function(){
            return {
                goods : {
                    kid : null,
                    productName : 'apple',
                    num : '152',
                    price : '100.20'
                },
                url : {
                    add : 'ichnography/add',
                    edit : 'ichnography/edit'
                }
            }
        },
        created() {
            this.getProductById();
        },
        methods : {
            getProductById : function(){
                this.goods = {
                    kid : '',
                    productName : 'apple',
                    num : '152',
                    price : '100.20'
                }
            }
        }
    });
</script>
</body>
</html>