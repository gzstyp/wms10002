package com.fwtai.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fwtai.entity.Task;
import com.fwtai.entity.TaskStatus;
import com.fwtai.service.TaskService;
import com.fwtai.tool.ToolClient;
import com.fwtai.tool.ToolString;
import com.fwtai.websocket.WebSocketServer;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import springfox.documentation.annotations.ApiIgnore;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

@RestController
@CrossOrigin
@Api(tags = "出入库接口文档")
@RequestMapping("/wms")
public class WmsController{

    @Resource
    private TaskService taskService;

    @Resource
    private WebSocketServer webSocketServer;

    //确认操作某个任务,如果当前正在操作任务,那不接收或忽略接收任务
    @PostMapping("/confirm")
    @ApiOperation(value = "确认操作某个任务", notes = "如果当前正在操作任务；那不接收或忽略接收任务；<br/>在返回的数据中list里的falg的值为1说明已有人接任务且userId不为空，即userId就是接任务的人，此时才做业务处理")
    @ApiImplicitParams(
        {
            @ApiImplicitParam(name = "kid", value = "当前要执行的任务kid", paramType = "query", dataType = "string",required = true),
            @ApiImplicitParam(name = "userId", value = "当前要执行任务人的useId", paramType = "query", dataType = "string",required = true)
        }
    )
    public final void confirm(final String kid,final String userId,final HttpServletResponse response) throws IOException{
        final Integer result = taskService.confirm(kid,userId);
        if(result == 1){
            final List<HashMap<String,Object>> listTask = taskService.queryListTask();//有人确认接任务后重新获取任务列表
            final ConcurrentHashMap<String,WebSocketServer> map = WebSocketServer.webSocketMap;
            for(final String key : map.keySet()){
                final HashMap<String,Object> _map = new HashMap<>();
                if(key.equals(userId)){
                    _map.put("userId",key);
                    _map.put("list",listTask);
                    final String json = ToolClient.queryJson(listTask);
                    webSocketServer.sendMessage(json,key);
                }else{
                    _map.put("list",listTask);
                    final String json = ToolClient.queryJson(listTask);
                    webSocketServer.sendMessage(json,key);
                }
            }
            final String json = ToolClient.createJsonSuccess("操作成功");
            ToolClient.responseJson(json,response);
        }else if(result == 2){
            final String json = ToolClient.createJsonFail("任务已被Ta人抢先执行");
            ToolClient.responseJson(json,response);
        }else if(result == 3){
            final String json = ToolClient.createJsonFail("选择的任务不存在");
            ToolClient.responseJson(json,response);
        }else if(result == 4){
            final String json = ToolClient.jsonValidateField();
            ToolClient.responseJson(json,response);
        } else{
            final String json = ToolClient.createJsonFail("操作失败");
            ToolClient.responseJson(json,response);
        }
    }

    /**
     * 根据用户key发送消息
     * @return
     * @throws Exception
    */
    @ApiOperation(value = "接收任务指令", notes = "接收任务指令,格式为josn格式")
    @PostMapping("/gateway")
    public void gateway(@RequestBody Task task,final HttpServletResponse response){
        final String jsonStr = JSONObject.toJSONString(task);
        final JSONObject jsonObject = ToolString.parseJsonObj(jsonStr);
        final String p_invoices_code = "invoices_code";
        final String p_type = "type";
        final String p_total = "total";
        final String p_status = "status";
        final String p_data = "data";
        final String validateField = ToolClient.validateField(jsonObject,p_invoices_code,p_type,p_total,p_status,p_data);
        if(validateField != null){
            ToolClient.responseJson(validateField,response);
            return;
        }
        final String validateInteger = ToolClient.validateInteger(jsonObject,p_type,p_total,p_status);
        if(validateInteger != null){
            ToolClient.responseJson(validateInteger,response);
            return;
        }
        final String data = jsonObject.getString(p_data);
        final ArrayList<HashMap<String,String>> list = ToolString.parseJsonArrayOriginal(data);
        if(list == null || list.size() <= 0){
            final String json = ToolClient.jsonValidateField();
            ToolClient.responseJson(json,response);
            return;
        }
        boolean b = false;
        for(int i = 0; i < list.size(); i++){
            final HashMap<String,String> map = list.get(i);
            if( !map.containsKey("item_code") || !map.containsKey("item_name") || !map.containsKey("item_total") || !map.containsKey("item_storage_code")){
                b = true;
                break;
            }
        }
        if(b){
            final String json = ToolClient.jsonValidateField();
            ToolClient.responseJson(json,response);
            return;
        }
        final Integer row = taskService.insert(jsonObject);
        if(row != 0){
            final String json = ToolClient.queryJson(taskService.queryListTask());//收到指令任务时获取任务列表
            final ConcurrentHashMap<String,WebSocketServer> map = WebSocketServer.webSocketMap;
            for(final String userId : map.keySet()){
                try{
                    webSocketServer.sendMessage(String.valueOf(json),userId);
                }catch(IOException e){}
            }
            final String result = ToolClient.createJsonSuccess("操作成功");
            ToolClient.responseJson(result,response);
        }else{
            final String result = ToolClient.createJsonFail("操作失败");
            ToolClient.responseJson(result,response);
        }
    }

    @ApiOperation(value = "客户端连接服务端成功后获取未完成的任务指令", notes = "连接成功后获取未完成的任务指令列表")
    @GetMapping("/getTask")
    @ApiIgnore
    public void getTask(final HttpServletResponse response){
        final String json = ToolClient.queryJson(taskService.queryListTask());//收到指令任务时获取任务列表
        ToolClient.responseJson(json,response);
    }

    //更新任务状态
    @ApiOperation(value = "更新任务", notes = "参数为json数组,即List< Bean >,返回的json格式")
    @PostMapping("/status")
    public void status(@RequestBody final List<TaskStatus> taskStatus,final HttpServletResponse response){

        final String jsonStr = JSONObject.toJSONString(taskStatus);
        final JSONArray jsonArray = ToolString.parseJsonArray(jsonStr);
        final String string=taskService.status(jsonArray);
        final ConcurrentHashMap<String,WebSocketServer> map = WebSocketServer.webSocketMap;
        final List<HashMap<String,Object>> listTask = taskService.queryListTask();
        for(final String userId : map.keySet()){
            try{
                final String json = ToolClient.queryJson(listTask);
                webSocketServer.sendMessage(json,userId);
            }catch(IOException e){}
        }

        ToolClient.responseJson(string,response);
    }
}
