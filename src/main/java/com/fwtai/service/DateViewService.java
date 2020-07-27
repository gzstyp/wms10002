package com.fwtai.service;

import com.fwtai.bean.PageFormData;
import com.fwtai.dao.DaoHandle;
import com.fwtai.tool.ToolClient;
import com.fwtai.tool.ToolString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

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
public class DateViewService{

    @Autowired
    private DaoHandle daoHandle;

    //获取楼层
    public String getFloorArea(){
        return ToolClient.queryJson(daoHandle.queryListEntity("layer_grid.getFloorArea"));
    }

    //获取楼层对应的货架货位信息
    public String getLayerGrid(final PageFormData formData){
        final String p_ids = "kids";
        final String validate = ToolClient.validateField(formData,p_ids);
        if(validate != null)return validate;
        final ArrayList<String> lists = ToolString.keysToList(formData.getString(p_ids));
        if(lists == null || lists.size() <= 0){
            return ToolClient.createJsonFail("请选择楼层");
        }
        return ToolClient.queryJson(daoHandle.queryForListHashMap("layer_grid.getLayerGrid",lists));
    }
}