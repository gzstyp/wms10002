/**
 * @作者 田应平
 * @创建时间 2020-05-28 16:41
 * @QQ号码 444141300
 * @官网 http://www.fwtai.com
*/

elementFn = new Vue({
    methods : {
        fnMessage : function(msg){
            this.$message({
                showClose: true,
                message : msg
            });
        },
        fnMsgError : function(msg){
            this.$message.error({
                showClose: true,
                message : msg,
                type : 'error'
            });
        },
        fnMsgSuccess : function(msg){
            this.$message({
                showClose: true,
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
        loadOpen : function(msg){
            return this.$loading({
                lock: true,
                text: msg,
                spinner: 'el-icon-loading',
                background: 'rgba(0, 0, 0, 0.3)'
            });
        },
        loadClose : function(loading){
            loading.close();
        }
    }
});