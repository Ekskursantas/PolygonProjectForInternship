

<%@page import="Domain.UserPrefs"%>
<%@page import="Domain.ServiceRequest"%>
<%@page import="java.util.List"%>
<%@page import="Domain.DomainFacade"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link href="css/styles.css" rel="stylesheet">
        <title>Reported Damages</title>
        <link rel="icon" href="images/polygon_icon.png">
        <%-- Java scrips for bootstrap here --%>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>

        <%
            DomainFacade domainModel = DomainFacade.getInstance();
            List<ServiceRequest> serviceRequests = domainModel.showPendingServiceRequests();
            request.setAttribute("serviceRequests", serviceRequests);

            if (serviceRequests == null || serviceRequests.isEmpty()) {
                request.setAttribute("nothingToShowMessage", "No service requests to show");
            }
        %>
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

            <div class="col-sm-8">
                <h2>Reported damages</h2>
                ${takeServiceMessage}
                ${nothingToShowMessage}
                <table class="table">
                    <thead>
                        <tr>
                            <th>Building ID</th>
                            <th>Service ID</th>
                            <th>Date</th>
                            <th>Description</th>
                            <th>Take Job</th>

                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="service" items="${serviceRequests}">
                            <tr>
                                <th scope="row"><c:out value="${service.getBuilding_id()}"/></th>
                                <td><c:out value="${service.getService_id()}"/></td>
                                <td><c:out value="${service.getRequestDate()}"/></td>
                                <td><c:out value="${service.getDescription()}"/></td>

                                <td><a href="UserServlet?command=takeServiceRequest&srequest_id=${service.getSrequest_id()}">Take this job</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>

    </body>
</html>
