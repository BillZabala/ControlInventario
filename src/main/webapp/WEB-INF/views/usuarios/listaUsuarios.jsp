<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.model.Usuario" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestión de Usuarios - ControlInventarioPRO</title>
<%
String url = request.getContextPath() + "/";
%>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.0/css/all.min.css">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<!-- Sidebar -->
<jsp:include page="../components/sidebar.jsp">
    <jsp:param name="active" value="usuarios" />
</jsp:include>
<jsp:include page="../components/navbar.jsp" />

<div class="main-content">
    <div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">
            <i class="fas fa-user-shield me-2 text-primary"></i> Gestión de Usuarios
        </h2>
        <button class="btn btn-primary-glow" onclick="modalUsuario.abrir('nuevo')">
            <i class="fas fa-plus"></i> Nuevo Usuario
        </button>
    </div>

    <!-- Mensajes de sesión -->
    <%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
    %>
    <div class="glass-card mb-3 p-3 text-info border-info" role="alert">
        <i class="fas fa-info-circle me-2"></i>
        <%=mensaje%>
        <button type="button" class="btn-close float-end" data-bs-dismiss="alert"></button>
    </div>
    <%
    session.removeAttribute("mensaje");
    }
    %>

    <!-- Tabla de Usuarios -->
    <div class="glass-card">
        <div class="card-body-glass">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th><i class="fas fa-hashtag text-muted"></i> ID</th>
                            <th><i class="fas fa-user text-muted"></i> Usuario</th>
                            <th><i class="fas fa-id-card text-muted"></i> Nombre Completo</th>
                            <th><i class="fas fa-envelope text-muted"></i> Email</th>
                            <th><i class="fas fa-shield-alt text-muted"></i> Rol</th>
                            <th><i class="fas fa-toggle-on text-muted"></i> Estado</th>
                            <th class="text-center"><i class="fas fa-cog text-muted"></i> Operaciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
                        if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                            for (Usuario usuario : listaUsuarios) {
                                String badgeEstado = "ACTIVO".equals(usuario.getEstado()) ? "bg-success" : "bg-danger";
                                String badgeRol = "ADMIN".equals(usuario.getRol()) ? "bg-warning text-dark" : "bg-secondary";
                        %>
                        <tr>
                            <td class="text-muted"><code><%=usuario.getIdUsuario()%></code></td>
                            <td><strong class="text-white"><%=usuario.getNombreUsuario()%></strong></td>
                            <td class="text-white"><%=usuario.getNombreCompleto()%></td>
                            <td class="text-muted"><%=usuario.getEmail() != null ? usuario.getEmail() : "-"%></td>
                            <td>
                                <span class="badge <%=badgeRol%>">
                                    <%=usuario.getRol()%>
                                </span>
                            </td>
                            <td>
                                <span class="badge <%=badgeEstado%>">
                                    <%=usuario.getEstado()%>
                                </span>
                            </td>
                            <td class="text-center">
                                <div class="btn-group" role="group">
                                    <button class="btn btn-glass text-warning btn-sm"
                                        onclick="modalUsuario.abrir('editar', <%=usuario.getIdUsuario()%>)"
                                        title="Modificar usuario">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-glass text-info btn-sm"
                                        onclick="modalUsuario.abrir('cambiarPassword', <%=usuario.getIdUsuario()%>)"
                                        title="Cambiar contraseña">
                                        <i class="fas fa-key"></i>
                                    </button>
                                    <button class="btn btn-glass text-danger btn-sm"
                                        onclick="eliminar(<%=usuario.getIdUsuario()%>)"
                                        title="Eliminar usuario">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <%
                        }
                        } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center text-muted py-5">
                                <i class="fas fa-inbox fa-3x mb-3 opacity-50"></i><br>
                                No hay usuarios registrados
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

<!-- Modal Universal para Usuarios -->
<div class="modal fade" id="modalUsuario" tabindex="-1"
    aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalUsuarioLabel">
                    <i class="fas fa-user-edit"></i> Usuario
                </h5>
                <button type="button" class="btn-close"
                    data-bs-dismiss="modal" id="btnCerrarModal"></button>
            </div>
            <div class="modal-body">
                <div id="loadingSpinner" class="text-center py-4">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Cargando...</span>
                    </div>
                    <p class="mt-2 text-muted">Cargando formulario...</p>
                </div>

                <div id="mensajeModal" class="alert d-none" role="alert"></div>
                <div id="contenidoModal" style="display: none;"></div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
