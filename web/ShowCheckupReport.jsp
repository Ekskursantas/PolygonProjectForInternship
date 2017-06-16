

<%@page import="Domain.UserPrefs"%>
<%@page import="Domain.CheckupReport"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%
    CheckupReport report = (CheckupReport) request.getAttribute("report");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Healthy Buildings</title>
        <link rel="icon" href="images/polygon_icon.png">
        <!-- Bootstrap Core CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
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
        <div class="container report">
            <!--report header-->

            <div class="row">
                <div class="col-sm-4">
                    <img src="images/polygon-logo.PNG" alt=""/>
                    <br><br>
                    <p>Report number: <%= report.getCreport_id()%></p>
                </div>
                <div class="col-sm-4"></div>
                <div class="col-sm-4">
                    <img src="images/sundebygninger-logo.PNG" alt=""/>
                </div>
            </div>
            <!--report basic information-->
            <div class="row">
                <div class="col-sm-4">
                    <p>
                        <br><br><br><br>
                        Name of building: <%= report.getBuilding().getName()%>
                        <br>
                        Address: <%= report.getBuilding().getStreet()%>
                        <br>
                        Postnr./City: <%= report.getBuilding().getZip()%> <%= report.getBuilding().getCity()%>
                    </p>
                </div>    
                <div class="col-sm-4 text-center"><h2>Building review</h2></div>
                <div class="col-sm-4">
                    <p class="pull-right">
                        Date: <%= report.getCheckDate()%>
                    </p>
                    <p class="contact-info">
                        <br><br>
                        Polygon<br>
                        Rypevang 5<br>
                        3450 Allerød<br><br>
                        Tlf. 4814 0555<br>
                        sundebygninger@polygon.dk
                    </p>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-sm-12">
                    <h4>General information of building</h4>
                    Year built: <%= report.getBuilding().getYear()%><br>
                    Size in m2: <%= report.getBuilding().getSize()%><br>
                    Use of building: <%= report.getBuilding().getBuildingUse()%>
                </div>
            </div>
            <!--content of report-->
            <div class="row">
                <div class="col-sm-12">
                    <h4>Examination of the building outside</h4>
                    <b>Roof: </b><%= report.getRoof()%> <br>
                    <b>Outside walls: </b><%= report.getWalls_outside()%>
                    <h4>Damage and repair</h4>

                    <b>Has there been damage in the building?</b> <%= report.getDamaged()%><br>
                    <c:set var="damage" value="<%= report.getDamaged()%>"/>
                    <c:choose> 
                        <c:when test="${damage == 'yes'}">
                            When? <%= report.getDamage_when()%><br>
                            Where? <%= report.getDamage_where()%><br>
                            What? <%= report.getDamage_what()%><br>
                            What has been repaired? <%= report.getDamage_repaired()%>
                        </c:when>
                        <c:otherwise>

                        </c:otherwise>
                    </c:choose>


                    <h4>Reviewing of...</h4>
                    <b>Walls: </b> <%= report.getWalls()%> <br>
                    <b>Ceiling: </b> <%= report.getCeiling()%> <br>
                    <b>Floor: </b><%= report.getFloor()%> <br>
                    <b>Windows/doors: </b><%= report.getWindows_doors()%>
                    <h4>Moisture scanning</h4>
                    <b>Has there been moisture scanning done?</b> <%= report.getMoisture_scanning()%> <br>
                    <c:set var="scanning" value="<%= report.getMoisture_scanning()%>"/>
                    <c:choose> 
                        <c:when test="${scanning == 'yes'}">
                            Measuring point: <%= report.getMoisture_measure()%>
                        </c:when>
                        <c:otherwise>

                        </c:otherwise>
                    </c:choose>

                </div>

                <h4>Conclusion</h4>
                <b>Recommendations</b><br>
                <%= report.getComments()%> <br>
                Building review was conducted by <i><%= report.getEmployee().getFname()%> <%= report.getEmployee().getLname()%></i>, Polygon in cooperation with <i><%= report.getCustomer().getFname()%> <%= report.getCustomer().getLname()%></i> (building resposible)
                <h4>The building is categorized as</h4>
                <c:set var="val" value="${report.getCondition_level()}"/>
                <table class="table table-responsive">
                    <thead>
                        <tr>
                            <th>
                                Condition grade
                            </th>
                            <th>
                                Description
                            </th>
                            <th>
                                Function of building
                            </th>
                            <th>
                                State level
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose> 
                            <c:when test="${val == '0'}">
                                <tr>
                                    <td>
                                        Condition grade 0
                                    </td>
                                    <td>
                                        The building is new and just built
                                    </td>
                                    <td>
                                        The function is as described
                                    </td>
                                    <td>
                                        <input type="radio" name="condition_level" value="0">
                                    </td>
                                </tr>
                            </c:when>
                            <c:when test="${val == '1'}">
                                <tr>
                                    <td>
                                        Condition grade 1
                                    </td>
                                    <td>
                                        The building part is intact, but with the start of wear and <br>visible damage (only cosmetic damage)
                                    </td>
                                    <td>
                                        The function is as described
                                    </td>
                                    <td>
                                        <input type="radio" name="condition_level" value="1">
                                    </td>
                                </tr>
                            </c:when>
                            <c:when test="${val == '2'}">
                                <tr>
                                    <td>
                                        Condition grade 2
                                    </td>
                                    <td>
                                        The building part is beginning to decay, with individual <br>defective components
                                    </td>
                                    <td>
                                        Function is impaired - <br>risk of consequential damages
                                    </td>
                                    <td>
                                        <input type="radio" name="condition_level" value="2">
                                    </td>
                                </tr>
                            </c:when>
                            <c:when test="${val == '3'}">
                                <tr>
                                    <td>
                                        Condition grade 3
                                    </td>
                                    <td>
                                        The building element is broken and must be replaced
                                    </td>
                                    <td>
                                        The function is terminated - <br>risk of consequential damages
                                    </td>
                                    <td>

                                        <input type="radio" name="condition_level" value="3">
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                No condition level
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>


                <p>Denne rapport og bygningsgennemgang er lavet for at klarlægge umiddelbare visuelle problemstillinger. Vores formål er at sikre, at bygningens anvendelse kan opretholdes. 
                    Vi udbedrer ikke skader som en del af bygningsgennemgangen/rapporten. Gennemgangen af bygningen indeholder ikke fugtmålinger af hele bygningen, men vi kan foretage fugtscanninger enkelte steder i bygningen, hvis vi 
                    finder  det  nødvendigt. Hvis vi finder kritiske områder i  bygningen vil vi fremlægge anbefalinger angående yderligere tiltag  så som 
                    yderligere undersøgelser, reparationer eller bygningsopdateringer.  
                    <br><br>
                    Bemærk at vi skal have adgang til hele bygningen for at kunne udføre en fuld gennemgang (dette inkluderer adgang til tag, tag rum, kælder, krybekælder eller andre aflukkede områder). Denne bygningsgennemgang er ikke-destruktiv. Hvis der skal laves destruktive indgreb,  skal  dette  først   godkendes  af  de  bygningsansvarlige.  Destruktive  indgreb  er  ikke   en  del  af  denne  rapport  eller bygningsgennemgang.
                    <br><br>
                    Den bygningsansvarlige skal udlevere plantegning over bygningen inden bygningsgennemgangen kan foretages. 
                </p>

                <button onclick="myFunction()" class="btn btn-info btn-lg center-block">Print <span class="glyphicon glyphicon-print"></span></button>

                <script>
                    function myFunction() {
                        window.print();
                    }
                </script>
                <hr>
            </div>
        </div>
    </div>
</body>
</html>
