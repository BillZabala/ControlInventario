<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String url = request.getContextPath() + "/";
    
    // Validación básica de sesión (Seguridad Sprint 1)
    if (session.getAttribute("username") == null) {
        response.sendRedirect(url + "views/login.jsp?error=Debes iniciar sesión");
        return;
    }

    String nombreCompleto = (String) session.getAttribute("nombreCompleto");
    String rol = (String) session.getAttribute("rol");
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard - ControlInventarioPRO</title>
<style>
    /* Estilo consistente con el Login */
    .hero-section {
        background: linear-gradient(135deg, #3a6186 0%, #89253e 100%);
        color: white;
        padding: 50px 0;
        margin-bottom: 40px;
        border-bottom: 5px solid #2c3e50;
    }
    
    .card-module {
        border: none;
        border-radius: 12px;
        box-shadow: 0 4px 6px rgba(0,0,0,.05);
        transition: all 0.3s ease;
        height: 100%;
        border-left: 5px solid transparent;
    }
    
    .card-module:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 20px rgba(0,0,0,.15);
    }

    /* Colores específicos para cada módulo */
    .card-productos { border-left-color: #3a6186; }
    .card-productos i { color: #3a6186; }
    
    .card-categorias { border-left-color: #e67e22; }
    .card-categorias i { color: #e67e22; }
    
    .card-usuarios { border-left-color: #89253e; }
    .card-usuarios i { color: #89253e; }
    
    .card-reportes { border-left-color: #27ae60; }
    .card-reportes i { color: #27ae60; }

    .card-module .card-body {
        padding: 25px;
        text-align: center;
    }
    .card-module i {
        font-size: 3rem;
        margin-bottom: 15px;
    }
    
    /* Badge del rol */
    .badge-rol {
        font-size: 0.9rem;
        padding: 0.5em 1em;
        background-color: rgba(255,255,255,0.2);
        border: 1px solid rgba(255,255,255,0.4);
    }
</style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="#">
        <i class="fas fa-boxes"></i> ControlInventarioPRO
    </a>
    <div class="d-flex">
        <a href="<%=url%>LoginServlet?action=logout" class="btn btn-outline-light btn-sm">
            <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
        </a>
    </div>
  </div>
</nav>

<div class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="display-5 fw-bold mb-2">
                    ¡Hola, <%=nombreCompleto != null ? nombreCompleto : "Usuario"%>!
                </h1>
                <p class="lead mb-0">
                    Panel de Control - <span class="badge rounded-pill badge-rol"><%=rol%></span>
                </p>
                <p class="mt-2 small opacity-75">Sistema de Gestión de Inventario v1.0</p>
            </div>
            <div class="col-md-4 text-end d-none d-md-block">
                 <i class="fas fa-dolly-flatbed" style="font-size: 7rem; opacity: 0.4;"></i>
            </div>
        </div>
    </div>
</div>

<div class="container mb-5">
    <h3 class="mb-4 text-secondary border-bottom pb-2">
        <i class="fas fa-grid-2"></i> Operaciones Disponibles
    </h3>
    
    <div class="row g-4">
        
        <div class="col-md-6 col-lg-3">
            <a href="<%=url%>ProductoServlet?action=listar" class="text-decoration-none text-dark">
                <div class="card card-module card-productos">
                    <div class="card-body">
                        <i class="fas fa-box-open"></i>
                        <h5 class="card-title">Productos</h5>
                        <p class="card-text text-muted small">
                            Catálogo, stock y precios.
                        </p>
                    </div>
                </div>
            </a>
        </div>
        
        <div class="col-md-6 col-lg-3">
            <a href="<%=url%>CategoriaServlet?action=listar" class="text-decoration-none text-dark">
                <div class="card card-module card-categorias">
                    <div class="card-body">
                        <i class="fas fa-tags"></i>
                        <h5 class="card-title">Categorías</h5>
                        <p class="card-text text-muted small">
                            Organización y proveedores.
                        </p>
                    </div>
                </div>
            </a>
        </div>
        
        <% if(rol != null && rol.equalsIgnoreCase("ADMIN")) { %>
        <div class="col-md-6 col-lg-3">
            <a href="<%=url%>UsuarioServlet?action=listar" class="text-decoration-none text-dark">
                <div class="card card-module card-usuarios">
                    <div class="card-body">
                        <i class="fas fa-users-cog"></i>
                        <h5 class="card-title">Usuarios</h5>
                        <p class="card-text text-muted small">
                            Gestión de accesos y roles.
                        </p>
                    </div>
                </div>
            </a>
        </div>
        
        <div class="col-md-6 col-lg-3">
            <a href="<%=url%>ReporteServlet?action=dashboard" class="text-decoration-none text-dark">
                <div class="card card-module card-reportes">
                    <div class="card-body">
                        <i class="fas fa-chart-pie"></i>
                        <h5 class="card-title">Reportes</h5>
                        <p class="card-text text-muted small">
                            Estadísticas de stock y ventas.
                        </p>
                    </div>
                </div>
            </a>
        </div>
        <% } %>
        
    </div>
</div>

<div class="container mb-5">
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white border-bottom-0 pt-3">
             <h6 class="fw-bold text-primary"><i class="fas fa-server"></i> Estado del Sistema</h6>
        </div>
        <div class="card-body pt-0">
            <div class="row mt-2">
                <div class="col-md-3 mb-2">
                    <small class="text-muted d-block">Usuario Actual</small>
                    <strong><%=username%></strong>
                </div>
                <div class="col-md-3 mb-2">
                    <small class="text-muted d-block">Base de Datos</small>
                    <span class="text-success"><i class="fas fa-database"></i> MySQL 8.0</span>
                </div>
                <div class="col-md-3 mb-2">
                    <small class="text-muted d-block">Conexión</small>
                    <span class="badge bg-success">Estable</span>
                </div>
                <div class="col-md-3 mb-2">
                    <small class="text-muted d-block">Sprint Actual</small>
                    <span class="badge bg-info text-dark">Sprint 1: Finalizado</span>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="text-center py-4 mt-auto">
    <p class="text-muted small mb-0">
        &copy; 2025 ControlInventarioPRO | Desarrollado por Bill Antony Zabala Paima
    </p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>