package com.unu.poowebmodalga.repository;

import com.unu.poowebmodalga.model.Producto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductoRepository extends JpaRepository<Producto, Integer> {

    List<Producto> findByEstadoOrderByNombreAsc(String estado);

    @Query("SELECT COUNT(p) FROM Producto p WHERE p.estado = 'ACTIVO'")
    long countActivos();

    @Query("SELECT COUNT(p) FROM Producto p WHERE p.stock < 10 AND p.estado = 'ACTIVO'")
    long countStockBajo();

    @Query("SELECT p.categoria.nombre, COUNT(p) FROM Producto p WHERE p.estado = 'ACTIVO' GROUP BY p.categoria.nombre")
    List<Object[]> countProductosByCategoria();

    @Query("SELECT p.proveedor.nombre, COUNT(p) FROM Producto p GROUP BY p.proveedor.nombre ORDER BY COUNT(p) DESC")
    List<Object[]> countProductosPorProveedor();
}
