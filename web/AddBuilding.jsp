

<%@page import="Domain.UserPrefs"%>
<%@page import="Domain.CityList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Domain.DomainFacade"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%
    DomainFacade domainModel = DomainFacade.getInstance();
    ArrayList<CityList> cityList = domainModel.getCities();
    request.setAttribute("cityList", cityList);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap Core CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <!-- Custom css -->
        <link href="css/styles.css" rel="stylesheet">

        <title>Add New Building</title>
        <link rel="icon" href="images/polygon_icon.png">
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
                <div class="col-sm-7">
                    <h1>Add a new building:</h1>
                    <form class="form-horizontal" role="form" name="AddBuilding" action="UserServlet" method="POST">
                        <input type="hidden" name="command" value="addBuilding">
                        <div class="form-group">
                            <label for="b_name">Building name:</label>
                            <input type="text" class="form-control" name="b_name">
                        </div>
                        <div class="form-group">
                            <label for="street">Street and No.:</label>
                            <input type="text" class="form-control" name="street" required>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <!--<div class="col-xs-6">
                                    <label for="zip">Zip:</label>
                                    <input type="text" class="form-control" name="zip" required>
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
                                    <input type="text" class="form-control" name="size" required>
                                </div>
                                <div class="col-xs-6">
                                    <label for="year">Year built: </label>
                                    <input type="text" class="form-control" name="year" required>
                                </div>
                                <div class="col-xs-6">
                                    <label for="usage">Use of building: </label>
                                    <input type="text" class="form-control" name="usage" required>
                                </div>
                            </div>    
                            
                        </div>
                        <button type="submit" class="btn btn-success">Add Building</button>
                    </form>

                </div>
                <div class="col-sm-3">
                    <img class="pull-left" src="images/building.gif" width="400" height="300" alt="building"/>
                </div>
            </div>
        </div>
        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
