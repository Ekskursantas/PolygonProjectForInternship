

<%@page import="Domain.CheckupReport"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    CheckupReport report = (CheckupReport) request.getAttribute("report");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>Report</title>
        <link rel="icon" href="images/polygon_icon.png">
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!--custom css-->
        <link href="css/styles.css" rel="stylesheet">
        <script src="js/bootstrap.min.js"></script>
        <link href="css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
        <script src="js/plugins/canvas-to-blob.min.js" type="text/javascript"></script>
        <script src="js/fileinput.min.js" type="text/javascript"></script>

    </head>
    <body>
        <div class="container report">
            <!--report header-->

            <div class="row">
                <div class="col-sm-4">
                    <img src="images/polygon-logo.PNG" alt=""/>
                    <br>
                    <p>Report number: <%= report.getCreport_id()%></p>
                </div>
                <div class="col-sm-4"><h2>Building review</h2></div>
                <div class="col-sm-4">
                    <img src="images/sundebygninger-logo.PNG" alt=""/>
                </div>
            </div>
            <!--report basic information-->
            <div class="row">
                <div class="col-sm-4">
                    <p>
                        Name of building: <%= report.getBuilding().getName()%>
                        <br>
                        Address: <%= report.getBuilding().getStreet()%>
                        <br>
                        Postnr./City: <%= report.getBuilding().getZip()%>
                        
                    </p>
                </div>    
                <div class="col-sm-4"></div>
                <div class="col-sm-4">
                    <p>
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
            <!-- image of building-->
            <fieldset>
            <legend>Upload Building Images</legend>
            <div class="row">
                <div class="col-sm-12">
                    <form method="post" action="uploadFile" encType="multipart/form-data">
                        
                        <input type="hidden" name="b_id" value="Report <%= report.getBuilding().getName()%>"/>
                        
                        <div class="row">
                            <div class="form-group">
                                <input id="input-700" name="kartik-input-700[]" type="file" multiple class="file-loading">
                                <script>
                                    $("#input-700").fileinput({
                                        showUpload: false,
                                        uploadAsync: true,
                                        maxFileCount: 5,
                                        allowedFileExtensions: ['png', 'img', 'gif', 'jpeg', 'jpg']
                                    });
                                </script>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group" >
                                
                                    <button style="float: right;" type="submit" class="btn btn-info">Upload</button>
                                
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            </fieldset>
            <!--content of report-->
            <form role="form" action="UserServlet" method="post">
                <input type="hidden" name="command" value="updateCheckupReport">
                <div class="row">
                    <div class="col-sm-12">
                        <h4>General information of building</h4>
                        Year built: <%= report.getBuilding().getYear()%><br>
                        Size in m2: <%= report.getBuilding().getSize()%><br>
                        Use of building: <%= report.getBuilding().getBuildingUse()%>

                        <h4>Examination of the building outside</h4>
                        <div class="form-group row">
                            <label for="roof" class="col-sm-2 form-control-label">Roof</label>
                            <div class="col-sm-10">
                                <input type="text" name="roof" class="form-control">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="walls_outside" class="col-sm-2 form-control-label">Outside walls</label>
                            <div class="col-sm-10">
                                <input type="text" name="walls_outside" class="form-control">
                            </div>
                        </div>
                        <h4>Damage and repair</h4>
                        <div class="checkbox">
                            <label for="damaged" class="col-sm-2 form-control-label">Has there been damage in the building? </label>
                            <label><input type="checkbox" name="damaged" value="yes" id="damage_checkbox"> Yes</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox" name="damaged" value="no"> No</label>
                        </div>
                        <div id="delivery" style="display:none;">
                            <div class="form-group row">
                                <label for="damage_when" class="col-sm-2 form-control-label">When?</label>
                                <div class="col-sm-10">
                                    <input type="text" name="damage_when" class="form-control">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="damage_where" class="col-sm-2 form-control-label">Where?</label>
                                <div class="col-sm-10">
                                    <input type="text" name="damage_where" class="form-control">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="damage_what" class="col-sm-2 form-control-label">What happened?</label>
                                <div class="col-sm-10">
                                    <input type="text" name="damage_what" class="form-control">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="damage_repaired" class="col-sm-2 form-control-label">What is repaired?</label>
                                <div class="col-sm-10">
                                    <input type="text" name="damage_repaired" class="form-control">
                                </div>
                            </div>
                        </div>

                        <h4>Reviewing of...</h4>
                        <div class="form-group row">
                            <label for="walls" class="col-sm-2 form-control-label">Walls</label>
                            <div class="col-sm-10">
                                <input type="text" name="walls" class="form-control">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="ceiling" class="col-sm-2 form-control-label">Ceiling</label>
                            <div class="col-sm-10">
                                <input type="text" name="ceiling" class="form-control">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="floor" class="col-sm-2 form-control-label">Floor</label>
                            <div class="col-sm-10">
                                <input type="text" name="floor" class="form-control">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="window_door" class="col-sm-2 form-control-label">Windows/doors</label>
                            <div class="col-sm-10">
                                <input type="text" name="window_door" class="form-control">
                            </div>
                        </div>

                        <h4>Moisture scanning</h4>
                        <div class="checkbox">
                            <label for="moisture_scanning" class="col-sm-2 form-control-label">Has there been moisture scanning? </label>
                            <label><input type="checkbox" name="moisture_scanning" value="yes" id="moisture_checkbox"> Yes</label>
                        </div>
                        <div class="checkbox">
                            <label><input type="checkbox" name="moisture_scanning" value="no"> No</label>
                        </div>
                        <div id="moisture_delivery" style="display:none;">
                            <div class="form-group row">
                                <label for="moisture_measure" class="col-sm-2 form-control-label">Measuring point:</label>
                                <div class="col-sm-10">
                                    <input type="text" name="moisture_measure" class="form-control">
                                </div>
                            </div>
                        </div>

                        <h4>Conclusion</h4>
                        Recommendations<br>
                        <div class="form-group row">
                            <div class="col-sm-10">
                                <textarea name="comments" rows="4" cols="100" class="form-control"></textarea>
                            </div>
                        </div>
                        Building review was conducted by <i><%= report.getEmployee().getFname()%> <%= report.getEmployee().getLname()%></i>, Polygon in cooperation with <i><%= report.getCustomer().getFname()%> <%= report.getCustomer().getLname()%></i> (building resposible)
                        <h4>The building is categorized as</h4>
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
                        <button type="submit" class="btn btn-info center-block">Submit</button>
                        <hr>
                    </div>
                </div>
                <input type="hidden" name="creport_id" value="<%= report.getCreport_id()%>"/>
            </form>
        </div> <!--container end-->
        <script>
            var checkbox = document.getElementById('damage_checkbox');
            var moisture_checkbox = document.getElementById('moisture_checkbox');
            var delivery_div = document.getElementById('delivery');
            var moisture_delivery_div = document.getElementById('moisture_delivery');
            checkbox.onclick = function () {
                console.log(this);
                if (this.checked) {
                    delivery_div.style['display'] = 'block';
                } else {
                    delivery_div.style['display'] = 'none';
                }
            };

            moisture_checkbox.onclick = function () {
                console.log(this);
                if (this.checked) {
                    moisture_delivery_div.style['display'] = 'block';
                } else {
                    moisture_delivery_div.style['display'] = 'none';
                }
            };
        </script>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
