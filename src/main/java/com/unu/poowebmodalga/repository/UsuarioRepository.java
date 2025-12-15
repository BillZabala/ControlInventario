package com.unu.poowebmodalga.repository;

import com.unu.poowebmodalga.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

    Optional<Usuario> findByNombreUsuarioAndEstado(String nombreUsuario, String estado);

    Optional<Usuario> findByNombreUsuario(String nombreUsuario);

    List<Usuario> findByEstado(String estado);

    long countByEstado(String estado);
}
