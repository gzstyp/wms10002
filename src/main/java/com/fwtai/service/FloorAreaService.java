package com.fwtai.service;

import com.fwtai.bean.PageFormData;
import com.fwtai.dao.DaoHandle;
import com.fwtai.tool.ToolClient;
import com.fwtai.tool.ToolString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
public class FloorAreaService extends DataService{

    @Autowired
    private DaoHandle daoHandle;

    public String add(final PageFormData formData){
        final String _floorId = "floorId";
        final String _areaId = "areaId";
        final String validateField = ToolClient.validateField(formData,_floorId,_areaId);
        if(validateField !=null)return validateField;
        formData.put("kid",ToolString.getIdsChar32());
        return ToolClient.executeRows(daoHandle.execute("floor_area.add",formData));
    }

    public String edit(final PageFormData formData){
        final String _kid = "kid";
        final String _floorId = "floorId";
        final String _areaId = "areaId";
        final String validateField = ToolClient.validateField(formData,_kid,_floorId,_areaId);
        if(validateField !=null)return validateField;
        return ToolClient.executeRows(daoHandle.execute("floor_area.edit",formData));
    }

    public String delById(final PageFormData formData){
        return delById(formData,"floor_area");
    }

    public String delByKeys(final PageFormData formData){
        return delByKeys(formData,"floor_area");
    }

    public String listData(PageFormData formData){
        return listData(formData,"floor_area");
    }

    public String getAllFloor(){
        return ToolClient.queryJson(daoHandle.queryListEntity("floor_area.getAllFloor"));
    }

    public String getAllArea(){
        return ToolClient.queryJson(daoHandle.queryListEntity("floor_area.getAllArea"));
    }
}