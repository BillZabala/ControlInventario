package com.unu.poowebmodalga.model;

import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "proveedores")
public class Proveedor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idproveedor")
    private int idProveedor;

    @Column(name = "nombre", nullable = false, length = 100)
    private String nombre;

    @Column(name = "contacto", length = 100)
    private String contacto;

    @Column(name = "telefono", length = 20)
    private String telefono;

    @Column(name = "email", length = 100)
    private String email;

    @Column(name = "direccion", columnDefinition = "TEXT")
    private String direccion;

    @Column(name = "estado", nullable = false, length = 20)
    private String estado = "ACTIVO";

    @Column(name = "fecha_creacion", insertable = false, updatable = false)
    private Timestamp fechaCreacion;

    public Proveedor() {
    }

    public Proveedor(String nombre, String contacto, String telefono, String email, String direccion) {
        this.nombre = nombre;
        this.contacto = contacto;
        this.telefono = telefono;
        this.email = email;
        this.direccion = direccion;
    }

    // Getters y Setters
    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getContacto() {
        return contacto;
    }

    public void setContacto(String contacto) {
        this.contacto = contacto;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
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
}
