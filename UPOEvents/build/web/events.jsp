<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="%{#session.USUARIO!=null}">
    <!DOCTYPE html>
    <html lang="en">

        <head>
            <title>UPOEvents | Events</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <!-- Bootstrap -->
            <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
            <!-- Custom fonts for custom styles -->
            <link href="https://fonts.googleapis.com/css?family=Catamaran:100,200,300,400,500,600,700,800,900" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i" rel="stylesheet">
            <!-- Custom styles -->
            <link rel="stylesheet" href="css/global-styles.css" />
            <link rel="stylesheet" href="css/tables-styles.css" />
        </head>

        <body class="bg-six">
            <!-- Navbar  -->
            <nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
                <div class="container">
                    <a class="navbar-brand" href="index.jsp">UPOEvents</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive"
                            aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarResponsive">
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item"><a class="nav-link" href="find-form.jsp">Find Events</a></li>
                            <li class="nav-item"><a class="nav-link" href="create.jsp">Create Events</a></li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false"><s:property value="%{#session.USUARIO.nombre}"></s:property></a>
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
                <h1>Events</h1>
                <div class="custom-nav">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active text-dark" id="host-tab" data-toggle="tab" href="#host" role="tab"
                               aria-controls="host" aria-selected="true">Host</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" id="attendant-tab" data-toggle="tab" href="#attendant" role="tab"
                               aria-controls="attendant" aria-selected="false">Attendant</a>
                        </li>
                    </ul>
                </div>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="host" role="tabpanel" aria-labelledby="host-tab">
                        <table class="table">
                            <thead class="thead-dark">
                                <tr>
                                    <th class="d-lg-block d-md-none d-none" scope="col">#</th>
                                    <th scope="col">Event Name</th>
                                    <th scope="col">Site</th>
                                    <th scope="col">Date</th>
                                    <th scope="col">Hour</th>
                                    <th scope="col">Capacity</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="eventosOrganizador">
                                    <tr>
                                        <th class="d-lg-block d-md-none d-none" scope="row"><s:property value="idEvento" /></th>
                                        <td><s:property value="nombre" /></td>
                                        <td><s:property value="lugar" /></td>
                                        <td><s:date name="fecha" format="yyyy-MM-dd" /></td>
                                        <td><s:property value="hora" /></td>
                                        <td><s:property value="aforo" /></td>
                                    </tr>
                                </s:iterator>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade" id="attendant" role="tabpanel" aria-labelledby="attendant-tab">
                        <table class="table">
                            <thead class="thead-dark">
                                <tr>
                                    <th class="d-lg-block d-md-none d-none" scope="col">#</th>
                                    <th scope="col">Event Name</th>
                                    <th scope="col">Site</th>
                                    <th scope="col">Date</th>
                                    <th scope="col">Hour</th>
                                    <th scope="col">Host</th>
                                    <th scope="col">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="eventosAsistente">
                                    <tr>
                                        <th class="d-lg-block d-md-none d-none" scope="row"><s:property value="idEvento" /></th>
                                        <td><s:property value="nombre" /></td>
                                        <td><s:property value="lugar" /></td>
                                        <td><s:date name="fecha" format="yyyy-MM-dd" /></td>
                                        <td><s:property value="hora" /></td>
                                        <td><s:property value="usuario.nombre" /></td>
                                        <td>
                                            <img src="img/icons/star-fill.svg" class="openReviewsModal clickable" />
                                            <img src="img/icons/report.svg" class="openReportingModal clickable" />
                                            <s:form cssClass="block" action="nuevoBloqueo" method="post">
                                                <s:textfield id="idEvento" name="idEvento" value="%{idEvento}" hidden="true" />
                                                <s:textfield name="trash_img" cssClass="icon block" type="image" src="img/icons/lock1-fill.svg" />
                                            </s:form>
                                        </td>
                                    </tr>
                                </s:iterator>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Reviews -->
            <div class="modal fade" id="reviewsModal" tabindex="-1" role="dialog" aria-labelledby="reviewsModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="reviewsModalLabel">Reviews</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <s:form action="nuevaValoracion" method="post">
                                <div class="row modal-form">
                                    <s:textfield name="idEvento" value="%{idEvento}" hidden="true" />
                                    <label class="col-12 p-0 m-0" for="rate">Rate</label>
                                    <s:textfield id="inputRate" name="inputRate" type="number" max="5" min="1" cssClass="col-12 mx-0 mb-2 mt-1 form-control" />
                                    <s:submit cssClass="mt-4 mx-0 col-12 btn btn-dark form-control" value="Send" />
                                </div>
                            </s:form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Reporting -->
            <div class="modal fade" id="reportingModal" tabindex="-1" role="dialog" aria-labelledby="reportingModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="reportingModalLabel">Reporting</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <s:form action="nuevoReporte" method="post">
                                <div class="row modal-form">
                                    <s:textfield name="idEvento" value="%{idEvento}" hidden="true" />
                                    <label class="col-12 p-0 m-0" for="category">Category</label>
                                    <select name="categoryInput" class="col-12 m-0 mb-2 mt-1 form-control">
                                        <option value="Others">Others</option>
                                    </select>
                                    <label class="col-12 p-0 m-0" for="issue">Explain your issue</label>
                                    <s:textarea cssClass="col-12 mb-2 mt-1 form-control" name="issueInput"></s:textarea>
                                    <s:submit cssClass="mt-4 mx-0 col-12 btn btn-dark form-control" value="Send" />
                                </div>
                            </s:form>
                        </div>
                    </div>
                </div>
            </div>



            <!-- Scripts -->
            <script type="text/javascript" src="jQuery/jquery-3.4.0.min.js"></script>
            <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
            <script type="text/javascript">
                $('.openReviewsModal').on('click', function () {
                    var id = $(this).closest('tr').find('th').text();
                    $('.modal-form').find("input[name='idEvento']").val(id);
                    $('#reviewsModal').modal('show');
                });

                $('.openReportingModal').on('click', function () {
                    var id = $(this).closest('tr').find('th').text();
                    $('.modal-form').find("input[name='idEvento']").val(id);
                    $('#reportingModal').modal('show');
                });


            </script>
        </body>

    </html>
</s:if>
