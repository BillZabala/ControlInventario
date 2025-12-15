package com.unu.poowebmodalga.config;

import com.unu.poowebmodalga.interceptors.AuthInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

        @Bean
        public AuthInterceptor authInterceptor() {
                return new AuthInterceptor();
        }

        @Override
        public void addInterceptors(InterceptorRegistry registry) {
                registry.addInterceptor(authInterceptor())
                                .addPathPatterns("/**")
                                .excludePathPatterns(
                                                "/login",
                                                "/LoginController",
                                                "/auth/**",
                                                "/css/**",
                                                "/js/**",
                                                "/images/**",
                                                "/uploads/**",
                                                "/*.css",
                                                "/*.js",
                                                "/*.png",
                                                "/*.jpg",
                                                "/*.jpeg",
                                                "/*.gif",
                                                "/*.ico",
                                                "/error");
        }

        @Override
        public void addResourceHandlers(ResourceHandlerRegistry registry) {
                // Static resources
                registry.addResourceHandler("/css/**")
                                .addResourceLocations("classpath:/static/css/", "/css/");

                registry.addResourceHandler("/js/**")
                                .addResourceLocations("classpath:/static/js/", "/js/");

                registry.addResourceHandler("/images/**")
                                .addResourceLocations("classpath:/static/images/", "/images/");

                // Uploads directory
                registry.addResourceHandler("/uploads/**")
                                .addResourceLocations("file:uploads/");
        }

        @Override
        public void addViewControllers(ViewControllerRegistry registry) {
                // Redirect root to login
                registry.addRedirectViewController("/", "/login");
        }
}
