package com.fwtai;

import com.fwtai.websocket.SpringUtil;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@SpringBootApplication
@Configuration
public class Launch{

    public static void main(String[] args){
        SpringApplication.run(Launch.class,args);
    }

    @Bean
    public SpringUtil springUtil(){
        return new SpringUtil();
    }
}
