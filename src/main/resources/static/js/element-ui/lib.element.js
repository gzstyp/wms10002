/**
 * @作者 田应平
 * @创建时间 2020-05-28 16:41
 * @QQ号码 444141300
 * @官网 http://www.fwtai.com
*/

elementFn = new Vue({
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
    }
});