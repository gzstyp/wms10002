package com.fwtai.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * 任务指令
 * @作者 田应平
 * @版本 v1.0
 * @创建时间 2020-05-17 22:23
 * @QQ号码 444141300
 * @Email service@dwlai.com
 * @官网 http://www.fwtai.com
 */
@ApiModel("出入库指令任务")
public final class Task{

    private String kid;
    private String user;
    @ApiModelProperty(notes = "任务单号|编号",required = true,value = "单号|编号,必填")
    private String invoices_code;
    @ApiModelProperty(notes = "指令类型(1入库;2出库;)",required = true,value = "1入库;2出库;必填",dataType = "Integer")
    private Integer type;
    @ApiModelProperty(notes = "任务数量",required = true,value = "任务数量,必填",dataType = "Integer")
    private Integer total;
    private Integer status;
    @ApiModelProperty(notes = "任务明细",required = true,value = "List明细,必填")
    private List<TaskDetail> data;

    public Task(){}

    public String getKid(){
        return kid;
    }

    public void setKid(String kid){
        this.kid = kid;
    }

    public String getInvoices_code(){
        return invoices_code;
    }

    public void setInvoices_code(String invoices_code){
        this.invoices_code = invoices_code;
    }

    public Integer getType(){
        return type;
    }

    public void setType(Integer type){
        this.type = type;
    }

    public Integer getTotal(){
        return total;
    }

    public void setTotal(Integer total){
        this.total = total;
    }

    public Integer getStatus(){
        return status;
    }

    public void setStatus(Integer status){
        this.status = status;
    }

    public List<TaskDetail> getData(){
        return data;
    }

    public void setData(List<TaskDetail> data){
        this.data = data;
    }

    public String getUser(){
        return user;
    }

    public void setUser(String user){
        this.user = user;
    }
}