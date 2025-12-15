package com.unu.poowebmodalga;

import com.unu.poowebmodalga.model.Usuario;
import com.unu.poowebmodalga.repository.UsuarioRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;

import java.util.Date;

@SpringBootApplication
public class SistemaApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(SistemaApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(SistemaApplication.class, args);
    }

    @Bean
    public CommandLineRunner initData(UsuarioRepository usuarioRepository) {
        return args -> {
            if (usuarioRepository.findByNombreUsuario("admin").isEmpty()) {
                Usuario admin = new Usuario();
                admin.setNombreUsuario("admin");
                admin.setPassword("123456");
                admin.setNombreCompleto("Administrador del Sistema");
                admin.setEmail("admin@example.com");
                admin.setRol("ADMIN");
                admin.setEstado("ACTIVO");
                admin.setFechaCreacion(new java.sql.Timestamp(new Date().getTime()));

                usuarioRepository.save(admin);
                System.out.println("Usuario admin creado por defecto: admin / 123456");
            } else {
                System.out.println("Usuario admin ya existe.");
            }
        };
    }
}
