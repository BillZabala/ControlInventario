package com.unu.poowebmodalga.services;

import com.unu.poowebmodalga.model.Categoria;
import com.unu.poowebmodalga.repository.CategoriaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoriasService {

    private final CategoriaRepository categoriaRepository;

    public CategoriasService(CategoriaRepository categoriaRepository) {
        this.categoriaRepository = categoriaRepository;
    }

    public List<Categoria> listarCategorias() {
        return categoriaRepository.findByEstadoOrderByNombreAsc("ACTIVO");
    }

    public int insertarCategoria(Categoria categoria) {
        categoriaRepository.save(categoria);
        return 1;
    }

    public Categoria obtenerCategoria(int idCategoria) {
        return categoriaRepository.findById(idCategoria).orElse(null);
    }

    public int modificarCategoria(Categoria categoria) {
        return categoriaRepository.findById(categoria.getIdCategoria()).map(existing -> {
            existing.setNombre(categoria.getNombre());
            existing.setDescripcion(categoria.getDescripcion());
            categoriaRepository.save(existing);
            return 1;
        }).orElse(0);
    }

    public int eliminarCategoria(int idCategoria) {
        return categoriaRepository.findById(idCategoria).map(c -> {
            c.setEstado("INACTIVO");
            categoriaRepository.save(c);
            return 1;
        }).orElse(0);
    }

    public int contarCategorias() {
        return (int) categoriaRepository.countByEstado("ACTIVO");
    }
}
