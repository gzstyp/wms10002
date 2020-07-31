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
    <title>物联网应用平台-区域货位信息</title>
    <link href="/css/element-ui/element-ui.css" rel="stylesheet">
    <link href="/css/page/page.container.css" rel="stylesheet">
</head>
<body>
<div id="app">
    <div class="head">
        <el-row :gutter="24">
            <el-col :span="4">
                <el-col style="padding:0px;height:40px;line-height:40px;">
                    楼层区域名称
                </el-col>
            </el-col>
            <el-col :span="6" :pull="2">
                <el-input placeholder="楼层区域名称" v-model="searchForm.name" clearable/>
            </el-col>
            <el-col :span="6" :pull="2" ><el-button @click="search()" icon="el-icon-search">搜索</el-button><el-button @click="handleEdit()" type="primary" icon="el-icon-plus">添加</el-button><el-button :disabled="kids.length > 0 ? false:true" type="danger" @click="delByKeys()" icon="el-icon-delete">删除</el-button></el-col>
        </el-row>
    </div>
    <div>
        <el-table :data="listDatas" :empty-text="listEmpty" @selection-change="selectionChange" @row-dblclick="dblclick" border stripe style="width: 100%;margin-top:6px;">
            <el-table-column type="selection" align="center" width="35"></el-table-column>
            <el-table-column prop="floorName" label="楼层名称" width="180"></el-table-column>
            <el-table-column prop="areaName" label="区域名称" width="100"></el-table-column>
            <el-table-column prop="fullName" label="楼层区域名称" width="180"></el-table-column>
            <el-table-column prop="grids" label="货架货位信息" show-overflow-tooltip></el-table-column>
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
    <el-dialog style="display:none;" :title="dialogTitle" :lock-scroll="false" :visible.sync="dialogVisible" width="60%" :before-close="handleClose" :close-on-click-modal="false" :append-to-body="true">
        <div>
            <el-form ref="form" :model="formData" label-width="120px">
                <el-form-item label="楼层区域名称">
                    <el-select v-model="formData.floor_area_id" placeholder="选择楼层区域名称" style="width:97%">
                        <el-option
                            v-for="(item,i) in optionsFloor"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="货架货位信息">
                    <el-input type="textarea" rows="24" v-model="formData.grids" placeholder="热点区域" style="width:97%;height:500px;"></el-input>
                </el-form-item>
            </el-form>
        </div>
        <span slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submits()">提交</el-button>
            <el-button @click="dialogVisible = false">取消</el-button>
        </span>
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
        data : function(){
            return {
                listEmpty:'暂无数据',
                dialogTitle :'楼层区域货位信息',
                formData : {
                    kid : '',
                    floor_area_id : '',
                    grids : ''
                },
                searchForm : {
                    name : ''
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
            this.getOptions();
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
                this.getListData();
            },
            openDialog : function(row){
                if(row != null && row.kid != null){
                    this.formData = {
                        kid : row.kid,
                        floor_area_id : row.floor_area_id,
                        grids : row.grids
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
                if(!this.formData.floor_area_id){
                    elementFn.fnMsgError('请选择楼层平面图');
                    return;
                }
                if(!this.formData.grids){
                    elementFn.fnMsgError('请填写货架货位信息');
                    return;
                }
                return true;
            },
            handleEdit : function(index,item){
                if(item != null && item.kid != null){
                    this.dialogTitle = '编辑货架货位信息';
                    this.openDialog(item);
                }else{
                    this.dialogTitle = '添加货架货位信息';
                    this.openDialog(null);
                }
            },
            handleDelete : function(index,row){
                var _this = this;
                elementFn.fnConfirm('删除之后是无法恢复,确认要删除吗?',function(){
                    elementFn.loadOpen();
                    _this.listDatas.splice(index,1);
                    ajax.post('layerGrid/delById',{kid:row.kid},function(data){
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
                        ajax.post('layerGrid/delByKeys',{ids:_this.kids},function(data){
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
                var url = (kid == null || kid.length <= 0) ? 'layerGrid/add' : 'layerGrid/edit';
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
                if(_this.searchForm.name){
                    params.name = _this.searchForm.name;
                }
                elementFn.loadOpen();
                ajax.get("layerGrid/listData",params,function(data){
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
            getOptions : function(){
                var _this = this;
                ajax.get("layerGrid/getOptions",{},function(data){
                    if(data.code === 200){
                        _this.optionsFloor = data.data;
                    }else{
                        _this.optionsFloor.push({"value":'',"label":data.msg});
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