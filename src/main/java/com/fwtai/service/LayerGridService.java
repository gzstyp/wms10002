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
 * 楼层的货位号管理
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2020-05-28 10:21
 * @QQ号码 444141300
 * @Email service@dwlai.com
 * @官网 http://www.fwtai.com
*/
@Service
public class LayerGridService{

    @Autowired
    private DaoHandle daoHandle;

    protected boolean queryImagesExist(final String kid){
        return daoHandle.queryForString("layer_grid.queryImagesExist",kid) == null;
    }

    public String add(final PageFormData formData){
        final String _floor_area_id = "floor_area_id";
        final String _grids = "grids";
        final String validate = ToolClient.validateField(formData,_floor_area_id,_grids);
        if(validate != null)return validate;
        if(queryImagesExist(formData.getString(_floor_area_id))){
            return ToolClient.createJsonFail("选择的货架货位不存在");
        }
        final String json = formData.getString(_grids).replaceAll("\\s*|\t|\r|\n","");
        final int type = ToolString.jsonType(json);
        if(type != 2){
            return ToolClient.createJsonFail("货位信息不是标准的json数据格式");
        }
        formData.put("kid",ToolString.getIdsChar32());
        return ToolClient.executeRows(daoHandle.execute("layer_grid.add",formData));
    }

    public String edit(final PageFormData formData){
        final String _kid = "kid";
        final String _floor_area_id = "floor_area_id";
        final String _grids = "grids";
        final String validate = ToolClient.validateField(formData,_kid,_floor_area_id,_grids);
        if(validate != null)return validate;
        if(queryImagesExist(formData.getString(_floor_area_id))){
            return ToolClient.createJsonFail("选择的货架货位不存在");
        }
        final String json = formData.getString(_grids).replaceAll("\\s*|\t|\r|\n","");
        final int type = ToolString.jsonType(json);
        if(type != 2){
            return ToolClient.createJsonFail("货位信息不是标准的json数据格式");
        }
        return ToolClient.executeRows(daoHandle.execute("layer_grid.edit",formData));
    }

    public String delById(final PageFormData formData){
        final String p_kid = "kid";
        final String validateField = ToolClient.validateField(formData,p_kid);
        if(validateField !=null)return validateField;
        return ToolClient.executeRows(daoHandle.execute("layer_grid.delById",formData.getString(p_kid)));
    }

    public String delByKeys(final PageFormData formData){
        final String p_ids = "ids";
        final String validate = ToolClient.validateField(formData,p_ids);
        if(validate != null)return validate;
        final ArrayList<Object> lists = ToolString.jsonArrayToList(formData.get(p_ids));
        if(lists == null || lists.size() <= 0){
            return ToolClient.createJsonFail("请选择要删除的数据");
        }
        return ToolClient.executeRows(daoHandle.execute("layer_grid.delByKeys",lists),"操作成功","数据已不存在,刷新重试");
    }

    public String listData(PageFormData formData){
        formData = ToolClient.dataMysql(formData);
        if(formData == null)return ToolClient.jsonValidateField();
        final HashMap<String,Object> map = daoHandle.queryForPage(formData,"layer_grid.getListData","layer_grid.getListTotal");
        return ToolClient.jsonPage(map.get(ConfigFile.data),(Integer) map.get(ConfigFile.total));
    }

    public String getOptions(){
        return ToolClient.queryJson(daoHandle.queryListEntity("layer_grid.getOptions"));
    }
}