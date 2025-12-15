<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ControlInventarioPRO</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/webjars/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    
    <style>
        body {
            /* Specific specific layout for Login */
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden !important; 
        }
    </style>
</head>
<body>

    <!-- Background Ambient Shapes -->
    <div class="bg-shape shape-1"></div>
    <div class="bg-shape shape-2"></div>
    <div class="bg-shape shape-3"></div>

    <div class="login-card text-center">
        <!-- Logo/Icon area -->
        <div class="mb-4">
            <div style="width: 70px; height: 70px; background: rgba(255,255,255,0.1); border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; margin-bottom: 1rem; box-shadow: 0 10px 20px rgba(0,0,0,0.2);">
                <i class="fas fa-cube fa-2x" style="color: var(--primary-accent);"></i>
            </div>
            <h2>Bienvenido</h2>
            <p class="subtitle text-muted">Ingresa a tu espacio de trabajo</p>
        </div>

        <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
        %>
        <div class="alert-error">
            <i class="fas fa-circle-exclamation me-2"></i>
            <div><%=error%></div>
        </div>
        <%
        }
        %>

        <form action="${pageContext.request.contextPath}/login" method="POST" id="formLogin">
            <input type="hidden" name="accion" value="login">
            
            <!-- Custom Input: Usuario -->
            <div class="input-group-custom">
                <i class="fas fa-user input-icon"></i>
                <input type="text" name="usuario" id="usuario" placeholder=" " required autofocus autocomplete="off">
                <label for="usuario">Usuario</label>
                <div class="input-border"></div>
            </div>

            <!-- Custom Input: Password -->
            <div class="input-group-custom">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" name="password" id="password" placeholder=" " required>
                <label for="password">Contraseña</label>
                <div class="input-border"></div>
                
                <span class="password-toggle" id="togglePassword">
                    <i class="far fa-eye"></i>
                </span>
            </div>

            <button type="submit" class="btn-premium">
                <span>INICIAR SESIÓN</span>
            </button>
        </form>
    </div>

    <!-- Scripts -->
    <script>
        // Toggle Password Logic
        const toggleBtn = document.getElementById('togglePassword');
        const passInput = document.getElementById('password');
        const icon = toggleBtn.querySelector('i');

        toggleBtn.addEventListener('click', () => {
            if (passInput.type === 'password') {
                passInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        // Button Loading Effect
        document.getElementById('formLogin').addEventListener('submit', function(e) {
            const btn = this.querySelector('button');
            
            btn.style.width = btn.offsetWidth + 'px'; // Prevent shrink
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-circle-notch fa-spin"></i>';
            btn.style.opacity = '0.8';
        });
    </script>

</body>
</html>