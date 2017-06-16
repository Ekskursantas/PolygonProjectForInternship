

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>

        <%-- Java scrips for bootstrap here --%>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <title>Login</title>
        <link rel="icon" href="images/polygon_icon.png">
    </head>
    <body>
        <div class="navbar navbar-fixed-top navbar-default">
            <div class="container">
                <div class="navbar-header"><a class="navbar-brand" href="index.jsp">HealthyBuildings</a><a class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="glyphicon glyphicon-bar"></span>
                        <span class="glyphicon glyphicon-bar"></span>
                        <span class="glyphicon glyphicon-bar"></span>
                    </a>
                </div>

            </div>
        </div>
        <br><br><br><br>
        <%
            String login = request.getParameter("login");
            String mismatch = request.getParameter("mismatch");
            request.setAttribute("login", login);
            request.setAttribute("mismatch", mismatch);
        %>


        <!-- Begin # DIV Form -->
        <div class="container">
            <div class="col-sm-6 col-sm-offset-3">

                <!-- Begin # Login Form -->
                <div class="container-fluid panel panel-default">
                    <form action="Authenticate" role="form" method="post">
                        <div class="modal-body">
                            <img src="images/SundeBygninger.png" class="img-responsive center-block" alt="Cinque Terre">
                            <br>
                            <c:if test="${login == true}">
                                <div class="alert alert-warning fade in">
                                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                    <strong>You are not logged in.</strong><br> Please log in first.
                                </div>
                            </c:if>
                            <c:if test="${mismatch == true}">
                                <div class="alert alert-danger fade in">
                                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                    <strong>Wrong username or password.</strong><br> Try again.
                                </div>
                            </c:if>
                            <div id="div-login-msg">
                                <div id="icon-login-msg" class="glyphicon glyphicon-chevron-right"></div>
                                <span id="text-login-msg">Type your username and password.</span>
                            </div>
                            <br>
                            <input name="command" type="hidden" value="login">
                            <input id="email" class="form-control" type="email" name="email" placeholder="Email address" required>
                            <br>
                            <input id="password" name="password" class="form-control" type="password" placeholder="Password" required>
                           
                        </div>
                        <div class="modal-footer">
                            <div>
                                <button type="submit" class="btn btn-primary btn-lg btn-block">Login</button>
                            </div>
                            <div>
                                <button id="login_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                                <button id="login_register_btn" type="button" class="btn btn-link">Register</button>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- End # Login Form -->

            </div>
        </div>
    </body>
</html>
