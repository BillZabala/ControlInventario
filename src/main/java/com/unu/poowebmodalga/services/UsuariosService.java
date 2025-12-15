package com.unu.poowebmodalga.services;

import com.unu.poowebmodalga.model.Usuario;
import com.unu.poowebmodalga.repository.UsuarioRepository;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UsuariosService {

    // private static final Logger logger =
    // LoggerFactory.getLogger(UsuariosService.class);

    private final UsuarioRepository usuarioRepository;

    public UsuariosService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public Usuario autenticarUsuario(String nombreUsuario, String password) {
        System.out.println("DEBUG: Buscando usuario: " + nombreUsuario + " con estado ACTIVO");
        Optional<Usuario> usuarioOpt = usuarioRepository.findByNombreUsuarioAndEstado(nombreUsuario, "ACTIVO");

        if (usuarioOpt.isEmpty()) {
            System.out.println("DEBUG: Usuario no encontrado o no activo: " + nombreUsuario);
            return null;
        }

        Usuario usuario = usuarioOpt.get();
        String dbPassword = usuario.getPassword();

        System.out.println("DEBUG: Password recibido: '" + password + "' (length: " + password.length() + ")");
        System.out.println("DEBUG: Password en DB: '" + dbPassword + "' (length: "
                + (dbPassword != null ? dbPassword.length() : "null") + ")");

        if (dbPassword != null && dbPassword.equals(password)) {
            System.out.println("DEBUG: Contraseña correcta para usuario: " + nombreUsuario);
            return usuario;
        } else {
            System.out.println("DEBUG: Contraseña INCORRECTA para usuario: " + nombreUsuario);
            return null;
        }
    }

    public List<Usuario> listarUsuarios() {
        return usuarioRepository.findAll(Sort.by(Sort.Direction.DESC, "idUsuario"));
    }

    public int insertarUsuario(Usuario usuario) {
        usuarioRepository.save(usuario);
        return 1;
    }

    public Usuario obtenerUsuario(int idUsuario) {
        return usuarioRepository.findById(idUsuario).orElse(null);
    }

    public int modificarUsuario(Usuario usuario) {
        // Ensure we are updating the existing user properly
        return usuarioRepository.findById(usuario.getIdUsuario()).map(existing -> {
            existing.setNombreUsuario(usuario.getNombreUsuario());
            existing.setNombreCompleto(usuario.getNombreCompleto());
            existing.setEmail(usuario.getEmail());
            existing.setRol(usuario.getRol());
            existing.setEstado(usuario.getEstado());
            usuarioRepository.save(existing);
            return 1;
        }).orElse(0);
    }

    public int cambiarPassword(int idUsuario, String passwordNueva) {
        return usuarioRepository.findById(idUsuario).map(u -> {
            u.setPassword(passwordNueva);
            usuarioRepository.save(u);
            return 1;
        }).orElse(0);
    }

    public int eliminarUsuario(int idUsuario) {
        return usuarioRepository.findById(idUsuario).map(u -> {
            u.setEstado("INACTIVO");
            usuarioRepository.save(u);
            return 1;
        }).orElse(0);
    }

    public int contarUsuarios() {
        return (int) usuarioRepository.countByEstado("ACTIVO");
    }
}
