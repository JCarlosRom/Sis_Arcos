<%@page import="java.util.Iterator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Model.lectura_vehiculo"%>
<%@page import="java.util.List"%>
<%@page import="ModelDAO.lectura_vehiculoDAO"%>
<%@page import="Config.Conexion"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
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
        <title>Arcos</title>
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.6.0/dist/leaflet.css"/>
        <script src="https://unpkg.com/leaflet@1.6.0/dist/leaflet.js"></script>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.min.css" />

    </head>

    <body class="theme-dark">
        <!-- top bar -->
        <nav class="main-navbar navbar navbar-expand-lg">
            <a class="navbar-brand" href="/Sis_Arcos/index.htm">
                <img class="img-fluid" src="images/logo-kiotrack-blanco.png" alt="kiotrack-logo">
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNavContent"
                    aria-controls="mainNavContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="main-navbar_content collapse navbar-collapse" id="mainNavContent">
                <ul class="navbar-nav">
                    <li class="nav-item center">
                        Arcos
                    </li>
                </ul>
                <ul class="main-navbar_options navbar-nav">
                    <li class="nav-item center">
                        <button class="btn btn-mute-action" onclick="this.classList.toggle('muted')">
                            <div class="mn-option-icon"></div>
                            <span class="mn-option-text-sm">silenciar <br> asistente</span>
                        </button>
                    </li>
                    <li class="nav-item d-flex center">
                        <div>
                            <span class="d-block"> <%= session.getAttribute("usuario")%> </span>
                            <a class="mn-logout-link" href="<c:url value="logout.htm" />">Cerrar sesión</a>
                        </div>
                        <div class="mn-option-profile-img">
                            <img width="50px" height="50px" style="border-radius: 20px;" src="images/persona.png" alt="user">
                            <!--<i class="fas fa-user-circle"></i>-->
                        </div>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- end topbar -->
        <nav class="content-navbar">
            <div class="container-fluid">
                <div class="row no-gutters">
                    <div class="col-md-2">
                        <div class="cn-wrapper no-border">
                            <a class="cn-bars d-flex flex-no-wrap align-items-center" href="" data-toggle="slide-menu"
                               data-target="#main-slide-nav">
                                <i class="fas fa-bars"></i>
                                <div class="cn-title">
                                    <h5>MENU</h5>
                                </div>
                            </a>
                        </div>
                    </div>

                    <!-- AQUI SE PONE EL PORCENTAJE DE CRITICO, ALERTA, INFORMATIVO -->

                    <div class="col-md-5">
                        <div class="cn-wrapper">

                            <%
                                try {
                                    ResultSet r = Conexion.query("select * from sp_advertencias_promedio()");
                                    while (r.next()) {
                                        if (r.getString(1).equals("Critico")) {%>

                            <div class="display-chart">
                                <div class="dc-info">
                                    <i class="dc-icon dc-danger"></i>
                                    <div class="dc-info-content">
                                        <span class="dc-info-top"><%= r.getString(2)%>%</span>
                                        <span class="dc-info-msg"><%= r.getString(1)%></span>
                                    </div>
                                </div>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: <%= r.getString(2)%>%"></div>
                                </div>
                            </div>

                            <%
                            } else if (r.getString(1).equals("Advertencia")) {%>


                            <div class="display-chart">
                                <div class="dc-info">
                                    <i class="dc-icon dc-warning"></i>
                                    <div class="dc-info-content">
                                        <span class="dc-info-top"><%= r.getString(2)%>%</span>
                                        <span class="dc-info-msg"><%= r.getString(1)%></span>
                                    </div>
                                </div>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: <%= r.getString(2)%>%"></div>
                                </div>
                            </div>

                            <%
                            } else if (r.getString(1).equals("Informativo")) {%>

                            <div class="display-chart">
                                <div class="dc-info">
                                    <i class="dc-icon dc-info"></i>
                                    <div class="dc-info-content">
                                        <span class="dc-info-top"><%= r.getString(2)%>%</span>
                                        <span class="dc-info-msg"><%= r.getString(1)%></span>
                                    </div>
                                </div>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: <%= r.getString(2)%>%"></div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <%
                                }
                            }
                            r.close();
                        } catch (Exception e) {
                        }
                    %>        


                    <div class="col-md-5">
                        <div class="cn-wrapper">
                            <%
                                try {
                                    ResultSet r = Conexion.query("select * from sp_acceso_datos_db()");
                                    while (r.next()) {
                                        if (r.getString(2).equals("1")) {%>
                            <div class="display-status">
                                <i class="ds-icon ds-success"></i>
                                <span class="ds-msg"> <%= r.getString(1)%></span>
                            </div>
                            <%
                            } else if (r.getString(2).equals("0")) {%>
                            <div class="display-status"> 
                                <i class="ds-icon ds-danger"></i>
                                <span class="ds-msg"><%= r.getString(1)%></span>
                            </div>
                            <%
                                        }
                                    }
                                    r.close();
                                } catch (Exception e) {
                                }
                            %>
                        </div>
                    </div>


                </div>
            </div>
        </nav>

        <main>
            <div class="slide-menu main-slide-menu" id="main-slide-menu">
                <a class="btn-slide-menu d-flex flex-no-wrap align-items-center" href="" data-toggle="slide-menu"
                   data-target="#main-slide-menu">
                    <i class="icon"></i>
                </a>
                <h6 class="p-4">Alerta de arcos y fuentes de información</h6>
                <div class="card main-slide-menu-card">
                    <div class="card-header">
                        <div class="container-fluid">
                            <div class="row no-gutters">
                                <div class="col-md-6">
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" id="tab-1" data-toggle="tab" href="#tab_1" role="tab"
                                               aria-controls="tab-1" aria-selected="true">Arcos</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="tab-2" data-toggle="tab" href="#tab_2" role="tab"
                                               aria-controls="tab-2" aria-selected="false">Autos</a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-md-6 center-v card-actions">
                                    <button title=""><i class="fas fa-file-pdf"></i></button>
                                    <button title=""><i class="fas fa-file-excel"></i></button>
                                    <button title=""><i class="fas fa-external-link-square-alt"></i></button>
                                    <!-- APLICAR AQUI PARA LOS FILTROS -->
                                    <form id="Aceptar" class="col-md-3" action="#">
                                        <button type="submit" class="action-filter"><i class="fas fa-filter"></i></button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-header table-filters">
                        <div class="container-fluid">
                            <div class="row no-gutters">
                                <div class="col-md-3">
                                    <label class="noselect" for="Aceptar">
                                        <i class="fas fa-times-circle text-danger"></i>
                                        <input id="filter-danger" type="checkbox">
                                        Crítico
                                    </label>
                                </div>
                                <div class="col-md-3">
                                    <label class="noselect" for="Aceptar">
                                        <i class="fas fa-info-circle text-info"></i>
                                        <input id="filter-info" type="checkbox">
                                        Informativo
                                    </label>
                                </div>
                                <div class="col-md-3">
                                    <label class="noselect" for="Aceptar">
                                        <i class="fas fa-exclamation-triangle text-warning"></i>
                                        <input id="filter-warning" type="checkbox">
                                        Advertencia
                                    </label>   
                                </div>
                                <div class="col-md-3">
                                    <label class="noselect" for="Aceptar">
                                        últimos días
                                        <input id="filter-days" type="number" name="ultimosDias" style="margin-left: 5px; max-width: 100px;" placeholder="0">
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="tab-content">
                            <div class="tab-pane fade show active" id="tab_1" role="tabpanel" aria-labelledby="tab-1">
                                <div class="table-arcos-head">
                                    <p>
                                        <%
                                            try {
                                                ResultSet r = Conexion.query("select * from sp_arcos_operando()");
                                                while (r.next()) {
                                        %>
                                        <span class="text-info font-weight-bold"><%= r.getString(1)%></span> de <span
                                            class="text-info font-weight-bold"><%= r.getString(2)%></span> Arcos Operando

                                        <%
                                                }
                                                r.close();
                                            } catch (Exception e) {
                                            }
                                        %>
                                    </p>
                                </div>



                                <table class="table-arcos">
                                    <tbody id="tbAlertasArcos">
                                        
                                    </tbody>
                                </table>
                            </div>
                            <div class="tab-pane fade" id="tab_2" role="tabpanel" aria-labelledby="tab-2" >
                                <table class="table-autos">
                                    <tbody id="tbAlertasAutos">
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer center">
                        <button class="btn btn-outline-primary text-uppercase">ver todo el historial</button>
                    </div>
                </div>
            </div>

            <!-- main slide nav -->
            <div class="slide-menu main-slide-nav" id="main-slide-nav">
                <nav class="nav flex-column">
                    <a class="nav-link active" href="index.htm"><i class="fas fa-home"></i> TABLERO</a>
                    <a class="nav-link" href="<c:url value="lecturas_vehiculo.htm" />" ><i class="fas fa-car"></i> LECTURAS POR VEHÍCULO</a>
                    <a class="nav-link" href= "<c:url value="lecturas_arco.htm" />"><i class="fas fa-archway"></i> LECTURAS POR ARCO</a>
                </nav>
            </div>
                
            <!-- map-container -->
            <div class="map-container" id="map" style="z-index: 1">
            </div>
        </main>

        <footer>
            <div class=" container">
                <div class="row">
                    <div class="col-md-2 center">
                        <img class="img-fluid" src="images/logo-kiotrack-color.png" alt="">
                    </div>
                    <div class="col-md-10">
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent imperdiet quis quam ut
                            aliquet. Maecenas sit amet mi suscipit, molestie sapien vel, tristique dui. Morbi varius,
                            odio
                            in suscipit ultricies, turpis diam sollicitudin nisl, non maximus risus elit ullamcorper
                            dolor.
                        </p>
                    </div>
                </div>
            </div>
        </footer>

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
        
        <script defer>    
            var map = L.map('map').setView([19.243772, -103.714532], 13);
            L.tileLayer('https://api.maptiler.com/maps/basic/256/{z}/{x}/{y}.png?key=5gUlBqllT3j0VghZnqHf', {
                attribution: '<a href="https://www.maptiler.com/copyright/" target="_blank">&copy; MapTiler</a> <a href="https://www.openstreetmap.org/copyright" target="_blank">&copy; OpenStreetMap contributors</a>'
            }).addTo(map);
            
            <c:forEach var="arco" items="${arcos}">
                //addMarker('id', 'nombre', 'descripcion', lat, lng);
                L.marker([${arco.getLatitud()}, ${arco.getLongitud()}]).bindTooltip("<b>${arco.getNombre()}</b><br>${arco.getDescripcion()}.", {permanent: true, direction: 'top'}).addTo(map);
                
                //L.marker(latlng).bindTooltip("Test Label", {permanent: true});
            </c:forEach>
                
            function goToCoords(coords) {
                let arr = coords.split(", ");
                let lat = +arr[0];
                let lon = +arr[1];
                map.flyTo([lat, lon], 17);
                $('#main-slide-menu').toggleClass('show');
            }
            
            // var markers = {};

            /*
            function addMarker(id, nombre, descripcion, latitud, longitud) {
                
                markers[id] = {
                    nombre: nombre,
                    descripcion: descripcion,
                    ubicacion: {
                        latitud: latitud,
                        longitud: longitud
                    },
                    marker: L.marker([latitud, latitud]).addTo(map)
                };
                
            }
            
            function goToArc(id_arco) {
                map.flyTo([markers[id_arco].ubicacion.latitud, markers[id_arco].ubicacion.longitud], 17);
            }
            */
        </script>

        <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
        crossorigin="anonymous"></script>
        <script src="javascript/vendors/popper.min.js"></script>
        <script src="javascript/vendors/bootstrap.min.js"></script>
        <script src="javascript/slide_menu.js"></script>
        <script src="javascript/main.js"></script>

        <script type="text/javascript">
                   $('#Aceptar').submit(function (evento) {
                       evento.preventDefault();

                       var warning = $("#filter-warning").is(':checked');
                       var info = $("#filter-info").is(':checked');
                       var danger = $("#filter-danger").is(':checked');
                       var dias = $("#filter-days").val();
                       console.log(warning);
                       console.log(info);
                       console.log(danger);
                       console.log(dias);

                       $.ajax({
                           url: 'listar_autos_interfazPrincipal.htm',
                           type: 'POST',
                           cache: false,
                           contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
                           dataType: "json",
                           data: {
                               warning: warning,
                               info: info,
                               danger: danger,
                               dias: dias},
                           success: function (data) {
                               console.log(data);
                               
                               var datos;
                               for (i in data.Alertas_Vehiculos) {
                                   let icon;
                                   if(data.Alertas_Vehiculos[i].tipo_registro == '3'){
                                        icon = '<i class="fas fa-times-circle"></i>';
                                   }else if(data.Alertas_Vehiculos[i].tipo_registro == '2'){
                                        icon = '<i class="fas fa-exclamation-triangle"></i>';
                                   }else if(data.Alertas_Vehiculos[i].tipo_registro == '1'){
                                        icon = '<i class="fas fa-info-circle"></i>';
                                   }
                                   datos = datos +'<tr>'+
                                            '<td>'+icon+'</td>'+
                                            '<td>'+
                                                '<p>' + data.Alertas_Vehiculos[i].fecha_hora + '</p>'+
                                                '<a href="#" onClick="goToCoords(`'+data.Alertas_Vehiculos[i].coordenadas+'`)">' + data.Alertas_Vehiculos[i].nombre_arco + '</a>'+
                                            '</td>'+
                                            '<td>'+
                                                data.Alertas_Vehiculos[i].niv +
                                            '</td>'+
                                            '<td>'+
                                                data.Alertas_Vehiculos[i].Descripcion +
                                            '</td>'+
                                            '<td>'+
                                                data.Alertas_Vehiculos[i].fuente +
                                            '</td>'+
                                        '</tr>';
                               }
                               
                              var datosArcos;
                              for (i in data.Alertas_Arcos) {
                                   let icon;
                                   if(data.Alertas_Arcos[i].tipo_registro == '3'){
                                        icon = '<i class="fas fa-times-circle"></i>';
                                   }else if(data.Alertas_Arcos[i].tipo_registro == '2'){
                                        icon = '<i class="fas fa-exclamation-triangle"></i>';
                                   }else if(data.Alertas_Arcos[i].tipo_registro == '1'){
                                       icon = '<i class="fas fa-info-circle"></i>';
                                   }
                                   datosArcos = datosArcos +'<tr>'+
                                            '<td>'+icon+'</td>'+
                                            '<td>'+
                                                '<p>' + data.Alertas_Arcos[i].fecha_hora + '</p>'+ 
                                                '<p><a href="#" onClick="goToCoords(`'+data.Alertas_Arcos[i].coordenadas+'`)">'+ data.Alertas_Arcos[i].nombre_arco +'</a>,'+ data.Alertas_Arcos[i].nombre_alerta +'</p>'+
                                            '</td>'+
                                        '</tr>';
                               }
                               
                               $("#tbAlertasAutos").html(datos);
                               $("#tbAlertasArcos").html(datosArcos);
                               
                               console.log("Entro");
                           }, error: function (error) {
                               console.log("Aqui esta2");
                               console.log(error);
                           }
                       })

                   });
        </script>
    </body>

</html>