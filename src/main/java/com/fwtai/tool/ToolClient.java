package com.fwtai.tool;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fwtai.bean.PageFormData;
import com.fwtai.config.ConfigFile;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 客户端请求|服务器端响应工具类
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2017年1月11日 19:20:50
 * @QQ号码 444141300
 * @主页 http://www.fwtai.com
*/
public final class ToolClient implements Serializable{

	private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(ToolClient.class);

	/**
	 * 生成简单类型json字符串,仅用于查询返回,客户端只需判断code是否为200才操作,仅用于查询操作,除了list集合之外都可以用data.map获取数据,list的是data.listData,字符串或数字对应是obj
	 * @作者 田应平
	 * @注意 如果传递的是List则在客户端解析listData的key值,即data.listData;是map或HashMap或PageFormData解析map的key值,即data.map;否则解析obj的key值即data.obj或data.map
	 * @用法 解析后判断data.code == AppKey.code.code200 即可
	 * @返回值类型 返回的是json字符串,内部采用JSONObject封装,不可用于redis缓存value
	 * @创建时间 2017年1月11日 上午10:27:53
	 * @QQ号码 444141300
	 * @主页 http://www.fwtai.com
	*/
	public final static String queryJson(final Object object){
        if(object == null || object.toString().trim().length() <= 0){
            return queryEmpty();
        }
        final JSONObject json = new JSONObject();
        if (object instanceof Exception) {
            json.put(ConfigFile.code,ConfigFile.code204);
            json.put(ConfigFile.msg,ConfigFile.msg204);
            json.put(ConfigFile.data,object);
            return json.toJSONString();
        }
        if(object instanceof Map<?,?>){
            final Map<?,?> map = (Map<?,?>) object;
            if(map == null || map.size() <= 0){
                queryEmpty();
            }else {
                json.put(ConfigFile.code,ConfigFile.code200);
                json.put(ConfigFile.msg,ConfigFile.msg200);
                json.put(ConfigFile.data,object);
                return json.toJSONString();
            }
        }
        if(object instanceof List<?>){
            final List<?> list = (List<?>) object;
            if(list == null || list.size() <= 0){
                return queryEmpty();
            }else {
                if (list.get(0) == null){
                    return queryEmpty();
                }else {
                    json.put(ConfigFile.code,ConfigFile.code200);
                    json.put(ConfigFile.msg,ConfigFile.msg200);
                    json.put(ConfigFile.data,object);
                    final String jsonObj = json.toJSONString();
                    final JSONObject j = JSONObject.parseObject(jsonObj);
                    final String listData = j.getString(ConfigFile.data);
                    if (listData.equals("[{}]")){
                        return queryEmpty();
                    }
                    return jsonObj;
                }
            }
        }
        if(String.valueOf(object).toLowerCase().equals("null") || String.valueOf(object).replaceAll("\\s*", "").length() == 0){
            return queryEmpty();
        }else {
            json.put(ConfigFile.code,ConfigFile.code200);
            json.put(ConfigFile.msg,ConfigFile.msg200);
            json.put(ConfigFile.data,object);
            final String jsonObj = json.toJSONString();
            final JSONObject j = JSONObject.parseObject(jsonObj);
            final String obj = j.getString(ConfigFile.data);
            if (obj.equals("{}")){
                return queryEmpty();
            }
            return jsonObj;
        }
	}

	/**
	 * 查询时得到的数据为空返回的json字符串
	 * @作者 田应平
	 * @返回值类型 String
	 * @创建时间 2017年1月11日 下午9:40:21
	 * @QQ号码 444141300
	 * @主页 http://www.fwtai.com
	*/
	private static final String queryEmpty(){
		final JSONObject json = new JSONObject();
		json.put(ConfigFile.code,ConfigFile.code201);
		json.put(ConfigFile.msg,ConfigFile.msg201);
		return json.toJSONString();
	}

