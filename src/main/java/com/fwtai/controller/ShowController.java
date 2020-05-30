package com.fwtai.controller;

import com.fwtai.bean.PageFormData;
import com.fwtai.service.ShowService;
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
@RequestMapping("/show")
public class ShowController{

    @Resource
    private HttpServletRequest request;

    @Resource
    private ShowService service;

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

    @GetMapping("getAllFloorMap")
    public void getAllFloorMap(final HttpServletResponse response){
        ToolClient.responseJson(service.getAllFloorMap(),response);
    }
}