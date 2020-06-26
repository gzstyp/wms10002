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
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2020-05-17 11:16
 * @QQ号码 444141300
 * @Email service@dwlai.com
 * @官网 http://www.fwtai.com
 */
@Service
public class StoragePointService{

    @Autowired
    private DaoHandle daoHandle;

    public String addStoragePoint(final PageFormData formData){
        final String p_item_storage_code = "item_storage_code";
        final String p_point = "point";
        final String validateField = ToolClient.validateField(formData,p_item_storage_code,p_point);
        if(validateField !=null)return validateField;
        final String point = formData.getString(p_point);
        final int type = ToolString.jsonType(point);
        if(type != 1)return ToolClient.createJsonFail("货位坐标的格式有误");
        final HashMap<String,String> map = ToolString.parseJsonObject(point);
        boolean bl = false;
        for(final String key : map.keySet()){
            final String value = map.get(key);
            final boolean b = ToolString.isNumber(value);
            if(!b){
                bl = true;
                break;
            }
        }
        if(bl){
            return ToolClient.createJsonFail("货位坐标的应该是数字");
        }
        final String kid = ToolString.getIdsChar32();
        formData.put("kid",kid);
        final int rows = daoHandle.execute("wms.addStoragePoint",formData);
        return ToolClient.executeRows(rows);
    }

    public String getListData(){
        return ToolClient.queryJson(daoHandle.queryForListString("wms.getData"));
    }

    public String listData(PageFormData formData){
        formData = ToolClient.dataMysql(formData);
        if(formData == null)return ToolClient.jsonValidateField();
        final HashMap<String,Object> map = daoHandle.queryForPage(formData,"wms.getListData","wms.getListTotal");
        return ToolClient.jsonPage(map.get(ConfigFile.data),(Integer) map.get(ConfigFile.total));
    }

    public String add(final PageFormData formData){
        final String p_item_storage_code = "item_storage_code";
        final String p_x1 = "x1";
        final String p_y1 = "y1";
        final String p_x2 = "x2";
        final String p_y2 = "y2";
        final String validateField = ToolClient.validateField(formData,p_item_storage_code,p_x1,p_y1,p_x2,p_y2);
        if(validateField !=null)return validateField;
        final String validateInteger = ToolClient.validateInteger(formData,p_x1,p_y1,p_x2,p_y2);
        if(validateInteger !=null)return validateInteger;
        final Integer x1 = formData.getInteger(p_x1);
        final Integer y1 = formData.getInteger(p_y1);
        final Integer x2 = formData.getInteger(p_x2);
        final Integer y2 = formData.getInteger(p_y2);
        final String point = "{\"x1\":"+x1+",\"y1\":"+y1+",\"x2\":"+x2+",\"y2\":"+y2+"}";
        final String kid = ToolString.getIdsChar32();
        formData.put("kid",kid);
        formData.put("point",point);
        formData.remove(p_x1);
        formData.remove(p_y1);
        formData.remove(p_x2);
        formData.remove(p_y2);
        return ToolClient.executeRows(daoHandle.execute("wms.addStoragePoint",formData));
    }

    public String edit(final PageFormData formData){
        final String p_item_storage_code = "item_storage_code";
        final String p_x1 = "x1";
        final String p_y1 = "y1";
        final String p_x2 = "x2";
        final String p_y2 = "y2";
        final String validateField = ToolClient.validateField(formData,p_item_storage_code,p_x1,p_y1,p_x2,p_y2);
        if(validateField !=null)return validateField;
        final String validateInteger = ToolClient.validateInteger(formData,p_x1,p_y1,p_x2,p_y2);
        if(validateInteger !=null)return validateInteger;
        final Integer x1 = formData.getInteger(p_x1);
        final Integer y1 = formData.getInteger(p_y1);
        final Integer x2 = formData.getInteger(p_x2);
        final Integer y2 = formData.getInteger(p_y2);
        final String point = "{\"x1\":"+x1+",\"y1\":"+y1+",\"x2\":"+x2+",\"y2\":"+y2+"}";
        formData.put("point",point);
        formData.remove(p_x1);
        formData.remove(p_y1);
        formData.remove(p_x2);
        formData.remove(p_y2);
        return ToolClient.executeRows(daoHandle.execute("wms.edit",formData));
    }

    public String delById(final PageFormData formData){
        final String p_kid = "kid";
        final String validateField = ToolClient.validateField(formData,p_kid);
        if(validateField !=null)return validateField;
        return ToolClient.executeRows(daoHandle.execute("wms.delById",formData));
    }

    public String delByKeys(final PageFormData formData){
        final String p_ids = "ids";
        final String validate = ToolClient.validateField(formData,p_ids);
        if(validate != null)return validate;
        final ArrayList<Object> lists = ToolString.jsonArrayToList(formData.get(p_ids));
        if(lists == null || lists.size() <= 0){
            return ToolClient.createJsonFail("请选择要删除的数据");
        }
        return ToolClient.executeRows(daoHandle.execute("wms.delByKeys",lists),"操作成功","数据已不存在,刷新重试");
    }
}