	/**
	 * 生成json字符串对象,直接采用JSONObject封装,执行效率会更高;适用于为增、删、改操作时,判断当前的rows是否大于0来确定是否操作成功,一般在service调用,偷懒的人可以使用本方法
	 * @param rows 执行后受影响的行数
	 * @用法 解析后判断data.code == AppKey.code.code200即可操作
	 * @作者 田应平
	 * @创建时间 2016年12月25日 下午5:44:23
	 * @QQ号码 444141300
	 * @官网 http://www.fwtai.com
	*/
	public static final String executeRows(final int rows){
		final JSONObject json = new JSONObject();
		if(rows > 0){
			json.put(ConfigFile.code,ConfigFile.code200);
			json.put(ConfigFile.msg,ConfigFile.msg200);
			json.put(ConfigFile.data,rows);
			return json.toJSONString();
		}else{
			json.put(ConfigFile.code,ConfigFile.code199);
			json.put(ConfigFile.msg,ConfigFile.msg199);
			json.put(ConfigFile.data,rows);
			return json.toJSONString();
		}
	}

    /**
     * 操作成功生成json字符串对象,失败信息是ConfigFile.msg199,直接采用JSONObject封装,执行效率会更高;适用于为增、删、改操作,一般在service调用
     * @param
     * @作者 田应平
     * @QQ 444141300
     * @创建时间 2020/1/19 11:31
    */
    public static final String executeRows(final int rows,final String success){
        final JSONObject json = new JSONObject();
        if(rows > 0){
            json.put(ConfigFile.code,ConfigFile.code200);
            json.put(ConfigFile.msg,success);
            json.put(ConfigFile.data,rows);
            return json.toJSONString();
        }else{
            json.put(ConfigFile.code,ConfigFile.code199);
            json.put(ConfigFile.msg,ConfigFile.msg199);
            json.put(ConfigFile.data,rows);
            return json.toJSONString();
        }
    }

	/**
	 * 生成自定义的json对象,直接采用JSONObject封装,执行效率会更高;适用于为增、删、改操作,一般在service调用
	 * @param rows 执行后受影响的行数
	 * @param success 执行成功的提示消息
	 * @param failure 执行失败的提示消息
	 * @作者 田应平
	 * @创建时间 2016年12月25日 下午5:50:22
	 * @QQ号码 444141300
	 * @官网 http://www.fwtai.com
	*/
	public static final String executeRows(final int rows,final String success,final String failure){
		final JSONObject json = new JSONObject();
		if(rows > 0){
			json.put(ConfigFile.code,ConfigFile.code200);
			json.put(ConfigFile.msg,success);
			json.put(ConfigFile.data,rows);
			return json.toJSONString();
		}else{
			json.put(ConfigFile.code,ConfigFile.code199);
			json.put(ConfigFile.msg,failure);
			json.put(ConfigFile.data,rows);
			return json.toJSONString();
		}
	}

	/**
	 * 生成json格式字符串,code和msg的key是固定的,直接采用JSONObject封装,执行效率会更高,用于增、删、改、查操作,一般在service层调用
	 * @作者 田应平
	 * @返回值类型 返回的是json字符串,内部采用JSONObject封装
	 * @用法 解析后判断data.code == AppKey.code.code200即可处理操作
	 * @创建时间 2016年12月25日 18:11:16
	 * @QQ号码 444141300
	 * @param code 相关参数协议
	 * @主页 http://www.fwtai.com
	*/
	public static final String createJson(final int code,final String msg){
		final JSONObject json = new JSONObject();
		json.put(ConfigFile.code,code);
		json.put(ConfigFile.msg,msg);
		return json.toJSONString();
	}

    /**
     * 生成json格式字符串,直接采用JSONObject封装,执行效率会更高,用于增、删、改、查操作,一般在service层调用
     * @作者 田应平
     * @返回值类型 返回的是json字符串,内部采用JSONObject封装
     * @用法 解析后判断data.code == AppKey.code.code200即可处理操作
     * @创建时间 2018年7月3日 09:20:05
     * @QQ号码 444141300
     * @param code 相关参数协议
     * @主页 http://www.fwtai.com
    */
    public static final String createJson(final String code,final String msg){
        final JSONObject json = new JSONObject();
        json.put(ConfigFile.code,code);
        json.put(ConfigFile.msg,msg);
        return json.toJSONString();
    }

    /**
     * 生成code为199的json格式数据且msg是提示信息
     * @param 
     * @作者 田应平
     * @QQ 444141300
     * @创建时间 2019/7/29 15:00
    */
    public final static String createJsonFail(final String msg){
        final JSONObject json = new JSONObject();
        json.put(ConfigFile.code,ConfigFile.code199);
        json.put(ConfigFile.msg,msg);
        return json.toJSONString();
    }

