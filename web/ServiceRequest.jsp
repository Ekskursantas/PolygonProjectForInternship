

<%@page import="Domain.Building"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="Domain.UserPrefs"%>
<%@page import="Domain.ServiceList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Domain.DomainFacade"%>
<%@page import="DataSource.DBFacade"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
        <title>Service Request</title>
        <link rel="icon" href="images/polygon_icon.png">
        <%-- Java scrips for bootstrap here --%>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
        <%
            DomainFacade domainModel = DomainFacade.getInstance();
            ArrayList<ServiceList> serviceList = domainModel.getAllServices();
            UserPrefs userPrefs = (UserPrefs) session.getAttribute("UserPrefs");
            request.setAttribute("serviceList", serviceList);

            int buildingID = 0;
            //Check if we received a buildingID parameter (then the request comes from a specific building)
            //or we have to show a dropdown list to choose one of their building
            if (request.getParameter("buildingID") != null) {
                buildingID = Integer.parseInt(request.getParameter("buildingID"));
            }
            
            if (userPrefs != null) {
                request.setAttribute("username", userPrefs.getUsername());
                request.setAttribute("accessLevel", userPrefs.getAccessLevel());
                request.setAttribute("customerID", userPrefs.getUserID());
                request.setAttribute("buildingID", buildingID);
            }

            List<Building> buildingList = domainModel.getMyBuildings(userPrefs.getUserID());
            if (buildingList != null) {
                request.setAttribute("buildingList", buildingList);
            }
        %>
        <c:if test="${username == null}">
            <jsp:forward page="Login.jsp?login=true" />
        </c:if>
        <mytags:navbar/>
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <form class="form-horizontal" role="form" action="UserServlet" method="post">
                        <fieldset>

                            <!-- Form Name -->
                            <legend>Report a damage</legend>
                            <input type="hidden" name="command" value="serviceRequest">
                            <input type="hidden" name="customerID" value="${customerID}">
                            <c:if test="${buildingID != 0}">
                                <input type="hidden" name="buildingID" value="${buildingID}">
                            </c:if>

                            <!-- Selecting the building yourself -->
                            <c:if test="${buildingID == 0}">
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="selectBuilding">Select a building</label>
                                        <div class="col-md-4">
                                            <select id="selectBuilding" name="selectBuilding" class="form-control">
                                                <c:forEach var="building" items="${buildingList}">
                                                    <option value="${building.getBuildingID()}">${building.getName()}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                </div>
                            </c:if>

                            <!-- Select Basic -->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="selectbasic">Choose a service</label>
                                <div class="col-md-4">
                                    <select id="selectbasic" name="selectService" class="form-control">
                                        <c:forEach var="service" items="${serviceList}">
                                            <option value="${service.getService_id()}">${service.getService_name()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>


                            <!-- Textarea -->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="description">Description</label>
                                <div class="col-md-6">                     
                                    <textarea class="form-control" id="description" name="description">Describe your specific needs for the service request</textarea> 
                                </div>
                            </div>
                            <!-- Button -->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="submit"></label>
                                <div class="col-md-4">
                                    <button type="submit" id="submit" name="submit" class="btn btn-primary">Submit</button>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>
                <div class="col-sm-4">
                    ${message}
                </div>
            </div>
        </div>
    </body>
</html>
