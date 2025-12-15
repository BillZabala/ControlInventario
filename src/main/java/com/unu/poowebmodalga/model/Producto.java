package com.unu.poowebmodalga.model;

import jakarta.persistence.*;
import jakarta.persistence.Transient;
import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Table(name = "productos")
public class Producto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idproducto")
    private int idProducto;

    @Transient
    private int idCategoria;

    @ManyToOne
    @JoinColumn(name = "idcategoria", nullable = false)
    private Categoria categoria;

    @Transient
    private int idProveedor;

    @ManyToOne
    @JoinColumn(name = "idproveedor")
    private Proveedor proveedor;

    @Column(name = "nombre", nullable = false, length = 100)
    private String nombre;

    @Column(name = "descripcion", columnDefinition = "TEXT")
    private String descripcion;

    @Column(name = "precio", nullable = false, precision = 10, scale = 2)
    private BigDecimal precio;

    @Column(name = "stock", nullable = false)
    private int stock = 0;

    @Column(name = "imagen", length = 255)
    private String imagen;

    @Column(name = "estado", nullable = false, length = 20)
    private String estado = "ACTIVO";

    @Column(name = "fecha_creacion", insertable = false, updatable = false)
    private Timestamp fechaCreacion;

    public Producto() {
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public Proveedor getProveedor() {
        return proveedor;
    }

    public void setProveedor(Proveedor proveedor) {
        this.proveedor = proveedor;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public void setPrecio(double precio) {
        this.precio = BigDecimal.valueOf(precio);
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
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

    @Transient
    public String getNombreCategoria() {
        return categoria != null ? categoria.getNombre() : "Sin Categoría";
    }

    @Transient
    public String getNombreProveedor() {
        return proveedor != null ? proveedor.getNombre() : "Sin Proveedor";
    }
}
