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
    <title>仓库货位号管理</title>
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
        </el-row>
    </div>
    <div>
        <el-table :data="listDatas" :empty-text="listEmpty" @selection-change="selectionChange" @row-dblclick="dblclick" border stripe style="width: 100%;margin-top:10px;">
            <el-table-column type="selection" align="center" width="35"></el-table-column>
            <el-table-column prop="item_storage_code" label="货位号" width="180"></el-table-column>
            <el-table-column prop="point" label="坐标信息" show-overflow-tooltip></el-table-column>
            <el-table-column prop="gmt_create" label="添加时间" show-overflow-tooltip></el-table-column>
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
    <el-dialog style="display:none;" :title="dialogTitle" :lock-scroll="false" :visible.sync="dialogVisible" width="30%" :before-close="handleClose" :close-on-click-modal="false" :append-to-body="true">
        <div>
            <el-form ref="form" :model="formData" label-width="120px">
                <el-form-item label="货位号">
                    <el-input v-model="formData.item_storage_code" placeholder="货位号" clearable style="width:340px;"></el-input>
                </el-form-item>
                <el-form-item label="坐标点1">
                    <el-input v-model="formData.x1" placeholder="坐标x1的值" clearable style="width:168px;"></el-input>
                    <el-input v-model="formData.y1" placeholder="坐标y1的值" clearable style="width:168px;"></el-input>
                </el-form-item>
                <el-form-item label="坐标点2">
                    <el-input v-model="formData.x2" placeholder="坐标x2的值" clearable style="width:168px;"></el-input>
                    <el-input v-model="formData.y2" placeholder="坐标y2的值" clearable style="width:168px;"></el-input>
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
<%--
可以结合jquery的其他插件一起使用!!!
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script src="/layer/layer.js"></script>
<script src="/js/page.layer.js"></script>
--%>
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
                    item_storage_code : '',
                    x1 : '',
                    y1 : '',
                    x2 : '',
                    y2 : ''
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
                this.page.current = 1;
                this.getListData();
            },
            openDialog : function(row){
                if(row){
                    var point = eval('(' + row.point + ')');
                    this.formData = {
                        kid : row.kid,
                        item_storage_code : row.item_storage_code,
                        x1 : point.x1,
                        y1 : point.y1,
                        x2 : point.x2,
                        y2 : point.y2
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
            handleClose : function(done){
                this.dialogVisible = false;
            },
            checkForm : function(){
                if(!this.formData.item_storage_code){
                    elementFn.fnMsgError('请填写货位号');
                    return;
                }
                if(!this.formData.x1){
                    elementFn.fnMsgError('请输入坐标x1的值');
                    return;
                }
                if(!this.formData.y1){
                    elementFn.fnMsgError('请输入坐标y1的值');
                    return;
                }
                if(!this.formData.x2){
                    elementFn.fnMsgError('请输入坐标x2的值');
                    return;
                }
                if(!this.formData.y2){
                    elementFn.fnMsgError('请输入坐标y2的值');
                    return;
                }
                return true;
            },
            handleEdit : function(index,item){
                if(item){
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
                    ajax.post('storage/delById',{kid:row.kid},function(data){
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
                        ajax.post('storage/delByKeys',{ids:_this.kids},function(data){
                            _this.resultHandle(data);
                        });
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
                var url = (kid == null || kid.length <= 0) ? 'storage/add' : 'storage/edit';
                elementFn.loadOpen();
                ajax.post(url,this.formData,function(data){
                    _this.resultHandle(data);
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
                ajax.get("storage/listData",params,function(data){
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
                },function(){
                    elementFn.loadClose();
                    _this.listDatas = [];
                    _this.listEmpty = elementFn.connectError;
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