package com.fwtai.config;

import com.fwtai.dao.DaoHandle;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

import javax.annotation.Resource;

@EnableScheduling
@Configuration
public class SchedulerConfig {

    @Resource
    private DaoHandle daoHandle;

    //@Scheduled(fixedDelay = 10000)
    public void sendMessages(){

    }
}