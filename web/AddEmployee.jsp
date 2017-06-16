

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
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>Healthy Buildings</title>
        <link rel="icon" href="images/polygon_icon.png">
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
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
            <div class="col-lg-12">
                <form class="form-horizontal" action="UserServlet" method="post">
                    <fieldset>

                        <!-- Form Name -->
                        <legend>Add new employee</legend>

                        <input type="hidden" name="command" value="addEmployee"/>
                        <!-- Text input-->
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="fname">First name</label>  
                            <div class="col-md-4">
                                <input id="textinput" name="fname" placeholder="First name" class="form-control input-md" required="" type="text">

                            </div>
                        </div>

                        <!-- Text input-->
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="lname">Last name</label>  
                            <div class="col-md-4">
                                <input id="laname" name="lname" placeholder="Last name" class="form-control input-md" required="" type="text">

                            </div>
                        </div>

                        <!-- Text input-->
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="username">Username</label>  
                            <div class="col-md-4">
                                <input id="username" name="username" placeholder="Username" class="form-control input-md" required="" type="text">

                            </div>
                        </div>

                        <!-- Password input-->
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="pwd">Password</label>
                            <div class="col-md-4">
                                <input id="pwd" name="pwd" placeholder="Password" class="form-control input-md" required="" type="password">

                            </div>
                        </div>

                        <!-- Text input-->
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="email">Email</label>  
                            <div class="col-md-4">
                                <input id="email" name="email" placeholder="Email" class="form-control input-md" required="" type="text">

                            </div>
                        </div>

                        <!-- Text input-->
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="phone_no">Phone number</label>  
                            <div class="col-md-4">
                                <input id="phone_no" name="phone_no" placeholder="Phone number" class="form-control input-md" required="" type="text">

                            </div>
                        </div>
                        <!-- Button -->
                        <div class="form-group">
                            <label class="col-md-4 control-label"></label>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-default">Submit</button>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