const modalUsuario = {
    instance: null,
    procesando: false,
    
    init() {
        const modalElement = document.getElementById('modalUsuario');
        this.instance = new bootstrap.Modal(modalElement);        
    },
    
    abrir(tipo, id = null) {
        this.resetear();
        let titulo = 'Usuario';
        if(tipo === 'nuevo') titulo = 'Nuevo Usuario';
        else if(tipo === 'editar') titulo = 'Editar Usuario';
        else if(tipo === 'cambiarPassword') titulo = 'Cambiar Contraseña';
        
        document.getElementById('modalUsuarioLabel').innerHTML = '<i class="fas fa-user-edit"></i> ' + titulo;
        
        this.mostrarSpinner();
        this.instance.show();
        
        let fetchUrl = '<%=url%>usuarios/' + tipo;
        if(tipo === 'nuevo' || tipo === 'editar') {
             fetchUrl += '?modal=true';
        }
        if(id) fetchUrl += '&id=' + id;
        
        fetch(fetchUrl)
            .then(response => response.text())
            .then(html => {
                this.cargarContenido(html);
                this.interceptarFormulario();
            })
            .catch(error => {
                this.ocultarSpinner();
                this.mostrarMensaje('Error al cargar el formulario: ' + error.message, 'danger');
            });
    },
    
    resetear() {
        this.procesando = false;
        this.ocultarMensaje();
        this.habilitarBotones();
        document.getElementById('contenidoModal').style.display = 'none';
    },
    
    mostrarSpinner() {
        document.getElementById('loadingSpinner').style.display = 'block';
    },
    
    ocultarSpinner() {
        document.getElementById('loadingSpinner').style.display = 'none';
    },
    
    cargarContenido(html) {
        document.getElementById('contenidoModal').innerHTML = html;
        this.ocultarSpinner();
        document.getElementById('contenidoModal').style.display = 'block';
    },
    
    interceptarFormulario() {
        const form = document.querySelector('#contenidoModal form');
        if(!form || form.dataset.listenerAdded === 'true') return;
        
        form.dataset.listenerAdded = 'true';
        form.addEventListener('submit', (e) => this.enviarFormulario(e, form));
    },
    
    enviarFormulario(e, form) {
        e.preventDefault();
        
        if(this.procesando) return;
        
        if(!form.checkValidity()) {
            form.reportValidity();
            return;
        }
        
        this.procesando = true;
        this.deshabilitarBotones();
        
        const formData = new FormData(form);
        
        let operacion = formData.get('op');
        if(!operacion || !operacion.endsWith('Ajax')) {
            formData.set('op', operacion + 'Ajax');
        }
        
        const urlBase = '<%=url%>usuarios/' + operacion;
        
        fetch(urlBase, {
            method: 'POST',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: formData
        })
        .then(response => response.text())
        .then(text => {
            if(text.trim().startsWith('<')) {
                throw new Error('El servidor devolvió HTML en lugar de JSON');
            }
            return JSON.parse(text);
        })
        .then(data => {
            this.procesando = false;
            
            if(data.success) {
                this.mostrarMensaje(data.mensaje, 'success');
                setTimeout(() => {
                    this.instance.hide();
                    location.href = '<%=url%>usuarios';
                }, 1500);
            } else {
                this.mostrarMensaje(data.mensaje, 'danger');
                this.habilitarBotones();
            }
        })
        .catch(error => {
            this.procesando = false;
            this.mostrarMensaje('Error: ' + error.message, 'danger');
            this.habilitarBotones();
        });
    },
    
    deshabilitarBotones() {
        const btnGuardar = document.querySelector('#contenidoModal input[type="submit"], #contenidoModal button[type="submit"]');
        const btnCerrar = document.getElementById('btnCerrarModal');
        
        if(btnGuardar) {
            btnGuardar.disabled = true;
            if(btnGuardar.tagName === 'BUTTON') {
                btnGuardar.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Guardando...';
            } else {
                btnGuardar.value = 'Guardando...';
            }
        }
        if(btnCerrar) btnCerrar.disabled = true;
    },
    
    habilitarBotones() {
        const btnGuardar = document.querySelector('#contenidoModal input[type="submit"], #contenidoModal button[type="submit"]');
        const btnCerrar = document.getElementById('btnCerrarModal');
        
        if(btnGuardar) {
            btnGuardar.disabled = false;
            if(btnGuardar.tagName === 'BUTTON') {
                btnGuardar.innerHTML = '<i class="fas fa-save"></i> Guardar';
            } else {
                btnGuardar.value = 'Guardar';
            }
        }
        if(btnCerrar) btnCerrar.disabled = false;
    },
    
    mostrarMensaje(mensaje, tipo) {
        const mensajeDiv = document.getElementById('mensajeModal');
        mensajeDiv.className = 'alert alert-' + tipo;
        mensajeDiv.textContent = mensaje;
        mensajeDiv.classList.remove('d-none');
    },
    
    ocultarMensaje() {
        document.getElementById('mensajeModal').classList.add('d-none');
    }
};

function eliminar(id) {
    if (confirm('¿Está seguro de eliminar este usuario? Esta acción no se puede deshacer.')) {
        window.location.href = '<%=url%>usuarios/eliminar?id=' + id;
    }
}

document.addEventListener('DOMContentLoaded', function() {
    modalUsuario.init();
});
</script>

</body>
</html>