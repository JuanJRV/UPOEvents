
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="%{#session.USUARIO==null}">
    <!DOCTYPE html>
    <html lang="en">

        <head>
            <title>UPOEvents | Sign Up</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <!-- Bootstrap -->
            <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />

            <!-- Custom fonts for custom styles -->
            <link href="https://fonts.googleapis.com/css?family=Catamaran:100,200,300,400,500,600,700,800,900" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i" rel="stylesheet">

            <!-- Custom styles -->
            <link rel="stylesheet" href="css/global-styles.css" />
            <link rel="stylesheet" href="css/forms-styles.css" />
        </head>

        <body class="bg-two">
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
                                <a class="nav-link disabled" href="sign-up.jsp">Sign Up</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="log-in.jsp">Log In</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Sign up  -->
            <div class="container fix-navbar">
                <div class="row">
                    <div class="col-md-12 col-lg-9 mx-auto">
                        <div class="card card-signin my-5">
                            <div class="card-body">
                                <h5 class="card-title text-center">SIGN UP</h5>
                                <s:form action="nuevoUsuario" cssClass="form-signin" method="post">
                                    <div class="row">
                                        <div class="form-label-group col-md-12 col-lg-6">
                                            <s:textfield id="inputName"
                                                         name="nombre"
                                                         cssClass="form-control"
                                                         required="true"
                                                         placeholder="Name"
                                                         autofocus="true"></s:textfield>
                                                <label for="inputName">Name</label>
                                            </div>
                                            <div class="form-label-group col-md-12 col-lg-6">
                                            <s:textfield id="inputSurnames" 
                                                         name="apellidos"
                                                         cssClass="form-control"
                                                         required="true"
                                                         placeholder="Surnames"
                                                         autofocus="true"></s:textfield>
                                                <label for="inputSurnames">Surnames</label>
                                            </div>
                                            <div class="form-label-group col-md-12 col-lg-6">
                                            <s:textfield id="inputEmail"
                                                         name="email"
                                                         cssClass="form-control"
                                                         required="true"
                                                         placeholder="Email address"
                                                         type="email"
                                                         autofocus="true"></s:textfield>
                                                <label for="inputEmail">Email address</label>
                                            </div>
                                            <div class="form-label-group col-md-12 col-lg-6">
                                            <s:textfield id="inputBirthDate" 
                                                         name="fechaNacimiento"
                                                         cssClass="form-control"
                                                         required="true"
                                                         placeholder="Birth Date"
                                                         data-toggle="datepicker"
                                                         type="date"
                                                         autofocus="true"></s:textfield>
                                                <label for="inputBirthDate">Birth Date</label>
                                            </div>
                                            <div class="form-label-group col-md-12 col-lg-6">
                                            <s:password id="inputPassword"
                                                        name="clave"
                                                        cssClass="form-control"
                                                        required="true"
                                                        placeholder="Password"
                                                        autofocus="true"></s:password>
                                                <label for="inputPassword">Password</label>
                                            </div>
                                            <div class="form-label-group col-md-12 col-lg-6">
                                                <select name="genero" class="custom-select" id="inlineFormCustomSelect">
                                                    <option value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                    <option value="Other">Other</option>
                                                </select>
                                                <label for="inlineFormCustomSelect">Gender</label>
                                            </div>
                                        </div>
                                    <s:submit cssClass="btn btn-lg btn-dark btn-block text-uppercase mt-4" value="Sign up"></s:submit>
                                </s:form>
                                <div class="errors">
                                    <s:actionerror />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Scripts -->                        
            <script type="text/javascript" src="jQuery/jquery-3.4.0.min.js"></script>
            <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
        </body>
    </html>
</s:if>