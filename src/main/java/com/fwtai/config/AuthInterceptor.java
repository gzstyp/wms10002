package com.fwtai.config;

import com.fwtai.tool.ToolClient;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.resource.ResourceHttpRequestHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 菜单|权限拦截器[认证和权限拦截应该分开,各执其职]
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2020-02-23 18:22
 * @QQ号码 444141300
 * @Email service@yinlz.com
 * @官网 <url>http://www.yinlz.com</url>
*/
public final class AuthInterceptor implements HandlerInterceptor{

    @Override
    public boolean preHandle(final HttpServletRequest request,final HttpServletResponse response,final Object handler) throws Exception{
        if(handler instanceof ResourceHttpRequestHandler){return true;}
        final String accessToken = request.getHeader("accessToken");
        final String refreshToken = request.getHeader("refreshToken");
        if(accessToken == null || refreshToken == null || accessToken.length() <= 0 || refreshToken.length() <= 0){
            this.response(response);
            return false;
        }
        return true;
    }

    @Override
    public void afterCompletion(final HttpServletRequest request,final HttpServletResponse response,final Object handler,final Exception exception) throws Exception{
    }

    private final void response(final HttpServletResponse response){
        ToolClient.responseJson(ToolClient.notAuthorized(),response);
    }
}