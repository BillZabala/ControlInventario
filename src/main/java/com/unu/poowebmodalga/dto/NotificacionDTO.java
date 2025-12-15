package com.unu.poowebmodalga.dto;

public class NotificacionDTO {
    private String mensaje;
    private String tipo; // "WARNING", "INFO", "ERROR"
    private String fecha;

    public NotificacionDTO(String mensaje, String tipo, String fecha) {
        this.mensaje = mensaje;
        this.tipo = tipo;
        this.fecha = fecha;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
}
