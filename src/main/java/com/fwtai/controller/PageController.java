package com.fwtai.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import springfox.documentation.annotations.ApiIgnore;

/**
 * 页面跳转
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2020-05-15 18:01
 * @QQ号码 444141300
 * @Email service@dwlai.com
 * @官网 http://www.fwtai.com
*/
@Controller
@ApiIgnore
public class PageController{

    @GetMapping(value = "/index")
    public String index(){
        return "index";
    }

    //货位号管理
    @GetMapping(value = "/point")
    public String point(){
        return "point";
    }

    @GetMapping(value = "/page")
    public String websocket(){
        return "websocket";
    }

    @GetMapping(value = "/floor")
    public String floor(){
        return "floor";
    }

    @GetMapping(value = "/floorOld")
    public String floorOld(){
        return "floorOld";
    }

    @GetMapping(value = "/point1")
    public String point1(){
        return "point1";
    }

    // http://127.0.0.1:82/ichnography
    @GetMapping(value = "/ichnography")
    public String ichnography(){
        return "ichnography";
    }

    // http://127.0.0.1:82/component
    @GetMapping(value = "/component")
    public String component(){
        return "component";
    }

    @GetMapping(value = "/layerGrid")
    public String layerGrid(){
        return "layerGrid";
    }

    @GetMapping(value = "/floorArea")
    public String floorArea(){
        return "floorArea";
    }

    @GetMapping(value = "/camera")
    public String camera(){
        return "camera";
    }

    @GetMapping(value = "/humiture")
    public String humiture(){
        return "humiture";
    }

    @GetMapping(value = "/floorCode")
    public String floorCode(){
        return "floorCode";
    }
}