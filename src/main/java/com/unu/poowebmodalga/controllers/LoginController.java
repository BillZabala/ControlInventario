package com.unu.poowebmodalga.controllers;

import com.unu.poowebmodalga.model.Usuario;
import com.unu.poowebmodalga.services.UsuariosService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    // Removed Logger to avoid import issues
    // private static final Logger logger =
    // LoggerFactory.getLogger(LoginController.class);

    private final UsuariosService usuariosService;

    public LoginController(UsuariosService usuariosService) {
        this.usuariosService = usuariosService;
    }

    @GetMapping({ "/login", "/LoginController" })
    public String mostrarLogin(HttpSession session, Model model) {
        // If already logged in, redirect to inicio
        if (session.getAttribute("usuario") != null) {
            return "redirect:/DashboardController";
        }
        return "auth/login";
    }

    @PostMapping("/login")
    public String autenticar(
            @RequestParam("usuario") String nombreUsuario,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {

        System.out.println("DEBUG: Intento de login - Usuario: " + nombreUsuario);

        // Validar campos vacíos
        if (nombreUsuario == null || nombreUsuario.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Por favor complete todos los campos");
            return "auth/login";
        }

        // Autenticar usuario
        Usuario usuario = usuariosService.autenticarUsuario(nombreUsuario, password);

        if (usuario != null) {
            System.out.println("DEBUG: Login exitoso para usuario: " + nombreUsuario);
            // Usuario autenticado correctamente
            session.setAttribute("usuario", usuario);
            session.setAttribute("nombreUsuario", usuario.getNombreUsuario());
            session.setAttribute("nombreCompleto", usuario.getNombreCompleto());
            session.setAttribute("rol", usuario.getRol());
            session.setAttribute("idUsuario", usuario.getIdUsuario());

            // Redireccionar al inicio
            return "redirect:/DashboardController";
        } else {
            System.out.println("DEBUG: Login fallido para usuario: " + nombreUsuario);
            // Credenciales incorrectas
            model.addAttribute("error", "Usuario o contraseña incorrectos");
            return "auth/login";
        }
    }

    @GetMapping("/logout")
    public String cerrarSesion(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login";
    }
}
