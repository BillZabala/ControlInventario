<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.unu.poowebmodalga.beans.Usuario"%>
<% 
String url = request.getContextPath() + "/";
Usuario usuario = (Usuario) request.getAttribute("usuario");
if(usuario == null) {
    usuario = new Usuario();
}
%>

<form action="<%=url%>UsuariosController" method="POST" id="formPassword" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="cambiarPasswordAjax">
    <input type="hidden" name="id" value="<%=usuario.getIdUsuario()%>">
    
    <div class="alert alert-info" role="alert">
        <i class="fas fa-user"></i> 
        Cambiar contraseña de: <strong><%=usuario.getNombreCompleto()%></strong> 
        (<%=usuario.getNombreUsuario()%>)
    </div>
    
    <div class="mb-3">
        <label for="passwordConfirmar" class="form-label">
            <i class="fas fa-lock"></i> Confirmar Contraseña <span class="text-danger">*</span>
        </label>
        <input type="password" class="form-control" name="passwordConfirmar" id="passwordConfirmar" 
            placeholder="Confirme la nueva contraseña" required minlength="6">
        <div class="invalid-feedback">
            Debe confirmar la contraseña
        </div>
    </div>
    
    <div class="alert alert-warning" role="alert">
        <i class="fas fa-exclamation-triangle"></i> 
        <strong>Importante:</strong> La contraseña será encriptada usando MD5.
    </div>
    
    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-info">
            <i class="fas fa-key"></i> Cambiar Contraseña
        </button>
    </div>
</form>

<script>
(function() {
    'use strict';
    const form = document.getElementById('formPassword');
    if(form) {
        form.classList.add('was-validated');
        
        // Validar que las contraseñas coincidan
        form.addEventListener('submit', function(e) {
            const password = document.getElementById('passwordNueva').value;
            const confirmar = document.getElementById('passwordConfirmar').value;
            
            if(password !== confirmar) {
                e.preventDefault();
                alert('Las contraseñas no coinciden');
                return false;
            }
        });
    }
    
    // Toggle mostrar/ocultar contraseña
    document.getElementById('togglePassword').addEventListener('click', function() {
        const passwordInput = document.getElementById('passwordNueva');
        const icon = this.querySelector('i');
        
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    });
})();
</script="passwordNueva" class="form-label">
            <i class="fas fa-lock"></i> Nueva Contraseña <span class="text-danger">*</span>
        </label>
        <div class="input-group">
            <input type="password" class="form-control" name="passwordNueva" id="passwordNueva" 
                placeholder="Ingrese la nueva contraseña" required minlength="6">
            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                <i class="fas fa-eye"></i>
            </button>
        </div>
        <div class="invalid-feedback">
            La contraseña debe tener al menos 6 caracteres
        </div>
    </div>
    
    <div class="mb-3">
        <label for