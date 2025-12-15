package com.unu.poowebmodalga.controllers;

import com.unu.poowebmodalga.model.Usuario;
import com.unu.poowebmodalga.services.UsuariosService;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/usuarios")
public class UsuariosController {

    private final UsuariosService usuariosService;

    public UsuariosController(UsuariosService usuariosService) {
        this.usuariosService = usuariosService;
    }

    @GetMapping
    public String listar(Model model) {
        List<Usuario> lista = usuariosService.listarUsuarios();
        model.addAttribute("listaUsuarios", lista);
        return "usuarios/listaUsuarios";
    }

    @GetMapping("/nuevo")
    public String nuevo(@RequestParam(value = "modal", required = false) String modal, Model model) {
        boolean esModal = modal != null;
        return esModal ? "usuarios/fragments/formNuevo" : "usuarios/nuevoUsuario";
    }

    @GetMapping("/editar")
    public String editar(@RequestParam("id") int id,
            @RequestParam(value = "modal", required = false) String modal,
            Model model) {
        Usuario usuario = usuariosService.obtenerUsuario(id);
        if (usuario != null) {
            model.addAttribute("usuario", usuario);
            boolean esModal = modal != null;
            return esModal ? "usuarios/fragments/formEditar" : "usuarios/editarUsuario";
        } else {
            return "redirect:/error404.jsp";
        }
    }

    @GetMapping("/cambiarPassword")
    public String cargarFormularioPassword(@RequestParam("id") int id, Model model) {
        Usuario usuario = usuariosService.obtenerUsuario(id);
        if (usuario != null) {
            model.addAttribute("usuario", usuario);
            return "usuarios/fragments/formPassword";
        } else {
            return "redirect:/error404.jsp";
        }
    }

    @PostMapping("/insertar")
    public String insertar(@RequestParam("nombreUsuario") String nombreUsuario,
            @RequestParam("password") String password,
            @RequestParam("nombreCompleto") String nombreCompleto,
            @RequestParam("email") String email,
            @RequestParam("rol") String rol,
            HttpSession session) {
        try {
            Usuario usuario = new Usuario();
            usuario.setNombreUsuario(nombreUsuario);
            usuario.setPassword(password);
            usuario.setNombreCompleto(nombreCompleto);
            usuario.setEmail(email);
            usuario.setRol(rol);

            int resultado = usuariosService.insertarUsuario(usuario);

            session.setAttribute("mensaje",
                    resultado > 0 ? "Usuario registrado exitosamente" : "Error al registrar usuario");
        } catch (Exception e) {
            session.setAttribute("mensaje", "Error: " + e.getMessage());
        }
        return "redirect:/usuarios";
    }

    @PostMapping("/insertarAjax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> insertarAjax(@RequestParam("nombreUsuario") String nombreUsuario,
            @RequestParam("password") String password,
            @RequestParam("nombreCompleto") String nombreCompleto,
            @RequestParam("email") String email,
            @RequestParam("rol") String rol) {
        Map<String, Object> response = new HashMap<>();
        try {
            Usuario usuario = new Usuario();
            usuario.setNombreUsuario(nombreUsuario);
            usuario.setPassword(password);
            usuario.setNombreCompleto(nombreCompleto);
            usuario.setEmail(email);
            usuario.setRol(rol);

            int resultado = usuariosService.insertarUsuario(usuario);

            response.put("success", resultado > 0);
            response.put("mensaje", resultado > 0 ? "Usuario registrado exitosamente" : "Error al registrar usuario");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("mensaje", "Error: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/modificar")
    public String modificar(@RequestParam("id") int id,
            @RequestParam("nombreUsuario") String nombreUsuario,
            @RequestParam("nombreCompleto") String nombreCompleto,
            @RequestParam("email") String email,
            @RequestParam("rol") String rol,
            @RequestParam("estado") String estado,
            HttpSession session) {
        try {
            Usuario usuario = new Usuario();
            usuario.setIdUsuario(id);
            usuario.setNombreUsuario(nombreUsuario);
            usuario.setNombreCompleto(nombreCompleto);
            usuario.setEmail(email);
            usuario.setRol(rol);
            usuario.setEstado(estado);

            int resultado = usuariosService.modificarUsuario(usuario);

            session.setAttribute("mensaje",
                    resultado > 0 ? "Usuario modificado exitosamente" : "Error al modificar usuario");
        } catch (Exception e) {
            session.setAttribute("mensaje", "Error: " + e.getMessage());
        }
        return "redirect:/usuarios";
    }

    @PostMapping("/modificarAjax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> modificarAjax(@RequestParam("id") int id,
            @RequestParam("nombreUsuario") String nombreUsuario,
            @RequestParam("nombreCompleto") String nombreCompleto,
            @RequestParam("email") String email,
            @RequestParam("rol") String rol,
            @RequestParam("estado") String estado) {
        Map<String, Object> response = new HashMap<>();
        try {
            Usuario usuario = new Usuario();
            usuario.setIdUsuario(id);
            usuario.setNombreUsuario(nombreUsuario);
            usuario.setNombreCompleto(nombreCompleto);
            usuario.setEmail(email);
            usuario.setRol(rol);
            usuario.setEstado(estado);

            int resultado = usuariosService.modificarUsuario(usuario);

            response.put("success", resultado > 0);
            response.put("mensaje", resultado > 0 ? "Usuario modificado exitosamente" : "Error al modificar usuario");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("mensaje", "Error: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/cambiarPasswordAjax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> cambiarPassword(@RequestParam("id") int id,
            @RequestParam("passwordNueva") String passwordNueva) {
        Map<String, Object> response = new HashMap<>();
        try {
            int resultado = usuariosService.cambiarPassword(id, passwordNueva);

            response.put("success", resultado > 0);
            response.put("mensaje", resultado > 0 ? "Contraseña cambiada exitosamente" : "Error al cambiar contraseña");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("mensaje", "Error: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @GetMapping("/eliminar")
    public String eliminar(@RequestParam("id") int id, HttpSession session) {
        try {
            int resultado = usuariosService.eliminarUsuario(id);
            session.setAttribute("mensaje",
                    resultado > 0 ? "Usuario eliminado exitosamente" : "Error al eliminar usuario");
        } catch (Exception e) {
            session.setAttribute("mensaje", "Error: " + e.getMessage());
        }
        return "redirect:/usuarios";
    }

    // Legacy support for old URLs
    @GetMapping("/UsuariosController")
    public String legacyHandler(@RequestParam(value = "op", required = false) String op,
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam(value = "modal", required = false) String modal,
            Model model) {
        if (op == null) {
            return "redirect:/usuarios";
        }

        switch (op) {
            case "nuevo":
                return nuevo(modal, model);
            case "editar":
                return editar(id, modal, model);
            case "cambiarPassword":
                return cargarFormularioPassword(id, model);
            default:
                return "redirect:/usuarios";
        }
    }
}
