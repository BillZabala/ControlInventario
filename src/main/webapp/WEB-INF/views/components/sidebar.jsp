<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentPage = request.getParameter("active");
    if (currentPage == null) currentPage = "";
%>
<div class="sidebar">
    <div class="sidebar-header">
        <div class="logo-container">
            <i class="fas fa-boxes fa-2x"></i>
            <span class="logo-text">ControlPRO</span>
        </div>
    </div>
    
    <div class="sidebar-menu">
        <div class="menu-label">PRINCIPAL</div>
        <a href="${pageContext.request.contextPath}/inicio" class="<%= "inicio".equals(currentPage) ? "active" : "" %>">
            <i class="fas fa-home"></i> <span>Inicio</span>
        </a>
        
        <div class="menu-label">INVENTARIO</div>
        <a href="${pageContext.request.contextPath}/productos" class="<%= "productos".equals(currentPage) ? "active" : "" %>">
            <i class="fas fa-box-open"></i> <span>Productos</span>
        </a>
        <a href="${pageContext.request.contextPath}/categorias" class="<%= "categorias".equals(currentPage) ? "active" : "" %>">
            <i class="fas fa-tags"></i> <span>Categorías</span>
        </a>
        <a href="${pageContext.request.contextPath}/proveedores" class="<%= "proveedores".equals(currentPage) ? "active" : "" %>">
            <i class="fas fa-truck"></i> <span>Proveedores</span>
        </a>
        
        <div class="menu-label">ADMINISTRACIÓN</div>
        <a href="${pageContext.request.contextPath}/usuarios" class="<%= "usuarios".equals(currentPage) ? "active" : "" %>">
            <i class="fas fa-users"></i> <span>Usuarios</span>
        </a>
        <a href="${pageContext.request.contextPath}/reportes/stock" class="<%= "reportes".equals(currentPage) ? "active" : "" %>">
            <i class="fas fa-chart-bar"></i> <span>Reportes</span>
        </a>
    </div>
    
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">
            <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
        </a>
    </div>
</div>


