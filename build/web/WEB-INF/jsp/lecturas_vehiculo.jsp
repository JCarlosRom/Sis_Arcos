<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>Lecturas Vehículo</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.min.css" />
        <link rel="stylesheet" href="css/lecturaVehiculo.css" />
    </head>

    <body class="theme-dark">
      <jsp:include page="/WEB-INF/jsp/Layouts/Header.jsp"></jsp:include>

        <main>
            <!-- Menu lateral de Consulta de lecturas por Vehículos -->
            <jsp:include page="/WEB-INF/jsp/Layouts/lateralMenuVeh.jsp"></jsp:include>
  
            <!-- map-container -->
            <div class="map-container" id="map" style="z-index: 1">
            </div>

        </main>

        <!--<script async defer
                src="https://snazzymaps.com/embed/29351"></script>-->
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
                <a href="arcos/" class="menu-item"><i class="fas fa-archway"></i></a>
            </menu>
        </div>
        <!-- end circular-menu -->



        <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
        crossorigin="anonymous"></script>
        <script src="javascript/vendors/popper.min.js"></script>
        <script src="javascript/vendors/bootstrap.min.js"></script>
        <script src="javascript/slide_menu.js"></script>
        <script src="javascript/main.js"></script>


        <script type="text/javascript" src="javascript/Scripts/lectura_vehiculo.js"></script>

        <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdTfw1waJScSYaMdXKGqAW6rnHcwmjZwc&callback=initMap">
        </script>

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
                addMarker(${arco.getId()}, "${arco.getNombre()}", ${arco.getLatitud()}, ${arco.getLongitud()}, ${arco.getTipo_alerta()});
            </c:forEach>

            }

            function addMarker(id, nombre, lat, lng, alerta) {
                let marcador = new google.maps.Marker({position: {lat: lat, lng: lng}, map: map, icon: iconMarker(alerta)});

                let infowindow = new google.maps.InfoWindow({
                    content: "<b>" + nombre + "</b>"
                });

                marcador.addListener('click', function () {
                    infowindow.open(map, marcador);
                    marcador.setAnimation(google.maps.Animation.BOUNCE);
                    setTimeout(() => marcador.setAnimation(null), 2000);
                });

                infowindow.open(map, marcador);

                markers["" + id + ""] = marcador;
            }

            function iconMarker(alerta) {
                let icon;
                if (alerta == 3) {
                    icon = criticoIcon;
                } else if (alerta == 2) {
                    icon = advertenciaIcon;
                } else {
                    icon = informativoIcon;
                }
                return icon;
            }

            function goToArco(id, alerta) {
                let arco = markers["" + id + ""];
                console.log('Id arco =>', id);
                arco.setIcon(iconMarker(alerta));
                map.setCenter(arco.getPosition());
                map.setZoom(15);
                arco.setAnimation(google.maps.Animation.BOUNCE);
                setTimeout(() => arco.setAnimation(null), 3000);
                $('#main-slide-menu').toggleClass('show');
            }

            function changedButton(id, alerta) {
                let arco = markers["" + id + ""];
                arco.setIcon(iconMarker(alerta));
            }
        </script>
    </body>

</html>