package com.fwtai.controller;

import com.fwtai.bean.PageFormData;
import com.fwtai.service.FloorCodeService;
import com.fwtai.tool.ToolClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 楼层仓库编码控制层|路由层
 * @作者 田应平
 * @版本 v1.0
 * @QQ号码 444141300
 * @创建日期 2021-01-22 22:06:05
 * @官网 <url>http://www.yinlz.com</url>
*/
@RestController
@RequestMapping("/foorCode")
public class FloorCodeController{

    @Resource
	private FloorCodeService floorcodeService;

    /**添加*/
    @PostMapping("/add")
    public void add(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(floorcodeService.add(request),response);
    }

    /**编辑*/
    @PostMapping("/edit")
    public void edit(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(floorcodeService.edit(request),response);
    }

    /**删除-单行*/
    @PostMapping("/delById")
    public void delById(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(floorcodeService.delById(new PageFormData(request)),response);
    }

    /**批量删除*/
    @PostMapping("/delByKeys")
    public void delByKeys(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(floorcodeService.delByKeys(new PageFormData(request)),response);
    }

    /**获取数据*/
    @GetMapping("/listData")
    public void listData(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(floorcodeService.listData(new PageFormData(request)),response);
    }
}