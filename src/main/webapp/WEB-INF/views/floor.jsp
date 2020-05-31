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
    <title>物联网应用平台-楼层货位管理</title>
    <link href="/css/element-ui/element-ui.css" rel="stylesheet">
    <link href="/css/page/page.container.css" rel="stylesheet">
</head>
<body>
<div id="app">
    <div class="head">
        <el-row :gutter="24">
            <el-col :span="2">
                <el-col style="padding:0px;height:40px;line-height:40px;">
                    货位号
                </el-col>
            </el-col>
            <el-col :span="6" :pull="1">
                <el-input placeholder="货位号" v-model="searchForm.storage_code" clearable/>
            </el-col>
            <el-col :span="6" :pull="1" ><el-button @click="search()" icon="el-icon-search">搜索</el-button><el-button @click="handleEdit()" type="primary" icon="el-icon-plus">添加</el-button><el-button :disabled="kids.length > 0 ? false:true" type="danger" @click="delByKeys()" icon="el-icon-delete">删除</el-button></el-col>
            <%--<el-col :span="4" style="background:#ccb19b;height:40px;line-height:40px;">4份</el-col>
            <el-col :span="4" style="background:#a6cc88;height:40px;line-height:40px;">4份</el-col>--%>
        </el-row>
    </div>
    <div>
        <el-table :data="listDatas" :empty-text="listEmpty" @selection-change="selectionChange" @row-dblclick="dblclick" border stripe style="width: 100%;margin-top:10px;">
            <el-table-column type="selection" width="35"></el-table-column>
            <el-table-column prop="item_storage_code" label="货位号" width="180"></el-table-column>
            <el-table-column prop="coords" label="热点区域" show-overflow-tooltip></el-table-column>
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
            <el-form ref="form" :model="formData" label-width="120px">
                <el-form-item label="货位号">
                    <el-input v-model="formData.item_storage_code" placeholder="货位号" clearable style="width:340px;"></el-input>
                </el-form-item>
                <el-form-item label="楼层平面图">
                    <el-select v-model="formData.images_id" placeholder="选择楼层平面图" style="width:340px;">
                        <el-option label="不选择" value=""></el-option>
                        <el-option
                            v-for="item in optionsFloor"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="热点区域">
                    <el-input v-model="formData.coords" placeholder="热点区域" clearable style="width:340px;"></el-input>
                </el-form-item>
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
                listEmpty:'暂无数据',
                dialogTitle :'货位号信息',
                formData : {
                    kid : '',
                    images_id : '',
                    item_storage_code : '',
                    coords : ''
                },
                searchForm : {
                    storage_code : ''
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
            this.getOptions();
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
            search : function(){
                this.getListData();
            },
            openDialog : function(row){
                if(row != null && row.kid != null){
                    this.formData = {
                        kid : row.kid,
                        images_id : row.images_id,
                        item_storage_code : row.item_storage_code,
                        coords : row.coords
                    };
                }else{
                    this.formData = {};
                    /*this.formData = {
                        kid : '',
                        images_id : '',
                        item_storage_code : '',
                        coords : ''
                    };*/
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
                if(!this.formData.item_storage_code){
                    elementFn.fnMsgError('请填写货位号');
                    return;
                }
                if(!this.formData.images_id){
                    elementFn.fnMsgError('请选择楼层平面图');
                    return;
                }
                if(!this.formData.coords){
                    elementFn.fnMsgError('请填写热点区域');
                    return;
                }
                return true;
            },
            handleEdit : function(index,item){
                if(item != null && item.kid != null){
                    this.dialogTitle = '编辑';
                    this.openDialog(item);
                }else{
                    this.dialogTitle = '添加';
                    this.openDialog(null);
                }
            },
            handleDelete : function(index,row){
                var _this = this;
                elementFn.fnConfirm('删除之后是无法恢复,确认要删除吗?',function(){
                    elementFn.loadOpen();
                    _this.listDatas.splice(index,1);
                    ajax.post('show/delById',{kid:row.kid},function(data){
                        _this.handleResult(data);
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
                            _this.handleResult(data);
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
                var url = (kid == null || kid.length <= 0) ? 'show/add' : 'show/edit';
                elementFn.loadOpen();
                ajax.post(url,this.formData,function(data){
                    _this.handleResult(data);
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
            getOptions : function(){
                var _this = this;
                ajax.get("show/getAllFloorMap",{},function(data){
                    if(data.code === 200){
                        //_this.optionsFloor = [];
                        _this.optionsFloor = data.data;
                    }else{
                        _this.optionsFloor[0].label= data.msg;
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