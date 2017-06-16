

<%@page import="Domain.DomainFacade"%>
<%@page import="Domain.CheckupReport"%>
<%@page import="Domain.UserPrefs"%>
<%@page import="java.util.List"%>
<%@page import="Presentation.UserServlet"%>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    List<CheckupReport> requestList = (List<CheckupReport>) request.getAttribute("reports");
    List<CheckupReport> reports = (List<CheckupReport>) request.getAttribute("reports");
    List<CheckupReport> donereports = (List<CheckupReport>) request.getAttribute("donereports");
    DomainFacade dm = DomainFacade.getInstance();

    //request.setAttribute("requestList", requestList);
    if (requestList == null || requestList.isEmpty()) {
        request.setAttribute("errorMessage", "requestList obj empty.");
        reports = dm.showActiveCheckupReports();
        donereports = dm.showDoneCheckupReports();
        request.setAttribute("reports", reports);
        request.setAttribute("donereports", donereports);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkup Reports</title>
        <link rel="icon" href="images/polygon_icon.png">
        <!-- Bootstrap -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
        <%-- Java scrips for bootstrap here --%>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.js"></script>
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
            <div class="row">
                <div class="col-sm-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Reports waiting to be filled out</h3>
                        </div>
                        <table class="table table-bordered"  width="100%">
                            <thread>
                                <tr>
                                    <th>ID</th> 
                                    <th>Customer</th> 
                                    <th>Employee</th>
                                    <th>Address</th>
                                    <th>Perform</th>
                                </tr>
                            </thread>
                            <c:forEach var="request" items="${reports}">
                                <tr>
                                    <td><c:out value="${request.getCreport_id()}"/></td>
                                    <td><c:out value="${request.getCustomer().getCompany_name()}"/></td>
                                    <td><c:out value="${request.getEmployee().getFname()}"/> <c:out value="${request.getEmployee().getLname()}"/></td>
                                    <td><c:out value="${request.getBuilding().getStreet()}"/> <br> <c:out value="${request.getBuilding().getZip()}"/> <c:out value="${request.getBuilding().getCity()}"/></td>
                                    <td><a href="UserServlet?command=selectReport&reportid=${request.getCreport_id()}">Fill out report</a></td>
                                </tr>

                            </c:forEach>
                        </table>
                    </div>
                </div>

                <div class="col-sm-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">

                            <h3 class="panel-title">Finished CheckUp Reports</h3>
                        </div>
                        <table class="table table-bordered" width="100%">
                            <thread>
                                <tr>
                                    <th>ID</th> 
                                    <th><span class="glyphicon glyphicon-user"></span> Customer</th> 
                                    <th>Employee</th>
                                    <th>Address</th>
                                    <th>Details</th>
                                </tr>
                            </thread>
                            <c:forEach var="request" items="${donereports}">
                                <tr>
                                    <td><c:out value="${request.getCreport_id()}"/></td>
                                    <td><c:out value="${request.getCustomer().getCompany_name()}"/></td>
                                    <td><c:out value="${request.getEmployee().getFname()}"/> <c:out value="${request.getEmployee().getLname()}"/></td>
                                    <td><c:out value="${request.getBuilding().getStreet()}"/> <br> <c:out value="${request.getBuilding().getZip()}"/></td>
                                    <td><a href="UserServlet?command=selectFinishedReport&reportid=${request.getCreport_id()}">Show more</a></a></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>

                </div>

            </div>
            <div class="row">
                <div class="col-lg-4">
                    <c:if test="${errorMessage != null}">
                        <div class="alert alert-warning">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            <strong>Warning!</strong> ${errorMessage}
                        </div>
                    </c:if>
                    <c:if test="${savedRequest == true}">
                        <div class="alert alert-success">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            <strong>Success!</strong> Request has been saved.
                        </div>
                    </c:if>
                    <c:if test="${savedRequest == false}">
                        <div class="alert alert-danger">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            <strong>Error!</strong> Your request failed to save.
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

</body>
</html>
