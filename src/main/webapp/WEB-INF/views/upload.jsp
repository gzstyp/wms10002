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
    <title>物联网应用平台-楼层货位图片</title>
    <link href="/css/element-ui/element-ui.css" rel="stylesheet">
    <link href="/css/page/page.container.css" rel="stylesheet">
</head>
<body>
<div id="app">
    <div class="head">
        <el-row :gutter="24">
            <el-col :span="3">
                <el-col style="padding:0px;height:40px;line-height:40px;">
                    楼层平面图名称
                </el-col>
            </el-col>
            <el-col :span="6" :pull="1">
                <el-input placeholder="楼层平面图名称" v-model="searchForm.storage_code" clearable/>
            </el-col>
            <el-col :span="6" :pull="1" ><el-button @click="search()" icon="el-icon-search">搜索</el-button><el-button @click="handleEdit()" type="primary" icon="el-icon-plus">添加</el-button><el-button :disabled="kids.length > 0 ? false:true" type="danger" @click="delByKeys()" icon="el-icon-delete">删除</el-button></el-col>
            <%--<el-col :span="4" style="background:#ccb19b;height:40px;line-height:40px;">4份</el-col>
            <el-col :span="4" style="background:#a6cc88;height:40px;line-height:40px;">4份</el-col>--%>
        </el-row>
    </div>
    <div>
        <el-table :data="listDatas" :empty-text="listEmpty" @selection-change="selectionChange" @row-dblclick="dblclick" border stripe style="width: 100%;margin-top:10px;">
            <el-table-column type="selection" width="35"></el-table-column>
            <el-table-column prop="floor_name" label="楼层平面图名称" width="180"></el-table-column>
            <el-table-column prop="width" label="图片的宽度" show-overflow-tooltip></el-table-column>
            <el-table-column prop="height" label="图片的高度" show-overflow-tooltip></el-table-column>
            <el-table-column width="160" label="操作">
                <template slot-scope="scope">
                    <el-button size="mini" type="primary" @click="handleEdit(scope.$index,scope.row)">编辑</el-button>
                    <el-button size="mini" type="danger" @click="handleDelete(scope.$index,scope.row)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-pagination
            v-if="page.size<page.total"
            background
            layout="total,sizes,prev,pager,next,jumper"
            @size-change="changeSize"
            @current-change="currentChange"
            :page-size="page.size"
            :page-sizes="page.sizes"
            :current-page="page.current"
            :total="page.total">
        </el-pagination>
    </div>
    <el-dialog style="display:none;" :title="dialogTitle" :visible.sync="dialogVisible" width="30%" :before-close="handleClose" :close-on-click-modal="false" :append-to-body="true">
        <div>
            <el-form ref="formData" :model="formData" label-width="120px">
                <el-form-item label="楼层平面图名称" prop="floor_name">
                    <el-input v-model="formData.floor_name" placeholder="楼层平面图名称" clearable style="width:340px;"></el-input>
                </el-form-item>
                <el-form-item label="图片的宽度" prop="width">
                    <el-input v-model="formData.width" placeholder="图片的宽度" oninput="value=value.replace(/[^\d]/g,'')" clearable style="width:340px;"></el-input>
                </el-form-item>
                <el-form-item label="图片的高度" prop="height">
                    <el-input v-model="formData.height" placeholder="图片的高度" oninput="value=value.replace(/[^\d]/g,'')" clearable style="width:340px;"></el-input>
                </el-form-item>
                <el-form-item label="热点usemap值" prop="usemap">
                    <el-input v-model="formData.usemap" placeholder="usemap值" clearable style="width:340px;"></el-input>
                </el-form-item>
                <el-form-item label="楼层平面图">
                    <el-upload style="width:340px;"
                        ref="upload"
                        action="http://127.0.0.1:82/show/imageInfo"
                        :on-preview="handlePreview"
                        :on-remove="handleRemove"
                        :on-success="onSuccess"
                        :on-error="onError"
                        :on-change="onChange"
                        :file-list="fileList"
                        list-type="picture"
                        :multiple=false
                        :auto-upload="false">
                        <el-button size="small">选择图片</el-button>
                    </el-upload>
                </el-form-item>


                <div id="upload">
                    <!--elementui的上传图片的upload组件-->
                    <el-upload class="upload-demo"
                               ref="upload"
                               list-type="picture-card"
                               action="http://127.0.0.1:82/show/imageInfo"
                               :limit="9"
                               :on-preview="handlePreview"
                               :before-upload="beforeupload"
                               :on-exceed="exceedHandle"
                               :auto-upload="false"
                               :multiple='true'>
                        <i class="el-icon-plus"></i>
                    </el-upload>
                    <!--展示选中图片的区域-->
                    <%--<el-dialog :visible.sync="dialogVisible">
                        <img width="100%"
                             :src="dialogImageUrl"
                             alt="">
                    </el-dialog>--%>
                    <!--elementui的form组件-->
                    <el-form ref="form"
                             :model="formData"
                             label-width="80px">
                        <el-form-item label="活动名称">
                            <el-input v-model="formData.floor_name" name="names"
                                      style="width:360px;"></el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary"
                                       @click="onSubmit">立即创建</el-button>
                            <el-button>取消</el-button>
                        </el-form-item>
                    </el-form>
                </div>
            </el-form>
        </div>
        <span slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submits()">提交</el-button>
            <el-button @click="dialogVisible = false">取消</el-button>
        </span>
    </el-dialog>
    <%-- 好使的,<p v-for="(item,i) in optionsFloor">--id--{{item.value}}   --姓名--{{item.label}}</p>--%>
