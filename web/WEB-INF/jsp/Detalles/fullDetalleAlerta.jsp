<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("login.htm");
    }
%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8" lang="es"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Tablero principal</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.min.css" />
        <link rel="stylesheet" href="css/index.css" />
       <link rel="stylesheet" href="css/detalleAlerta.css" />
    </head>
    
    <body class="theme-dark">
        <!-- Header -->
        <jsp:include page="/WEB-INF/jsp/Layouts/headerFull.jsp"></jsp:include>
  
        <main>
            <br>
            <br>
            <div class="container theme-dark">
                <div class="row">
                    <div class="col-md-7">
                        <div class="row">
                            <div class="col-6 col-md-4">
                                <div class="alert alert-danger" role="alert">
                                    <i class="fas fa-exclamation-circle"></i>
                                    vehículo robado
                                </div>
                            </div>
                            <div class="col-6 col-md-8">
                                <h6 class="text-bright" style="font-size: 14px;">Alerta critica reportada en ${detalle_alerta.getArco()}</h6>
                                <h6 class="text-bright" style="font-size: 14px;">Vehículo con dirección a ${detalle_alerta.getDireccion()}</h6>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6 col-md-5">
                                 <p class="small text-bright">
                                    <i class="fas fa-calendar mr-2"></i>
                                    Fecha: ${detalle_alerta.getAlertaFecha()}
                                </p>
                            </div>
                            <div class="col-6 col-md-7">
                                <p class="small text-bright">
                                    <i class="fas fa-clock mr-2"></i>
                                    Hora: ${detalle_alerta.getAlertaHora()}
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-5">
                        <div class="row">
                            <div class="col-md-7">
                                <h6 class="small">Estatus de la alerta:</h6>
                                <span class="text-info font-weight-bold">${detalle_alerta.getEstatus()}</span>
                            </div>
                            <div class="col-md-5">

                                <ul class="step-bar">
                                    <c:forEach items="${Etapa}" var="etapa">
                                        <c:if test="${etapa.getNombreEtapa()=='Validación'}">
                                            <li class="step${detalle_alerta.getEtapa()=='Validación' || detalle_alerta.getEtapa()=='Vinculación'  ? ' done':""}" id="${etapa.getIdEtapa()}" style="margin-top: 39px; height:10px; width:10px; margin-right: 59px;">
                                                <p style="transform: rotate(1deg); margin-left: -20px;">Validación</p>
                                            </li>
                                        </c:if>
                                        <c:if test="${etapa.getNombreEtapa()=='Cierre en SM'}">
                                            <li class="step${detalle_alerta.getEtapa()=='Cierre en SM' || detalle_alerta.getEtapa()=='Vinculación' || detalle_alerta.getEtapa()=='Validación' ? ' done':""}" id="${etapa.getIdEtapa()}" style="transform: rotate(-15deg); margin-right: -50px; width: 130px; margin-left: -86px; height: 25px;">
                                                <p style="transform: rotate(21deg);">Cerrado</p>
                                            </li>
                                        </c:if>
                                        <c:if test="${etapa.getNombreEtapa()=='Vinculación'}">
                                            <li class="step${detalle_alerta.getEtapa()=='Vinculación'  ? ' done':""}" id="${etapa.getIdEtapa()}" style="margin-top: 73px;margin-left: -32px;transform: rotate(19deg);width: 100px;">
                                                <p style="transform: rotate(343deg);margin-top: 0px;padding-top: 0px;">Vinculado</p>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>

                            </div>
                        </div>



                    </div>
                </div>

                <div class="row">
                    <div class="col-10">
                        <p class="small text-bright">
                            Fuente de información: <span style="color:rgb(26,117,207);">BD IPH / Lista negra</span>
                        </p>
                    </div>
                    <div class="col-md-1">
                        <a  data-toggle="modal" data-target="#modalPlataformaMexico">
                            <img src="images/Plataforma-mexico.png" style="height: 85px; cursor: pointer;"></img>
                        </a>

                    </div>
                </div>
                <hr class="hr-1">

                <div class="row mb-3">
                    <div class="col-12">
                        <div class="card main-slide-menu-card p-1">
                            <table class="table-card text-bright">
                                <thead>
                                    <th width="20%">
                                        Tipo de vehículo:
                                    </th>
                                    <th>
                                        Marca:
                                    </th>
                                    <th>
                                        Color:
                                    </th>
                                    <th>
                                        Placa:
                                    </th>
                                    <th>
                                        NIV:
                                    </th>
                                   
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>${detalle_alerta.getTipo()}</td>
                                        <td>${detalle_alerta.getMarca()}</td>
                                        <td>${detalle_alerta.getColor()}</td>
                                        <td>${detalle_alerta.getPlaca()}</td>
                                        <td>${detalle_alerta.getNiv()}</td>
                                       
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                                        
                <div class="row mb-3">
                    <div class="col-md-7">
                        <a href="" class="btn-camera-gallery">
                            <button class="btn btn-primary-2">
                                <i class="fas fa-video"></i>
                            </button>
                        </a>
                        <div class="container my-4"

                            <!--Carousel Wrapper-->
                            <div id="carousel-thumb" class="carousel slide carousel-fade carousel-thumbnails" data-ride="carousel" style="height: 250px;">
                              <!--Slides-->
                              <div class="carousel-inner" role="listbox" style="height: 90%;">
                                 <div class="carousel-item active" style="height: 250px;">
                                  <img class="d-block w-100"  style="height: 250px;" src="https://mdbootstrap.com/img/Photos/Slides/img%20(88).jpg" alt="First slide">
                                </div>
                                <div class="carousel-item" style="height: 250px;">
                                  <img class="d-block w-100" style="height: 250px;" src="https://mdbootstrap.com/img/Photos/Slides/img%20(121).jpg" alt="Second slide">
                                </div>
                                <div class="carousel-item" style="height: 250px;">
                                  <img class="d-block w-100" style="height: 250px;" src="https://mdbootstrap.com/img/Photos/Slides/img%20(31).jpg" alt="Third slide">
                                </div>
                              </div>
                              <!--/.Slides-->
                              <!--Controls-->
                              <a class="carousel-control-prev" href="#carousel-thumb" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                              </a>
                              <a class="carousel-control-next" href="#carousel-thumb" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                              </a>
                              <!--/.Controls-->
                              <ol class="carousel-indicators" style="position: relative !important;">
                                <li data-target="#carousel-thumb" data-slide-to="0" class="active"> <img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Others/Carousel-thumbs/img%20(88).jpg"
                                    class="img-fluid"></li>
                                <li data-target="#carousel-thumb" data-slide-to="1"><img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Others/Carousel-thumbs/img%20(121).jpg"
                                    class="img-fluid"></li>
                                <li data-target="#carousel-thumb" data-slide-to="2"><img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Others/Carousel-thumbs/img%20(31).jpg"
                                    class="img-fluid"></li>
                              </ol>
                            </div>
                            <!--/.Carousel Wrapper-->

                          </div>
                    </div>
                    <div class="col-md-5">

                        <div class="map-container" id="mapAlerta" >

                        </div>



                    </div>
                </div>

                <form action="guardarSeguimiento.htm" method="POST" id="guardarSeguimiento">
                    <div class="row">
                        <div class="col-md-6">

                            <h6 class="small text-bright">Acción / Comentario</h6>

                            <textarea class="alert alert-secondary small" name="Comentario" cols="35" rows="5"></textarea>

                        </div>
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col">
                                    <h6 class="small text-bright">Estado de la alerta</h6>        
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <select class="form-control mb-3" name="idEstatus" id="selectIdEstatus">
                                        <c:forEach items="${estatusEtapa}" var="etapa">

                                            <option value="${etapa.getIdEstatusEtapa()}" selected>${etapa.getNombreEstatusEtapa()}</option>

                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-6">
                                    <input id="page" name="page" value="2" hidden>
                                    <input id="idAlerta" name="idAlerta" value="${detalle_alerta.getIdAlerta()}" hidden>
                                    <input id="idEtapaAlerta" name="idEtapaAlerta" value="${detalle_alerta.getIdEtapa()}" hidden>
                                    <input name="idEtapaAlerta" value="${detalle_alerta.getIdEtapa()}" hidden>
                                    <input name="fechaHora" value="${detalle_alerta.getAlertaFecha()} ${detalle_alerta.getAlertaHora()}" hidden>
                                    <input name="Ubicacion" value="${detalle_alerta.getLatitud()}, ${detalle_alerta.getLongitud()}" hidden>
                                    <input name="Geocoder" value="" hidden>

                                    <button type="button" class="btn btn-primary-2" id="Guardar">
                                        <i class="fas fa-save mr-2"></i>
                                        Guardar
                                    </button>
                                    <br>
                </form>
                                <form action="uploadDocs.htm" method="POST" enctype="multipart/form-data">
                                    <input id="page" name="page" value="2" hidden>
                                    <input id="idAlerta" name="idAlerta" value="${detalle_alerta.getIdAlerta()}" hidden>

                                        </div>
                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <label for="document" style="color:white; font-size: 10px;">Adjuntar Documento</label>
                                                </div>
                                                <div class="col-md-4">
                                                    <button class="btn btn-primary-2" type="button" id="modalUploadDocs" style="width:35px;"
                                                         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                         <i class="fas fa-paperclip"></i>
                                                         <i class="fas fa-ellipsis-v"></i>
                                                     </button>
                                                     <div class="dropdown-menu" aria-labelledby="modalUploadDocs">
                                                         <div class="card card-dropdown">
                                                             <ul class="list-group list-group-flush">
                                                                 <li class="list-group-item">
                                                                    <div class="row">
                                                                        <div class="col-md-2">
                                                                            <label for="file" class="btn btn-primary-2 ml-2" style="width:25px; cursor:pointer;"><i class="far fa-file" style="margin-left: 5px;"></i></label>
                                                                            <input type="file"
                                                                            id="file" name="file"
                                                                            accept="image/png, image/jpeg" hidden>
                                                                        </div>
                                                                        <div class="col-md-2">
                                                                            <label for="file" class="btn btn-primary-2 ml-2" style="width:25px; cursor:pointer;"><i class="far fa-file-image" style="margin-left: 5px;"></i></label>
                                                                        </div>
                                                                        <div class="col-md-2">
                                                                            <label for="file" class="btn btn-primary-2 ml-2" style="width:25px; cursor:pointer;"><i class="far fa-file-video" style="margin-left: 5px;"></i></label>
                                                                        </div>
                                                                        <div class="col-md-2">
                                                                            <label for="file" class="btn btn-primary-2 ml-2" style="width:25px; cursor:pointer;"><i class="far fa-file-audio" style="margin-left: 5px;"></i></label>
                                                                        </div>
                                                                        <div class="col-md-2">
                                                                            <label for="file" class="btn btn-primary-2 ml-2" style="width:25px; cursor:pointer;"><i class="fas fa-map-pin" style="margin-left: 5px;"></i></label>
                                                                        </div>

                                                                    </div>

                                                                 </li>
                                                                 <div id="containerDocs">

                                                                 </div>

                                                                 <li class="p-2">

                                                                    <button type="submit" class="btn btn-primary-2 m-auto pr-3" id="guardarImagen">
                                                                        <i class="fas fa-paperclip"></i>
                                                                        Adjuntar 
                                                                    </button>       

                                                                 </li>
                                                             </ul>
                                                         </div>
                                                     </div>

                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </form>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">


                        <div class="card main-slide-menu-card">
                            <table class="table-autos text-bright">
                                <tbody>
                                    <c:forEach items="${detalleAlertaSeguimiento}" var="alerta">

                                        <tr>
                                            <td>
                                                <i class="fas fa-user-circle"></i>
                                            </td>
                                            <td style="width:40px;padding-right: 20px;padding-left: 10px; text-align: center;">
                                                ${alerta.getAlertaFecha()}
                                            </td>
                                            <td>
                                                ${alerta.getEtapa()}
                                            </td>
                                            <td>
                                                ${alerta.getEstatus()}
                                            </td>
                                            <td>
                                                ${alerta.getComentario()}
                                            </td>

                                            <td>
                                                <form action="uploadDocSeguimiento.htm" method="POST" enctype="multipart/form-data">
                                                    <input id="page" name="page" value="2" hidden>
                                                    <input id="idAlerta" name="idAlerta" value="${detalle_alerta.getIdAlerta()}" hidden>
                                                    <input id="idAlertaSeguimiento" name="idAlertaAseguimiento" value="${alerta.getIdAlerta()}" hidden>
                                                    <div class="dropdown">
                                                        <button class="btn btn-primary-2" type="button" 
                                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            <i class="fas fa-paperclip"></i>
                                                            <i class="fas fa-ellipsis-v"></i>
                                                        </button>

                                                        <div id="containerDocs${alerta.getIdAlerta()}">
                                                            <div class='dropdown-menu' aria-labelledby='dropdownMenuButton' id='dropdown-menu'>
                                                                <div class='card card-dropdown'>
                                                                    <ul class='list-group list-group-flush'>
                                                                        <div class='row'>
                                                                            <div class='col-md-2'>
                                                                                <label for='fileSeguimiento${alerta.getIdAlerta()}' class='btn btn-primary-2 ml-2' style='width:25px; cursor:pointer;'><i class='far fa-file' style='margin-left: -1px;'></i></label>
                                                                                <input type='file' name="fileSeguimiento${alerta.getIdAlerta()}" id='fileSeguimiento${alerta.getIdAlerta()}' accept='image/png, image/jpeg' hidden>
                                                                            </div>
                                                                            <div class='col-md-2'>
                                                                                <label for='fileSeguimiento${alerta.getIdAlerta()}'  class='btn btn-primary-2 ml-2' style='width:25px; cursor:pointer;'><i class='far fa-file-image' style='margin-left: -1px;'></i></label>
                                                                            </div>
                                                                            <div class='col-md-2'>
                                                                                <label for='fileSeguimiento${alerta.getIdAlerta()}'  class='btn btn-primary-2 ml-2' style='width:25px; cursor:pointer;'><i class='far fa-file-video' style='margin-left: -1px;'></i></label>
                                                                            </div>
                                                                            <div class='col-md-2'>
                                                                                <label for='fileSeguimiento${alerta.getIdAlerta()}'  class='btn btn-primary-2 ml-2' style='width:25px; cursor:pointer;'><i class='far fa-file-audio' style='margin-left: -1px;'></i></label>
                                                                            </div>
                                                                            <div class='col-md-2'>
                                                                                <label for='fileSeguimiento${alerta.getIdAlerta()}'  class='btn btn-primary-2 ml-2' style='width:25px; cursor:pointer;'><i class='fas fa-map-pin' style='margin-left: -1px;'></i></label>
                                                                            </div>

                                                                        </div>
                                                                        <div id='docsAlertaSeguimiento${alerta.getIdAlerta()}'>

                                                                        </div>

                                                                        <li class='p-2'>
                                                                            <button type='button' class='btn btn-primary-2 m-auto pr-3 buttonDocsSeguimiento' id='${alerta.getIdAlerta()}' ><i class='fas fa-paperclip'></i> Adjuntar</button>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>


                                                    </div>

                                                </form>


                                            </td>
                                        </tr>
                                    </c:forEach> 


                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
          <!-- Modal -->
            <div class="modal fade show" id="modalAlert" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                    ...
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                  </div>
                </div>
              </div>
            </div>
          
           <div class="modal fade show" id="modalPlataformaMexico" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document" style="max-width: 1300px;">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                    <iframe src="https://www.repuve-consultar.com/consulta-ciudadana" width="100%" height="800" allowfullscreen="allowfullscreen"></iframe>
                  </div>
                
                </div>
              </div>
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
        <script src='javascript/Scripts/alertaConsulta.js'></script>
        <script src='javascript/Scripts/detalleAlerta.js'></script>
        
        <script type="text/javascript">
            var advertenciaIcon = 'images/advertencia.png';
            var criticoIcon = 'images/critico.png';
            var informativoIcon = 'images/informativo.png';
            var markers = {};
            var map;
            var mapAlerta;
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
                
            mapAlerta = new google.maps.Map(document.getElementById('mapAlerta'), {
               center: {lat: ${detalle_alerta.getLatitud()}, lng: ${detalle_alerta.getLongitud()}},
               zoom: 15,
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
           var imageMarkerPreview = {
            url: 'images/critico.png',
            size: new google.maps.Size(71, 71),
            origin: new google.maps.Point(0, 0),
            anchor: new google.maps.Point(17, 34),
            scaledSize: new google.maps.Size(20, 20)
          };
           
            let marcador = new google.maps.Marker({position: {lat: ${detalle_alerta.getLatitud()}, lng: ${detalle_alerta.getLongitud()}}, map: mapAlerta, icon: imageMarkerPreview});
            //markers["" + id + ""] = marcador;

        }
        
        

        </script>
        
    </body>

</html>
