package com.fwtai.controller;

import com.fwtai.bean.PageFormData;
import com.fwtai.service.DateViewService;
import com.fwtai.tool.ToolClient;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@CrossOrigin
@RequestMapping("/dataView")
public class DateViewController{

    @Resource
    private DateViewService dateViewService;

    @GetMapping("getFloorArea")
    public void getFloorArea(final HttpServletResponse response){
        ToolClient.responseJson(dateViewService.getFloorArea(),response);
    }

    @GetMapping("getLayerGrid")
    public void getLayerGrid(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(dateViewService.getLayerGrid(new PageFormData(request)),response);
    }
}