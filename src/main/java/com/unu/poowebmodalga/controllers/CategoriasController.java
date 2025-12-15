package com.unu.poowebmodalga.controllers;

import com.unu.poowebmodalga.model.Categoria;
import com.unu.poowebmodalga.services.CategoriasService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/categorias")
public class CategoriasController {

    private final CategoriasService categoriasService;

    public CategoriasController(CategoriasService categoriasService) {
        this.categoriasService = categoriasService;
    }

    @GetMapping
    public String listar(Model model) {
        List<Categoria> lista = categoriasService.listarCategorias();
        model.addAttribute("listaCategorias", lista);
        return "categorias/lista";
    }

    @PostMapping("/guardar")
    public String guardar(@RequestParam("nombre") String nombre,
            @RequestParam("descripcion") String descripcion) {
        Categoria categoria = new Categoria();
        categoria.setNombre(nombre);
        categoria.setDescripcion(descripcion);
        categoriasService.insertarCategoria(categoria);
        return "redirect:/categorias";
    }

    @PostMapping("/actualizar")
    public String actualizar(@RequestParam("id") int id,
            @RequestParam("nombre") String nombre,
            @RequestParam("descripcion") String descripcion) {
        Categoria categoria = new Categoria();
        categoria.setIdCategoria(id);
        categoria.setNombre(nombre);
        categoria.setDescripcion(descripcion);
        categoriasService.modificarCategoria(categoria);
        return "redirect:/categorias";
    }

    @GetMapping("/eliminar")
    public String eliminar(@RequestParam("id") int id) {
        categoriasService.eliminarCategoria(id);
        return "redirect:/categorias";
    }

    // Legacy support for old URLs - Redirect to list
    @GetMapping("/CategoriasController")
    public String legacyHandler(@RequestParam(value = "accion", required = false) String accion,
            @RequestParam(value = "id", required = false) Integer id,
            Model model) {
        return "redirect:/categorias";
    }
}
