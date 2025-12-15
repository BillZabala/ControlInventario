package com.unu.poowebmodalga.controllers;

import com.unu.poowebmodalga.model.Categoria;
import com.unu.poowebmodalga.model.Producto;
import com.unu.poowebmodalga.model.Proveedor;
import com.unu.poowebmodalga.services.CategoriasService;
import com.unu.poowebmodalga.services.ProductosService;
import com.unu.poowebmodalga.services.ProveedoresService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping("/productos")
public class ProductosController {

    private final ProductosService productosService;
    private final CategoriasService categoriasService;
    private final ProveedoresService proveedoresService;
    private final ServletContext servletContext;

    public ProductosController(ProductosService productosService,
            CategoriasService categoriasService,
            ProveedoresService proveedoresService,
            ServletContext servletContext) {
        this.productosService = productosService;
        this.categoriasService = categoriasService;
        this.proveedoresService = proveedoresService;
        this.servletContext = servletContext;
    }

    @GetMapping
    public String listar(Model model) {
        List<Producto> lista = productosService.listarProductos();
        List<Categoria> categorias = categoriasService.listarCategorias();
        List<Proveedor> proveedores = proveedoresService.listarProveedores();
        model.addAttribute("listaProductos", lista);
        model.addAttribute("listaCategorias", categorias);
        model.addAttribute("listaProveedores", proveedores);
        return "productos/lista";
    }

    @PostMapping("/guardar")
    public String guardar(@RequestParam("idCategoria") int idCategoria,
            @RequestParam(value = "idProveedor", defaultValue = "0") int idProveedor,
            @RequestParam("nombre") String nombre,
            @RequestParam("descripcion") String descripcion,
            @RequestParam("precio") double precio,
            @RequestParam("stock") int stock,
            @RequestParam(value = "tipoImagen", required = false) String tipoImagen,
            @RequestParam(value = "imagenUrl", required = false) String imagenUrl,
            @RequestParam(value = "imagenFile", required = false) MultipartFile imagenFile) throws IOException {

        String imagen = processImageUpload(tipoImagen, imagenUrl, imagenFile);

        Producto producto = new Producto();
        producto.setIdCategoria(idCategoria);
        producto.setIdProveedor(idProveedor);
        producto.setNombre(nombre);
        producto.setDescripcion(descripcion);
        producto.setPrecio(precio);
        producto.setStock(stock);
        producto.setImagen(imagen);

        productosService.insertarProducto(producto);
        return "redirect:/productos";
    }

    @PostMapping("/actualizar")
    public String actualizar(@RequestParam("id") int id,
            @RequestParam("idCategoria") int idCategoria,
            @RequestParam(value = "idProveedor", defaultValue = "0") int idProveedor,
            @RequestParam("nombre") String nombre,
            @RequestParam("descripcion") String descripcion,
            @RequestParam("precio") double precio,
            @RequestParam("stock") int stock,
            @RequestParam(value = "tipoImagen", required = false) String tipoImagen,
            @RequestParam(value = "imagenUrl", required = false) String imagenUrl,
            @RequestParam(value = "imagenFile", required = false) MultipartFile imagenFile,
            @RequestParam(value = "imagenActual", required = false) String imagenActual) throws IOException {

        String imagen = processImageUpload(tipoImagen, imagenUrl, imagenFile);
        if (imagen == null || imagen.isEmpty()) {
            imagen = imagenActual;
        }

        Producto producto = new Producto();
        producto.setIdProducto(id);
        producto.setIdCategoria(idCategoria);
        producto.setIdProveedor(idProveedor);
        producto.setNombre(nombre);
        producto.setDescripcion(descripcion);
        producto.setPrecio(precio);
        producto.setStock(stock);
        producto.setImagen(imagen);

        productosService.modificarProducto(producto);
        return "redirect:/productos";
    }

    @GetMapping("/eliminar")
    public String eliminar(@RequestParam("id") int id) {
        productosService.eliminarProducto(id);
        return "redirect:/productos";
    }

    private String processImageUpload(String tipoImagen, String imagenUrl, MultipartFile imagenFile)
            throws IOException {
        if ("url".equals(tipoImagen) && imagenUrl != null && !imagenUrl.isEmpty()) {
            return imagenUrl;
        } else if (imagenFile != null && !imagenFile.isEmpty()) {
            String fileName = Paths.get(imagenFile.getOriginalFilename()).getFileName().toString();
            // Change path to project root to match WebConfig
            String uploadPath = System.getProperty("user.dir") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String filePath = uploadPath + File.separator + fileName;
            imagenFile.transferTo(new File(filePath));
            return "uploads/" + fileName;
        }
        return null;
    }

    // Legacy support for old URLs - Redirect to list
    @GetMapping("/ProductosController")
    public String legacyHandler(@RequestParam(value = "accion", required = false) String accion,
            @RequestParam(value = "id", required = false) Integer id,
            Model model) {
        return "redirect:/productos";
    }
}
