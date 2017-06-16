

<%@page import="Domain.UserPrefs"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
         <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap Core CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <!-- Custom css -->
        <link href="css/styles.css" rel="stylesheet">
        <title>Healthy Buildings</title>
        <link rel="icon" href="images/polygon_icon.png">
        
    </head>
    <body>
        <%
            UserPrefs userPrefs = (UserPrefs) session.getAttribute("UserPrefs");
            if (userPrefs != null) {
                request.setAttribute("username", userPrefs.getUsername());
                request.setAttribute("accessLevel", userPrefs.getAccessLevel());
            }
        %>
        <c:if test="${username == null}">
            <jsp:forward page="Login.jsp?login=true" />
        </c:if>
        <mytags:navbar/>
        <div class="container">
            <div class="col-sm-6">
                <h1>Add new customer</h1>
                <form role="form" action="UserServlet" method="post" data-toggle="validator">
                    <input type="hidden" name="command" value="addCustomer">
                    <div class="form-group">
                        <label for="company_name">Municipality or association name:</label>
                        <input type="text" class="form-control" name="company_name" placeholder="Municipality or association name" required>
                    </div>
                    <div class="form-group">
                        <label for="fname">Contact person's first name:</label>
                        <input type="text" class="form-control" name="fname" placeholder="Contact person's first name" required>
                    </div>
                    <div class="form-group">
                        <label for="lname">Contact person's last name:</label>
                        <input type="text" class="form-control" name="lname" placeholder="Contact person's last name" required>
                    </div>
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" class="form-control" name="username" placeholder="Username" required>
                    </div>
                    <div class="form-group">
                        <label for="pwd">Password:</label>
                        <input type="password" class="form-control" name="pwd" placeholder="Password" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" placeholder="Email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="phone_no">Phone number:</label>
                        <input type="text" class="form-control" name="phone_no" placeholder="Phone number">
                    </div>
                    <button type="submit" class="btn btn-success">Submit</button>
                </form>
            </div>
            <div class="col-sm-6">
                <img class="pull-left" src="images/helico2.gif" width="400" height="300" alt="building"/>
            </div>
        </div>

        <!-- Latest compiled JavaScript -->
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