</div>
<!-- import Vue before Element -->
<script src="/js/element-ui/vue.min.js"></script>
<!-- import JavaScript -->
<script src="/js/element-ui/index.js"></script>
<script src="/js/element-ui/lib.element.js"></script>
<script src="/js/element-ui/axios.min.js"></script>
<script src="/js/page/http.js"></script>

<script>
    new Vue({
        el : '#app',
        data : function(){
            return {
                dialogImageUrl : '',
                listEmpty:'暂无数据',
                dialogTitle :'编辑楼层平面图',
                formData : {
                    kid : '',
                    floor_name : '',
                    width : '',
                    height : '',
                    usemap : '',
                    img_url : ''
                },
                fileList : [],
                searchForm : {
                    storage_code : ''
                },
                rules: {
                    floor_name: [
                        {required:true, message:'楼层平面图名称',trigger: 'blur'},
                        {min:2,max:64,message:'长度在2到64个字符',trigger: 'blur'}
                    ],
                    width: [
                        {required:true, message:'请输入图片的宽度',trigger:'blur'},
                        {pattern: /^-?\d+\.?\d*$/,min:0,message:'请输入正确的数值',trigger:'blur'}
                    ],
                    height: [
                        {required:true, message:'请输入图片的高度',trigger:'blur'}
                    ],
                    usemap: [
                        {required:true,message:'请输入图片热点usemap值',trigger:'blur'}
                    ],
                },
                kids: [],
                listDatas : [],
                page: {
                    current: 1,
                    size: 20,
                    sizes: [20,50,99],
                    total: 0
                },
                optionsFloor: [],
                dialogVisible : false
            }
        },
        created() {
            this.getListData();
        },
        methods : {
            // 行选择触发事件
            selectionChange(selection) {
                this.kids = [];
                selection.forEach(element => {
                    this.kids.push(element.kid);
                });
            },
            dblclick : function(row,column,event){
                this.openDialog(row);
            },
            handleRemove(file,fileList) {
                console.log(file,fileList);
            },
            onSuccess : function(response,file,fileList){
                console.info(response);
                console.info(file);
                console.info(fileList);
            },
            onError : function(err,file,fileList){

            },
            //文件状态改变时的钩子，添加文件、上传成功和上传失败时都会被调用
            onChange : function(file,fileList){

            },
            //预览
            handlePreview(file){
                console.log(file);
            },
            submitUpload(){
                this.$refs.upload.submit();
            },
            search : function(){
                this.getListData();
            },
            openDialog : function(row){
                if(row != null && row.kid != null){
                    this.formData = {
                        kid : row.kid,
                        floor_name : row.floor_name,
                        width : row.width,
                        height : row.height,
                        usemap : row.usemap,
                        img_url : row.img_url
                    };
                }else{
                    this.formData = {};
                }
                this.dialogVisible = true;
            },
            //dialog对话框右上角的关闭之前的操作
            handleClose : function(done) {
                /*有用,不要删除,this.$confirm('确认关闭?')
                    .then(_ => {
                        done();
                    })
                .catch(_ => {});*/
                this.dialogVisible = false;
            },
            checkForm : function(){
                if(!this.formData.floor_name){
                    elementFn.fnMsgError('楼层平面图名称');
                    return;
                }
                if(!this.formData.width){
                    elementFn.fnMsgError('请填写图片宽度');
                    return;
                }
                if(!this.formData.height){
                    elementFn.fnMsgError('请填写图片高度');
                    return;
                }
                if(!this.formData.usemap){
                    elementFn.fnMsgError('请填图片热点区域usemap');
                    return;
                }
                /*if(!this.formData.img_url){
                    elementFn.fnMsgError('请请上传图片');
                    return;
                }*/
                return true;
            },
            handleEdit : function(index,item){
                if(item != null && item.kid != null){
                    this.dialogTitle='编辑楼层平面图';
                    this.openDialog(item);
                }else{
                    this.dialogTitle='添加楼层平面图';
                    this.openDialog(null);
                }
            },
            handleDelete : function(index,row){
                var _this = this;
                elementFn.fnConfirm('删除之后是无法恢复,确认要删除吗?',function(){
                    elementFn.loadOpen();
                    _this.listDatas.splice(index,1);
                    ajax.post('show/delById',{kid:row.kid},function(data){
                        _this.handleResult(data.data);
                    });
                },function(){
                    elementFn.fnMessage('已取消操作');
                });
            },
            handleResult : function(data){
                elementFn.loadClose();
                if(data.code === 200){
                    this.dialogVisible = false;
                    elementFn.fnNotifySuccess(data.msg);
                    this.getListData();
                }else{
                    elementFn.fnNotifyWarning(data.msg);
                }
            },
            delByKeys : function(){
                var _this = this;
                if(this.kids){
                    elementFn.fnConfirm(this.kids.length + "删除之后是无法恢复的,你要批量删除"+this.kids.length+"条数据吗?",function(){
                        ajax.post('show/delByKeys',{ids:_this.kids},function(data){
                            _this.handleResult(data.data);
                        });
                        elementFn.loadOpen();//注意不要放错顺序!!!
                    });
                }else{
                    elementFn.fnMsgError('请选择要删除的数据!');
                }
            },
            submits : function(){
                var form = this.checkForm();
                if(!form){
                    return;
                }
                var _this = this;
                var kid = this.formData.kid;
                var url = (kid == null || kid.length <= 0) ? 'show/imageInfo' : 'show/edit';
                elementFn.loadOpen();
                ajax.post(url,this.formData,function(data){
                    _this.handleResult(data.data);
                });
            },
            getListData : function(){
                var _this = this;
                var params = {
                    current : _this.page.current,
                    pageSize : _this.page.size
                };
                if(_this.searchForm.storage_code){
                    params.item_storage_code = _this.searchForm.storage_code;
                }
                elementFn.loadOpen();
                ajax.get("show/listData",params,function(data){
                    elementFn.loadClose();
                    if(data.data.code === 200){
                        _this.listDatas = data.data.data;
                        _this.page.total = data.data.total;
                    }else if(data.data.code === 202){
                        _this.listDatas = [];
                        _this.page.total = 0;
                    }else{
                        _this.listEmpty = data.data.msg;
                    }
                });
            },
            changeSize : function (pageSize){
                this.page.current = 1;
                this.page.size = pageSize;
                this.getListData();
            },
            currentChange : function(current){
                this.page.current = current;
                this.getListData();
            },




            // 1，上传前移除事件
            beforeRemove (file, fileList) {
                return this.$confirm(`确定移除 ${file.name}？`)
            },
            // 2，上传前事件
            beforeupload (file) {
                // 2.1，重新写一个表单上传的方法
                this.param = new FormData()
                this.fileList.push(file) // 把单个文件变成数组
                let images = [...this.fileList] // 把数组存储为一个参数，便于后期操作
                // 2.2，遍历数组
                images.forEach((img, index) => {
                    this.param.append(`img_${index}`, img) // 把单个图片重命名，存储起来（给后台）
                })
                return false
            },
            // 3，点击文件列表中已上传的文件时的钩子
            handlePictureCardPreview (file) {
                this.dialogImageUrl = file.url
                this.dialogVisible = true
            },
            // 4，表单提交的事件
            onSubmit () {
                let _this = this
                debugger;
                var names = _this.formData.floor_name
                this.$refs.upload.submit()
                // 4.1，下面append的东西就会到form表单数据的this.param中；
                this.param.append('company_id', _this.company_id)
                this.param.append('caption', names)
                // 4.2，赋予提交请求头，格式为：'multipart/form-data'（必须！！）
                let config = {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                }
                // 4.3，然后通过下面的方式把内容通过axios来传到后台
                axios.post('http://127.0.0.1:82/show/imageInfo', this.param, config).then(function (result) {
                    console.log(result)
                })
            },
            // 5设置超过9张图给与提示
            exceedHandle () {
                alert('您现在选择已超过9张图，请重新选择')
            }
        }
    });
</script>
</body>
</html>