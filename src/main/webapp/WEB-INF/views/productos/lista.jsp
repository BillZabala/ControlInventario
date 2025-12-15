<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Productos - ControlInventarioPRO</title>

<!-- Fonts & Styles -->
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.0/css/all.min.css">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

</head>
<body>

<!-- Componentes Globales -->
<jsp:include page="../components/sidebar.jsp">
    <jsp:param name="active" value="productos" />
</jsp:include>

<jsp:include page="../components/navbar.jsp" />

<div class="main-content">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">Gestión de Productos</h2>
             <button type="button" class="btn btn-primary-glow" onclick="nuevoProducto()">
                <i class="fas fa-plus"></i> Nuevo Producto
            </button>
        </div>

        <div class="glass-card">
            <div class="card-body-glass">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Imagen</th>
                                <th>Producto</th>
                                <th>Categoría</th>
                                <th>Proveedor</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prod" items="${listaProductos}">
                                <tr>
                                    <td>#${prod.idProducto}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty prod.imagen}">
                                                <img src="${prod.imagen}" alt="${prod.nombre}" width="50" height="50" class="rounded border border-secondary">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bg-dark rounded d-flex align-items-center justify-content-center" style="width: 50px; height: 50px; border: 1px solid rgba(255,255,255,0.1);">
                                                    <i class="fas fa-image text-muted"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <strong class="text-white">${prod.nombre}</strong><br>
                                        <small class="text-muted text-truncate d-inline-block" style="max-width: 150px;">${prod.descripcion}</small>
                                    </td>
                                    <td><span class="badge bg-info text-dark">${prod.nombreCategoria}</span></td>
                                    <td><span class="badge bg-secondary">${prod.nombreProveedor}</span></td>
                                    <td class="text-white fw-bold">S/ ${prod.precio}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${prod.stock < 10}"><span class="badge bg-danger">${prod.stock}</span></c:when>
                                            <c:otherwise><span class="badge bg-success">${prod.stock}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><span class="badge bg-primary">${prod.estado}</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-glass text-warning" 
                                            onclick="editarProducto(${prod.idProducto}, '${prod.nombre}', '${prod.descripcion}', ${prod.categoria.idCategoria}, ${prod.proveedor != null ? prod.proveedor.idProveedor : 0}, ${prod.precio}, ${prod.stock}, '${prod.imagen}')">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <a href="${pageContext.request.contextPath}/productos/eliminar?id=${prod.idProducto}" class="btn btn-sm btn-glass text-danger" onclick="return confirm('¿Eliminar producto?')"><i class="fas fa-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listaProductos}">
                                <tr>
                                    <td colspan="9" class="text-center py-5 text-muted">
                                        <i class="fas fa-box-open fa-3x mb-3 opacity-50"></i><br>
                                        No hay productos registrados
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Formulario -->
<div class="modal fade" id="productoModal" tabindex="-1" aria-labelledby="modalTitulo" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitulo">Nuevo Producto</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="${pageContext.request.contextPath}/productos/guardar" method="POST" enctype="multipart/form-data" id="formProducto">
      <div class="modal-body">
            <input type="hidden" name="id" id="idProducto" value="0">
            <input type="hidden" name="imagenActual" id="imagenActual">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted small text-uppercase fw-bold">Nombre del Producto</label>
                    <input type="text" class="form-control" name="nombre" id="nombre" required placeholder="Ej. Laptop HP">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted small text-uppercase fw-bold">Categoría</label>
                    <select class="form-select" name="idCategoria" id="idCategoria" required>
                        <option value="">Seleccione una categoría</option>
                        <c:forEach var="cat" items="${listaCategorias}">
                            <option value="${cat.idCategoria}">${cat.nombre}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted small text-uppercase fw-bold">Proveedor</label>
                    <select class="form-select" name="idProveedor" id="idProveedor">
                        <option value="0">Sin Proveedor</option>
                        <c:forEach var="prov" items="${listaProveedores}">
                            <option value="${prov.idProveedor}">${prov.nombre}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label text-muted small text-uppercase fw-bold">Descripción</label>
                <textarea class="form-control" name="descripcion" id="descripcion" rows="3" placeholder="Detalles del producto..."></textarea>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted small text-uppercase fw-bold">Precio (S/)</label>
                    <div class="input-group">
                        <span class="input-group-text bg-dark border-secondary text-muted">S/</span>
                        <input type="number" step="0.01" class="form-control" name="precio" id="precio" required>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted small text-uppercase fw-bold">Stock</label>
                    <input type="number" class="form-control" name="stock" id="stock" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label text-muted small text-uppercase fw-bold">Imagen</label>
                <div class="glass-card p-3 mb-2 bg-transparent border-secondary">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="tipoImagen" id="radioUrl" value="url" checked onclick="toggleImagenInput()">
                        <label class="form-check-label text-white" for="radioUrl">URL</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="tipoImagen" id="radioArchivo" value="archivo" onclick="toggleImagenInput()">
                        <label class="form-check-label text-white" for="radioArchivo">Subir Archivo</label>
                    </div>
                    
                    <div class="mt-2">
                         <input type="text" class="form-control" name="imagenUrl" id="inputUrl" placeholder="https://ejemplo.com/imagen.jpg">
                         <input type="file" class="form-control d-none" name="imagenFile" id="inputFile" accept="image/*">
                    </div>
                </div>
            </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-glass" data-bs-dismiss="modal">Cancelar</button>
        <button type="submit" class="btn btn-primary-glow"><i class="fas fa-save"></i> Guardar</button>
      </div>
      </form>
    </div>
  </div>
</div>

<script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
    function toggleImagenInput() {
        const isUrl = document.getElementById('radioUrl').checked;
        const inputUrl = document.getElementById('inputUrl');
        const inputFile = document.getElementById('inputFile');
        
        if (isUrl) {
            inputUrl.classList.remove('d-none');
            inputFile.classList.add('d-none');
        } else {
            inputUrl.classList.add('d-none');
            inputFile.classList.remove('d-none');
        }
    }

    function nuevoProducto() {
        document.getElementById("formProducto").reset();
        document.getElementById("formProducto").action = "${pageContext.request.contextPath}/productos/guardar";
        document.getElementById("idProducto").value = "0";
        document.getElementById("modalTitulo").innerText = "Nuevo Producto";
        
        // Reset radio
        document.getElementById('radioUrl').checked = true;
        toggleImagenInput();
        
        new bootstrap.Modal(document.getElementById('productoModal')).show();
    }

    function editarProducto(id, nombre, descripcion, idCategoria, idProveedor, precio, stock, imagen) {
        document.getElementById("idProducto").value = id;
        document.getElementById("nombre").value = nombre;
        document.getElementById("descripcion").value = descripcion;
        document.getElementById("idCategoria").value = idCategoria;
        if(idProveedor) document.getElementById("idProveedor").value = idProveedor;
        document.getElementById("precio").value = precio;
        document.getElementById("stock").value = stock;
        document.getElementById("imagenActual").value = imagen;
        
        document.getElementById("inputUrl").value = imagen; 

        document.getElementById("formProducto").action = "${pageContext.request.contextPath}/productos/actualizar";
        document.getElementById("modalTitulo").innerText = "Editar Producto";
        
        new bootstrap.Modal(document.getElementById('productoModal')).show();
    }
</script>

</body>
</html>
