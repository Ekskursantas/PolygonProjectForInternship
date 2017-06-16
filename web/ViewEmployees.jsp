

<%@page import="Domain.UserPrefs"%>
<%@page import="Domain.Employee"%>
<%@page import="java.util.List"%>
<%@page import="Domain.DomainFacade"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%
    DomainFacade domainModel = DomainFacade.getInstance();

    List<Employee> employees = domainModel.showEmployees();
    request.setAttribute("employees", employees);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!--Custom css-->
        <link href="css/styles.css" rel="stylesheet">

        <title>Employees</title>
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
            <h1>Employees</h1>
            <div class="panel">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone number</th>

                        </tr>
                    </thead>
                    <c:forEach var="employee" items="${employees}">
                        <tr>
                            <td><c:out value="${employee.getEmployee_id()}"/></td>
                            <td><c:out value="${employee.getFname()}"/> <c:out value="${employee.getLname()}"/></td>
                            <td><c:out value="${employee.getUsername()}"/></td>
                            <td><c:out value="${employee.getEmail()}"/></td> 
                            <td><c:out value="${employee.getPhone_no()}"/></td>
                        </tr>
                    </c:forEach>
                </table>
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
