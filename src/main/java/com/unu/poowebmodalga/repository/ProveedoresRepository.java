package com.unu.poowebmodalga.repository;

import com.unu.poowebmodalga.model.Proveedor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProveedoresRepository extends JpaRepository<Proveedor, Integer> {
    List<Proveedor> findByEstado(String estado);

    long countByEstado(String estado);
}
