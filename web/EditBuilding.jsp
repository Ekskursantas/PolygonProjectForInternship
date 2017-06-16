

<%@page import="Domain.UserPrefs"%>
<%@page import="Domain.CityList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Domain.DomainFacade"%>
<%@page import="Domain.Building"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    DomainFacade domainModel = DomainFacade.getInstance();
    ArrayList<CityList> cityList = domainModel.getCities();
    request.setAttribute("cityList", cityList);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
        <title>Edit building</title>
        <link rel="icon" href="images/polygon_icon.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/bootstrap.min.js"></script>
        <link href="css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
        <script src="js/plugins/canvas-to-blob.min.js" type="text/javascript"></script>
        <script src="js/fileinput.min.js" type="text/javascript"></script>

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
        <%
            Building building = (Building) request.getAttribute("building");
            if (building == null) {
                out.println("Building object is NULL.");
            }
        %>

        <div class="container">

            <div class="col-sm-6">

                <h1>Editing building</h1>
                <p>Building ID: ${building.getBuildingID()}</p>
                <form class="form-horizontal" role="form" name="EditBuilding" action="UserServlet" method="POST">
                    <input type="hidden" name="command" value="saveBuildingEdits">
                    <input type="hidden" name="building_id" value="${building.getBuildingID()}">
                    <div class="form-group">
                        <label for="b_name">Building name:</label>
                        <input type="text" class="form-control" name="b_name" value="${building.getName()}">
                    </div>
                    <div class="form-group">
                        <label for="street">Street and No.:</label>
                        <input type="text" class="form-control" name="street" required value="${building.getStreet()}">
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <!--<div class="col-xs-6">
                                <label for="zip">Zip:</label>
                                <input type="text" class="form-control" name="zip" required value="${building.getZip()}">
                            </div>-->
                            <div class="col-xs-6">
                                <label for="zip">City</label>
                                <select name="zip" class="form-control">
                                    <c:forEach var="city" items="${cityList}">
                                        <option value="<c:out value="${city.getZip()}"/>"><c:out value="${city.getZip()}"/> <c:out value="${city.getCity()}"/></option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-xs-6">
                                <label for="size">Size: (m2)</label>
                                <input type="text" class="form-control" name="size" value="${building.getSize()}">
                            </div>
                        </div>    
                        <div class="form-group">
                            <div class="col-xs-6">
                                <label for="condition_level">Condition level:</label>
                                <input type="text" class="form-control" name="condition_level" required value="${building.getCondition()}">
                            </div>
                            <div class="col-xs-6">
                                <label for="parcel_no">Parcel number:</label>
                                <input type="text" class="form-control" name="parcel_no" required value="${building.getParcel_no()}">
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-default">Save changes</button>
                </form>


                <fieldset>
                    <!-- Form Name -->
                    <legend>Upload Building Images</legend>
                    <form method="post" action="uploadFile" encType="multipart/form-data">

                        <input type="hidden" name="b_id" value="${building.getBuildingID()}"/>

                        <div class="row">
                            <div class="form-group">
                                <input id="input-700" name="kartik-input-700[]" type="file" multiple class="file-loading">
                                <script>
                                    $("#input-700").fileinput({
                                        uploadUrl: "c:/temp",
                                        showUpload: false,
                                        uploadAsync: true,
                                        maxFileCount: 5,
                                        allowedFileExtensions: ['png', 'img', 'gif', 'jpeg', 'jpg']
                                    });
                                </script>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <div class="col-xs-6">
                                    <button type="submit" class="btn btn-info">Upload</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </fieldset>
            </div>
            <div class="col-sm-3">
                <img class="pull-left" src="images/building.gif" width="400" height="300" alt="building"/>
            </div>
        </div>

        ${SaveSuccessMessage}

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script> 
        <script src="js/jquery.duplicate.js"></script>

    </body>
</html>

