
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="%{#session.USUARIO!=null}">

    <!DOCTYPE html>
    <html lang="en">

        <head>
            <title>UPOEvents | Profile</title>
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

            <!--Main-->
            <div class="container">
                <h1>Profile</h1>

                <div class="custom-nav">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <button class="nav-link active text-dark openEditModal">Edit</button>
                        </li>
                        <li class="nav-item">
                            <button class="nav-link active text-dark openPasswordModal">Change Password</button>
                        </li>
                        <li class="nav-item">
                            <button class="nav-link active text-danger openCloseModal">Close Account</button>
                        </li>
                    </ul>
                </div>
                <hr>
                <div class="px-2">
                    <h2>Personal Info</h2>

                    <div class="row a-center">
                        <div class="col-6 my-1">
                            Name: <span id="userName"><s:property value="%{#session.USUARIO.nombre}"></s:property></span>
                            </div>
                            <div class="col-6 my-1">
                                Surnames: <span id="userSurnames"><s:property value="%{#session.USUARIO.apellidos}"></s:property></span>
                            </div>
                            <div class="col-6 my-1">
                                Gender: <span id="userGender"><s:property value="%{#session.USUARIO.genero}"></s:property></span>
                            </div>
                            <div class="col-6 my-1">
                                Birth Date: <span id="userBirthDate"><s:date name = "%{#session.USUARIO.fechaNacimiento}" format = "yyyy-MM-dd" /></span>
                        </div>
                        <div class="col-6 my-1">
                            Email: <s:property value="%{#session.USUARIO.email}"></s:property>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Edit -->
                <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editModalLabel">Edit</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                            <s:form action="editarUsuario"  method="post">
                                <div class="row modal-form">
                                    <label class="col-12 p-0 m-0" for="inputName">Name</label>
                                    <s:textfield id="inputName"
                                                 name="nombre"
                                                 cssClass="col-12 mx-0 mb-2 mt-1 form-control"
                                                 autofocus="true"></s:textfield>

                                        <label class="col-12 p-0 m-0" for="inputSurnames">Surnames</label>
                                    <s:textfield id="inputSurnames" 
                                                 name="apellidos"
                                                 cssClass="col-12 mx-0 mb-2 mt-1 form-control"
                                                 autofocus="true"
                                                 value="%{#session.USUARIO.apellidos}"></s:textfield>


                                        <label class="col-12 p-0 m-0" for="inputGender">Gender</label>
                                        <select name="genero" class="col-12 m-0 mb-2 mt-1 form-control" id="inlineFormCustomSelect">
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                            <option value="Other">Other</option>
                                        </select>

                                        <label class="col-12 p-0 m-0" for="inputBirthDate">Birth Date</label>
                                    <s:textfield id="inputBirthDate" 
                                                 name="fechaNacimiento"
                                                 cssClass="col-12 mx-0 mb-2 mt-1 form-control"
                                                 data-toggle="datepicker"
                                                 type="date"
                                                 autofocus="true"></s:textfield>

                                        <label class="col-12 p-0 m-0" for="inputPassword">Password</label>
                                    <s:password name="clave"
                                                cssClass="col-12 mx-0 mb-2 mt-1 form-control"
                                                autofocus="true"></s:password>

                                    <s:submit cssClass="mt-4 mx-0 col-12 btn btn-dark form-control" value="Send"></s:submit>
                                    </div>
                            </s:form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Password -->
            <div class="modal fade" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="passwordModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="passwordModalLabel">Change Password</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <s:form action="cambiarClave"  method="post">
                                <div class="row modal-form">

                                    <label class="col-12 p-0 m-0" for="inputPasswordNew">New password</label>
                                    <s:password id="inputPasswordNew"
                                                name="nuevaClave"
                                                cssClass="col-12 mx-0 mb-2 mt-1 form-control"
                                                autofocus="true"></s:password>

                                        <label class="col-12 p-0 m-0" for="inputPasswordCurrent">Current password</label>
                                    <s:password id="inputPasswordCurrent"
                                                name="clave"
                                                cssClass="col-12 mx-0 mb-2 mt-1 form-control"
                                                autofocus="true"></s:password>
                                    <s:submit cssClass="mt-4 mx-0 col-12 btn btn-dark form-control" value="Send"></s:submit>
                                    </div>
                            </s:form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- close -->
            <div class="modal fade" id="closeModal" tabindex="-1" role="dialog" aria-labelledby="closeModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="closeModalLabel">Close Account</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <s:form action="borrarUsuario"  method="post">
                                <div class="row modal-form">

                                    <label class="col-12 p-0 m-0" for="inputPassword">Password</label>
                                    <s:password name="clave"
                                                cssClass="col-12 mx-0 mb-2 mt-1 form-control"
                                                autofocus="true"></s:password>
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
                $('.openEditModal').on('click', function () {

                    $("#inputName").val($("#userName").text());
                    $("#inputSurnames").val($("#userSurnames").text());
                    $("#inlineFormCustomSelect").val($("#userGender").text());
                    $("#inputBirthDate").val($("#userBirthDate").text());

                    $('#editModal').modal({show: true});
                });
                $('.openPasswordModal').on('click', function () {
                    $('#passwordModal').modal({show: true});
                });
                $('.openCloseModal').on('click', function () {
                    $('#closeModal').modal({show: true});
                });

               
            </script>
        </body>

    </html>

</s:if>