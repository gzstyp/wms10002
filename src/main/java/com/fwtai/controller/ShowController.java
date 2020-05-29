package com.fwtai.controller;

import com.fwtai.bean.PageFormData;
import com.fwtai.service.ShowService;
import com.fwtai.tool.ToolClient;
import io.swagger.annotations.Api;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

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

    @PostMapping("/imageInfo")
    public final void photo(final HttpServletRequest request,final HttpServletResponse response){
        try {
            final PageFormData formData = new PageFormData(request);
            MultipartHttpServletRequest mhsr = null;
            try {
                mhsr =  (MultipartHttpServletRequest) request;
            } catch (Exception e) {
                System.out.println("请上传照片1");
            }
            if(mhsr == null){
                System.out.println("未上传照片2");
            }
            final DiskFileItemFactory fac = new DiskFileItemFactory();
            final ServletFileUpload upload = new ServletFileUpload(fac);
            String originalPath = null;
            upload.setHeaderEncoding("utf-8");
            mhsr.setCharacterEncoding("utf-8");
            final String sys = File.separator;
            String dirType = sys;
            ToolClient.responseJson(ToolClient.createJsonSuccess("上传成功"),response);
        } catch (Exception e) {
            ToolClient.responseJson(ToolClient.exceptionJson(),response);
        }
    }
}