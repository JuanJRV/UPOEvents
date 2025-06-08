

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="%{#session.USUARIO!=null}">
    <!DOCTYPE html>
    <html lang="en">

        <head>
            <title>UPOEvents | Requests</title>
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
            <link rel="stylesheet" href="css/tables-styles.css" />
        </head>

        <body class="bg-six">
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

            <!-- Main -->
            <div class="container">
                <h1>Requests</h1>
                <div class="custom-nav">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active text-dark" id="sent-tab" data-toggle="tab" href="#sent" role="tab"
                               aria-controls="sent" aria-selected="true">Sent</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" id="received-tab" data-toggle="tab" href="#received" role="tab"
                               aria-controls="received" aria-selected="false">Received</a>
                        </li>
                    </ul>
                </div>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="sent" role="tabpanel" aria-labelledby="sent-tab">
                        <table class="table">
                            <thead class="thead-dark">
                                <tr>
                                    <th class="d-lg-block d-md-none d-none" scope="col">#</th>
                                    <th scope="col">Event Name</th>
                                    <th scope="col">Site</th>
                                    <th scope="col">Date</th>
                                    <th scope="col">Hour</th>
                                    <th scope="col">State</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="peticionesEnviadas">
                                    <tr>
                                        <th class="d-lg-block d-md-none d-none" scope="row"><s:property value="idPeticion"></s:property></th>
                                        <td><s:property value="evento.nombre"></s:property></td>
                                        <td><s:property value="evento.lugar"></s:property></td>
                                        <td><s:date name = "evento.fecha" format = "yyyy-MM-dd" /></td>
                                        <td><s:property value="evento.hora"></s:property></td>
                                        <td><s:property value="estado"></s:property></td>
                                        </tr>
                                </s:iterator>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade" id="received" role="tabpanel" aria-labelledby="received-tab">
                        <table class="table">
                            <thead class="thead-dark">
                                <tr>
                                    <th class="d-lg-block d-md-none d-none" scope="col">#</th>
                                    <th scope="col">Event Name</th>
                                    <th scope="col">Site</th>
                                    <th scope="col">Date</th>
                                    <th scope="col">Hour</th>
                                    <th scope="col">State</th>
                                    <th scope="col">Contact</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="peticionesRecividas">
                                    <tr>
                                        <th class="d-lg-block d-md-none d-none" scope="row"><s:property value="idPeticion"></s:property></th>
                                        <td><s:property value="evento.nombre"></s:property></td>
                                        <td><s:property value="evento.lugar"></s:property></td>
                                        <td><s:date name = "evento.fecha" format = "yyyy-MM-dd" /></td>
                                        <td><s:property value="evento.hora"></s:property></td>
                                        <td><s:property value="estado"></s:property></td>
                                        <s:if test="estado=='ACCEPTED'">
                                            <td><s:property value="usuario.email"></s:property></td>
                                        </s:if>
                                        <s:elseif test="estado=='WAITING'">
                                            <td>
                                                <s:form action="aceptarPeticion" method="post">
                                                    <s:textfield name="idPeticion"
                                                                 value="%{idPeticion}"
                                                                 hidden="true"></s:textfield>
                                                    <s:textfield name="check_img"
                                                                 cssClass="icon block"
                                                                 type="image"
                                                                 src="img/icons/success-circle.svg"></s:textfield>
                                                </s:form>
                                                <s:form action="rechazarPeticion" method="post">
                                                    <s:textfield name="idPeticion"
                                                                 value="%{idPeticion}"
                                                                 hidden="true"></s:textfield>
                                                    <s:textfield name="x_img"
                                                                 cssClass="icon block"
                                                                 type="image"
                                                                 src="img/icons/error-circle.svg"></s:textfield>
                                                </s:form>
                                            </td>
                                        </s:elseif>
                                        <s:else>
                                            <td>-</td>
                                        </s:else>	
                                    </tr>
                                </s:iterator>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>

            <!-- Scripts -->   
            <script type="text/javascript" src="jQuery/jquery-3.4.0.min.js"></script>
            <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
        </body>

    </html>

</s:if>