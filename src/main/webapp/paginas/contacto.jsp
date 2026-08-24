<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content />
        <meta name="author" content />
        <title>Contacto</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="../imagenes/favicon.ico" />
        <!-- Custom Google font-->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@100;200;300;400;500;600;700;800;900&amp;display=swap" rel="stylesheet" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
    </head>
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
            <nav class="navbar navbar-expand-lg navbar-light bg-white py-3">
                <div class="container px-5">
                    <!--<a class="navbar-brand" href="index.html"><span class="fw-bolder text-primary">Start Bootstrap</span></a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>-->
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0 small fw-bolder">
                            <li class="nav-item"><a class="nav-link" href="../index.jsp">Inicio</a></li>
                            <li class="nav-item"><a class="nav-link" href="../paginas/experiencia.html">Experiencia</a></li>
                            <li class="nav-item"><a class="nav-link" href="../paginas/habilidades.html">Habilidades</a></li>
                            <li class="nav-item"><a class="nav-link" href="../paginas/proyectos.html">Proyectos</a></li>
                            <li class="nav-item"><a class="nav-link" href="../paginas/contacto.jsp">Contacto</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
            <!-- Page content-->
            <section class="py-5">
                <div class="container px-5">
                    <!-- Contact form-->
                    <div class="bg-light rounded-4 py-5 px-4 px-md-5">
                        <div class="text-center mb-5">
                            <div class="feature bg-primary bg-gradient-primary-to-secondary text-white rounded-3 mb-3"><i class="bi bi-envelope"></i></div>
                            <h1 class="fw-bolder">¿Quieres contactarme?</h1>
                            <p class="lead fw-normal text-muted mb-0">Escríbeme un mensaje</p>
                        </div>
                        <div class="row gx-5 justify-content-center">
                            <div class="col-lg-8 col-xl-6">
                                <%
                            // 1. Detectar si el formulario fue enviado al presionar el botón
                            if ("POST".equalsIgnoreCase(request.getMethod())) {
                                
                                // Capturar lo que el usuario escribió en las cajas de texto
                                String nombreParam = request.getParameter("nombre");
                                String correoParam = request.getParameter("correo");
                                String comentarioParam = request.getParameter("comentario");

                                // Credenciales del servidor Linux
                                String url = "jdbc:mysql://192.168.1.9:3306/Naty?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                                String usuario = "naty";
                                String password = "AbC12313e1985";

                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection(url, usuario, password);
                                    
                                    // 2. Preparar el INSERT (Usamos '?' para evitar problemas con comillas y saltos de línea)
                                    String sql = "INSERT INTO contacto (nombre, Correo, Comentario) VALUES (?, ?, ?)";
                                    PreparedStatement pstmt = conn.prepareStatement(sql);
                                    
                                    // 3. Asignar las variables a cada '?'
                                    pstmt.setString(1, nombreParam);
                                    pstmt.setString(2, correoParam);
                                    pstmt.setString(3, comentarioParam);
                                    
                                    // 4. Ejecutar la inserción
                                    int filasGuardadas = pstmt.executeUpdate();
                                    
                                    if (filasGuardadas > 0) {
                                        out.print("<div class='alert alert-success'>¡Tu comentario ha sido guardado exitosamente!</div>");
                                    }
                                    
                                    pstmt.close();
                                    conn.close();

                                } catch (Exception e) {
                                    out.print("<div class='alert alert-danger'>Error al guardar: " + e.getMessage() + "</div>");
                                }
                            }
                        %>
                                <form method="POST" action="">
                                    <!-- Nmbre input-->
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="nombre" name="nombre" type="text" placeholder="Ingresa tu nombre..." data-sb-validations="required" />
                                        <label for="nombre">Nombre completo</label>
                                        <div class="invalid-feedback" data-sb-feedback="name:required">El nombre es requerido.</div>
                                    </div>
                                    <!-- Email input-->
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="correo" name="correo" type="email" placeholder="name@example.com" data-sb-validations="required,email" />
                                        <label for="correo">Email</label>
                                        <div class="invalid-feedback" data-sb-feedback="email:required">Un email es requerido.</div>
                                        <div class="invalid-feedback" data-sb-feedback="email:email">Email inválido.</div>
                                    </div>
                                    <!-- Message input-->
                                    <div class="form-floating mb-3">
                                        <textarea class="form-control" id="comentario" name="comentario" type="text" placeholder="Ingresa tu mensaje aquí..." style="height: 10rem" data-sb-validations="required"></textarea>
                                        <label for="comentario">Mensaje</label>
                                        <div class="invalid-feedback" data-sb-feedback="message:required">Un mensaje es requerido.</div>
                                    </div>
                                    <!-- Botón enviar-->
                                    <div class="d-grid"><button type="submit" class="btn btn-primary btn-lg" >Enviar</button></div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="../js/scripts.js"></script>
    </body>
</html>
