package com.fwtai.service;

import com.fwtai.bean.PageFormData;
import com.fwtai.dao.DaoHandle;
import com.fwtai.tool.ToolClient;
import com.fwtai.tool.ToolString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

/**
 * 楼层仓库编码业务层
 * @作者 田应平
 * @版本 v1.0
 * @QQ号码 444141300
 * @创建日期 2021-01-22 22:06:05
 * @官网 <url>http://www.yinlz.com</url>
*/
@Service
public class FloorCodeService extends DataService{

    @Autowired
    private DaoHandle daoHandle;

    public String add(final HttpServletRequest request){
        final PageFormData formData = new PageFormData(request);
        final String p_block_name = "block_name";
        final String p_floorId = "floorId";
        final String p_target_code = "target_code";
        final String p_target_label = "target_label";
        final String validate = ToolClient.validateField(formData,p_block_name,p_floorId,p_target_code,p_target_label);
        if(validate != null)return validate;
        formData.put("kid",ToolString.getIdsChar32());
        return ToolClient.executeRows(daoHandle.execute("floorCode.add",formData));
    }

    public String edit(final HttpServletRequest request){
        final PageFormData formData = new PageFormData(request);
        final String p_kid = "kid";
        final String p_block_name = "block_name";
        final String p_floorId = "floorId";
        final String p_target_code = "target_code";
        final String p_target_label = "target_label";
        final String validate = ToolClient.validateField(formData,p_block_name,p_floorId,p_target_code,p_target_label,p_kid);
        if(validate != null)return validate;
        return ToolClient.executeRows(daoHandle.execute("floorCode.edit",formData));
    }

    public String delById(final PageFormData formData){
        return delById(formData,"floorCode");
    }

    public String delByKeys(final PageFormData formData){
        return delByKeys(formData,"floorCode");
    }

    public String listData(PageFormData formData){
        return listData(formData,"floorCode");
    }
}