    /**
     * 生成code为200的json格式数据且msg是提示信息
     * @param 
     * @作者 田应平
     * @QQ 444141300
     * @创建时间 2019/7/29 15:00
    */
    public final static String createJsonSuccess(final String msg){
        final JSONObject json = new JSONObject();
        json.put(ConfigFile.code,ConfigFile.code200);
        json.put(ConfigFile.msg,msg);
        return json.toJSONString();
    }

	/**
	 * 验证必要的参数字段是否为空的返回json格式专用,先调用方法validateField()返回值false后再直接调用本方法返回json字符串
	 * @作者 田应平
	 * @返回值类型 返回的是json字符串,内部采用JSONObject封装
	 * @创建时间 2017年1月11日 下午7:38:48
	 * @QQ号码 444141300
	 * @主页 http://www.fwtai.com
	*/
	public static final String jsonValidateField(){
		final JSONObject json = new JSONObject();
		json.put(ConfigFile.code,ConfigFile.code202);
		json.put(ConfigFile.msg,ConfigFile.msg202);
		return json.toJSONString();
	}

    /**
     * 验证必要的字段是否为空,不验证ckey密钥,一般在service层调用,如果返回为 null 则验证成功,否则失败;适用于增、删、改、查操作!
     * @fields 需要验证的form字段
     * @用法1 final String validate = ToolClient.validateField(params,"kid");if(validate != null)return validate;
     * @用法2 final String validate = ToolClient.validateField(params,new String[]{"id"});if(validate != null)return validate;
     * @作者 田应平
     * @返回值类型 返回的是json字符串,内部采用JSONObject封装,如果返回为 null 则验证成功!
     * @创建时间 2017年2月23日 下午10:10:34
     * @QQ号码 444141300
     * @主页 http://www.fwtai.com
    */
    public final static String validateField(final Map<String,?> params,final String... fields){
        if(ToolString.isBlank(params) || ToolString.isBlank(fields)){
            return jsonValidateField();
        }
        boolean flag = false;
        for (final String p : fields){
            if(ToolString.isBlank(params.get(p))){
                flag = true;
                break;
            }
        }
        if(flag)return jsonValidateField();
        return null;
    }

    public final static String validateField(final String... fields){
        if(fields == null || fields.length <= 0){
            return jsonValidateField();
        }
        boolean flag = false;
        for (final String p : fields){
            if(p == null || p.length() <= 0){
                flag = true;
                break;
            }
        }
        if(flag)return jsonValidateField();
        return null;
    }

    public final static String validateField(final JSONObject params,final String... fields){
        if(ToolString.isBlank(params) || ToolString.isBlank(fields)){
            return jsonValidateField();
        }
        boolean flag = false;
        for (final String p : fields){
            if(ToolString.isBlank(params.get(p))){
                flag = true;
                break;
            }
        }
        if(flag)return jsonValidateField();
        return null;
    }

    /**
     * 验证必填字段,线程安全
     * @用法1 final String validate = ToolClient.validateForm(params,"kid");if(validate != null)return validate;
     * @用法2 final String validate = ToolClient.validateForm(params,new String[]{"id"});if(validate != null)return validate;
     * @param
     * @作者 田应平
     * @QQ 444141300
     * @创建时间 2019/11/2 18:31
   */
    public final static String validateForm(final ConcurrentHashMap<String,String> formData,final String[] fields){
        if(ToolString.isBlank(formData) || ToolString.isBlank(fields)){
            return jsonValidateField();
        }
        if(!ToolString.isBlank(fields)){
            boolean flag = false;
            for(String p : fields){
                if(ToolString.isBlank(formData.get(p))){
                    flag = true;
                    break;
                }
            }
            if(flag)return jsonValidateField();
        }
        return null;
    }

    private static final String jsonValidateInteger(){
        final JSONObject json = new JSONObject();
        json.put(ConfigFile.code,ConfigFile.code199);
        json.put(ConfigFile.msg,"参数类型有误");
        return json.toJSONString();
    }

