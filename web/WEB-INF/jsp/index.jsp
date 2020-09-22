<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("login.htm");
    }
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Tablero principal</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.min.css" />
        <link rel="stylesheet" href="css/index.css" />
    </head>
    
    <body class="theme-dark">
        <!-- Header -->
        <jsp:include page="/WEB-INF/jsp/Layouts/Header.jsp"></jsp:include>
  
        <main>
            <!-- Menú lateral -->
          <jsp:include page="/WEB-INF/jsp/Layouts/lateralMenuIndex.jsp"></jsp:include>
            <!-- main slide nav -->
            <jsp:include page="/WEB-INF/jsp/Layouts/Menu.jsp"></jsp:include>
            <!-- map-container -->
            <div class="map-container" id="map" style="z-index: 1">
            </div>
        </main>
        <!-- Footer -->
        <jsp:include page="/WEB-INF/jsp/Layouts/Footer.jsp"></jsp:include>

        <!-- circular-menu -->
        <div id="circularMenu" class="circular-menu">
            <a class="floating-btn noselect"
               onclick="document.getElementById('circularMenu').classList.toggle('active');">
                <img src="images/ico-kiotrack-isotipo-2.png" alt="">
            </a>

            <menu class="items-wrapper">
                <a href="#" class="menu-item"><i class="fas fa-bus"></i></a>
                <a href="#" class="menu-item"><i class="fas fa-taxi"></i></a>
                <a href="#" class="menu-item"><i class="fas fa-traffic-light"></i></a>
                <a href="arcos/" class="menu-item"><img src="images/ico-arcos-white.png" alt=""></a>
                <a href="arcos/" class="menu-item"><i class="fas fa-archway"></i></a>
            </menu>
        </div>
        <!-- end circular-menu -->

        <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
        <script src="<c:url value="/javascript/vendors/popper.min.js" />"></script>
        <script src="<c:url value="/javascript/vendors/bootstrap.min.js" />"></script>
        <script src="<c:url value="/javascript/slide_menu.js" />"></script>
        <script src="<c:url value="/javascript/main.js"/>"></script>

       

        <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdTfw1waJScSYaMdXKGqAW6rnHcwmjZwc&callback=initMap"></script>
        <script src='javascript/Scripts/index.js'></script>
        
        <script type="text/javascript">
            var advertenciaIcon = 'images/advertencia.png';
            var criticoIcon = 'images/critico.png';
            var informativoIcon = 'images/informativo.png';
            var markers = {};
            var map;
            function initMap() {
                map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 19.243772, lng: -103.714532},
                    zoom: 13,
                    disableDefaultUI: true,
                    styles: [
                        {elementType: 'geometry', stylers: [{color: '#03060c'}]},
                        {elementType: 'labels.text.stroke', stylers: [{color: '#0A1E28'}]},
                        {elementType: 'labels.text.fill', stylers: [{color: '#746855'}]},
                        {
                            featureType: 'administrative.locality',
                            elementType: 'labels.text.fill',
                            stylers: [{color: '#83888d'}]
                        },
                        {
                            featureType: 'poi',
                            elementType: 'labels.text.fill',
                            stylers: [{color: '#83888d'}]
                        },
                        {
                            featureType: 'poi.park',
                            elementType: 'geometry',
                            stylers: [{color: '#263c3f'}]
                        },
                        {
                            featureType: 'poi.park',
                            elementType: 'labels.text.fill',
                            stylers: [{color: '#6b9a76'}]
                        },
                        {
                            featureType: 'road',
                            elementType: 'geometry',
                            stylers: [{color: '#0e1c23'}]
                        },
                        {
                            featureType: 'road',
                            elementType: 'geometry.stroke',
                            stylers: [{color: '#212a37'}]
                        },
                        {
                            featureType: 'road',
                            elementType: 'labels.text.fill',
                            stylers: [{color: '#9ca5b3'}]
                        },
                        {
                            featureType: 'road.highway',
                            elementType: 'geometry',
                            stylers: [{color: '#009186'}]
                        },
                        {
                            featureType: 'road.highway',
                            elementType: 'geometry.stroke',
                            stylers: [{color: '#1f2835'}]
                        },
                        {
                            featureType: 'road.highway',
                            elementType: 'labels.text.fill',
                            stylers: [{color: '#f3d19c'}]
                        },
                        {
                            featureType: 'transit',
                            elementType: 'geometry',
                            stylers: [{color: '#830203'}]
                        },
                        {
                            featureType: 'transit.station',
                            elementType: 'labels.text.fill',
                            stylers: [{color: '#d59563'}]
                        },
                        {
                            featureType: 'water',
                            elementType: 'geometry',
                            stylers: [{color: '#17263c'}]
                        },
                        {
                            featureType: 'water',
                            elementType: 'labels.text.fill',
                            stylers: [{color: '#515c6d'}]
                        },
                        {
                            featureType: 'water',
                            elementType: 'labels.text.stroke',
                            stylers: [{color: '#17263c'}]
                        }
                    ]
                });
            <c:forEach var="arco" items="${arcos}">
                addMarker(${arco.getId()}, "${arco.getNombre()}", "${arco.getDescripcion()}", ${arco.getLatitud()}, ${arco.getLongitud()}, ${arco.getTipo_alerta()});
            </c:forEach>

        }

        </script>
        
    </body>

</html>
