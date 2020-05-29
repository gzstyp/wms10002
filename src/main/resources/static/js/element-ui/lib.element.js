/**
 * @作者 田应平
 * @创建时间 2020-05-28 16:41
 * @QQ号码 444141300
 * @官网 http://www.fwtai.com
*/

elementFn = new Vue({
    data : {
        title : '系统提示',
        loadIndex:null
    },
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
        fnNotify : function(msg,type){
            switch (type){
                case 1:
                    this.fnNotifySuccess(msg);
                    break;
                case 2:
                    this.fnNotifyError(msg);
                    break;
                case 3:
                    this.fnNotifyWarning(msg);
                    break;
                default:
                    this.fnNotifyInfo(msg);
                    break;
            }
        },
        fnNotifySuccess : function(msg){
            this.$notify({
                title: this.title,
                message: msg,
                type: 'success'
            });
        },
        fnNotifyWarning : function(msg){
            this.$notify({
                title: this.title,
                message: msg,
                type: 'warning'
            });
        },
        fnNotifyInfo : function(msg){
            this.$notify.info({
                title: this.title,
                message: msg,
                type: 'info'
            });
        },
        fnNotifyError : function(msg){
            this.$notify.error({
                title: this.title,
                message: msg,
                type: 'error'
            });
        },
        fnConfirm : function(msg,verify,cancel){
            this.$confirm(msg,this.title,{
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
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
            msg = (msg == null || msg.length <= 0) ? '正在操作,请稍候……' : msg;
            this.loadIndex = this.$loading({
                lock: true,
                text: msg,
                spinner: 'el-icon-loading',
                background: 'rgba(0, 0, 0, 0.3)'
            });
        },
        loadClose : function(){
            if(this.loadIndex){
                this.loadIndex.close();
            }
        }
    }
});