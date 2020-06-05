package com.fwtai.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * swagger2配置,注意扫描的包名!!!
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2020/3/23 18:00
 * @QQ号码 444141300
 * @Email service@yinlz.com
 * @官网 <url>http://www.yinlz.com</url>
*/
@Configuration
@EnableSwagger2
public class Swagger2{

    //swagger2的配置文件,打开 http://127.0.0.1:82/swagger-ui.html
    @Bean
    public Docket docketV1(){// 创建API基本信息
        return docket("v1.0文档");
    }

    /*@Bean*/
    public Docket docketV2(){// 创建API基本信息
        return docket("v1.1文档");
    }

    private Docket docket(final String groupName){
        return new Docket(DocumentationType.SWAGGER_2).groupName(groupName)//多版本支持
          .apiInfo(apiInfo()).enable(true)//是否开启swagger
          .select()
          //扫描该包下的所有需要在Swagger中展示的API，@ApiIgnore注解标注的除外(若不想在swagger上面显示接口文档直接把扫描的包名改下即可)
          .apis(RequestHandlerSelectors.basePackage("com.fwtai.controller"))
          .paths(PathSelectors.any())
          .build();
    }

    private ApiInfo apiInfo(){
        return new ApiInfoBuilder()
            .title("省应急物资管理系统接口文档")
            .description("接口文档说明<br />返回统一json数据格式:<br/>返回正常且有效数据<br/>" + "{<br/>" + "    \"code\": 200,<br/>" + "    \"msg\": \"操作成功\"<br/>" + "}<br/>" + "其他情况<br/>" + "{<br/>" + "    \"code\": 202,<br/>" + "    \"msg\": \"请求参数不完整\"<br/>" + "},<br/>" + "{<br/>" + "    \"code\": 204,<br/>" + "    \"msg\": \"系统出现错误\"<br/>" + "}")//API描述
            .version("v1.0")//版本号
            .contact(new Contact("引路者","http://www.yinlz.com","444141300@qq.com"))
            .termsOfServiceUrl("http://www.yinlz.com")
            .license("保密版本")
            .licenseUrl("http://www.yinlz.com")
            .build();
    }
}