
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="%{#session.USUARIO!=null}">

    <!DOCTYPE html>
    <html lang="en">

        <head>
            <title>UPOEvents | Find Events</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <!-- Bootstrap -->
            <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />

            <!-- Custom fonts for custom styles -->
            <link href="https://fonts.googleapis.com/css?family=Catamaran:100,200,300,400,500,600,700,800,900" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i"
                  rel="stylesheet">

            <!-- Custom styles -->
            <link rel="stylesheet" href="css/global-styles.css" />
            <link rel="stylesheet" href="css/find-result-styles.css" />

        </head>

        <body class="bg-three">
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
                                <a class="nav-link" href="offer.jsp">Create Events</a>
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

            <!--Available events-->
            <div class="container trip-container">
                <s:if test="eventosDisponibles.size()==0">
                    <h1>No available Events</h1>
                </s:if>
                <s:else>
                    <h1>Available Events</h1>

                    <s:iterator value="eventosDisponibles" status="incr">
                        <s:if test="%{#incr.index%2==0}">
                            <div class="row">
                            </s:if>

                            <article class="card fl-left">
                                <section class="date">
                                    <time datetime="<s:property value='fecha.toString()'></s:property>">
                                        <span><s:property value='fecha.getDate()'></s:property></span><span><s:property value='fecha.toString().split(" ")[1]'></s:property></span>
                                        </time>
                                    </section>
                                    <section class="card-cont">
                                            <small>Posted by <s:property value='usuario.nombre'></s:property></small>
                                    <h3><s:property value='nombre'></s:property></h3>
                                        <small>Site</small>
                                        <h3><s:property value='lugar'></s:property></h3>
                                        <div class="even-date">
                                            <time>
                                                <small>Date</small>
                                                <span><h3><s:property value='fecha.toString().replaceAll( "00:00:00 ", "").replaceAll("CEST ", "")'></s:property></span>
                                            <span><s:property value='hora'></s:property></h3></span>
                                            </time>
                                        </div>
                                        <div class="even-info">
                                            <small>Capacity</small>
                                            <span><h3><s:property value='aforo'></s:property></h3></span> 
                                        </div>
                                    <s:form action="enviarPeticion" method="post">
                                        <s:textfield id="idEvento" name="idEvento" value="%{idEvento}" hidden="true"></s:textfield>
                                        <s:submit cssClass="btn btn-dark" value="Request"></s:submit>
                                    </s:form>
                                </section>
                            </article>
                            <s:if test="%{#incr.index%2!=0}">
                            </div>
                        </s:if>

                    </s:iterator>

                </s:else>
            </div>

            <!-- Scripts -->   
            <script type="text/javascript" src="jQuery/jquery-3.4.0.min.js"></script>
            <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
        </body>

    </html>
</s:if>