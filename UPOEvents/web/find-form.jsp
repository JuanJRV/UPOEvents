
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
            <link rel="stylesheet" href="css/forms-styles.css" />
        </head>

        <body class="bg-five">
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
                                <a class="nav-link disabled" href="find-form.jsp">Find Events</a>
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

            <!-- Post Form -->
            <div class="container fix-navbar">
                <div class="row">
                    <div class="col-md-12 col-lg-9 mx-auto">
                        <div class="card card-signin my-5">
                            <div class="card-body">
                                <h5 class="card-title text-center">FIND EVENTS</h5>
                                <s:form action="buscarEvento" cssClass="form-signin" method="post">
                                    <div class="row">
                                        <div class="form-label-group col-md-12 col-lg-6">
                                            <select name="lugar" class="custom-select" id="lugarSelect"></select>
                                            <label for="lugarSelect">Site</label>
                                        </div>
                                        <div class="form-label-group col-md-12 col-lg-6">
                                            <s:textfield id="inputInitialDate" 
                                                         name="fecha_inicio"
                                                         cssClass="form-control"
                                                         required="true"
                                                         placeholder="Date"
                                                         data-toggle="datepicker"
                                                         type="date"
                                                         autofocus="true"></s:textfield>
                                                <label for="inputInitialDate">From</label>
                                            </div>
                                            <div class="form-label-group col-md-12 col-lg-6">
                                            <s:textfield id="inputFinalDate" 
                                                         name="fecha_fin"
                                                         cssClass="form-control"
                                                         required="true"
                                                         placeholder="Date"
                                                         data-toggle="datepicker"
                                                         type="date"
                                                         autofocus="true"></s:textfield>
                                                <label for="inputFinalDate">To</label>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-lg btn-dark btn-block text-uppercase mt-4">Find Events</button>
                                </s:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Scripts -->   
            <script type="text/javascript" src="jQuery/jquery-3.4.0.min.js"></script>
            <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
            <script type="text/javascript">
                // Generamos opciones para los campos #lugarSelect 
                var requestURL = 'https://public.opendatasoft.com/api/explore/v2.1/catalog/datasets/georef-spain-provincia/records?select=prov_name&order_by=prov_name%20ASC&limit=52&exclude=prov_name:Territorio%20no%20asociado%20a%20ninguna%20provincia';
                var request = new XMLHttpRequest();
                request.open('GET', requestURL);
                request.responseType = 'json';
                request.send();

                request.onload = function () {
                    if (request.status >= 200 && request.status < 300) {
                        console.log("Respuesta de la API:", request.response);

                        var provinces = request.response.results; // Acceder al array de resultados
                        if (provinces && Array.isArray(provinces)) {
                            var rows = provinces.length;

                            for (var i = 0; i < rows; i++) {
                                var province = provinces[i].prov_name; // Acceder al campo prov_name
                                $("#lugarSelect").append($("<option>").attr("value", province).text(province));
                            }
                        } else {
                            console.error("La respuesta no contiene el formato esperado.");
                        }
                    } else {
                        console.error("Error en la solicitud: " + request.statusText);
                    }
                }

                request.onerror = function () {
                    console.error("Error en la solicitud.");
                }
            </script>
        </body>
    </html>
</s:if>