package com.unu.poowebmodalga.model;

import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "movimientos")
public class Movimiento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idmovimiento")
    private int idMovimiento;

    @Transient
    private int idProducto;

    @ManyToOne
    @JoinColumn(name = "idproducto", nullable = false)
    private Producto producto;

    @Column(name = "tipo", nullable = false, length = 20)
    private String tipo; // ENTRADA, SALIDA

    @Column(name = "cantidad", nullable = false)
    private int cantidad;

    @Column(name = "fecha")
    private Timestamp fecha;

    @PrePersist
    public void prePersist() {
        if (this.fecha == null) {
            this.fecha = new Timestamp(System.currentTimeMillis());
        }
    }

    public Movimiento() {
    }

    public Movimiento(Producto producto, String tipo, int cantidad) {
        this.producto = producto;
        this.tipo = tipo;
        this.cantidad = cantidad;
    }

    public int getIdMovimiento() {
        return idMovimiento;
    }

    public void setIdMovimiento(int idMovimiento) {
        this.idMovimiento = idMovimiento;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }
}
