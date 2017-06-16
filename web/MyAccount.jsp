

<%@page import="Domain.UserPrefs"%>
<%@ page import="java.io.*,java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
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
        <title>My Account</title>
        <link rel="icon" href="images/polygon_icon.png">
    </head>
    <body>
        <br><br>
        
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
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Welcome, <%=userPrefs.getUsername()%>!</h3>
                    </div>
                    <div class="panel-body">
                        <div class="table">
                            <table class="table">
                                <tr>
                                    <td><b>User ID:</b></td>
                                    <td><%=userPrefs.getUserID()%></td>
                                </tr>
                                <tr>
                                    <td><b>Full Name</b></td>
                                    <td><%=userPrefs.getLname()%> <%=userPrefs.getFname()%></td>
                                </tr>

                                <tr>
                                    <td><b>Email:</b></td>
                                    <td><%=userPrefs.getEmail()%></td>
                                </tr>
                                <tr>
                                    <td><b>Phone:</b></td>
                                    <td><%=userPrefs.getPhoneNo()%></td>
                                </tr>                                
                                <tr>
                                    <td><b>Access level:</b></td>
                                    <td><%
                                        int accessLevel = userPrefs.getAccessLevel();
                                        if (accessLevel == 1) {
                                            out.print("Admin");
                                        }
                                        if (accessLevel == 2) {
                                            out.print("Employee");
                                        }
                                        if (accessLevel == 3) {
                                            out.print("Customer");
                                        }
                                        %></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                ${errorMessage}
            </div>
        </div>
    </body>
</html>
