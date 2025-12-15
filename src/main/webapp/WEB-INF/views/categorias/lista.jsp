<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Categorías - ControlInventarioPRO</title>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.0/css/all.min.css">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<!-- Componentes Globales -->
<jsp:include page="../components/sidebar.jsp">
    <jsp:param name="active" value="categorias" />
</jsp:include>

<jsp:include page="../components/navbar.jsp" />

<div class="main-content">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">Gestión de Categorías</h2>
            <button type="button" class="btn btn-primary-glow" onclick="nuevaCategoria()">
                <i class="fas fa-plus"></i> Nueva Categoría
            </button>
        </div>

        <div class="glass-card">
            <div class="card-body-glass">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cat" items="${listaCategorias}">
                                <tr>
                                    <td>#${cat.idCategoria}</td>
                                    <td><strong class="text-white">${cat.nombre}</strong></td>
                                    <td class="text-muted">${cat.descripcion}</td>
                                    <td><span class="badge bg-success">${cat.estado}</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-glass text-warning" 
                                            onclick="editarCategoria(${cat.idCategoria}, '${cat.nombre}', '${cat.descripcion}')">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <a href="${pageContext.request.contextPath}/categorias/eliminar?id=${cat.idCategoria}" class="btn btn-sm btn-glass text-danger" onclick="return confirm('¿Eliminar categoría?')"><i class="fas fa-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                             <c:if test="${empty listaCategorias}">
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <i class="fas fa-tags fa-3x mb-3 opacity-50"></i><br>
                                        No hay categorías registradas
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
<div class="modal fade" id="categoriaModal" tabindex="-1" aria-labelledby="modalTitulo" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitulo">Nueva Categoría</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="${pageContext.request.contextPath}/categorias/guardar" method="POST" id="formCategoria">
      <div class="modal-body">
            <input type="hidden" name="id" id="idCategoria" value="0">

            <div class="mb-3">
                <label class="form-label text-muted small text-uppercase fw-bold">Nombre de Categoría</label>
                <input type="text" class="form-control" name="nombre" id="nombre" required>
            </div>

            <div class="mb-3">
                <label class="form-label text-muted small text-uppercase fw-bold">Descripción</label>
                <textarea class="form-control" name="descripcion" id="descripcion" rows="3"></textarea>
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
    function nuevaCategoria() {
        document.getElementById("formCategoria").reset();
        document.getElementById("formCategoria").action = "${pageContext.request.contextPath}/categorias/guardar";
        document.getElementById("idCategoria").value = "0";
        document.getElementById("modalTitulo").innerText = "Nueva Categoría";
        new bootstrap.Modal(document.getElementById('categoriaModal')).show();
    }

    function editarCategoria(id, nombre, descripcion) {
        document.getElementById("idCategoria").value = id;
        document.getElementById("nombre").value = nombre;
        document.getElementById("descripcion").value = descripcion;
        document.getElementById("formCategoria").action = "${pageContext.request.contextPath}/categorias/actualizar";

        document.getElementById("modalTitulo").innerText = "Editar Categoría";
        new bootstrap.Modal(document.getElementById('categoriaModal')).show();
    }
</script>

</body>
</html>
