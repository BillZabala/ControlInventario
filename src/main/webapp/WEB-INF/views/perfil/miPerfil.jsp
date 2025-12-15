<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.unu.poowebmodalga.model.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mi Perfil - ControlInventarioPRO</title>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.0/css/all.min.css">
    <style>
        .profile-header {
            background: linear-gradient(135deg, #3a6186 0%, #89253e 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 0 0 20px 20px;
        }
        .profile-img {
            width: 120px;
            height: 120px;
            border: 4px solid rgba(255,255,255,0.3);
            object-fit: cover;
        }
    </style>
</head>
<body class="bg-light">

    <!-- Navbar -->
    <jsp:include page="../components/navbar.jsp" />

    <%
        Usuario usuario = (Usuario) request.getAttribute("usuario");
        String mensaje = (String) request.getAttribute("mensaje"); // RedirectAttributes not directly available as req attr? Flash attr usually goes to model.
        // In Spring Boot JSP with RedirectAttributes, successful redirect puts attributes in model/request. 
         // Actually, RedirectAttributes.addFlashAttribute puts it in the session temporarily and then into the Model.
         // Let's check if we need to retrieve it from parameter or model.
         // Usually available in JSTL as ${mensaje}. Using scriptlet for consistency with other files.
         // But let's try strict request attribute.
         
         // if(mensaje == null) mensaje = (String) model.asMap().get("mensaje"); // No 'model' here.
    %>

    <div class="profile-header text-center">
        <div class="container">
            <img src="https://ui-avatars.com/api/?name=<%= usuario.getNombreCompleto() %>&size=200&background=random" 
                 class="rounded-circle profile-img mb-3">
            <h2 class="fw-bold"><%= usuario.getNombreCompleto() %></h2>
            <p class="mb-0 opacity-75"><%= usuario.getRol() %> | <%= usuario.getNombreUsuario() %></p>
        </div>
    </div>

    <div class="container">
        
        <c:if test="${not empty mensaje}">
            <div class="alert alert-${tipoMensaje} alert-dismissible fade show" role="alert">
                ${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row justify-content-center">
            <!-- Información Personal -->
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-white border-bottom-0 pt-3">
                        <h5 class="card-title text-primary mb-0">
                            <i class="fas fa-user-circle"></i> Información Personal
                        </h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/perfil/actualizar" method="post">
                            <div class="mb-3">
                                <label class="form-label text-muted small">Nombre de Usuario</label>
                                <input type="text" class="form-control" value="<%= usuario.getNombreUsuario() %>" disabled>
                                <div class="form-text">El nombre de usuario no se puede cambiar.</div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Nombre Completo</label>
                                <input type="text" name="nombreCompleto" class="form-control" 
                                       value="<%= usuario.getNombreCompleto() %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Correo Electrónico</label>
                                <input type="email" name="email" class="form-control" 
                                       value="<%= usuario.getEmail() %>" required>
                            </div>
                            
                            <div class="mt-4 text-end">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Guardar Cambios
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Cambiar Contraseña -->
            <div class="col-md-5 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-white border-bottom-0 pt-3">
                        <h5 class="card-title text-danger mb-0">
                            <i class="fas fa-key"></i> Seguridad
                        </h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/perfil/cambiarPassword" method="post">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Contraseña Actual</label>
                                <input type="password" name="passwordActual" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Nueva Contraseña</label>
                                <input type="password" name="passwordNueva" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Confirmar Nueva Contraseña</label>
                                <input type="password" name="passwordConfirmar" class="form-control" required>
                            </div>
                            
                            <div class="mt-4 text-end">
                                <button type="submit" class="btn btn-danger text-white">
                                    <i class="fas fa-lock"></i> Actualizar Contraseña
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
