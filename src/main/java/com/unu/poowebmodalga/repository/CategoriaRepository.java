package com.unu.poowebmodalga.repository;

import com.unu.poowebmodalga.model.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {

    List<Categoria> findByEstadoOrderByNombreAsc(String estado);

    long countByEstado(String estado);
}
