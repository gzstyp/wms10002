package com.fwtai.controller;

import com.fwtai.bean.PageFormData;
import com.fwtai.service.FloorCameraService;
import com.fwtai.tool.ToolClient;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 楼层摄像头
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2020/5/28 10:22
 * @QQ号码 444141300
 * @Email service@yinlz.com
 * @官网 <url>http://www.yinlz.com</url>
*/
@RestController
@CrossOrigin
@RequestMapping("/floorCamera")
public class FloorCameraController{

    @Resource
    private FloorCameraService service;

    @PostMapping("add")
    public void add(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.add(new PageFormData().build(request)),response);
    }

    @PostMapping("edit")
    public void edit(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.edit(new PageFormData().build(request)),response);
    }

    @PostMapping("delById")
    public void delById(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.delById(new PageFormData().build(request)),response);
    }

    @PostMapping("delByKeys")
    public void delByKeys(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.delByKeys(new PageFormData().build(request)),response);
    }

    @GetMapping("listData")
    public void listData(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.listData(new PageFormData(request)),response);
    }

    @GetMapping("getAllFloor")
    public void getAllFloor(final HttpServletResponse response){
        ToolClient.responseJson(service.getAllFloor(),response);
    }

    //获取指定区域的监控摄像头 http://127.0.0.1:10000/floorCamera/getFloorCamera?code=02-1A&kid=ffffffffdc2ebe6a000000006b149e18
    @GetMapping("getFloorCamera")
    public void getFloorCamera(final String code,final String kid,final HttpServletResponse response){
        ToolClient.responseJson(service.getFloorCamera(code,kid),response);
    }
}