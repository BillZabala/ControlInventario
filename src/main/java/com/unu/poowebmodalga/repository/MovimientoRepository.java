package com.unu.poowebmodalga.repository;

import com.unu.poowebmodalga.model.Movimiento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MovimientoRepository extends JpaRepository<Movimiento, Integer> {

    List<Movimiento> findTop10ByOrderByFechaDesc();

    List<Movimiento> findAllByOrderByFechaDesc();

    @Query(value = "SELECT DATE(fecha) as dia, COUNT(*) FROM movimientos WHERE fecha >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) GROUP BY dia ORDER BY dia ASC", nativeQuery = true)
    List<Object[]> countMovimientosLastWeek();
}