    /**
     * 验证所输入的数据是否是Integer类型,先验证是否必填后才调用本方法
     * @用法1 final String FieldInteger = ToolClient.validateInteger(pageFormData,"type");if(FieldInteger != null)return FieldInteger;
     * @用法2 final String FieldInteger = ToolClient.validateInteger(pageFormData,new String[]{"category","subset","type"});if(FieldInteger != null)return FieldInteger;
     * @param
     * @作者 田应平
     * @QQ 444141300
     * @创建时间 2020/4/2 13:04
    */
    public final static String validateInteger(final Map<String,?> params,final String... fields){
        for(int i = 0; i < fields.length; i++){
            try {
                final Object o = params.get(fields[i]);
                if(o != null){
                    final String value = String.valueOf(String.valueOf(o));
                    if(value.equalsIgnoreCase("null") || value.equalsIgnoreCase("undefined"))return jsonValidateInteger();
                    if(value == null){
                        return jsonValidateInteger();
                    }
                    Integer.parseInt(value);
                }else{
                    return jsonValidateInteger();
                }
            } catch (Exception e) {
                e.printStackTrace();
                return jsonValidateInteger();
            }
        }
        return null;
    }

    public final static String validateInteger(final JSONObject params,final String... fields){
        for(int i = 0; i < fields.length; i++){
            try {
                final Object o = params.get(fields[i]);
                if(o != null){
                    final String value = String.valueOf(String.valueOf(o));
                    if(value.equalsIgnoreCase("null") || value.equalsIgnoreCase("undefined"))return jsonValidateInteger();
                    if(value == null){
                        return jsonValidateInteger();
                    }
                    Integer.parseInt(value);
                }else{
                    return jsonValidateInteger();
                }
            } catch (Exception e) {
                e.printStackTrace();
                return jsonValidateInteger();
            }
        }
        return null;
    }

	/**
	 * 生成|计算总页数
	 * @作者 田应平
	 * @返回值类型 Integer
	 * @创建时间 2016年12月2日 下午1:20:53
	 * @QQ号码 444141300
	 * @主页 http://www.fwtai.com
	*/
	public final static Integer totalPage(final Integer total,final Integer pageSize){
		return (total%pageSize) == 0 ? (total/pageSize):(total/pageSize)+1; //总页数
	}

	/**
	 * 生成json对象
	 * @param map
	 * @作者 田应平
	 * @返回值类型 String
	 * @创建时间 2017年7月30日 22:47:24
	 * @QQ号码 444141300
	 * @官网 http://www.fwtai.com
	*/
	public final static String jsonObj(final Map<String, Object> map){
		return JSON.toJSONString(map);
	}

	/**
	 * 生成json数组
	 * @param listData
	 * @return
	 * @作者 田应平
	 * @返回值类型 String
	 * @创建时间 2017年1月12日 下午9:28:55
	 * @QQ号码 444141300
	 * @官网 http://www.fwtai.com
	*/
	public final static String jsonArray(final List<Map<String, Object>> listData){
		return JSONArray.toJSONString(listData);
	}


	/**
	 * 用于生成出现异常信息时的json固定code:204字符串提示,返回给controller层调用,一般在service层调用
	 * @作者 田应平
	 * @返回值类型 String,内部采用JSONObject封装,msg 为系统统一的‘系统出现错误’
	 * @创建时间 2017年1月10日 21:40:23
	 * @QQ号码 444141300
	 * @主页 http://www.fwtai.com
	*/
	public final static String exceptionJson(){
		final JSONObject json = new JSONObject();
		json.put(ConfigFile.code,ConfigFile.code204);
		json.put(ConfigFile.msg,ConfigFile.msg204);
		return json.toJSONString();
	}

	/**
	 * 用于生成出现异常信息时的json固定code:204字符串提示,返回给controller层调用,一般在service层调用
	 * @param msg 自定义提示的异常信息
	 * @作者 田应平
	 * @返回值类型 String,内部采用JSONObject封装
	 * @创建时间 2017年1月10日 21:40:23
	 * @QQ号码 444141300
	 * @主页 http://www.fwtai.com
	*/
	public final static String exceptionJson(final String msg){
		final JSONObject json = new JSONObject();
		json.put(ConfigFile.code,ConfigFile.code204);
		json.put(ConfigFile.msg,msg);
		return json.toJSONString();
	}

	/**
	 * 返回给客户端系统出现错误的提示信息,已返回给客户端,只能在controller层调用,用于增、删、改、查操作的异常返回给客户端
	 * @注意 不能在service层调用
	 * @作者 田应平
	 * @创建时间 2016年12月25日 下午5:07:16
	 * @QQ号码 444141300
	 * @官网 http://www.fwtai.com
	*/
	public final static void responseException(final HttpServletResponse response){
		responseJson(exceptionJson(),response);
		return;
	}

