package com.fwtai.controller;

import com.fwtai.bean.PageFormData;
import com.fwtai.service.IchnographyService;
import com.fwtai.tool.ToolClient;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

/**
 * 大屏显示处理
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2020/5/28 10:22
 * @QQ号码 444141300
 * @Email service@yinlz.com
 * @官网 <url>http://www.yinlz.com</url>
*/
@RestController
@CrossOrigin
@Api(tags = "出入库接口文档")
@RequestMapping("/ichnography")
public class IchnographyController{

    @Resource
    private HttpServletRequest request;

    @Resource
    private IchnographyService service;

    @PostMapping("add")
    public void add(final HttpServletResponse response){
        ToolClient.responseJson(service.add(new PageFormData().build(request)),response);
    }

    @PostMapping("delById")
    public void delById(final HttpServletResponse response){
        ToolClient.responseJson(service.delById(new PageFormData().build(request)),response);
    }

    @PostMapping("delByKeys")
    public void delByKeys(final HttpServletResponse response){
        ToolClient.responseJson(service.delByKeys(new PageFormData().build(request)),response);
    }

    @PostMapping("edit")
    public void edit(final HttpServletResponse response){
        ToolClient.responseJson(service.edit(new PageFormData().build(request)),response);
    }

    @GetMapping("listData")
    public void listData(final HttpServletResponse response){
        ToolClient.responseJson(service.listData(new PageFormData(request)),response);
    }

    @PostMapping("/imageInfo")//封装文件上传,指定上传的目录,返回值HashMap<String,Object>,files,params
    public final void photo(final HttpServletRequest request,final HttpServletResponse response){
        try {
            final PageFormData formData = new PageFormData(request);
            final HashMap<String,Object> map = ToolClient.uploadImage(request,"C:\\20200527\\",null);
            if(map.containsKey("error")){
                final String error = String.valueOf(map.get("error"));
                ToolClient.responseJson(ToolClient.createJsonFail(error),response);
                return;
            }
            ToolClient.responseJson(ToolClient.createJsonSuccess("上传成功"),response);
        } catch (Exception e) {
            ToolClient.responseJson(ToolClient.exceptionJson(),response);
        }
    }
}