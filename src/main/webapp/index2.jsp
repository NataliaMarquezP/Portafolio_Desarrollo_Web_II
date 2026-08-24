<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Prueba de Conexión MySQL - Naty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-5">

    <div class="container">
        <h2 class="mb-4">Estado de la Base de Datos</h2>

        <%
            // 1. Credenciales actualizadas a tu servidor
            String url = "jdbc:mysql://192.168.1.9:3306/Naty?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            String usuario = "naty";
            String password = "AbC12313e1985";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // 2. Cargar el Driver que Maven descargó
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // 3. Conectar
                conn = DriverManager.getConnection(url, usuario, password);
                
                out.print("<div class='alert alert-success'>✅ ¡Conexión establecida exitosamente a la base de datos Naty en 192.168.1.9!</div>");
                
                // 4. Hacer un SELECT de prueba 
                // IMPORTANTE: Cambia 'nombre_de_una_tabla_real' por una tabla que exista en tu BD Naty
                out.print("<ul class='list-group mt-3'>");
                stmt = conn.createStatement();
                
                // Asegúrate de cambiar esta consulta para que coincida con tu base de datos
                rs = stmt.executeQuery("SELECT * FROM contacto LIMIT 5"); 
                
                while (rs.next()) {
                    // Muestra el valor de la primera columna de la tabla
                    String dato = rs.getString(1); 
                    out.print("<li class='list-group-item'>" + dato + "</li>");
                }
                out.print("</ul>");

            } catch (ClassNotFoundException e) {
                out.print("<div class='alert alert-danger'>❌ Error: No se encontró el Driver de MySQL.</div>");
            } catch (SQLException e) {
                out.print("<div class='alert alert-danger'>❌ Error de Base de Datos: " + e.getMessage() + "</div>");
            } finally {
                // 5. Cerrar conexiones
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>

</body>
</html>