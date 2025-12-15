package com.unu.poowebmodalga.controllers;

import com.unu.poowebmodalga.model.Movimiento;
import com.unu.poowebmodalga.services.CategoriasService;
import com.unu.poowebmodalga.services.MovimientosService;
import com.unu.poowebmodalga.services.ProductosService;
import com.unu.poowebmodalga.services.UsuariosService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class DashboardController {

    private final ProductosService productosService;
    private final CategoriasService categoriasService;
    private final UsuariosService usuariosService;
    private final MovimientosService movimientosService;
    private final com.unu.poowebmodalga.services.ProveedoresService proveedoresService;

    public DashboardController(ProductosService productosService,
            CategoriasService categoriasService,
            UsuariosService usuariosService,
            MovimientosService movimientosService,
            com.unu.poowebmodalga.services.ProveedoresService proveedoresService) {
        this.productosService = productosService;
        this.categoriasService = categoriasService;
        this.usuariosService = usuariosService;
        this.movimientosService = movimientosService;
        this.proveedoresService = proveedoresService;
    }

    @GetMapping("/DashboardController")
    public String mostrarDashboard(Model model) {
        System.out.println("DEBUG: Executing DashboardController.mostrarDashboard");
        int totalProductos = productosService.contarProductos();
        int totalCategorias = categoriasService.contarCategorias();
        int totalUsuarios = usuariosService.contarUsuarios();
        int stockBajo = productosService.contarStockBajo();
        List<Movimiento> ultimosMovimientos = movimientosService.listarUltimosMovimientos();

        System.out.println("DEBUG: Dashboard Data - Productos: " + totalProductos);
        System.out.println("DEBUG: Dashboard Data - Categorias: " + totalCategorias);
        System.out.println("DEBUG: Dashboard Data - Usuarios: " + totalUsuarios);
        System.out.println("DEBUG: Dashboard Data - StockBajo: " + stockBajo);
        System.out.println("DEBUG: Dashboard Data - Movimientos: "
                + (ultimosMovimientos != null ? ultimosMovimientos.size() : "null"));

        model.addAttribute("totalProductos", totalProductos);
        model.addAttribute("totalCategorias", totalCategorias);
        model.addAttribute("totalUsuarios", totalUsuarios);
        model.addAttribute("stockBajo", stockBajo);
        model.addAttribute("ultimosMovimientos", ultimosMovimientos);
        model.addAttribute("totalProveedores", proveedoresService.contarProveedores());
        model.addAttribute("proveedoresActivos", proveedoresService.contarProveedoresActivos());

        return "inicio";
    }

    @GetMapping("/inicio")
    public String redireccionarInicio() {
        return "redirect:/DashboardController";
    }

    @GetMapping("/api/dashboard/stats")
    @org.springframework.web.bind.annotation.ResponseBody
    public java.util.Map<String, Object> getStats() {
        java.util.Map<String, Object> stats = new java.util.HashMap<>();
        stats.put("totalProductos", productosService.contarProductos());
        stats.put("totalCategorias", categoriasService.contarCategorias());
        stats.put("totalUsuarios", usuariosService.contarUsuarios());
        stats.put("stockBajo", productosService.contarStockBajo());
        stats.put("totalProveedores", proveedoresService.contarProveedores());
        stats.put("proveedoresActivos", proveedoresService.contarProveedoresActivos());
        return stats;
    }

    @GetMapping("/api/dashboard/chart/stock-category")
    @org.springframework.web.bind.annotation.ResponseBody
    public List<Object[]> getStockByCategory() {
        return productosService.obtenerDatosStockCategoria();
    }

    @GetMapping("/api/dashboard/chart/movements-weekly")
    @org.springframework.web.bind.annotation.ResponseBody
    public List<Object[]> getWeeklyMovements() {
        return movimientosService.obtenerDatosMovimientosSemana();
    }

    @GetMapping("/api/dashboard/chart/top-providers")
    @org.springframework.web.bind.annotation.ResponseBody
    public List<Object[]> getTopProviders() {
        return proveedoresService.obtenerTopProveedores();
    }
}
