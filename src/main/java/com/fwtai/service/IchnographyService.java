package com.fwtai.service;

import com.fwtai.bean.PageFormData;
import com.fwtai.config.ConfigFile;
import com.fwtai.dao.DaoHandle;
import com.fwtai.tool.ToolClient;
import com.fwtai.tool.ToolString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * 大屏显示处理
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2020-05-28 10:21
 * @QQ号码 444141300
 * @Email service@dwlai.com
 * @官网 http://www.fwtai.com
*/
@Service
public class IchnographyService{

    @Autowired
    private DaoHandle daoHandle;

    @Value("${dir_window}")
    private String dir_window;

    @Value("${dir_linux}")
    private String dir_linux;

    public String add(final HttpServletRequest request){
        final PageFormData formData = new PageFormData(request);
        final String baseDir = ToolString.isLinuxOS() ? dir_linux : dir_window;
        final HashMap<String,Object> map = ToolClient.uploadImage(request,baseDir,1,true);
        if(map.containsKey("error")){
            final String error = String.valueOf(map.get("error"));
            return ToolClient.createJsonFail(error);
        }
        final String p_width = "width";
        final String p_height = "height";
        final String validateField = ToolClient.validateField(formData,p_width,p_height,"usemap","floor_name");
        if(validateField !=null)return validateField;
        final String fieldInteger = ToolClient.validateInteger(formData,p_width,p_height);
        if(fieldInteger != null)return fieldInteger;
        final ArrayList<HashMap<String,String>> files = (ArrayList<HashMap<String,String>>)map.get("files");
        final String img_url = files.get(0).get("fileName");
        if(img_url == null){
            return ToolClient.createJsonFail("请选择上传图片");
        }
        formData.put("img_url","/images/"+img_url);
        formData.put("kid",ToolString.getIdsChar32());
        return ToolClient.executeRows(daoHandle.execute("ichnography.add",formData));
    }

    public String edit(final HttpServletRequest request){
        final PageFormData formData = new PageFormData(request);
        final String baseDir = ToolString.isLinuxOS() ? dir_linux : dir_window;
        final HashMap<String,Object> map = ToolClient.uploadImage(request,baseDir,0,false);
        if(map.containsKey("error")){
            final String error = String.valueOf(map.get("error"));
            return ToolClient.createJsonFail(error);
        }
        final String p_width = "width";
        final String p_height = "height";
        final String validateField = ToolClient.validateField(formData,p_width,p_height,"usemap","floor_name","kid");
        if(validateField !=null)return validateField;
        final String fieldInteger = ToolClient.validateInteger(formData,p_width,p_height);
        if(fieldInteger != null)return fieldInteger;
        final ArrayList<HashMap<String,String>> files = (ArrayList<HashMap<String,String>>)map.get("files");
        if(files != null){
            final String img_url = files.get(0).get("fileName");
            if(img_url != null){
                formData.put("img_url","/images/"+img_url);
            }
        }
        return ToolClient.executeRows(daoHandle.execute("ichnography.edit",formData));
    }

    public String delById(final PageFormData formData){
        final String p_kid = "kid";
        final String validateField = ToolClient.validateField(formData,p_kid);
        if(validateField !=null)return validateField;
        return ToolClient.executeRows(daoHandle.execute("ichnography.delById",formData.getString(p_kid)));
    }

    public String delByKeys(final PageFormData formData){
        final String p_ids = "ids";
        final String validate = ToolClient.validateField(formData,p_ids);
        if(validate != null)return validate;
        final ArrayList<Object> lists = ToolString.jsonArrayToList(formData.get(p_ids));
        return ToolClient.executeRows(daoHandle.execute("ichnography.delByKeys",lists),"操作成功","数据已不存在,刷新重试");
    }

    public String listData(PageFormData formData){
        formData = ToolClient.dataMysql(formData);
        if(formData == null)return ToolClient.jsonValidateField();
        final HashMap<String,Object> map = daoHandle.queryForPage(formData,"ichnography.getListData","ichnography.getListTotal");
        return ToolClient.jsonPage(map.get(ConfigFile.data),(Integer) map.get(ConfigFile.total));
    }
}