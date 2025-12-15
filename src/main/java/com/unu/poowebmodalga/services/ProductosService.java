package com.unu.poowebmodalga.services;

import com.unu.poowebmodalga.model.Categoria;
import com.unu.poowebmodalga.model.Producto;
import com.unu.poowebmodalga.repository.CategoriaRepository;
import com.unu.poowebmodalga.repository.ProductoRepository;
import com.unu.poowebmodalga.repository.ProveedoresRepository;
import com.unu.poowebmodalga.model.Movimiento;
import com.unu.poowebmodalga.repository.MovimientoRepository;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductosService {

    private final ProductoRepository productoRepository;
    private final CategoriaRepository categoriaRepository;
    private final ProveedoresRepository proveedoresRepository;
    private final MovimientoRepository movimientoRepository;

    public ProductosService(ProductoRepository productoRepository, CategoriaRepository categoriaRepository,
            ProveedoresRepository proveedoresRepository, MovimientoRepository movimientoRepository) {
        this.productoRepository = productoRepository;
        this.categoriaRepository = categoriaRepository;
        this.proveedoresRepository = proveedoresRepository;
        this.movimientoRepository = movimientoRepository;
    }

    public List<Producto> listarProductos() {
        return productoRepository.findByEstadoOrderByNombreAsc("ACTIVO");
    }

    public int insertarProducto(Producto producto) {
        Categoria categoria = categoriaRepository.findById(producto.getIdCategoria()).orElse(null);
        if (categoria != null) {
            producto.setCategoria(categoria);

            // Asignar proveedor si existe
            if (producto.getIdProveedor() > 0) {
                proveedoresRepository.findById(producto.getIdProveedor())
                        .ifPresent(producto::setProveedor);
            }

            Producto nuevoProducto = productoRepository.save(producto);

            // Registrar movimiento inicial
            if (nuevoProducto.getStock() > 0) {
                Movimiento movimiento = new Movimiento(
                        nuevoProducto, "ENTRADA", nuevoProducto.getStock());
                movimientoRepository.save(movimiento);
            }
            return 1;
        }
        return 0;
    }

    public Producto obtenerProducto(int idProducto) {
        Producto p = productoRepository.findById(idProducto).orElse(null);
        if (p != null) {
            p.setIdCategoria(p.getCategoria().getIdCategoria());
            if (p.getProveedor() != null) {
                p.setIdProveedor(p.getProveedor().getIdProveedor());
            }
        }
        return p;
    }

    public int modificarProducto(Producto producto) {
        return productoRepository.findById(producto.getIdProducto()).map(existing -> {
            Categoria categoria = categoriaRepository.findById(producto.getIdCategoria()).orElse(null);
            if (categoria != null) {
                int stockAnterior = existing.getStock();
                int nuevoStock = producto.getStock();

                existing.setCategoria(categoria);

                // Actualizar proveedor
                if (producto.getIdProveedor() > 0) {
                    proveedoresRepository.findById(producto.getIdProveedor())
                            .ifPresent(existing::setProveedor);
                } else {
                    existing.setProveedor(null);
                }

                existing.setNombre(producto.getNombre());
                existing.setDescripcion(producto.getDescripcion());
                existing.setPrecio(producto.getPrecio());
                existing.setStock(nuevoStock);
                existing.setImagen(producto.getImagen());
                productoRepository.save(existing);

                // Registrar movimiento por diferencia
                if (nuevoStock != stockAnterior) {
                    int diferencia = nuevoStock - stockAnterior;
                    String tipo = diferencia > 0 ? "ENTRADA" : "SALIDA";
                    Movimiento movimiento = new Movimiento(
                            existing, tipo, Math.abs(diferencia));
                    movimientoRepository.save(movimiento);
                }

                return 1;
            }
            return 0;
        }).orElse(0);
    }

    public int eliminarProducto(int idProducto) {
        return productoRepository.findById(idProducto).map(p -> {
            p.setEstado("INACTIVO");
            productoRepository.save(p);
            return 1;
        }).orElse(0);
    }

    public int contarProductos() {
        return (int) productoRepository.countActivos();
    }

    public int contarStockBajo() {
        return (int) productoRepository.countStockBajo();
    }

    public List<Object[]> obtenerDatosStockCategoria() {
        return productoRepository.countProductosByCategoria();
    }
}
