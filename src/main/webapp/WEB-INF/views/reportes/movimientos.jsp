<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.model.Movimiento" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Historial de Movimientos - ControlInventarioPRO</title>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <!-- Navbar -->
    <jsp:include page="../components/navbar.jsp" />

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary mb-0">
                <i class="fas fa-history"></i> Historial de Movimientos
            </h2>
            <a href="${pageContext.request.contextPath}/reportes/movimientos/pdf" class="btn btn-danger">
                <i class="fas fa-file-pdf"></i> Exportar a PDF
            </a>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Fecha y Hora</th>
                                <th>Producto</th>
                                <th class="text-center">Tipo</th>
                                <th class="text-center">Cantidad</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            List<Movimiento> listaMovimientos = (List<Movimiento>) request.getAttribute("listaMovimientos");
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                            
                            if (listaMovimientos != null && !listaMovimientos.isEmpty()) {
                                for (Movimiento m : listaMovimientos) {
                                    String tipoClass = "ENTRADA".equalsIgnoreCase(m.getTipo()) ? "bg-success" : "bg-danger";
                                    String icono = "ENTRADA".equalsIgnoreCase(m.getTipo()) ? "fa-arrow-down" : "fa-arrow-up";
                                    String productoNombre = m.getProducto() != null ? m.getProducto().getNombre() : "Producto Eliminado";
                            %>
                            <tr>
                                <td><%= m.getIdMovimiento() %></td>
                                <td><%= m.getFecha() != null ? sdf.format(m.getFecha()) : "-" %></td>
                                <td>
                                    <strong><%= productoNombre %></strong>
                                </td>
                                <td class="text-center">
                                    <span class="badge <%= tipoClass %>">
                                        <i class="fas <%= icono %>"></i> <%= m.getTipo() %>
                                    </span>
                                </td>
                                <td class="text-center fw-bold">
                                    <%= m.getCantidad() %>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">
                                    <i class="fas fa-exchange-alt fa-2x mb-2"></i><br>
                                    No hay movimientos registrados
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

    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
