<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    final String path = request.getContextPath();
    final String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <base href="<%=basePath%>">
    <title>仓库货位号管理</title>
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link href="/webjars/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
    <script src="/layer/layer.js"></script>
    <script src="/js/page.layer.js"></script>
</head>
<body>
<div id="main-content" class="container">
    <div class="row"  style="margin-top:22px;">
        <div class="col-md-1">
            <label for="item_storage_code" style="margin-top:6px;">货位号</label>
        </div>
        <div class="col-md-11">
            <input type="text" id="item_storage_code" class="form-control" placeholder="输入货位号">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <label style="margin-top:8px;">坐标</label>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3">
            <input type="text" class="form-control" id="x1" placeholder="坐标x1的值">
        </div>
        <div class="col-md-3">
            <input type="text" class="form-control" id="y1" placeholder="坐标y1的值">
        </div>
        <div class="col-md-3">
            <input type="text" class="form-control" id="x2" placeholder="坐标x2的值">
        </div>
        <div class="col-md-3">
            <input type="text" class="form-control" id="y2" placeholder="坐标y2的值">
        </div>
    </div>
    <div class="row" style="margin-top:14px;">
        <div class="col-md-12">
            <button id="btnAdd" class=" col-md-12 btn btn-primary">添加</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table id="conversation" class="table table-striped">
                <thead>
                <tr>
                    <th>编号</th>
                    <th>货位信息</th>
                    <th>坐标信息</th>
                    <th>添加时间</th>
                </tr>
                </thead>
                <tbody id="storagePoint">
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <label id="total">共计:0</label>
        </div>
    </div>
    </form>
</div>

<script type="text/javascript">
    ;(function($){
        var thisPage = {
            init:function(){
                this.initDom();
                $("#btnAdd").on('click',function(){
                    thisPage.addSubmit();
                });
            },
            initDom:function(){
                thisPage.getListData();
            },
            getListData : function(){
                ajaxGet('/storage/getListData',{},function(data){
                    if(data.code === 200){
                        thisPage.initHtml(data.data);
                    }
                },function(error){
                    $('#total').html('连接服务器失败');
                });
            },
            initHtml : function(list){
                var html = '';
                $("#storagePoint").html(html);
                $.each(list,function(index,data){
                    var point = data.point.replace(/"/g,"");
                    html += "<tr><td>" + (index+1) + "</td><td>" + data.item_storage_code + "</td><td>" + point + "</td><td>" + data.gmt_create + "</td></tr>";
                });
                $("#storagePoint").html(html);
                $('#total').html('共计:'+list.length+'条');
            },
            addSubmit : function(){
                var storage_code = $('#item_storage_code').val();
                var x1 = $('#x1').val();
                var y1 = $('#y1').val();
                var x2 = $('#x2').val();
                var y2 = $('#y2').val();
                if(storage_code == null || storage_code.length == 0){
                    layer.alert('请输入货位号');
                    return;
                }
                if(x1 == null || x1.length == 0){
                    layer.alert('请输入坐标x1的值');
                    return;
                }
                if(y1 == null || y1.length == 0){
                    layer.alert('请输入坐标y1的值');
                    return;
                }
                if(x2 == null || x2.length == 0){
                    layer.alert('请输入坐标x2的值');
                    return;
                }
                if(y2 == null || y2.length == 0){
                    layer.alert('请输入坐标y2的值');
                    return;
                }
                var params = {};
                params['x1']=x1;
                params['y1']=y1;
                params['x2']=x2;
                params['y2']=y2;
                var json = JSON.stringify(params);
                var param = {
                    item_storage_code : storage_code,
                    point : json
                };
                thisPage.btnText("正在提交……",false);
                ajaxPost('/storage/addPoint',param,function(data){
                    thisPage.btnText("添加",true);
                    if(data.code === 200){
                        result(data.msg,1500);
                        thisPage.getListData();
                        resetForm();
                    }else{
                        layer.alert(data.msg);
                    }
                },function(err){
                    thisPage.btnText("添加",true);
                });
            },
            btnText : function(text,bl){
                if(bl){
                    $("#btnAdd").removeAttr("disabled");
                }else{
                    $("#btnAdd").prop("disabled",bl);
                }
                $("#btnAdd").text(text);
            },
        };
        thisPage.init();
        function resetForm(){
            $('#x1').val('');
            $('#y1').val('');
            $('#x2').val('');
            $('#y2').val('');
        }
    })(jQuery);
</script>
</body>
</html>