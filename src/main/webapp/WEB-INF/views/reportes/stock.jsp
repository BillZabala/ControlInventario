<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.model.Producto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reporte de Stock - ControlInventarioPRO</title>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Navbar -->
    <jsp:include page="../components/sidebar.jsp">
        <jsp:param name="active" value="reportes" />
    </jsp:include>
    <jsp:include page="../components/navbar.jsp" />

    <div class="main-content">
        <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary mb-0">
                <i class="fas fa-chart-bar"></i> Reporte de Stock
            </h2>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/reportes/stock/excel" class="btn btn-success">
                    <i class="fas fa-file-excel"></i> Exportar a Excel
                </a>
                <a href="${pageContext.request.contextPath}/reportes/stock/pdf" class="btn btn-danger">
                    <i class="fas fa-file-pdf"></i> Exportar a PDF
                </a>
            </div>
        </div>

        <div class="glass-card">
            <div class="card-body-glass">
                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Imagen</th>
                                <th>Producto</th>
                                <th>Categoría</th>
                                <th class="text-end">Precio</th>
                                <th class="text-center">Stock</th>
                                <th class="text-center">Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProductos");
                            if (listaProductos != null && !listaProductos.isEmpty()) {
                                for (Producto p : listaProductos) {
                                    String stockClass = p.getStock() < 10 ? "bg-danger" : (p.getStock() < 20 ? "bg-warning text-dark" : "bg-success");
                                    String estadoClass = "ACTIVO".equals(p.getEstado()) ? "text-success" : "text-danger";
                                    String imagenUrl = (p.getImagen() != null && !p.getImagen().isEmpty()) 
                                            ? (p.getImagen().startsWith("http") ? p.getImagen() : request.getContextPath() + "/" + p.getImagen())
                                            : request.getContextPath() + "/images/no-image.png";
                            %>
                            <tr>
                                <td><%= p.getIdProducto() %></td>
                                <td>
                                    <img src="<%= imagenUrl %>" alt="<%= p.getNombre() %>" 
                                         class="img-thumbnail" style="width: 50px; height: 50px; object-fit: cover;">
                                </td>
                                <td><strong><%= p.getNombre() %></strong></td>
                                <td><%= p.getCategoria() != null ? p.getCategoria().getNombre() : "-" %></td>
                                <td class="text-end">S/ <%= String.format("%.2f", p.getPrecio()) %></td>
                                <td class="text-center">
                                    <span class="badge <%= stockClass %> rounded-pill">
                                        <%= p.getStock() %>
                                    </span>
                                </td>
                                <td class="text-center">
                                    <span class="<%= estadoClass %> fw-bold">
                                        <i class="fas <%= "ACTIVO".equals(p.getEstado()) ? "fa-check-circle" : "fa-times-circle" %>"></i>
                                        <%= p.getEstado() %>
                                    </span>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
                                    <i class="fas fa-box-open fa-2x mb-2"></i><br>
                                    No hay productos registrados
                                </td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    </div>

    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
