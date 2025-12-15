<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.unu.poowebmodalga.model.Usuario" %>
<% 
String url = request.getContextPath() + "/";
Usuario usuario = (Usuario) request.getAttribute("usuario");
if(usuario == null) {
    usuario = new Usuario();
}
%>

<style>
    /* Reusing the same styles for consistency */
    .form-floating > label {
        padding-left: 1.5rem;
    }
    .form-floating > .form-control:focus ~ label::after {
        background-color: transparent;
    }
    .form-floating > .form-control {
        border-radius: 10px;
        border: 1px solid #dee2e6;
        padding-left: 1.5rem;
    }
    .form-floating > .form-control:focus {
        border-color: #f0ad4e; /* Warning color for edit */
        box-shadow: 0 0 0 0.25rem rgba(240, 173, 78, 0.25);
    }
    .form-icon {
        position: absolute;
        top: 18px;
        right: 15px;
        color: #6c757d;
        z-index: 10;
    }
    .btn-update {
        background: linear-gradient(to right, #f2994a, #f2c94c);
        border: none;
        color: white;
        padding: 12px;
        font-weight: 600;
        border-radius: 10px;
        transition: all 0.3s ease;
    }
    .btn-update:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(242, 153, 74, 0.3);
        color: white;
    }
</style>

<form action="<%=url%>usuarios/modificarAjax" method="POST" id="formUsuario" class="needs-validation p-3" novalidate>
    <input type="hidden" name="op" value="modificarAjax">
    <input type="hidden" name="id" value="<%=usuario.getIdUsuario()%>">
    
    <div class="row g-3">
        <!-- Nombre Usuario -->
        <div class="col-12">
            <div class="form-floating position-relative">
                <input type="text" class="form-control" name="nombreUsuario" id="nombreUsuario" 
                    value="<%=usuario.getNombreUsuario() != null ? usuario.getNombreUsuario() : ""%>" 
                    placeholder="Usuario" required pattern="[a-zA-Z0-9_]{4,20}"
                    title="4-20 caracteres, solo letras, números y guión bajo">
                <label for="nombreUsuario">Nombre de Usuario <span class="text-danger">*</span></label>
                <i class="fas fa-user form-icon"></i>
                <div class="invalid-feedback">
                    4-20 caracteres (letras, números, _)
                </div>
            </div>
        </div>
    
        <!-- Nombre Completo -->
        <div class="col-12">
            <div class="form-floating position-relative">
                <input type="text" class="form-control" name="nombreCompleto" id="nombreCompleto" 
                    value="<%=usuario.getNombreCompleto() != null ? usuario.getNombreCompleto() : ""%>" 
                    placeholder="Nombre Completo" required>
                <label for="nombreCompleto">Nombre Completo <span class="text-danger">*</span></label>
                <i class="fas fa-id-card form-icon"></i>
                <div class="invalid-feedback">
                    Se requiere el nombre completo
                </div>
            </div>
        </div>
        
        <!-- Email -->
        <div class="col-12">
            <div class="form-floating position-relative">
                <input type="email" class="form-control" name="email" id="email" 
                    value="<%=usuario.getEmail() != null ? usuario.getEmail() : ""%>" 
                    placeholder="name@example.com">
                <label for="email">Email (Opcional)</label>
                <i class="fas fa-envelope form-icon"></i>
                <div class="invalid-feedback">
                    Ingrese un email válido
                </div>
            </div>
        </div>

        <!-- Rol -->
        <div class="col-md-6">
            <div class="form-floating">
                <select class="form-select" name="rol" id="rol" required>
                    <option value="" disabled>Seleccione...</option>
                    <option value="USUARIO" <%= "USUARIO".equals(usuario.getRol()) ? "selected" : "" %>>Usuario Estándar</option>
                    <option value="ADMIN" <%= "ADMIN".equals(usuario.getRol()) ? "selected" : "" %>>Administrador</option>
                </select>
                <label for="rol">Rol <span class="text-danger">*</span></label>
                <div class="invalid-feedback">
                    Seleccione un rol
                </div>
            </div>
        </div>
        
        <!-- Estado -->
        <div class="col-md-6">
            <div class="form-floating">
                <select class="form-select" name="estado" id="estado" required>
                    <option value="" disabled>Seleccione...</option>
                    <option value="ACTIVO" <%= "ACTIVO".equals(usuario.getEstado()) ? "selected" : "" %>>Activo</option>
                    <option value="INACTIVO" <%= "INACTIVO".equals(usuario.getEstado()) ? "selected" : "" %>>Inactivo</option>
                </select>
                <label for="estado">Estado <span class="text-danger">*</span></label>
                <div class="invalid-feedback">
                    Seleccione un estado
                </div>
            </div>
        </div>
    </div>
    
    <div class="alert alert-warning border mt-4 mb-4 d-flex align-items-center" role="alert">
        <i class="fas fa-exclamation-triangle me-2 text-warning fa-lg"></i>
        <div class="small">
            Modificando ID: <strong><%=usuario.getIdUsuario()%></strong><br>
            <span class="text-muted">Para cambiar la contraseña, use la opción en la lista.</span>
        </div>
    </div>
    
    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-update">
            <i class="fas fa-sync-alt me-2"></i> Actualizar Usuario
        </button>
    </div>
</form>

<script>
(function() {
    'use strict';
    const form = document.getElementById('formUsuario');
    if(form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    }
})();
</script>