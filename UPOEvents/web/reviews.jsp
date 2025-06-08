
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="%{#session.USUARIO!=null}">
    <!DOCTYPE html>
    <html lang="en">

        <head>
            <title>UPOEvents | Reviews</title>
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
                <h1>Reviews</h1>
                <table class="table">
                    <thead class="thead-dark">
                        <tr>
                            <th class="d-lg-block d-md-none d-none" scope="col">#</th>
                            <th scope="col">Event Name</th>
                            <th scope="col">Site</th>
                            <th scope="col">Date</th>
                            <th scope="col">Hour</th>
                            <th scope="col">Reviews</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <s:iterator value="listaValoracion">
                            <tr>
                                <th class="d-lg-block d-md-none d-none" scope="row"><s:property value="idValoracion"></s:property></th>
                                <td><s:property value="evento.nombre"></s:property></td>
                                <td><s:property value="evento.lugar"></s:property></td>
                                <td><s:date name = "evento.fecha" format = "yyyy-MM-dd" /></td>
                                <td><s:property value="evento.hora"></s:property></td>
                                <td id="rateValue"><s:property value="valoracion"></s:property></td>
                                    <td>
                                    <s:form method="post" action="eliminarValoracion">
                                        <s:textfield name="idValoracion"
                                                     value="%{idValoracion}"
                                                     hidden="true"></s:textfield>
                                        <s:textfield name="trash_img"
                                                     cssClass="icon block"
                                                     type="image"
                                                     src="img/icons/trash.svg"></s:textfield>
                                    </s:form>
                                    <img src="img/icons/pencil.svg" class="openReviewsModal clickable" />
                                </td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
            </div>

            <!-- Reviews -->
            <div class="modal fade" id="reviewsModal" tabindex="-1" role="dialog" aria-labelledby="reviewsModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="reviewsModalLabel">Reviews</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <s:form method="post" action="editarValoracion">
                                <div class="row modal-form">
                                    <s:textfield name="idValoracion"
                                                 hidden="true"></s:textfield>
                                        <label class="col-12 p-0 m-0" for="rate">Rate</label>
                                    <s:textfield id="inputRate"
                                                 name="inputRate"
                                                 type="number"
                                                 max="5"
                                                 min="1"
                                                 cssClass="col-12 mx-0 mb-2 mt-1 form-control"></s:textfield>
                                    <s:submit cssClass="mt-4 mx-0 col-12 btn btn-dark form-control" value="Send"></s:submit>
                                    </div>
                            </s:form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Scripts -->   
            <script type="text/javascript" src="jQuery/jquery-3.4.0.min.js"></script>
            <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
            <script typw="text/javascript">
                $('.openReviewsModal').on('click', function () {
                    var id = $(this).closest('tr').find('th').text();
                    var rate = $(this).closest('tr').find($("#rateValue")).text();

                    $('.modal-form').find("input[name='idValoracion']").val(id);
                    $("#inputRate").val(rate);

                    $('#reviewsModal').modal({show: true});
                });
            </script>
        </body>

    </html>
</s:if>