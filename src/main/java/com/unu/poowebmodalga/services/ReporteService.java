package com.unu.poowebmodalga.services;

import com.unu.poowebmodalga.model.Producto;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

@Service
public class ReporteService {

    public ByteArrayInputStream generarReporteStock(List<Producto> productos) {
        // Adjusted columns based on available fields in Producto model
        String[] columns = { "ID", "Nombre", "Descripción", "Stock", "Precio", "Categoría", "Estado" };

        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet("Stock");

            // Header Font
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.WHITE.getIndex());

            // Header CellStyle
            CellStyle headerCellStyle = workbook.createCellStyle();
            headerCellStyle.setFont(headerFont);
            headerCellStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
            headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // Row for Header
            Row headerRow = sheet.createRow(0);

            // Header
            for (int col = 0; col < columns.length; col++) {
                Cell cell = headerRow.createCell(col);
                cell.setCellValue(columns[col]);
                cell.setCellStyle(headerCellStyle);
            }

            int rowIdx = 1;
            for (Producto producto : productos) {
                Row row = sheet.createRow(rowIdx++);

                row.createCell(0).setCellValue(producto.getIdProducto());
                row.createCell(1).setCellValue(producto.getNombre());
                row.createCell(2).setCellValue(producto.getDescripcion());
                row.createCell(3).setCellValue(producto.getStock());
                // Assuming getPrecio returns BigDecimal, checking for null
                row.createCell(4).setCellValue(producto.getPrecio() != null ? producto.getPrecio().doubleValue() : 0.0);
                row.createCell(5).setCellValue(
                        producto.getCategoria() != null ? producto.getCategoria().getNombre() : "Sin Categoría");
                row.createCell(6).setCellValue(producto.getEstado());
            }

            // Auto-size columns
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        } catch (IOException e) {
            throw new RuntimeException("Error al generar el archivo Excel: " + e.getMessage());
        }
    }
}
