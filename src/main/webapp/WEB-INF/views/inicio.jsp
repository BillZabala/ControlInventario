<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.unu.poowebmodalga.model.Usuario" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard - ControlInventarioPRO</title>

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<!-- Bootstrap & FontAwesome -->
<link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.0/css/all.min.css">

<!-- Custom Styles -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

</head>
<body>

    <!-- Background Shapes (Optional, for extra flair like login) -->
    <div style="position: fixed; top: -10%; left: -10%; width: 600px; height: 600px; background: #8e2de2; filter: blur(150px); opacity: 0.2; border-radius: 50%; z-index: -1;"></div>
    <div style="position: fixed; bottom: -10%; right: -10%; width: 500px; height: 500px; background: #00ecbc; filter: blur(150px); opacity: 0.1; border-radius: 50%; z-index: -1;"></div>

    <!-- Sidebar -->
    <jsp:include page="components/sidebar.jsp">
        <jsp:param name="active" value="inicio" />
    </jsp:include>

    <!-- Top Header -->
    <jsp:include page="components/navbar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            
            <!-- Welcome Banner -->
            <div class="glass-card mb-4">
                <div class="card-body-glass d-flex justify-content-between align-items-center">
                    <div>
                        <h4 class="mb-1">Hola, <span class="text-gradient-primary"><%= usuario.getNombreCompleto() %></span> 👋</h4>
                        <p class="mb-0 text-muted">Aquí está el resumen de tu inventario hoy.</p>
                    </div>
                    <div class="d-none d-md-block">
                        <a href="${pageContext.request.contextPath}/reportes/stock/pdf" class="btn btn-primary-glow">
                            <i class="fas fa-download me-2"></i> Descargar Reporte
                        </a>
                    </div>
                </div>
            </div>

            <!-- KPIs Row -->
            <div class="row g-4">
                <!-- KPI Items -->
                <div class="col-md-3 col-xl-2">
                    <div class="glass-card h-100">
                        <div class="card-body-glass text-center">
                            <div class="stat-icon-wrapper mx-auto mb-3">
                                <i class="fas fa-box text-primary"></i>
                            </div>
                            <h6 class="stat-card-title">Productos</h6>
                            <h2 class="stat-card-value" id="stat-productos">${totalProductos}</h2>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 col-xl-2">
                    <div class="glass-card h-100">
                        <div class="card-body-glass text-center">
                            <div class="stat-icon-wrapper mx-auto mb-3">
                                <i class="fas fa-tags text-success"></i>
                            </div>
                            <h6 class="stat-card-title">Categorías</h6>
                            <h2 class="stat-card-value" id="stat-categorias">${totalCategorias}</h2>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-xl-2">
                    <div class="glass-card h-100">
                        <div class="card-body-glass text-center">
                            <div class="stat-icon-wrapper mx-auto mb-3">
                                <i class="fas fa-exclamation-triangle text-warning"></i>
                            </div>
                            <h6 class="stat-card-title">Stock Bajo</h6>
                            <h2 class="stat-card-value" id="stat-stock-bajo">${stockBajo}</h2>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 col-xl-2">
                    <div class="glass-card h-100">
                        <div class="card-body-glass text-center">
                            <div class="stat-icon-wrapper mx-auto mb-3">
                                <i class="fas fa-users text-info"></i>
                            </div>
                            <h6 class="stat-card-title">Usuarios</h6>
                            <h2 class="stat-card-value" id="stat-usuarios">${totalUsuarios}</h2>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-xl-2">
                    <div class="glass-card h-100">
                        <div class="card-body-glass text-center">
                            <div class="stat-icon-wrapper mx-auto mb-3">
                                <i class="fas fa-truck text-secondary"></i>
                            </div>
                            <h6 class="stat-card-title">Proveedores</h6>
                            <h2 class="stat-card-value" id="stat-proveedores">${totalProveedores}</h2>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-xl-2">
                    <div class="glass-card h-100">
                        <div class="card-body-glass text-center">
                            <div class="stat-icon-wrapper mx-auto mb-3">
                                <i class="fas fa-check-circle text-gradient-primary"></i>
                            </div>
                            <h6 class="stat-card-title">Activos</h6>
                            <h2 class="stat-card-value" id="stat-proveedores-activos">${proveedoresActivos}</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts & Actions -->
            <div class="row g-4 mt-2">
                <!-- Movements Chart -->
                <div class="col-lg-8">
                    <div class="glass-card h-100">
                        <div class="card-header-glass">
                            <h5 class="mb-0">Movimientos de Inventario</h5>
                            <small class="text-muted">Últimos 7 días</small>
                        </div>
                        <div class="card-body-glass" style="height: 350px;">
                            <canvas id="weeklyMovementsChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="col-lg-4">
                     <div class="glass-card h-100">
                        <div class="card-header-glass">
                            <h5 class="mb-0">Accesos Rápidos</h5>
                        </div>
                        <div class="card-body-glass">
                            <div class="d-grid gap-3">
                                <a href="${pageContext.request.contextPath}/productos" class="btn btn-glass d-flex align-items-center justify-content-between">
                                    <span><i class="fas fa-plus text-primary me-2"></i> Nuevo Producto</span>
                                    <i class="fas fa-chevron-right text-muted"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/categorias" class="btn btn-glass d-flex align-items-center justify-content-between">
                                    <span><i class="fas fa-layer-group text-success me-2"></i> Nueva Categoría</span>
                                    <i class="fas fa-chevron-right text-muted"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/proveedores" class="btn btn-glass d-flex align-items-center justify-content-between">
                                    <span><i class="fas fa-truck text-info me-2"></i> Gestionar Proveedores</span>
                                    <i class="fas fa-chevron-right text-muted"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/reportes/stock" class="btn btn-glass d-flex align-items-center justify-content-between">
                                    <span><i class="fas fa-file-alt text-warning me-2"></i> Generar Reportes</span>
                                    <i class="fas fa-chevron-right text-muted"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bottom Row: Stock Chart / Top Providers -->
            <div class="row g-4 mt-2">
                 <div class="col-lg-4">
                    <div class="glass-card h-100">
                        <div class="card-header-glass">
                            <h5 class="mb-0">Stock por Categoría</h5>
                        </div>
                        <div class="card-body-glass" style="height: 300px;">
                            <canvas id="stockCategoryChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8">
                     <div class="glass-card">
                        <div class="card-header-glass">
                             <h5 class="mb-0">Top Proveedores</h5>
                        </div>
                        <div class="card-body-glass" style="height: 300px;">
                            <canvas id="topProvidersChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Table -->
             <div class="row mt-4 mb-4">
                <div class="col-12">
                     <div class="glass-card">
                        <div class="card-header-glass">
                            <h5 class="mb-0">Últimos Movimientos</h5>
                             <a href="#" class="text-sm text-primary">Ver todos</a>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <th>Fecha</th>
                                        <th>Tipo</th>
                                        <th>Cantidad</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="mov" items="${ultimosMovimientos}">
                                        <tr>
                                            <td class="fw-bold text-white">${mov.producto.nombre}</td>
                                            <td>${mov.fecha}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${mov.tipo == 'ENTRADA'}"><span class="badge bg-success"><i class="fas fa-arrow-down me-1"></i> Entrada</span></c:when>
                                                    <c:otherwise><span class="badge bg-danger"><i class="fas fa-arrow-up me-1"></i> Salida</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-white font-monospace">
                                                <c:choose>
                                                    <c:when test="${mov.tipo == 'ENTRADA'}">+${mov.cantidad}</c:when>
                                                    <c:otherwise>-${mov.cantidad}</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty ultimosMovimientos}">
                                        <tr><td colspan="4" class="text-center py-4 text-muted">No hay movimientos recientes</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
             </div>

        </div>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <script>
        // Global Chart Defaults
        Chart.defaults.color = 'rgba(255, 255, 255, 0.7)';
        Chart.defaults.borderColor = 'rgba(255, 255, 255, 0.1)';
        Chart.defaults.font.family = "'Outfit', sans-serif";

        document.addEventListener("DOMContentLoaded", function() {
            initializeCharts();
        });

        function initializeCharts() {
            // -- STOCK PIE CHART --
            const ctxPie = document.getElementById('stockCategoryChart');
            if(ctxPie) {
                 fetch('${pageContext.request.contextPath}/api/dashboard/chart/stock-category')
                    .then(r => r.json())
                    .then(data => {
                        if (!data || data.length === 0) return;
                        new Chart(ctxPie, {
                            type: 'doughnut',
                            data: {
                                labels: data.map(i => i[0]),
                                datasets: [{
                                    data: data.map(i => i[1]),
                                    backgroundColor: [
                                        '#00ecbc', '#8e2de2', '#4a00e0', '#f6c23e', '#e74a3b', '#2c3e50'
                                    ],
                                    borderWidth: 0,
                                    hoverOffset: 10
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                cutout: '70%',
                                plugins: {
                                    legend: { position: 'bottom', labels: { padding: 20, usePointStyle: true } }
                                }
                            }
                        });
                    }).catch(console.error);
            }

            // -- WEEKLY MOVEMENTS BAR CHART --
            const ctxBar = document.getElementById('weeklyMovementsChart');
            if (ctxBar) {
                fetch('${pageContext.request.contextPath}/api/dashboard/chart/movements-weekly')
                    .then(r => r.json())
                    .then(data => {
                        if (!data) return;
                        new Chart(ctxBar, {
                            type: 'bar',
                            data: {
                                labels: data.map(i => i[0]),
                                datasets: [{
                                    label: 'Movimientos',
                                    data: data.map(i => i[1]),
                                    backgroundColor: '#00ecbc',
                                    borderRadius: 5
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                scales: {
                                    y: { 
                                        beginAtZero: true, 
                                        grid: { color: 'rgba(255, 255, 255, 0.05)' } 
                                    },
                                    x: { 
                                        grid: { display: false } 
                                    }
                                },
                                plugins: { legend: { display: false } }
                            }
                        });
                    }).catch(console.error);
            }

            // -- TOP PROVIDERS BAR CHART --
            const ctxTopProv = document.getElementById('topProvidersChart');
            if (ctxTopProv) {
                fetch('${pageContext.request.contextPath}/api/dashboard/chart/top-providers')
                    .then(r => r.json())
                    .then(data => {
                        if (!data) return;
                        new Chart(ctxTopProv, {
                            type: 'bar',
                            data: {
                                labels: data.map(i => i[0]),
                                datasets: [{
                                    label: 'Productos',
                                    data: data.map(i => i[1]),
                                    backgroundColor: '#8e2de2', // Secondary Accent
                                    borderRadius: 4
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                indexAxis: 'y',
                                scales: {
                                    x: { beginAtZero: true, grid: { color: 'rgba(255, 255, 255, 0.05)' } },
                                    y: { grid: { display: false } }
                                },
                                plugins: { legend: { display: false } }
                            }
                        });
                    }).catch(console.error);
            }
        }
    </script>
</body>
</html>