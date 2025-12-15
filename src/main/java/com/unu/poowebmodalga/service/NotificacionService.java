package com.unu.poowebmodalga.service;

import com.unu.poowebmodalga.dto.NotificacionDTO;
import com.unu.poowebmodalga.model.Producto;
import com.unu.poowebmodalga.repository.ProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class NotificacionService {

    @Autowired
    private ProductoRepository productoRepository;

    public List<NotificacionDTO> getNotificaciones() {
        List<NotificacionDTO> notificaciones = new ArrayList<>();
        List<Producto> productos = productoRepository.findAll();

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        String fechaActual = sdf.format(new Date());

        for (Producto p : productos) {
            if (p.getStock() <= 10 && "ACTIVO".equals(p.getEstado())) {
                String mensaje = "El producto " + p.getNombre() + " tiene bajo stock (" + p.getStock() + ").";
                notificaciones.add(new NotificacionDTO(mensaje, "WARNING", fechaActual));
            }
        }

        return notificaciones;
    }
}
