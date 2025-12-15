<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String url = request.getContextPath() + "/";
%>

<style>
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
        border-color: #8f94fb;
        box-shadow: 0 0 0 0.25rem rgba(143, 148, 251, 0.25);
    }
    .form-icon {
        position: absolute;
        top: 18px;
        right: 15px;
        color: #6c757d;
        z-index: 10;
    }
    .btn-save {
        background: linear-gradient(to right, #4e54c8, #8f94fb);
        border: none;
        color: white;
        padding: 12px;
        font-weight: 600;
        border-radius: 10px;
        transition: all 0.3s ease;
    }
    .btn-save:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(78, 84, 200, 0.3);
        color: white;
    }
</style>

<form action="<%=url%>usuarios/insertarAjax" method="POST" id="formUsuario" class="needs-validation p-3" novalidate>
    <input type="hidden" name="op" value="insertarAjax">
    
    <div class="row g-3">
        <!-- Usuario y Password -->
        <div class="col-md-6">
            <div class="form-floating position-relative">
                <input type="text" class="form-control" name="nombreUsuario" id="nombreUsuario" 
                    placeholder="Usuario" required pattern="[a-zA-Z0-9_]{4,20}"
                    title="4-20 caracteres, solo letras, números y guión bajo">
                <label for="nombreUsuario">Usuario <span class="text-danger">*</span></label>
                <i class="fas fa-user form-icon"></i>
                <div class="invalid-feedback">
                    4-20 caracteres (letras, números, _)
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="form-floating position-relative">
                <input type="password" class="form-control" name="password" id="password" 
                    placeholder="Contraseña" required minlength="6">
                <label for="password">Contraseña <span class="text-danger">*</span></label>
                <i class="fas fa-lock form-icon"></i>
                <div class="invalid-feedback">
                    Mínimo 6 caracteres
                </div>
            </div>
        </div>
    
        <!-- Nombre Completo -->
        <div class="col-12">
            <div class="form-floating position-relative">
                <input type="text" class="form-control" name="nombreCompleto" id="nombreCompleto" 
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
                    placeholder="name@example.com">
                <label for="email">Email (Opcional)</label>
                <i class="fas fa-envelope form-icon"></i>
                <div class="invalid-feedback">
                    Ingrese un email válido
                </div>
            </div>
        </div>

        <!-- Rol -->
        <div class="col-12">
            <div class="form-floating">
                <select class="form-select" name="rol" id="rol" required>
                    <option value="" selected disabled>Seleccione...</option>
                    <option value="USUARIO">Usuario Estándar</option>
                    <option value="ADMIN">Administrador</option>
                </select>
                <label for="rol">Rol del Usuario <span class="text-danger">*</span></label>
                <div class="invalid-feedback">
                    Debes seleccionar un rol
                </div>
            </div>
        </div>
    </div>
    
    <div class="alert alert-light border mt-4 mb-4 d-flex align-items-center" role="alert">
        <i class="fas fa-info-circle text-primary me-2 fa-lg"></i>
        <div class="small text-muted">
            El usuario se creará con estado <strong>ACTIVO</strong> por defecto.
        </div>
    </div>
    
    <div class="d-grid mt-2">
        <button type="submit" class="btn btn-save">
            <i class="fas fa-save me-2"></i> Guardar Usuario
        </button>
    </div>
</form>

<script>
(function() {
    'use strict';
    const form = document.getElementById('formUsuario');
    if(form) {
        // Validación Bootstrap
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