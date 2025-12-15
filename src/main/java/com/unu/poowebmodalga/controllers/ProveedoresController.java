package com.unu.poowebmodalga.controllers;

import com.unu.poowebmodalga.model.Proveedor;
import com.unu.poowebmodalga.services.ProveedoresService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/proveedores")
public class ProveedoresController {

    private final ProveedoresService proveedoresService;

    public ProveedoresController(ProveedoresService proveedoresService) {
        this.proveedoresService = proveedoresService;
    }

    @GetMapping
    public String listarProveedores(Model model) {
        List<Proveedor> lista = proveedoresService.listarProveedores();
        model.addAttribute("proveedores", lista);
        return "proveedores/lista";
    }

    @PostMapping("/guardar")
    public String guardarProveedor(@ModelAttribute("proveedor") Proveedor proveedor,
            RedirectAttributes redirectAttributes) {
        proveedoresService.guardarProveedor(proveedor);
        redirectAttributes.addFlashAttribute("mensaje", "Proveedor guardado exitosamente");
        return "redirect:/proveedores";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminarProveedor(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        proveedoresService.eliminarProveedor(id);
        redirectAttributes.addFlashAttribute("mensaje", "Proveedor eliminado exitosamente");
        return "redirect:/proveedores";
    }
}
