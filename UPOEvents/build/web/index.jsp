

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>UPOEvents | Index</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />

        <!-- Custom fonts for custom styles -->
        <link href="https://fonts.googleapis.com/css?family=Catamaran:100,200,300,400,500,600,700,800,900" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i"
              rel="stylesheet">

        <!-- Custom styles -->
        <link rel="stylesheet" href="css/global-styles.css" />
    </head>

    <body>
        <s:if test="%{#session.USUARIO!=null}">
            <!-- Nav -->
            <nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
                <div class="container">
                    <a class="navbar-brand" data-text="UPOEvents" href="index.jsp">UPOEvents</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive"
                            aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarResponsive">
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="find-form.jsp">Find Events</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="create.jsp">Create Events</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <s:property value="%{#session.USUARIO.nombre}"></s:property>
                                    </a>
                                    <div class="dropdown-menu navbar-dropdown" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item text-dark" href="profile.jsp">Profile</a>
                                    <s:form method="post" action="cargarEventos" cssClass="dropdown-item p-0">
                                        <s:submit cssClass="text-dark btn btn-link input-logout" value="Events"></s:submit>
                                    </s:form>
                                    <s:form method="post" action="cargarPeticiones" cssClass="dropdown-item p-0">
                                        <s:submit cssClass="text-dark btn btn-link input-logout" value="Requests"></s:submit>
                                    </s:form>
                                    <s:form method="post" action="cargarReportes" cssClass="dropdown-item p-0">
                                        <s:submit cssClass="text-dark btn btn-link input-logout" value="Reports"></s:submit>
                                    </s:form>
                                    <s:form method="post" action="cargarValoraciones" cssClass="dropdown-item p-0">
                                        <s:submit cssClass="text-dark btn btn-link input-logout" value="Reviews"></s:submit>
                                    </s:form>
                                    <s:form method="post" action="cargarBloqueos" cssClass="dropdown-item p-0">
                                        <s:submit cssClass="text-dark btn btn-link input-logout" value="Blocks"></s:submit>
                                    </s:form>
                                    <div class="dropdown-divider"></div>
                                    <s:form method="post" action="cerrarSesionUsuario" cssClass="dropdown-item p-0">
                                        <s:submit cssClass="text-danger btn btn-link input-logout" value="Log out"></s:submit>
                                    </s:form>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </s:if>
        <s:else>
            <!-- Navigation -->
            <nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
                <div class="container">
                    <a class="navbar-brand" data-text="UPOEvents" href="index.jsp">UPOEvents</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive"
                            aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarResponsive">
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="sign-up.jsp">Sign Up</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="log-in.jsp">Log In</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </s:else>

        <!--Header-->
        <header>
            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner" role="listbox">
                    <!-- Slide One  -->
                    <div class="carousel-item active" style="background-image: url('img/carousel1-01.jpg')"></div>
                    <!-- Slide Two  -->
                    <div class="carousel-item" style="background-image: url('img/carousel-02.jpg')"></div>
                    <!-- Slide Three -->
                    <div class="carousel-item" style="background-image: url('img/carousel-03.jpg')"></div>
                </div>

                <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </header>
        <!--Main-->
        <main class="mb-2">
            <section class="card-template">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6 order-lg-2">
                            <div class="p-5">
                                <img class="img-fluid rounded-circle" src="img/card1-01.jpg" alt="">
                            </div>
                        </div>
                        <div class="col-lg-6 order-lg-1">
                            <div class="p-5">
                                <h2 class="display-4">With access to millions of events </h2>
                                <p style="text-align: justify;">With access to millions of events on our platform, you can explore a wide variety of activities and gatherings that suit your interests and geographical proximity. Meet like-minded people nearby and join exciting events in your area.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="card-template" style="text-align: justify;">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <div class="p-5">
                                <img class="img-fluid rounded-circle" src="img/card-02.jpg" alt="">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="p-5">
                                <h2 class="display-4">Simple</h2>
                                <p>Our platform makes it easy to find the perfect event. Simply enter your location and discover a diverse range of events that match your preferences and availability. With just a few clicks, you'll be on your way to new experiences and meaningful connections.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="card-template" style="text-align: justify;">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6 order-lg-2">
                            <div class="p-5">
                                <img class="img-fluid rounded-circle" src="img/card3-03.jpg" alt="">
                            </div>
                        </div>
                        <div class="col-lg-6 order-lg-1">
                            <div class="p-5">
                                <h2 class="display-4">Without ads!</h2>
                                <p>Enjoy an interruption-free experience with our ad-free platform. Connect with new people and live authentic experiences without distractions. Focus on what truly matters: meeting new people and enjoying unforgettable moments at exciting events.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <!-- Footer -->
        <footer class="py-5 bg-black text-white">
            <div class="container">
                UPOEvents brings people together through unforgettable experiences. Say goodbye to dull weekends and hello to thrilling adventures. Join us to discover exciting events and meet like-minded individuals who share your passions.
                <br /><br />
                UPOEvents, 2024 &copy;
            </div>
        </footer>

        <!-- Scripts -->   
        <script type="text/javascript" src="jQuery/jquery-3.4.0.min.js"></script>
        <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    </body>

</html>