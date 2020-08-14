package com.fwtai.config;

import java.io.Serializable;

/**
 * 全局统一的配置变量及标识码-客户端和服务器端
 * @提示 code为200正常;msg的提示信息
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2017年1月11日 10:11:29
 * @QQ号码 444141300
 * @官网 http://www.fwtai.com
*/
public final class ConfigFile implements Serializable{

	private static final long serialVersionUID = 1L;

	/**自定义code及msg*/
	public final static int code198 = 198;
	/**操作失败*/
	public final static int code199 = 199;
	/**操作失败*/
	public final static String msg199 = "操作失败";
	/**操作成功*/
	public final static int code200 = 200;
	/**操作成功*/
	public final static String msg200 = "操作成功";
	/**暂无数据*/
	public final static int code201 = 201;
	/**暂无数据*/
	public final static String msg201 = "暂无数据";
    /**请求参数不完整*/
    public final static int code202 = 202;
    /**请求参数不完整*/
    public final static String msg202 = "请求参数不完整";
	public final static int code204 = 204;
	/**系统出现异常*/
	public final static String msg204 = "系统出现错误";
    /**没有操作权限*/
    public final static int code401 = 401;
    /**没有操作权限*/
    public final static String msg401 = "没有操作权限";
	/**统一全局的code的状态码json关键字key关键字响应给客户端*/
	public final static String code = "code";
	/**统一全局的msg提示消息json关键字key响应给客户端*/
	public final static String msg = "msg";
	/**统一全局的listData数据集合(含分页的数据)json关键字key响应给客户端*/
	public final static String data = "data";
	/**分页的默认大小*/
	public final static int size_default = 50;
    /**统一全局的total总条数|总记录数json关键字key响应给客户端*/
    public final static String total = "total";
    /**分页的区间标识符*/
    public final static String section = "section";
    /**统一全局的pageSize每页大小json关键字key响应给客户端或作为Mybatis的分页参数*/
    public final static String pageSize = "pageSize";
	/**拦截器表达式,配置不拦截的url资源,以括号(xxx)什么开头的都不拦截;即不对匹配该值的访问路径拦截（正则）*/
	public final static String expression = ".*/((app)|(weChat)|(api)).*";
}