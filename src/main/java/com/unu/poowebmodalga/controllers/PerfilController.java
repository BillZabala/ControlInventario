package com.unu.poowebmodalga.controllers;

import com.unu.poowebmodalga.model.Usuario;
import com.unu.poowebmodalga.services.UsuariosService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/perfil")
public class PerfilController {

    private final UsuariosService usuariosService;

    public PerfilController(UsuariosService usuariosService) {
        this.usuariosService = usuariosService;
    }

    @GetMapping
    public String mostrarPerfil(HttpSession session, Model model) {
        Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
        if (usuarioSesion == null) {
            return "redirect:/login";
        }

        // Refresh user data from DB to ensure latest info
        Usuario usuario = usuariosService.obtenerUsuario(usuarioSesion.getIdUsuario());
        model.addAttribute("usuario", usuario);

        return "perfil/miPerfil";
    }

    @PostMapping("/actualizar")
    public String actualizarPerfil(
            @RequestParam("nombreCompleto") String nombreCompleto,
            @RequestParam("email") String email,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
        if (usuarioSesion == null) {
            return "redirect:/login";
        }

        try {
            Usuario usuario = usuariosService.obtenerUsuario(usuarioSesion.getIdUsuario());
            usuario.setNombreCompleto(nombreCompleto);
            usuario.setEmail(email);

            // Keep existing password and other fields
            // Assuming modifying user requires all fields or service handles partial
            // updates?
            // UsuariosController.modificar uses all fields.
            // Let's see UsuariosService.modificarUsuario

            int resultado = usuariosService.modificarUsuario(usuario);

            if (resultado > 0) {
                // Update session
                session.setAttribute("usuario", usuario);
                session.setAttribute("nombreCompleto", usuario.getNombreCompleto());
                redirectAttributes.addFlashAttribute("mensaje", "Perfil actualizado exitosamente");
                redirectAttributes.addFlashAttribute("tipoMensaje", "success");
            } else {
                redirectAttributes.addFlashAttribute("mensaje", "Error al actualizar perfil");
                redirectAttributes.addFlashAttribute("tipoMensaje", "danger");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("mensaje", "Error: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipoMensaje", "danger");
        }

        return "redirect:/perfil";
    }

    @PostMapping("/cambiarPassword")
    public String cambiarPassword(
            @RequestParam("passwordActual") String passwordActual,
            @RequestParam("passwordNueva") String passwordNueva,
            @RequestParam("passwordConfirmar") String passwordConfirmar,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
        if (usuarioSesion == null) {
            return "redirect:/login";
        }

        if (!passwordNueva.equals(passwordConfirmar)) {
            redirectAttributes.addFlashAttribute("mensaje", "Las contraseñas nuevas no coinciden");
            redirectAttributes.addFlashAttribute("tipoMensaje", "danger");
            return "redirect:/perfil";
        }

        try {
            Usuario usuario = usuariosService.obtenerUsuario(usuarioSesion.getIdUsuario());

            // Verify current password (simple check, assuming plaintext as per login
            // controller)
            if (!usuario.getPassword().equals(passwordActual)) {
                redirectAttributes.addFlashAttribute("mensaje", "La contraseña actual es incorrecta");
                redirectAttributes.addFlashAttribute("tipoMensaje", "danger");
                return "redirect:/perfil";
            }

            int resultado = usuariosService.cambiarPassword(usuario.getIdUsuario(), passwordNueva);

            if (resultado > 0) {
                redirectAttributes.addFlashAttribute("mensaje", "Contraseña cambiada exitosamente");
                redirectAttributes.addFlashAttribute("tipoMensaje", "success");
            } else {
                redirectAttributes.addFlashAttribute("mensaje", "Error al cambiar la contraseña");
                redirectAttributes.addFlashAttribute("tipoMensaje", "danger");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("mensaje", "Error: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipoMensaje", "danger");
        }

        return "redirect:/perfil";
    }
}
