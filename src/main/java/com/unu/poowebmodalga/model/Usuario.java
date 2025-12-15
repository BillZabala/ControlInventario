package com.unu.poowebmodalga.model;

import jakarta.persistence.*;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@Entity
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idusuario")
    private int idUsuario;

    @Column(name = "nombre_usuario", nullable = false, length = 50, unique = true)
    private String nombreUsuario;

    @Column(name = "password", nullable = false, length = 100)
    private String password;

    @Column(name = "nombre_completo", nullable = false, length = 100)
    private String nombreCompleto;

    @Column(name = "email", length = 100)
    private String email;

    @Column(name = "rol", nullable = false, length = 20)
    private String rol = "USER";

    @Column(name = "estado", nullable = false, length = 20)
    private String estado = "ACTIVO";

    @Column(name = "fecha_creacion", insertable = false, updatable = false)
    private Timestamp fechaCreacion;

    public Usuario() {
    }

    public Usuario(String nombreUsuario, String password, String nombreCompleto, String email, String rol) {
        this.nombreUsuario = nombreUsuario;
        this.password = password;
        this.nombreCompleto = nombreCompleto;
        this.email = email;
        this.rol = rol;
    }

    // Getters y Setters
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    // Método de utilidad
    public boolean esAdmin() {
        return "ADMIN".equals(this.rol);
    }

    public boolean estaActivo() {
        return "ACTIVO".equals(this.estado);
    }

    @PrePersist
    public void prePersist() {
        if (this.rol == null)
            this.rol = "USER";
        if (this.estado == null)
            this.estado = "ACTIVO";
    }
}
