# CONTROL INVENTARIO PRO - INFORME DE PROYECTO (SPRINT 2)

**Fecha:** 24 de Diciembre, 2025
**Estado:** Segundo Presentable (Sprint 2)
**Aplicación:** Sistema Web de Control de Inventario y Asistencia

---

## 1. Información General del Proyecto
**ControlInventarioPRO** es una aplicación web empresarial diseñada para la gestión eficiente de inventarios, proveedores y control de stock. Este segundo entregable (Sprint 2) consolida la capa de persistencia, la lógica de negocio y las funcionalidades principales de administración y reportería.

---

## 2. Arquitectura Técnica
El sistema está construido siguiendo una arquitectura en capas (MVC), utilizando tecnologías modernas y estándares de la industria:

*   **Backend Framework:** Spring Boot 3.2.0
    *   **Spring Web:** Para el manejo de peticiones HTTP y arquitectura MVC.
    *   **Spring Data JPA / JDBC:** Para la interacción robusta con la base de datos.
    *   **Spring Security (Simulado/Custom):** Implementación de interceptores (`AuthInterceptor`) para seguridad y manejo de sesiones.
*   **Base de Datos:** MySQL
    *   Uso extensivo de **Stored Procedures** para encapsular la lógica de datos y mejorar el rendimiento.
*   **Frontend:**
    *   **JSP (JavaServer Pages):** Motor de plantillas para el renderizado del lado del servidor.
    *   **JSTL:** Biblioteca de etiquetas estándar para lógica en vistas.
    *   **Bootstrap 5.3:** Framework CSS para diseño responsivo y moderno.
    *   **FontAwesome 6.4:** Iconografía.
*   **Reportería:**
    *   **Apache POI (5.2.3):** Generación de reportes en formato **Excel**.
    *   **OpenPDF (1.3.30):** Generación de reportes en formato **PDF**.

---

## 3. Diseño de Base de Datos
La base de datos `dbcontrolinventariopro` está normalizada y estructurada de la siguiente manera:

### Tablas Principales
1.  **`usuarios`**: Gestión de acceso y roles (ADMIN, USER).
2.  **`categorias`**: Clasificación de productos.
3.  **`proveedores`**: Datos de contacto y gestión de proveedores.
4.  **`productos`**: Inventario principal, con control de stock, precios y asociación a categorías/proveedores.
5.  **`movimientos`**: Historial transaccional de entradas y salidas de stock.

### Stored Procedures (Procedimientos Almacenados)
Se han implementado procedimientos para todas las operaciones críticas:
*   **Autenticación:** `sp_autenticarUsuario`
*   **Dashboard:** `sp_contarProductos`, `sp_contarStockBajo`, `sp_contarVentas`, etc.
*   **CRUDs:** `sp_insertarProducto`, `sp_modificarProveedor`, `sp_listarMovimientos`, etc.

---

## 4. Funcionalidades Implementadas (Sprint 2)

Las siguientes características están completamente funcionales en este entregable:

### A. Módulo de Autenticación y Seguridad
*   **Login Seguro:** Validación de credenciales contra base de datos.
*   **Control de Sesión:** Manejo de usuarios activos en sesión HTTP.
*   **Roles:** Diferenciación básica entre administradores y usuarios regulares.
*   **Logout:** Cierre de sesión seguro.

### B. Dashboard Principal (Cuadro de Mando)
Panel de control con estadísticas en tiempo real para la toma de decisiones:
*   **Tarjetas Informativas (KPIs):**
    *   Total de Productos.
    *   Categorías registradas.
    *   Usuarios del sistema.
    *   **Alerta de Stock Bajo:** Indicador crítico de productos con menos de 10 unidades.
    *   Total de Proveedores y Proveedores Activos.
*   **Gráficos (APIs Integradas):** Endpoints JSON listos para alimentar gráficos de Stock por Categoría y Movimientos Semanales.

### C. Gestión de Inventario (Productos y Categorías)
*   **CRUD Completo de Productos:** Crear, Leer, Actualizar y Eliminar productos.
*   **Categorización:** Gestión dinámica de categorías.
*   **Control de Stock:** Visualización clara de niveles de inventario.

### D. Gestión de Proveedores
*   Registro y administración completa de proveedores.
*   Seguimiento de contacto, teléfono, email y dirección.

### E. Reportes y Exportación
Sistema robusto de exportación de datos para auditoría y análisis externo:
*   **Reporte de Stock:**
    *   Exportación a **Excel (.xlsx)**.
    *   Exportación a **PDF**.
*   **Reporte de Movimientos:**
    *   Exportación a **PDF**.

---

## 5. Próximos Pasos (Sprint 3 / Final)
*   Refinamiento final de la Interfaz de Usuario (UI/UX).
*   Pruebas de integración completas.
*   Despliegue en entorno de producción.

---
*Este documento refleja el estado actual del código fuente al 24 de Diciembre de 2025.*
