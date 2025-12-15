package com.unu.poowebmodalga.controllers;

import com.unu.poowebmodalga.dto.NotificacionDTO;
import com.unu.poowebmodalga.service.NotificacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/notificaciones")
public class NotificacionRestController {

    @Autowired
    private NotificacionService notificacionService;

    @GetMapping
    public List<NotificacionDTO> getNotificaciones() {
        return notificacionService.getNotificaciones();
    }
}
