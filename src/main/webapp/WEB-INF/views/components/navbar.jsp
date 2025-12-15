<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// Validación de sesión
String nombreUsuario = (String) session.getAttribute("nombreCompleto");
String rol = (String) session.getAttribute("rol");
boolean esAdmin = "ADMIN".equals(rol);

// Si no hay sesión, redirigir al login
if(nombreUsuario == null) {
    response.sendRedirect(request.getContextPath() + "/views/login.jsp");
    return;
}
%>

<nav class="navbar navbar-expand-lg navbar-light bg-white header-navbar">
    <div class="container-fluid">
        <!-- Toggler para Mobile (Futuro uso) -->
        <button class="btn btn-link text-dark d-md-none me-3">
            <i class="fas fa-bars"></i>
        </button>

        <!-- Título de Pagina (Dinámico o estático) -->
        <div class="d-none d-md-block">
            <h5 class="mb-0 text-muted" id="pageTitle">
                <i class="far fa-calendar-alt me-2"></i> <%= new java.text.SimpleDateFormat("EEEE, d MMMM yyyy").format(new java.util.Date()) %>
            </h5>
        </div>
        
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav align-items-center">
                
                <!-- Notificaciones -->
                <li class="nav-item dropdown me-3">
                    <a class="nav-link dropdown-toggle position-relative text-secondary" href="#" id="notifDropdown" 
                        role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-bell fa-lg"></i>
                        <span id="notifBadge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="display: none; font-size: 0.5rem;">
                            0
                        </span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0" aria-labelledby="notifDropdown" id="notifList" style="width: 300px; max-height: 400px; overflow-y: auto;">
                        <li><h6 class="dropdown-header">Notificaciones</h6></li>
                        <li><hr class="dropdown-divider"></li>
                        <li class="text-center text-muted small py-2" id="notifLoading">Cargando...</li>
                    </ul>
                </li>
                
                <script>
                    document.addEventListener("DOMContentLoaded", function() {
                        fetchNotificaciones();
                        // Poll every 30 seconds
                        setInterval(fetchNotificaciones, 30000);
                    });

                    function fetchNotificaciones() {
                        fetch('${pageContext.request.contextPath}/api/notificaciones')
                            .then(response => response.json())
                            .then(data => {
                                updateNotificacionesUI(data);
                            })
                            .catch(error => console.error('Error fetching notifications:', error));
                    }

                    function updateNotificacionesUI(notificaciones) {
                        const badge = document.getElementById('notifBadge');
                        const list = document.getElementById('notifList');
                        
                        // Update Badge
                        if (notificaciones.length > 0) {
                            badge.innerText = notificaciones.length;
                            badge.style.display = 'block';
                        } else {
                            badge.style.display = 'none';
                        }

                        // Update List
                        // Keep header and divider
                        const header = list.children[0].outerHTML;
                        const divider = list.children[1].outerHTML;
                        
                        let html = header + divider;

                        if (notificaciones.length === 0) {
                            html += '<li class="text-center text-muted small py-2">Sin notificaciones nuevas</li>';
                        } else {
                            notificaciones.forEach(n => {
                                let icon = '<i class="fas fa-info-circle text-info me-2"></i>';
                                if (n.tipo === 'WARNING') icon = '<i class="fas fa-exclamation-triangle text-warning me-2"></i>';
                                if (n.tipo === 'ERROR') icon = '<i class="fas fa-times-circle text-danger me-2"></i>';

                                html += `
                                    <li>
                                        <a class="dropdown-item" href="#">
                                            <div class="d-flex align-items-start">
                                                <div class="mt-1">\${icon}</div>
                                                <div>
                                                    <div class="small fw-bold">\${n.mensaje}</div>
                                                    <div class="text-muted" style="font-size: 0.7rem;">\${n.fecha}</div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                `;
                            });
                        }
                        
                        list.innerHTML = html;
                    }
                </script>

                <!-- User Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown" 
                        role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="text-end me-2 d-none d-lg-block">
                            <div class="fw-bold text-dark" style="font-size: 0.9rem;"><%=nombreUsuario%></div>
                            <div class="text-muted" style="font-size: 0.75rem;"><%= esAdmin ? "Administrador" : "Usuario" %></div>
                        </div>
                        <img src="https://ui-avatars.com/api/?name=<%=nombreUsuario%>&background=3498db&color=fff&size=40" class="rounded-circle shadow-sm" width="40" height="40">
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0" aria-labelledby="userDropdown">
                        <li>
                            <div class="dropdown-header">
                                Mi Cuenta
                            </div>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/perfil">
                                <i class="fas fa-user-edit me-2 text-primary"></i> Mi Perfil
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>


