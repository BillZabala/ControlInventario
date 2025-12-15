package com.unu.poowebmodalga.interceptors;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession(false);
        boolean usuarioLogueado = (session != null && session.getAttribute("usuario") != null);

        if (!usuarioLogueado) {
            // Usuario no autenticado, redirigir al login
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        // Usuario autenticado, continuar con la petición
        return true;
    }
}
