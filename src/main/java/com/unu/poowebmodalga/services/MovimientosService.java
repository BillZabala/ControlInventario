package com.unu.poowebmodalga.services;

import com.unu.poowebmodalga.model.Movimiento;
import com.unu.poowebmodalga.model.Producto;
import com.unu.poowebmodalga.repository.MovimientoRepository;
import com.unu.poowebmodalga.repository.ProductoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MovimientosService {

    private final MovimientoRepository movimientoRepository;
    private final ProductoRepository productoRepository;

    public MovimientosService(MovimientoRepository movimientoRepository, ProductoRepository productoRepository) {
        this.movimientoRepository = movimientoRepository;
        this.productoRepository = productoRepository;
    }

    public List<Movimiento> listarUltimosMovimientos() {
        return movimientoRepository.findTop10ByOrderByFechaDesc();
    }

    public List<Movimiento> listarMovimientos() {
        return movimientoRepository.findAllByOrderByFechaDesc();
    }

    public int registrarMovimiento(int idProducto, String tipo, int cantidad) {
        // Find product
        Producto producto = productoRepository.findById(idProducto).orElse(null);
        if (producto != null) {
            Movimiento movimiento = new Movimiento(producto, tipo, cantidad);
            movimientoRepository.save(movimiento);

            // Update stock ? Stored procedure didn't seem to update stock explicitly in
            // `sp_registrarMovimiento`
            // but usually it should.
            // Checking database.sql: sp_registrarMovimiento just inserts.
            // But usually a movement implies stock update.
            // Analyzing sp_registrarMovimiento in database.sql:
            /*
             * CREATE PROCEDURE sp_registrarMovimiento(IN p_idproducto INT, IN p_tipo
             * VARCHAR(20), IN p_cantidad INT)
             * BEGIN
             * INSERT INTO movimientos (idproducto, tipo, cantidad) VALUES (p_idproducto,
             * p_tipo, p_cantidad);
             * END
             */
            // It seems the stock update logic was missing in the SP or handled elsewhere?
            // Or maybe trigger? database.sql didn't show triggers.
            // I will strictly allow the same behavior (just insert).

            return 1;
        }
        return 0;
    }

    public List<Object[]> obtenerDatosMovimientosSemana() {
        return movimientoRepository.countMovimientosLastWeek();
    }
}
