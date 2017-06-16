
<%@page import="Domain.CheckupReport"%>
<%@page import="Domain.UserPrefs"%>
<%@page import="java.util.List"%>
<%@page import="Domain.Building"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Domain.DomainFacade"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My jobs</title>
        <link rel="icon" href="images/polygon_icon.png">
        <!-- Bootstrap Core CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
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
            DomainFacade dm = DomainFacade.getInstance();
            List<CheckupReport> myReports = dm.getMyReports(userPrefs.getUserID());
            if (!myReports.isEmpty()) {
                request.setAttribute("myReports", myReports);
            } else {
                request.setAttribute("myReports", null);
            }
        %>
        <c:if test="${username == null}">
            <jsp:forward page="Login.jsp?login=true" />
        </c:if>
        <mytags:navbar/>
        <div class="container">
            <div class="col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">My CheckUp requests to do</h3>
                    </div>
                    <c:choose>
                        <c:when test="${myReports != null}">
                            <table class="table table-bordered" cellspacing="0" width="100%">
                                <thread>
                                    <tr>
                                        <th>ID</th> 
                                        <th>Customer</th> 
                                        <th>Employee</th>
                                        <th>Address</th>
                                        <th>Perform</th>
                                    </tr>
                                </thread>
                                <c:forEach var="report" items="${myReports}">
                                    <tr>
                                        <td><c:out value="${report.getCreport_id()}"/></td>
                                        <td><c:out value="${report.getCustomer().getFname()}"/> <c:out value="${report.getCustomer().getLname()}"/></td>
                                        <td><c:out value="${report.getEmployee().getFname()}"/> <c:out value="${report.getEmployee().getLname()}"/></td>
                                        <td><c:out value="${report.getBuilding().getStreet()}"/> <br> <c:out value="${report.getBuilding().getZip()}"/> <c:out value="${report.getBuilding().getCity()}"/></td>
                                        <td><a href="UserServlet?command=selectReport&reportid=${report.getCreport_id()}">Fill out report</a></td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:when>
                        <c:when test="${myReports == null}">
                                <div class="alert alert-success fade in">
                                    <strong>No jobs.</strong> You have no task assigned.
                                </div>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>
    </body>
</html>
