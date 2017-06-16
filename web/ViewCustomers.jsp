

<%@page import="Domain.UserPrefs"%>
<%@page import="java.util.List"%>
<%@page import="Domain.Customer"%>
<%@page import="Domain.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Healthy Buildings</title>
        <link rel="icon" href="images/polygon_icon.png">
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
        <%-- Java scrips for bootstrap here --%>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
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
            <div class="col-md-12">
                <c:choose>
                    <c:when test="${result}">
                        <div class="alert alert-success fade in">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            <strong>Success!</strong> Customer added.
                        </div>
                    </c:when>
                    <c:when test="${result}">
                        <div class="alert alert-warning fade in">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            <strong>Failure!</strong> Data was not saved.
                        </div>
                    </c:when>
                    <c:otherwise>

                    </c:otherwise>
                </c:choose>
                <h1>Customers</h1>
                <div class="panel">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Phone number</th>
                                <th><span class="glyphicon glyphicon-home"></span> Company</th>
                            </tr>
                        </thead>
                        <c:forEach var="customer" items="${customers}" >
                            <tr>
                                <td><c:out value="${customer.getCustomer_id()}"/></td>
                                <td><c:out value="${customer.getFname()}"/> <c:out value="${customer.getLname()}"/></td>
                                <td><c:out value="${customer.getUsername()}"/></td>
                                <td><c:out value="${customer.getEmail()}"/></td> 
                                <td><c:out value="${customer.getPhone_no()}"/></td>
                                <td><c:out value="${customer.getCompany_name()}"/></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
