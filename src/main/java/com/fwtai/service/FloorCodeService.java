package com.fwtai.service;

import com.fwtai.bean.PageFormData;
import com.fwtai.config.ConfigFile;
import com.fwtai.dao.DaoHandle;
import com.fwtai.tool.ToolClient;
import com.fwtai.tool.ToolString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
/**
 * 楼层仓库编码业务层
 * @作者 田应平
 * @版本 v1.0
 * @QQ号码 444141300
 * @创建日期 2021-01-22 22:06:05
 * @官网 <url>http://www.yinlz.com</url>
*/
@Service
public class FloorCodeService{

    @Autowired
    private DaoHandle daoHandle;

    public String add(final HttpServletRequest request){
        final PageFormData formData = new PageFormData(request);
        final String p_block_name = "block_name";
        final String p_floor_humiture = "floor_humiture";
        final String p_floorId = "floorId";
        final String p_target_code = "target_code";
        final String p_target_label = "target_label";
        final String validate = ToolClient.validateField(formData,p_block_name,p_floor_humiture,p_floorId,p_target_code,p_target_label);
        if(validate != null)return validate;
        formData.put("kid",ToolString.getIdsChar32());
        return ToolClient.executeRows(daoHandle.execute("floor_code.add",formData));
    }

    public String edit(final HttpServletRequest request){
        final PageFormData formData = new PageFormData(request);
        final String p_kid = "kid";
        final String p_block_name = "block_name";
        final String p_floor_humiture = "floor_humiture";
        final String p_floorId = "floorId";
        final String p_target_code = "target_code";
        final String p_target_label = "target_label";
        final String validate = ToolClient.validateField(formData,p_block_name,p_floor_humiture,p_floorId,p_target_code,p_target_label,p_kid);
        if(validate != null)return validate;
        return ToolClient.executeRows(daoHandle.execute("floor_code.edit",formData));
    }

    public String delById(final PageFormData formData){
        final String p_kid = "id";
        final String validate = ToolClient.validateField(formData,p_kid);
        if(validate != null)return validate;
        final String kid = formData.getString(p_kid);
        return ToolClient.executeRows(daoHandle.execute("floor_code.delById",kid));
    }

    public String delByKeys(final PageFormData formData){
        final String p_ids = "ids";
        final String validate = ToolClient.validateField(formData,p_ids);
        if(validate != null)return validate;
        final String ids = formData.getString(p_ids);
        final ArrayList<String> lists = ToolString.keysToList(ids);
        if(lists == null || lists.size() <= 0){
            return ToolClient.createJsonFail("请选择要删除的数据");
        }
        final int rows = daoHandle.execute("floor_code.delByKeys",lists);
        return ToolClient.executeRows(rows,"操作成功","数据已不存在,刷新重试");
    }

    public String listData(PageFormData formData){
        formData = ToolClient.dataMysql(formData);
        if(formData == null)return ToolClient.jsonValidateField();
        final HashMap<String,Object> map = daoHandle.queryForPage(formData,"floor_code.getListData","floor_code.getListTotal");
        return ToolClient.jsonPage(map.get(ConfigFile.data),(Integer) map.get(ConfigFile.total));
    }
}