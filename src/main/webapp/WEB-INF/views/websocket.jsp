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
    <link href="/webjars/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
    <script src="/layer/layer.js"></script>
</head>
<script>
    var socket;
    function openSocket() {
        if(typeof(WebSocket) == "undefined") {
            alert("您的浏览器不支持WebSocket");
        }else{
            //实现化WebSocket对象，指定要连接的服务器地址与端口  建立连接
            //等同于socket = new WebSocket("ws://localhost:8888/xxxx/im/25");
            var socketUrl = "<%=basePath%>imserver/"+$("#userId").val();//连接WebSocket服务端
            socketUrl=socketUrl.replace("https","ws").replace("http","ws");
            if(socket!=null){
                socket.close();
                socket = null;
            }
            socket = new WebSocket(socketUrl);
            //打开事件
            socket.onopen = function(){
                //socket.send("这是来自客户端的消息" + location.href + new Date());
            };
            //获得消息事件
            socket.onmessage = function(msg){
                //发现消息进入    开始处理前端触发逻辑
                showGreeting(msg.data);
            };
            //关闭事件
            socket.onclose = function() {
                console.log("websocket已断开");
            };
            //发生了错误事件
            socket.onerror = function() {
                console.log("websocket发生了错误");
            }
        }
    }
    function showGreeting(message) {
        $("#greetings").append("<tr><td>" + message + "</td></tr>");
    }
    function sendMessage() {
        if(typeof(WebSocket) == "undefined") {
            layer.alert("您的浏览器不支持WebSocket");
        }else {
            if(socket == null || socket.length <= 0){
                layer.alert('请先开启socket');
                return;
            }
            socket.send('{"toUserId":"'+$("#toUserId").val()+'","contentText":"'+$("#contentText").val()+'"}');
        }
    }
</script>
<body>
<div id="main-content" class="container">
    <div class="row"  style="margin-top:22px;">
        <div class="row" style="margin-top:22px;">
            <div class="col-md-2">
                <label for="userId" style="margin-top:6px;">当前的userId</label>
            </div>
            <div class="col-md-10">
                <input id="userId" name="userId" type="text" value="10" class="form-control" placeholder="当前的userId">
            </div>
        </div>
        <div class="row" style="margin-top:22px;">
            <div class="col-md-2">
                <label for="toUserId" style="margin-top:6px;">发送到userId</label>
            </div>
            <div class="col-md-10">
                <input id="toUserId" name="toUserId" type="text" value="20" class="form-control" placeholder="发送到指定userId">
            </div>
        </div>
        <div class="row" style="margin-top:22px;">
            <div class="col-md-2">
                <label for="contentText" style="margin-top:6px;">发送内容</label>
            </div>
            <div class="col-md-10">
                <input id="contentText" name="contentText" type="text" value="hello websocket" class="form-control" placeholder="请输入消息内容">
            </div>
        </div>
        <div class="row" style="margin-top:22px;">
            <div class="col-md-6">
                <a onclick="openSocket()" class="col-md-12 btn btn-default">开启socket</a>
            </div>
            <div class="col-md-6">
                <a onclick="sendMessage()" class="col-md-12 btn btn-success">发送消息</a>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table id="conversation" class="table table-striped">
                    <thead>
                    <tr>
                        <th>消息信息</th>
                    </tr>
                    </thead>
                    <tbody id="greetings">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>