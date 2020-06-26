package com.fwtai.controller;

import com.fwtai.bean.PageFormData;
import com.fwtai.service.StoragePointService;
import com.fwtai.tool.ToolClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import springfox.documentation.annotations.ApiIgnore;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 仓库货位号管理
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2020-05-14 14:34
 * @QQ号码 444141300
 * @Email service@yinlz.com
 * @官网 <url>http://www.yinlz.com</url>
*/
@RestController
@RequestMapping("storage")
@ApiIgnore
public class StoragePointController{

    @Resource
    private StoragePointService service;

    //添加货位对应的坐标
    @PostMapping("addPoint")
    public void addPoint(final HttpServletRequest request,final HttpServletResponse response){
        final PageFormData formData = new PageFormData(request);
        final String json = service.addStoragePoint(formData);
        ToolClient.responseJson(json,response);
    }

    @GetMapping("getListData")
    public final void getListData(final HttpServletResponse response){
        final String json = service.getListData();
        ToolClient.responseJson(json,response);
    }

    @GetMapping("listData")
    public void listData(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.listData(new PageFormData(request)),response);
    }

    @PostMapping(value = "/add")
    public final void add(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.add(new PageFormData().build(request)),response);
    }

    @PostMapping(value = "/edit")
    public final void edit(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.edit(new PageFormData().build(request)),response);
    }

    @PostMapping(value = "/delById")
    public final void delById(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.delById(new PageFormData().build(request)),response);
    }

    @PostMapping(value = "/delByKeys")
    public final void delByKeys(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.delByKeys(new PageFormData().build(request)),response);
    }
}