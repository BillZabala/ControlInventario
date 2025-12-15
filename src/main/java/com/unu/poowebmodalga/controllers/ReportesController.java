package com.unu.poowebmodalga.controllers;

import com.unu.poowebmodalga.model.Movimiento;
import com.unu.poowebmodalga.model.Producto;
import com.unu.poowebmodalga.services.MovimientosService;
import com.unu.poowebmodalga.services.ProductosService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.core.io.InputStreamResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.ByteArrayInputStream;
import java.util.List;

@Controller
@RequestMapping("/reportes")
public class ReportesController {

    private final ProductosService productosService;
    private final MovimientosService movimientosService;
    private final com.unu.poowebmodalga.services.ReporteService reporteService;
    private final com.unu.poowebmodalga.services.PdfReportService pdfReportService;

    public ReportesController(ProductosService productosService,
            MovimientosService movimientosService,
            com.unu.poowebmodalga.services.ReporteService reporteService,
            com.unu.poowebmodalga.services.PdfReportService pdfReportService) {
        this.productosService = productosService;
        this.movimientosService = movimientosService;
        this.reporteService = reporteService;
        this.pdfReportService = pdfReportService;
    }

    @GetMapping("/stock")
    public String reporteStock(Model model) {
        List<Producto> productos = productosService.listarProductos();
        model.addAttribute("listaProductos", productos);
        return "reportes/stock";
    }

    @GetMapping("/movimientos")
    public String reporteMovimientos(Model model) {
        List<Movimiento> movimientos = movimientosService.listarMovimientos();
        model.addAttribute("listaMovimientos", movimientos);
        return "reportes/movimientos";
    }

    @GetMapping("/stock/excel")
    public org.springframework.http.ResponseEntity<org.springframework.core.io.InputStreamResource> exportarStockExcel() {
        List<Producto> productos = productosService.listarProductos();
        java.io.ByteArrayInputStream in = reporteService.generarReporteStock(productos);

        org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=reporte_stock.xlsx");

        return org.springframework.http.ResponseEntity
                .ok()
                .headers(headers)
                .contentType(org.springframework.http.MediaType
                        .parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                .body(new org.springframework.core.io.InputStreamResource(in));
    }

    @GetMapping("/stock/pdf")
    public org.springframework.http.ResponseEntity<org.springframework.core.io.InputStreamResource> exportarStockPdf() {
        List<Producto> productos = productosService.listarProductos();
        java.io.ByteArrayInputStream in = pdfReportService.generarReporteStock(productos);

        org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=reporte_stock.pdf");

        return org.springframework.http.ResponseEntity
                .ok()
                .headers(headers)
                .contentType(org.springframework.http.MediaType.APPLICATION_PDF)
                .body(new org.springframework.core.io.InputStreamResource(in));
    }

    @GetMapping("/movimientos/pdf")
    public org.springframework.http.ResponseEntity<org.springframework.core.io.InputStreamResource> exportarMovimientosPdf() {
        List<Movimiento> movimientos = movimientosService.listarMovimientos();
        java.io.ByteArrayInputStream in = pdfReportService.generarReporteMovimientos(movimientos);

        org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=reporte_movimientos.pdf");

        return org.springframework.http.ResponseEntity
                .ok()
                .headers(headers)
                .contentType(org.springframework.http.MediaType.APPLICATION_PDF)
                .body(new org.springframework.core.io.InputStreamResource(in));
    }
}