	/**
	 * 返回给客户端系统出现错误的提示信息,已返回给客户端,只能在controller层调用,用于增、删、改、查操作的异常返回给客户端
	 * @param msg 自定义提示的异常信息
	 * @注意 不能在service层调用
	 * @作者 田应平
	 * @创建时间 2016年12月25日 下午5:07:16
	 * @QQ号码 444141300
	 * @官网 http://www.fwtai.com
	*/
	public final static void responseException(final HttpServletResponse response,final String msg){
		responseJson(exceptionJson(msg),response);
		return;
	}

    /**
     * 通用的响应json返回json对象,只能在是controller层调用
     * @param json json对象
     * @注意 不能在service层调用
     * @作者 田应平
     * @创建时间 2016年8月18日 17:53:18
     * @QQ号码 444141300
     * @官网 http://www.fwtai.com
    */
    public final static void responseJson(final String json){
        try {
            final HttpServletResponse response = getResponse();
            responseJson(json,response);
        } catch (Exception e) {}
    }

	/**
	 * 通用的响应json返回json对象,只能在是controller层调用
	 * @param json json对象
	 * @param response
	 * @注意 不能在service层调用
	 * @作者 田应平
	 * @创建时间 2016年8月18日 17:53:18
	 * @QQ号码 444141300
	 * @官网 http://www.fwtai.com
	*/
	public final static void responseJson(final String json,final HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		PrintWriter writer = null;
        try {
			writer = response.getWriter();
            if(json == null){
                writer.write(createJson(ConfigFile.code201,ConfigFile.msg201));
                writer.flush();
            }else{
                writer.write(String.valueOf(JSON.parse(json)));
                writer.flush();
            }
		}catch (IOException e){
			logger.error("类ToolClient的方法responseJson出现异常",e.getMessage());
		}finally{
			if(writer != null){
				writer.close();
                writer = null;
			}
		}
	}

    public final static HttpServletResponse getResponse(){
        return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
    }

	/**
	 * 获取项目所在的物理路径,推荐使用
	 * @param request
	 * @作者 田应平
	 * @创建时间 2017年9月25日 下午3:47:29
	 * @QQ号码 444141300
	 * @官网 http://www.fwtai.com
	*/
	public final static String getWebRoot(final HttpServletRequest request){
		return request.getSession().getServletContext().getRealPath(File.separator);
	}

	/**
	 * 获取访问项目的网站域名,如http://api.yinlz.com
	 * @param request
	 * @作者 田应平
	 * @返回值类型 String
	 * @创建时间 2016年1月16日 15:18:55
	 * @QQ号码 444141300
	 * @官网 http://www.fwtai.com
	*/
	public final static String getDomainName(final HttpServletRequest request){
		return request.getScheme()+"://"+request.getServerName();
	}

    public final static String getHttpClientRequest(final HttpServletRequest request){
        final StringBuilder sb = new StringBuilder();
        try {
            final InputStream is = request.getInputStream();
            final InputStreamReader isr = new InputStreamReader(is,"UTF-8");
            final BufferedReader br = new BufferedReader(isr);
            String s = "";
            while ((s = br.readLine()) != null){
                sb.append(s);
            }
            return sb.length() > 0 ? sb.toString() : null;
        } catch (Exception e) {}
        return null;
    }

    public final static String jsonPage(Object listData,Integer total){
        final JSONObject json = new JSONObject();
        if(total == null || total == 0){
            listData = new ArrayList<HashMap<String,Object>>();
            total = 0;
            json.put(ConfigFile.code,ConfigFile.code202);
            json.put(ConfigFile.msg,ConfigFile.msg201);
            json.put(ConfigFile.total,total);
            json.put(ConfigFile.data,listData);
            return json.toJSONString();
        }else{
            json.put(ConfigFile.code,ConfigFile.code200);
            json.put(ConfigFile.msg,ConfigFile.msg200);
            json.put(ConfigFile.total,total);
            json.put(ConfigFile.data,listData);
            return json.toJSONString();
        }
    }

