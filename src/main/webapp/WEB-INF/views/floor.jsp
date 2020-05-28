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
    <title>物联网应用平台</title>
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
        <el-table :data="listDatas" @selection-change="selectionChange" border style="width: 100%;margin-top:10px;">
            <el-table-column type="selection" width="36"></el-table-column>
            <el-table-column prop="item_storage_code" label="货位号" width="180"></el-table-column>
            <el-table-column prop="coords" label="热点区域" show-overflow-tooltip></el-table-column>
            <el-table-column width="160" label="操作">
                <template slot-scope="scope">
                    <el-button size="mini" type="primary" @click="handleEdit(scope.$index,scope.row)">编辑</el-button>
                    <el-button size="mini" type="danger" @click="handleDelete(scope.$index,scope.row)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>

    <el-dialog style="display:none;" title="编辑货位号" :visible.sync="dialogVisible" width="30%" :before-close="handleClose" :close-on-click-modal="false" :append-to-body="true">
        <div>
            <el-form ref="form" :model="formData" label-width="120px">
                <el-form-item label="货位号">
                    <el-input v-model="formData.item_storage_code" clearable style="width:330px;"></el-input>
                </el-form-item>
                <el-form-item label="楼层平面图">
                    <el-select v-model="formData.images_id" placeholder="选择楼层平面图">
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
                    <el-input v-model="formData.coords" clearable style="width:330px;"></el-input>
                </el-form-item>
            </el-form>
        </div>
        <span slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submitSave">提交</el-button>
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
                    size: 5,
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
            search : function(){
                this.getListData();
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
                    this.formData = {
                        kid : item.kid,
                        images_id : item.images_id,
                        item_storage_code : item.item_storage_code,
                        coords : item.coords
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
            handleDelete : function(index,row){
                var _this = this;
                elementFn.fnConfirm('删除之后是无法恢复,确认要删除吗?',function(){
                    _this.listDatas.splice(index,1);
                    ajax.post('show/delById',{kid:row.kid},function(data){
                        if(data.data.code === 200){
                            elementFn.fnMsgSuccess(data.data.msg);
                            _this.getListData();
                        }else{
                            elementFn.fnMsgError(data.data.msg);
                        }
                    });
                },function(){
                    elementFn.fnMessage('已取消操作');
                });
            },
            delByKeys : function(){
                var _this = this;
                if(this.kids){
                    elementFn.fnConfirm(this.kids.length + "删除之后是无法恢复的,你要批量删除"+this.kids.length+"条数据吗?",function(){
                        elementFn.fnMessage('已确认操作');
                        ajax.post('show/delByKeys',{ids:_this.kids},function(data){
                            if(data.data.code === 200){
                                elementFn.fnMsgSuccess(data.data.msg);
                                _this.getListData();
                            }else{
                                elementFn.fnMsgError(data.data.msg);
                            }
                        });
                    },function(){
                        elementFn.fnMessage('已取消操作');
                    });


                    /*elementFn.fnConfirm(,function(){


                    },function(){
                        elementFn.fnMessage('已取消操作');
                    });*/
                }else{
                    elementFn.fnMsgError('请选择要删除的数据!');
                }
            },
            submitSave : function(){
                var form = this.checkForm();
                if(!form){
                    return;
                }
                var _this = this;
                var kid = this.formData.kid;
                var url = (kid == null || kid.length <= 0) ? 'show/add' : 'show/edit';
                ajax.post(url,this.formData,function(data){
                    if(data.data.code === 200){
                        elementFn.fnMsgSuccess(data.data.msg);
                        _this.getListData();
                    }else{
                        elementFn.fnMsgError(data.data.msg);
                    }
                });
                this.dialogVisible = false;
            },
            getListData : function(){
                var _this = this;
                var params = {
                    current:_this.page.current,pageSize:_this.page.size
                };
                if(_this.searchForm.storage_code){
                    params.item_storage_code = _this.searchForm.storage_code;
                }
                ajax.get("show/listData",params,function(data){
                    if(data.data.code === 200){
                        _this.listDatas = data.data.data;
                        _this.page.total = data.data.total;
                    }
                });
            },
            getOptions : function(){
                var _this = this;
                ajax.get("show/getAllFloorMap",{},function(data){
                    if(data.data.code === 200){
                        _this.optionsFloor = [];
                        _this.optionsFloor = data.data.data;
                    }else{
                        _this.optionsFloor[0].label= data.data.msg;
                    }
                });
            }
        }
    });
</script>
</body>
</html>