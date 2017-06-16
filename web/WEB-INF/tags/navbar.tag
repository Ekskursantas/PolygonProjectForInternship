<%-- 
    Document   : navbar
    Created on : Apr 6, 2016, 1:00:07 PM
    Author     : Minerva
--%>

<%@tag description="navigation bar" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="message"%>
<%@attribute name="username"%>
<%@attribute name="fullname"%>

<%@attribute name="userPrefs"%>
<%@attribute name="accessLevel"%>

<%-- any content can be specified here e.g.: --%>
<div class="navbar navbar-fixed-top navbar-default">
    <div class="container">

        <div class="navbar-header">
            <a href="index.jsp" class="pull-left"><img class="img-responsive" src="images/polygon_icon.png" height="30"></a>
            <a class="navbar-brand" href="index.jsp">SundeBygninger</a>
            <a class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="glyphicon glyphicon-bar">Menu</span>
            </a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav pull-left">
                <c:choose>
                    <c:when test="${accessLevel == 3}">
                        <%-- Customer access: --%>
                        <p class="navbar-text">Customer Access</p>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-home"></span> Buildings <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="MyBuildings.jsp"><span class="glyphicon glyphicon-th-list"></span>  My buildings</a></li>
                                <li><a href="AddBuilding.jsp"><span class="glyphicon glyphicon-plus"></span> Add new building</a></li>
                                
                            </ul>
                        </li>
                        <li class="nav-divider"></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-wrench"></span> Services<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="ServiceRequest.jsp"><span class="glyphicon glyphicon-plus"></span> Request new Service</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:when test="${accessLevel == 2}">
                        <%-- Employee access: --%>
                        <p class="navbar-text">Employee Access</p>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-home"></span> Buildings <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="Buildings.jsp"><span class="glyphicon glyphicon-th-list"></span>  All buildings</a></li>
                                <li><a href="AddBuilding.jsp"><span class="glyphicon glyphicon-plus"></span> Add new building</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-user"></span> Users<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="UserServlet?command=showCustomers"><span class="glyphicon glyphicon-th-list"></span>  All customers</a></li>
                                <li><a href="AddCustomer.jsp"><span class="glyphicon glyphicon-plus"></span> Add new customer</a></li>
                                <li role="separator" class="divider"></li>
                                
                                <li><a href="ViewEmployees.jsp"><span class="glyphicon glyphicon-th-list"></span>  All employees</a></li>
                                <li><a href="AddEmployee.jsp"><span class="glyphicon glyphicon-plus"></span> Add new employee</a></li>
                            </ul>
                        </li>
                        <li class="nav-divider"></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-fire"></span> Damage Reports<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="ShowServiceRequests.jsp"><span class="glyphicon glyphicon-th-list"></span> Damage Reports</a></li>
                                <li><a href="ServiceRequest.jsp"><span class="glyphicon glyphicon-plus"></span> Report Damage</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-heart"></span> Health CheckUps<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="UserServlet?command=showCheckupReports"><span class="glyphicon glyphicon-sort-by-attributes"></span> CheckUp Reports</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="AssignEmployee.jsp"><span class="glyphicon glyphicon-arrow-right"></span> Assign jobs</a></li>
                                <li><a href="MyJobs.jsp"><span class="glyphicon glyphicon-tasks"></span> My Jobs</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:when test="${accessLevel == 1}">
                        <%-- Admin access: --%>
                        <p class="navbar-text">Admin Access</p>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-home"></span> Buildings <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="Buildings.jsp"><span class="glyphicon glyphicon-th-list"></span>  All buildings</a></li>
                                <li><a href="AddBuilding.jsp"><span class="glyphicon glyphicon-plus"></span> Add new building</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-user"></span> Customers <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="UserServlet?command=showCustomers"><span class="glyphicon glyphicon-th-list"></span>  All customers</a></li>
                                <li><a href="AddCustomer.jsp"><span class="glyphicon glyphicon-plus"></span> Add new customer</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-user"></span> Employees <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="ViewEmployees.jsp"><span class="glyphicon glyphicon-th-list"></span>  All employees</a></li>
                                <li><a href="AddEmployee.jsp"><span class="glyphicon glyphicon-plus"></span> Add new employee</a></li>
                            </ul>
                        </li>
                        <li class="nav-divider"></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-wrench"></span> Services<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="ShowServiceRequests.jsp"><span class="glyphicon glyphicon-th-list"></span> Service Requests</a></li>
                                <li><a href="ServiceRequest.jsp"><span class="glyphicon glyphicon-plus"></span> Request new Service</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="UserServlet?command=showCheckupReports"><span class="glyphicon glyphicon-th-list"></span> CheckUp Reports</a></li>
                                <li><a href="MyJobs.jsp"><span class="glyphicon glyphicon-th-list"></span> My Jobs</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:when test="${userPrefs == null}">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-wrench"></span> Services<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="ShowServiceRequests.jsp"><span class="glyphicon glyphicon-th-list"></span> Service Requests</a></li>
                                <li><a href="ServiceRequest.jsp"><span class="glyphicon glyphicon-plus"></span> Request new Service</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="UserServlet?command=showCheckupReports"><span class="glyphicon glyphicon-th-list"></span> CheckUp Reports</a></li>
                            </ul>
                        </li>
                    </c:when>
                </c:choose>


            </ul>

            <c:choose>
                <c:when test="${username != null}">
                    <ul class="nav navbar-nav pull-right">
                        <li class="divider-vertical"></li>
                        <li class="dropdown"  id="menu1">
                            <a class="dropdown-toggle " data-toggle="dropdown" href="#menu1">
                                <i class="icon-user "></i><span class="glyphicon glyphicon-user"></span> <strong> ${username} </strong>
                                <b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="MyAccount.jsp"><b>My Account</b></a></li>
                                <li><a href="Authenticate?command=logout"><span class="glyphicon glyphicon-log-out"></span> Log out</a></li>
                            </ul>
                        </li>
                    </ul> 
                </c:when>
                <c:otherwise>
                    <ul class="nav navbar-nav pull-right">
                        <li><a href="Login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                    </ul>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</div>
</div>
<br><br><br>

<%-- Navbar bottom
<div class="navbar navbar-default navbar-fixed-bottom">
    <div class="navbar-header"><a class="navbar-brand" href="#">Brand</a></div>
    <ul class="nav navbar-nav">
     <li class="active"><a href="#">Home</a></li>
     <li><a href="#">Link</a></li>
     <li><a href="#">More</a></li>
     <li><a href="#">Options</a></li>
      </ul>
</div>
--%>
