

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
        <title>My Buildings</title>
        <link rel="icon" href="images/polygon_icon.png">
        <link rel="icon" href="http://example.com/favicon.png">
        <!-- Bootstrap Core CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link href="css/styles.css" rel="stylesheet">
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/galleria-1.4.2.min.js"></script>

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

        <%
            DomainFacade domainModel = DomainFacade.getInstance();
            List<Building> buildings = domainModel.getMyBuildings(userPrefs.getUserID());

            if (buildings.isEmpty() || buildings == null) {
                request.setAttribute("message", "No buildings to show.");
            } else {
                request.setAttribute("buildings", buildings);
            }
        %>
        <mytags:navbar/>
        <div class="container">
            <h1>My Buildings</h1>

            <div class="col-sm-12">
                <div class="panel panel-group">
                    <c:choose>
                        <c:when test="${result == 'true'}">
                            <div class="alert alert-success fade in">
                                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                <strong>Success!</strong> Building was added.
                            </div>
                        </c:when>
                        <c:when test="${result == 'false'}">
                            <div class="alert alert-warning fade in">
                                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                <strong>Failure!</strong> Building was not added.
                            </div>
                        </c:when>
                        <c:otherwise>

                        </c:otherwise>
                    </c:choose>

                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th><span class="glyphicon glyphicon-home"></span> Name</th>
                                <th>Street</th>
                                <th>Zip</th>
                                <th>Parcel No.</th>
                                <th>Size (m2)</th>
                                <th>Condition</th>
                                <th>Building use</th>
                                <th>Year</th>
                                <th>CheckUp</th>
                                <th>Edit</th>
                                <th>Report Damage</th>
                                <th>Images</th>
                            </tr>
                        </thead>
                        <c:forEach var="building" items="${buildings}" >
                            <tr>
                                <td><c:out value="${building.getBuildingID()}"/></td>
                                <td><c:out value="${building.getName()}"/></td>
                                <td><c:out value="${building.getStreet()}"/></td>
                                <td><c:out value="${building.getZip()}"/></td>
                                <td><c:out value="${building.getParcel_no()}"/></td> 
                                <td><c:out value="${building.getSize()}"/></td>
                                <td><c:out value="${building.getCondition()}"/></td>
                                <td>n/a</td>
                                <td>n/a</td>
                                <td><a class="btn btn-default btn-xs" href="UserServlet?command=requestCheckup&building_id=${building.getBuildingID()}">Request CheckUp</a></td>
                                <td><a class="btn btn-default btn-xs" href="UserServlet?command=editBuilding&building_id=${building.getBuildingID()}">Edit</a></td>
                                <td><a class="btn btn-default btn-xs" href="ServiceRequest.jsp?buildingID=${building.getBuildingID()}">Damage Report</a></td>
                                <!-- Button trigger modal -->
                                <td><button  class="btn btn-default btn-xs imageview" data-toggle="modal" data-target="#myModal" value="${building.getBuildingID()}">
                                        View
                                    </button></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>

            ${message}
            ${SaveSuccessMessage}

        </div>
        <div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="reload" type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Building Images</h4>
                    </div>

                    <div class="modal-body">
                        <center>
                            <div id="imgas"></div>
                        </center>
                    </div>
                </div>
            </div>
        </div>
        <script>

            $(".imageview").click(function () {
                var id = $(this).attr("value");
                $("#imgas").load("SlideShow.jsp?id=" + id);
            });



        </script>
        <script>
            $("#reload").click(function () {
                location.reload();
            });
        </script>
    </body>

</html>
