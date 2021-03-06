package com.fwtai.websocket;

import com.fwtai.service.TaskService;
import com.fwtai.tool.ToolClient;
import com.fwtai.tool.ToolString;
import org.apache.commons.lang3.StringUtils;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

//客户端连接WebSocket服务端,Nginx不支持WebSocket,需要配置或直接连接到项目服务本身
@ServerEndpoint("/imserver/{userId}")
@Component
@EnableScheduling
public class WebSocketServer{

    /**
     * 静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
     */
    private static int onlineCount = 0;

    /**
     * concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。
    */
    public static ConcurrentHashMap<String,WebSocketServer> webSocketMap = new ConcurrentHashMap<>();

    /**
     * 与某个客户端的连接会话，需要通过它来给客户端发送数据
    */
    private Session session;

    /**
     * 接收userId
    */
    private String userId;

    /**
     * 连接建立成功调用的方法
    */
    @OnOpen
    public void onOpen(final Session session,@PathParam("userId") String userId){
        this.session = session;
        this.userId = userId;
        if(webSocketMap.containsKey(userId)){
            webSocketMap.remove(userId);
            webSocketMap.put(userId,this);
            //加入set中
        }else{
            webSocketMap.put(userId,this);
            //加入set中
            addOnlineCount();
            //在线数加1
        }
        System.out.println("当前连接用户:" + userId + ",当前在线人数为:" + getOnlineCount());
        try{
            final TaskService authService =  (TaskService) SpringUtil.getBean("taskService");
            final List<HashMap<String,Object>> hashMaps = authService.queryListTask();
            final String json = ToolClient.queryJson(hashMaps);
            sendMsg(json);
        }catch(IOException e){
            System.out.println("用户:" + userId + ",网络异常!!!!!!");
        }
    }

    /**
     * 连接关闭调用的方法
    */
    @OnClose
    public void onClose(){
        if(webSocketMap.containsKey(userId)){
            webSocketMap.remove(userId);
            //从set中删除
            subOnlineCount();
        }
        System.out.println("用户"+userId+"退出,当前在线人数为:" + getOnlineCount());
    }

    /**
     * 收到客户端消息后调用的方法
     * @param message 客户端发送过来的消息
    */
    @OnMessage
    public void onMessage(final String message,Session session){
        System.out.println("用户" + userId + "消息,报文:" + message);
        //可以群发消息
        //消息保存到数据库、redis
        if(StringUtils.isNotBlank(message)){
            try{
                //解析发送的报文
                final HashMap<String,String> map = ToolString.parseJsonObject(message);
                if(map == null || map.size() <= 0)return;
                //追加发送人(防止串改)
                map.put("fromUserId",this.userId);
                String toUserId = map.get("toUserId");
                //传送给对应toUserId用户的websocket
                if(StringUtils.isNotBlank(toUserId) && webSocketMap.containsKey(toUserId)){
                    webSocketMap.get(toUserId).sendMsg(ToolClient.queryJson(map));
                }else{
                    System.err.println("请求的userId:" + toUserId + "不在该服务器上");
                    //否则不在这个服务器上，发送到mysql或者redis
                }
            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }

    /**
     * @param session
     * @param error
    */
    @OnError
    public void onError(final Session session,final Throwable error){
        System.err.println("用户错误:" + this.userId + ",原因:" + error.getMessage());
        error.printStackTrace();
    }

    /**
     * 实现服务器主动推送
    */
    public void sendMsg(final String message) throws IOException{
        this.session.getBasicRemote().sendText(message);
    }

    /**
     * 发送自定义消息
    */
    public static void sendInfo(final String message,@PathParam("userId") String userId) throws IOException{
        System.out.println("发送消息到:" + userId + "，报文:" + message);
        if(StringUtils.isNotBlank(userId) && webSocketMap.containsKey(userId)){
            webSocketMap.get(userId).sendMsg(message);
        }else{
            System.err.println("用户" + userId + ",不在线！");
        }
    }

    //@Scheduled(fixedDelay = 10000)
    public void sendMessages(){
        if(webSocketMap.size() > 0){
            for(final String key : webSocketMap.keySet()){
                try{
                    webSocketMap.get(key).sendMsg("你有新的消息");
                }catch(IOException e){
                    e.printStackTrace();
                }
            }
        }
    }

    public static synchronized int getOnlineCount(){
        return onlineCount;
    }

    public static synchronized void addOnlineCount(){
        WebSocketServer.onlineCount++;
    }

    public static synchronized void subOnlineCount(){
        WebSocketServer.onlineCount--;
    }

    /**
     * 发送自定义消息指定到userId
    */
    public void sendMessage(final String message,final String userId) throws IOException{
        if(StringUtils.isNotBlank(userId) && webSocketMap.containsKey(userId)){
            webSocketMap.get(userId).sendMsg(message);
        }
    }
}