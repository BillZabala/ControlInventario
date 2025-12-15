package com.unu.poowebmodalga.services;

import com.unu.poowebmodalga.model.Proveedor;
import com.unu.poowebmodalga.repository.ProveedoresRepository;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProveedoresService {

    private final ProveedoresRepository proveedoresRepository;
    private final com.unu.poowebmodalga.repository.ProductoRepository productoRepository;

    public ProveedoresService(ProveedoresRepository proveedoresRepository,
            com.unu.poowebmodalga.repository.ProductoRepository productoRepository) {
        this.proveedoresRepository = proveedoresRepository;
        this.productoRepository = productoRepository;
    }

    public List<Proveedor> listarProveedores() {
        return proveedoresRepository.findByEstado("ACTIVO");
    }

    public void guardarProveedor(Proveedor proveedor) {
        proveedoresRepository.save(proveedor);
    }

    public Proveedor obtenerProveedor(int id) {
        return proveedoresRepository.findById(id).orElse(null);
    }

    public void eliminarProveedor(int id) {
        proveedoresRepository.findById(id).ifPresent(p -> {
            p.setEstado("INACTIVO");
            proveedoresRepository.save(p);
        });
    }

    public long contarProveedores() {
        return proveedoresRepository.count();
    }

    public long contarProveedoresActivos() {
        return proveedoresRepository.countByEstado("ACTIVO");
    }

    public List<Object[]> obtenerTopProveedores() {
        return productoRepository.countProductosPorProveedor();
    }
}