    public final static PageFormData dataMysql(final PageFormData pageFormData){
        Integer size = pageFormData.getInteger("pageSize");//每页大小
        Integer current = pageFormData.getInteger("current");//当前页
        if(size == null || current == null) return null;
        if(current <= 0){
            current = 1;
        }
        if(size > 200){
            size = ConfigFile.size_default;
        }
        pageFormData.put(ConfigFile.section,(current - 1) * size);//读取区间
        pageFormData.put(ConfigFile.pageSize,size);//每页大小
        pageFormData.remove("current");
        return pageFormData;
    }

    /**
     * 封装文件上传,指定上传的目录,返回值HashMap<String,Object>,files,params,error
     * @param baseDir 该值的结尾必须要带 /
     * @param limit 如果该值为null或为负数时则不限制文件数
     * @return HashMap<key,Object>,其中key可能为error,files,params，要做判断再做页面处理
     * @作者 田应平
     * @QQ 444141300
     * @创建时间 2020/5/30 10:19
    */
    public final static HashMap<String,Object> uploadImage(final HttpServletRequest request,final String baseDir,final Integer limit){
        //final PageFormData formData = new PageFormData().build(request);
        final PageFormData formData = new PageFormData(request);
        final HashMap<String,Object> objectHashMap = new HashMap<String,Object>(2);
        final String error = "error";
        MultipartHttpServletRequest mhsr = null;
        try {
            mhsr =  (MultipartHttpServletRequest) request;
        } catch (Exception e){
            objectHashMap.put(error,"请上传文件");
            return objectHashMap;
        }
        if(mhsr == null){
            objectHashMap.put(error,"未上传文件");
            return objectHashMap;
        }
        final DiskFileItemFactory fac = new DiskFileItemFactory();
        final ServletFileUpload upload = new ServletFileUpload(fac);
        String originalPath = null;
        try {
            upload.setHeaderEncoding("utf-8");
            mhsr.setCharacterEncoding("utf-8");
            /* 在 spring boot 的jar下这个方式想不通啦!!!
            final String sys = File.separator;
            String dirType = sys;
            final String savePath = mhsr.getSession().getServletContext().getRealPath(dirType);
            final File directory = new File(savePath);
            if(!directory.exists()){
                directory.mkdirs();
            }*/
            final Map<String,MultipartFile> map = mhsr.getFileMap();
            if(map == null || map.size() <=0){
                objectHashMap.put(error,"请选择上传文件");
                return objectHashMap;
            }
            if(limit != null && limit > 0){
                if(map != null && map.size() > limit){
                    objectHashMap.put(error,"图片数量已超过限制");
                    return objectHashMap;
                }
            }
            final ArrayList<HashMap<String,String>> fileList = new ArrayList<HashMap<String,String>>();
            boolean bl = false;
            for(final String key : map.keySet()){
                final MultipartFile mf = mhsr.getFile(key);
                if(mf.getSize() > 5242880l){
                    bl = true;
                    break;
                }
                final String name = mf.getOriginalFilename();
                final String extName = name.substring(name.lastIndexOf("."));
                final String fileName = ToolString.getIdsChar32() + extName;
                final File fileDir = new File(baseDir);
                if(!fileDir.exists()){
                    fileDir.mkdirs();
                }
                originalPath = baseDir + fileName;
                mf.transferTo(new File(originalPath));
                final HashMap<String,String> maps = new HashMap<String,String>(3);
                maps.put("originalName",name);
                maps.put("fileName",fileName);
                maps.put("path",originalPath);
                fileList.add(maps);
            }
            if(bl){
                for(int i = 0; i < fileList.size(); i++){
                    delFileByThread(fileList.get(i).get("path"));
                }
                objectHashMap.put(error,"操作失败,某个文件过大");
                return objectHashMap;
            }
            if(fileList.size() > 0){
                objectHashMap.put("files",fileList);
            }
            if(formData.size() > 0){
                objectHashMap.put("params",formData);
            }
            return objectHashMap;
        } catch (Exception e) {
            delFileByThread(originalPath);
            objectHashMap.put(error,"操作失败,处理文件失败");
            return objectHashMap;
        }
    }

    /**
     * 开线程访问服务器删除图片
     * @date 2019年10月31日 16:41:40
    */
    public final static void delFileByThread(final String filePath) {
        try {
            new Thread(){
                public void run() {
                    final File file = new File(filePath);
                    if(file.isFile()){
                        file.delete();
                    }
                }
            }.start();
        } catch (Exception e){}
    }
}