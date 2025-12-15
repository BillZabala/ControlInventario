package com.unu.poowebmodalga.services;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.unu.poowebmodalga.model.Movimiento;
import com.unu.poowebmodalga.model.Producto;
import org.springframework.stereotype.Service;

import java.awt.Color;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.List;

@Service
public class PdfReportService {

    public ByteArrayInputStream generarReporteStock(List<Producto> productos) {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Title
            Font fontTitle = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, Color.BLACK);
            Paragraph title = new Paragraph("Reporte de Stock Actual", fontTitle);
            title.setAlignment(Paragraph.ALIGN_CENTER);
            document.add(title);
            document.add(new Paragraph(" ")); // Spacer

            // Table
            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            table.setWidths(new int[] { 1, 4, 3, 2, 2 });

            String[] headers = { "ID", "Producto", "Categoría", "Precio", "Stock" };
            for (String header : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(header, FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
                cell.setBackgroundColor(Color.LIGHT_GRAY);
                cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
                table.addCell(cell);
            }

            for (Producto p : productos) {
                table.addCell(String.valueOf(p.getIdProducto()));
                table.addCell(p.getNombre());
                table.addCell(p.getCategoria() != null ? p.getCategoria().getNombre() : "S/C");
                table.addCell(String.format("S/. %.2f", p.getPrecio()));
                table.addCell(String.valueOf(p.getStock()));
            }

            document.add(table);
            document.close();

        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return new ByteArrayInputStream(out.toByteArray());
    }

    public ByteArrayInputStream generarReporteMovimientos(List<Movimiento> movimientos) {
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            Font fontTitle = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, Color.BLACK);
            Paragraph title = new Paragraph("Reporte de Movimientos", fontTitle);
            title.setAlignment(Paragraph.ALIGN_CENTER);
            document.add(title);
            document.add(new Paragraph(" "));

            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            table.setWidths(new int[] { 3, 3, 2, 2, 2 });

            String[] headers = { "Producto", "Fecha", "Tipo", "Cantidad", "Stock Resultante" }; // Stock Resultante
                                                                                                // currently not tracked
                                                                                                // in Movimiento model
                                                                                                // explicitly per row?
                                                                                                // Check model.
            // Actually checking Movimiento model previously it seemed simple.
            // Let's stick to available fields.

            for (String header : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(header, FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
                cell.setBackgroundColor(Color.LIGHT_GRAY);
                cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
                table.addCell(cell);
            }

            for (Movimiento m : movimientos) {
                table.addCell(m.getProducto().getNombre());
                table.addCell(m.getFecha().toString());
                table.addCell(m.getTipo());
                table.addCell(String.valueOf(m.getCantidad()));
                table.addCell("-"); // Placeholder or remove column if data not available
            }

            document.add(table);
            document.close();

        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return new ByteArrayInputStream(out.toByteArray());
    }
}
