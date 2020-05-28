/**
 * @作者 田应平
 * @创建时间 2020-05-01 18:21
 * @QQ号码 444141300
 * @官网 http://www.fwtai.com
*/
new Vue({
    fields : {
        name : '',
        sex : '',
        tell : ''
    },
    el : '#app',
    data : function(){
        return {
            userInfo : {//表单的输入框的数据及dom(user对象)
                name : '',
                sex : '',
                tell : ''
            },
            tableData : [],
            options: [{
                value : '',
                label : '选择'
            },{
                value : '1',
                label : '男生'
            },{
                value : '2',
                label : '女生'
            }],
            dialogVisible : false, //控制dialog对话框是否显示的
            editObj : {
                name : '',
                sex : '',
                tell : ''
            },
            //保留要修改的数据
            userIndex : 0
        }
    },
    /*html加载完成之前，执行。执行顺序：父组件-子组件,在模板渲染成html前调用，即通常初始化某些属性值，然后再渲染成视图。*/
    created : function(){
    },
    /*页面初始化方法,html加载完成后执行。执行顺序：子组件-父组件,在模板渲染成html后调用，通常是初始化页面完成后，再对html的dom节点进行一些需要的操作*/
    mounted : function(){
        this.getWmsData();
    },
    /*事件方法执行*/
    methods : {
        fnMessage : function(msg){
            this.$message(msg);
        },
        fnMsgError : function(msg){
            this.$message.error(msg);
        },
        fnMsgSuccess : function(msg){
            this.$message({
                message : msg,
                type : 'success'
            });
        },
        fnConfirm : function(msg,verify,cancel){
            this.$confirm(msg, '系统提示',{
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
                //center: true
            }).then(() => {
                if(verify){
                    verify();
                }
            }).catch(() => {
                if(cancel){
                    cancel();
                }
            });
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
        checkFormAdd : function(){
            if(!this.userInfo.name){
                this.fnMsgError('请输入姓名');
                return;
            }
            if(!this.userInfo.sex){
                this.fnMsgError('请选择性别');
                return;
            }
            if(!this.userInfo.tell){
                this.fnMsgError('电话号码不能为空');
                return;
            }
            if(!(/^1[3456789]\d{9}$/.test(this.userInfo.tell))){
                this.fnMsgError('请输入正确的手机号');
                return;
            }
            return true;
        },
        //添加
        addUser : function(){
            var form = this.checkFormAdd();
            if(!form){
                return;
            }
            this.tableData.push(this.userInfo);
            this.userInfo = { //清空表单
                name : '',
                sex : '',
                tell : ''
            }
            this.fnMsgSuccess('添加成功');
        },
        handleEdit : function(index,item){
            this.userIndex = index;
            /*this.editObj.name = item.name;
            this.editObj.sex = item.sex;
            this.editObj.tell = item.tell;*/
            this.editObj = {
                name : item.name,
                sex : item.sex,
                tell : item.tell
            }
            this.dialogVisible = true;
        },
        handleDelete : function(index,row){
            var _this = this;
            this.fnConfirm('删除之后是无法恢复,确认要删除吗?',function(){
                _this.tableData.splice(index,1);
                _this.fnMsgSuccess('删除成功');
            },function(){
                _this.fnMessage('已取消操作');
            });
        },
        checkFormEdit : function(){
            if(!this.editObj.name){
                this.fnMsgError('请输入姓名');
                return;
            }
            if(!this.editObj.sex){
                this.fnMsgError('请选择性别');
                return;
            }
            if(!this.editObj.tell){
                this.fnMsgError('电话号码不能为空');
                return;
            }
            if(!(/^1[3456789]\d{9}$/.test(this.editObj.tell))){
                this.fnMsgError('请输入正确的手机号');
                return;
            }
            return true;
        },
        submitSave : function(){
            var form = this.checkFormEdit();
            if(!form){
                return;
            }
            var _this = this;
            //this.tableData[this.userIndex] = this.editObj;//这种方式不支持响应式的更新数据,没有及时渲染到页面上,没有实现数据双向绑定,是不是响应性的!!!
            //官方示例
            //Vue.set(vm.items, indexOfItem, newValue)//第1个参数是表格的数据,第2个是修改列表的索引值,第3个是编辑后的数据
            Vue.set(_this.tableData,this.userIndex,this.editObj);//第1个参数是表格的数据,第2个是修改列表的索引值,第3个是编辑后的数据,ok
            this.dialogVisible = false;
            this.fnMsgSuccess('操作成功');
        },
        getWmsData : function(){
            var _this = this;
            ajax.get('http://127.0.0.1:83/api/getListData?pageSize=2&start=1',{},function(data){
                if(data.data.code === 200){
                    _this.tableData = data.data.data;
                }
            },function(err){
                console.info(err);
            });
        }
    }
});