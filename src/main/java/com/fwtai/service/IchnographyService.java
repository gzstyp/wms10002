package com.fwtai.service;

import com.fwtai.bean.PageFormData;
import com.fwtai.config.ConfigFile;
import com.fwtai.dao.DaoHandle;
import com.fwtai.tool.ToolClient;
import com.fwtai.tool.ToolString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    public String add(final PageFormData formData){
        final String p_images_id = "images_id";
        final String p_item_storage_code = "item_storage_code";
        final String validateField = ToolClient.validateField(formData,p_images_id,p_item_storage_code,"coords");
        if(validateField !=null)return validateField;
        formData.put("kid",ToolString.getIdsChar32());
        return ToolClient.executeRows(daoHandle.execute("ichnography.add",formData));
    }

    public String edit(final PageFormData formData){
        final String p_kid = "kid";
        final String p_images_id = "images_id";
        final String p_item_storage_code = "item_storage_code";
        final String validateField = ToolClient.validateField(formData,p_kid,p_images_id,p_item_storage_code,"coords");
        if(validateField !=null)return validateField;
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