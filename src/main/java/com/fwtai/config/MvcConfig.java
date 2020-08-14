package com.fwtai.config;

import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.Arrays;

//@SpringBootConfiguration
public class MvcConfig implements WebMvcConfigurer{

    //静态资源配置2,优先级比 implements HandlerInterceptor 和 extends HandlerInterceptorAdapter
    @Override
    public void addInterceptors(final InterceptorRegistry registry){
        final String[] array = {"/error","/","/index","/login","/user/login","/user/logout"};
        //权限拦截器
        registry.addInterceptor(new AuthInterceptor()).addPathPatterns("/**").excludePathPatterns(Arrays.asList(array));
    }
}