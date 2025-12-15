<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Proveedores - ControlInventarioPRO</title>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.0/css/all.min.css">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<!-- Componentes Globales -->
<jsp:include page="../components/sidebar.jsp">
    <jsp:param name="active" value="proveedores" />
</jsp:include>

<jsp:include page="../components/navbar.jsp" />

<div class="main-content">
    <div class="container-fluid">
        
        <c:if test="${not empty mensaje}">
            <div class="alert alert-success alert-dismissible fade show glass-card border-0 bg-success bg-opacity-25 text-white" role="alert">
                ${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">Gestión de Proveedores</h2>
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary-glow" onclick="nuevoProveedor()">
                <i class="fas fa-plus"></i> Nuevo Proveedor
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
                                <th>Contacto</th>
                                <th>Teléfono</th>
                                <th>Email</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prov" items="${proveedores}">
                                <tr>
                                    <td>#${prov.idProveedor}</td>
                                    <td><strong class="text-white">${prov.nombre}</strong></td>
                                    <td>${prov.contacto}</td>
                                    <td>${prov.telefono}</td>
                                    <td>${prov.email}</td>
                                    <td>
                                        <button class="btn btn-sm btn-glass text-warning btn-editar" 
                                            data-id="${prov.idProveedor}"
                                            data-nombre="${prov.nombre}"
                                            data-contacto="${prov.contacto}"
                                            data-telefono="${prov.telefono}"
                                            data-email="${prov.email}"
                                            data-direccion="${prov.direccion}"
                                            onclick="cargarDatosEditar(this)">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <a href="${pageContext.request.contextPath}/proveedores/eliminar/${prov.idProveedor}" class="btn btn-sm btn-glass text-danger" onclick="return confirm('¿Eliminar proveedor?')"><i class="fas fa-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty proveedores}">
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        <i class="fas fa-truck fa-3x mb-3 opacity-50"></i><br>
                                        No hay proveedores registrados
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
<div class="modal fade" id="proveedorModal" tabindex="-1" aria-labelledby="modalTitulo" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitulo">Nuevo Proveedor</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="${pageContext.request.contextPath}/proveedores/guardar" method="POST" id="formProveedor">
      <div class="modal-body">
            <input type="hidden" name="idProveedor" id="idProveedor" value="0">

            <div class="mb-3">
                <label class="form-label text-muted small text-uppercase fw-bold">Nombre de la Empresa / Proveedor</label>
                <input type="text" class="form-control" name="nombre" id="nombre" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted small text-uppercase fw-bold">Nombre de Contacto</label>
                    <input type="text" class="form-control" name="contacto" id="contacto">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted small text-uppercase fw-bold">Teléfono</label>
                    <input type="text" class="form-control" name="telefono" id="telefono">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label text-muted small text-uppercase fw-bold">Correo Electrónico</label>
                <input type="email" class="form-control" name="email" id="email">
            </div>

            <div class="mb-3">
                <label class="form-label text-muted small text-uppercase fw-bold">Dirección</label>
                <textarea class="form-control" name="direccion" id="direccion" rows="3"></textarea>
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
    function nuevoProveedor() {
        document.getElementById("formProveedor").reset();
        document.getElementById("idProveedor").value = "0";
        document.getElementById("modalTitulo").innerText = "Nuevo Proveedor";
        new bootstrap.Modal(document.getElementById('proveedorModal')).show();
    }

    function cargarDatosEditar(btn) {
        var id = btn.getAttribute("data-id");
        var nombre = btn.getAttribute("data-nombre");
        var contacto = btn.getAttribute("data-contacto");
        var telefono = btn.getAttribute("data-telefono");
        var email = btn.getAttribute("data-email");
        var direccion = btn.getAttribute("data-direccion");

        document.getElementById("idProveedor").value = id;
        document.getElementById("nombre").value = nombre;
        document.getElementById("contacto").value = contacto;
        document.getElementById("telefono").value = telefono;
        document.getElementById("email").value = email;
        document.getElementById("direccion").value = direccion;

        document.getElementById("modalTitulo").innerText = "Editar Proveedor";
        new bootstrap.Modal(document.getElementById('proveedorModal')).show();
    }
</script>

</body>
</html>
