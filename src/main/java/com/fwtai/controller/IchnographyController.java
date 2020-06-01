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
import springfox.documentation.annotations.ApiIgnore;

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
@Api(tags = "平面图货位信息")
@RequestMapping("/ichnography")
@ApiIgnore
public class IchnographyController{

    @Resource
    private IchnographyService service;

    @PostMapping("add")//在提交表单若有文件上传时,不能用注解的 HttpServletRequest,否则获取不到文件!!!
    public void add(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.add(request),response);
    }

    @PostMapping("edit")//在提交表单若有文件上传时,不能用注解的 HttpServletRequest,否则获取不到文件!!!
    public void edit(final HttpServletRequest request,final HttpServletResponse response){
        ToolClient.responseJson(service.edit(request),response);
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
}