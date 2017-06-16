<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <script src="js/galleria-1.4.2.min.js"></script>

        <style>
            .galleria{ width: 700px; height: 400px; background: #000 }
        </style>
        <%
            String id = request.getParameter("id");
        %>


    </head>
    <body>
        <div id="imageslide"></div>
        <script>
            $(document).ready(function () {
                $.get("ImagePreview?b_id=<%=id%>", function (responseJson) {
                     
                    $( "#imageslide" ).empty();
                    var $select = $("<div/>").addClass("galleria").appendTo($("#imageslide"));
                    $.each(responseJson, function (index, item) {  
                        $("<img />").attr("src", item).appendTo($select);
                    });
                });
            });

        </script>
        <script>
            Galleria.loadTheme('js/themes/classic/galleria.classic.min.js');
            Galleria.run('.galleria');
        </script>
    </body>
</html>