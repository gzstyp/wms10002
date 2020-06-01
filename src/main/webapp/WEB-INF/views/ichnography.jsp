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
                <el-input placeholder="楼层平面图名称" v-model="searchForm.floor_name" clearable/>
            </el-col>
            <el-col :span="6" :pull="1" ><el-button @click="search()" icon="el-icon-search">搜索</el-button><el-button @click="handleEdit()" type="primary" icon="el-icon-plus">添加</el-button><el-button :disabled="kids.length > 0 ? false:true" type="danger" @click="delByKeys()" icon="el-icon-delete">删除</el-button></el-col>
            <%--<el-col :span="4" style="background:#ccb19b;height:40px;line-height:40px;">4份</el-col>
            <el-col :span="4" style="background:#a6cc88;height:40px;line-height:40px;">4份</el-col>--%>
        </el-row>
    </div>
    <div>
        <el-table :data="listDatas" :empty-text="listEmpty" @selection-change="selectionChange" @sort-change="sortChange" @row-dblclick="dblclick" border stripe style="width: 100%;margin-top:10px;">
            <el-table-column type="selection" align="center" width="35"></el-table-column>
            <el-table-column prop="floor_name" label="楼层平面图名称" width="300" :sortable="'custom'"></el-table-column>
            <el-table-column prop="width" label="宽度" width="72"></el-table-column>
            <el-table-column prop="height" label="高度" width="72"></el-table-column>
            <el-table-column prop="usemap" label="usemap值" width="150"></el-table-column>
            <el-table-column prop="img_url" label="图片" show-overflow-tooltip :formatter="urlFormatter">
                <template slot-scope="scope">
                    <a style="color:#1E9FFF;cursor:pointer;" @click="viewImage(scope.row.img_url)">查看图片</a>
                </template>
            </el-table-column>
            <%--<el-table-column property="img_url" label="图片" align="left">
                <template slot-scope="scope">
                    <el-image
                        style="width:20px;height:20px"
                        :src="scope.row.img_url"
                        :preview-src-list="imageList">
                    </el-image>
                </template>
            </el-table-column>--%>
            <el-table-column width="210" label="操作">
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
                    accept=".jpg,.jpeg,.png,.gif,.bmp"
                    :on-preview="handlePreview"
                    :on-remove="handleRemove"
                    :on-success="onSuccess"
                    :on-error="onError"
                    :on-change="onChange"
                    :limit="1"
                    :before-upload="beforeupload"
                    :file-list="fileList"
                    list-type="picture"
                    :multiple=false
                    :auto-upload="false">
                    <el-button size="small">选择图片</el-button>
                </el-upload>
            </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submits()">提交</el-button>
            <el-button @click="dialogVisible = false">取消</el-button>
        </span>
    </el-dialog>
    <%-- 好使的,<p v-for="(item,i) in optionsFloor">--id--{{item.value}}  --姓名--{{item.label}}</p>--%>
    <el-dialog style="display:none;" :title="viewImageTitle" :visible.sync="viewImageVisible" width="80%" height="100%" :before-close="viewImageClose" :close-on-click-modal="false" :append-to-body="true">
        <el-image :src="view_img_url"/>
    </el-dialog>
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
        data : {
            dialogImageUrl : '',
            listEmpty:'暂无数据',
            dialogTitle :'编辑楼层平面图',
            viewImageTitle :'查看图片',
            view_img_url : null,
            formData : {
                kid : '',
                floor_name : '',
                width : '',
                height : '',
                usemap : '',
                img_url : ''
            },
            order : {
                column : null,
                sort : null
            },
            fileList : [],
            searchForm : {
                floor_name : ''
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
            dialogVisible : false,
            viewImageVisible : false
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
            handleRemove(file,files) {
                console.log(file);
                //console.log(files);
            },
            onSuccess : function(response,file,files){
                console.info(response);
                console.info(file);
                console.info(files);
            },
            onError : function(err,file,files){

            },
            //文件状态改变时的钩子，添加文件、上传成功和上传失败时都会被调用
            onChange : function(file,files){

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
            handleClose : function(done){
                /*有用,不要删除,this.$confirm('确认关闭?')
                    .then(_ => {
                        done();
                    })
                .catch(_ => {});*/
                this.dialogVisible = false;
            },
            viewImageClose : function(){
                this.viewImageVisible = false
            },
            handleEdit : function(index,item){
                this.fileList = [];//置空
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
                    ajax.post('ichnography/delById',{kid:row.kid},function(data){
                        _this.resultHandle(data);
                    });
                },function(){
                    elementFn.fnMessage('已取消操作');
                });
            },
            resultHandle : function(data){
                elementFn.loadClose();
                if(data.code === 200){
                    this.dialogVisible = false;
                    this.fileList = [];//置空
                    elementFn.fnNotifySuccess(data.msg);
                    this.getListData();
                }else{
                    elementFn.fnNotifyWarning(data.msg);
                }
            },
            delByKeys : function(){
                var _this = this;
                if(this.kids){
                    elementFn.fnConfirm("删除之后是无法恢复的,你要批量删除"+this.kids.length+"条数据吗?",function(){
                        elementFn.loadOpen();
                        ajax.post('ichnography/delByKeys',{ids:_this.kids},function(data){
                            _this.resultHandle(data);
                        });
                    });
                }else{
                    elementFn.fnMsgError('请选择要删除的数据!');
                }
            },
            sortChange : function(column){
                this.order.column = column.prop;
                this.order.sort = column.order;
                this.getListData();
            },
            /*适用于格式化1男2女*/
            urlFormatter : function(row,column,cellValue,index){
                return cellValue;
                /*console.info(row);
                console.info(cellValue);*/
            },
            viewImage : function(url){
                //var html = '<img style="width:1002px;height:1002px" src="'+url+'"/>';
                //elementFn.fnAlert(html,'查看图片');
                this.view_img_url = url;
                this.viewImageVisible = true;
                //elementFn.fnMsgbox('表单');
            },
            // 文件上传前事件
            beforeupload (file){
                // 2.1，重新写一个表单上传的方法
                this.fileList.push(file); // 把单个文件变成数组
                var images = [...this.fileList]; // 把数组存储为一个参数，便于后期操作
                // 2.2，遍历数组
                images.forEach((img,index) => {
                    this.param.append(img.name,img);
                });
                return false
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
                var kid = this.formData.kid;
                //新增|添加
                if(kid == null || kid.length <= 0){
                    var fe = this.fileList[0];
                    if(fe == null || fe.length <= 0){
                        elementFn.fnMsgError('请选择上传图片');
                        return;
                    }
                }
                return true;
            },
            submits : function(){
                this.param = new FormData();//初始化表单参数!!!
                this.$refs.upload.submit();//用于页面的图片初始化的,这个不能丢!!!
                var form = this.checkForm();
                if(!form){
                    return;
                }
                var _this = this;
                var kid = _this.formData.kid;
                var url = (kid == null || kid.length <= 0) ? 'ichnography/add' : 'ichnography/edit';
                if(kid){
                    this.param.append('kid',kid);
                }
                var floor_name = _this.formData.floor_name;
                var width = _this.formData.width;
                var height = _this.formData.height;
                var usemap = _this.formData.usemap;
                if(floor_name){
                    this.param.append('floor_name',floor_name);
                }
                if(width){
                    this.param.append('width',width);
                }
                if(height){
                    this.param.append('height',height);
                }
                if(usemap){
                    this.param.append('usemap',usemap);
                }
                elementFn.loadOpen();
                ajax.postFile(url,this.param,function(data){
                    _this.resultHandle(data);
                },function(err){
                    this.dialogVisible = false;
                    elementFn.fnFailure();
                });
            },
            getListData : function(){
                var _this = this;
                var params = {
                    current : _this.page.current,
                    pageSize : _this.page.size,
                    column : _this.order.column,
                    sort : _this.order.sort
                };
                if(_this.searchForm.floor_name){
                    params.floor_name = _this.searchForm.floor_name;
                }
                elementFn.loadOpen();
                ajax.get("ichnography/listData",params,function(data){
                    elementFn.loadClose();
                    if(data.code === 200){
                        _this.listDatas = data.data;
                        _this.page.total = data.total;
                    }else if(data.code === 202){
                        _this.listDatas = [];
                        _this.page.total = 0;
                    }else{
                        _this.listEmpty = data.msg;
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
            }
        }
    });
</script>
</body>
</html>