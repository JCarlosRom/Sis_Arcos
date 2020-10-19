<%-- 
    Document   : detalleAlerta
    Created on : 29-sep-2020, 15:27:42
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<!-- Header -->


    <div class="slide-menu slide-menu-lg main-slide-menu show" id="main-slide-menu">
        
        <a class="btn-slide-menu d-flex flex-no-wrap align-items-center" href="" data-toggle="slide-menu"
            data-target="#main-slide-menu">
            <i class="icon"></i>
        </a>
        <div class="container-fluid">
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
                                        <li class="step${detalle_alerta.getEtapa()=='Cierre en SM' || detalle_alerta.getEtapa()=='Vinculación' || detalle_alerta.getEtapa()=='Validación' ? ' done':""}" id="${etapa.getIdEtapa()}" style="transform: rotate(-21deg); margin-right: -50px; width: 245px; margin-left: -86px; height: 25px;">
                                            <p style="transform: rotate(21deg);">Cerrado</p>
                                        </li>
                                    </c:if>
                                    <c:if test="${etapa.getNombreEtapa()=='Vinculación'}">
                                        <li class="step${detalle_alerta.getEtapa()=='Vinculación'  ? ' done':""}" id="${etapa.getIdEtapa()}" style="margin-top: 73px;margin-left: -32px;transform: rotate(19deg);width: 230px;">
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
                                <th></th>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>${detalle_alerta.getTipo()}</td>
                                    <td>${detalle_alerta.getMarca()}</td>
                                    <td>${detalle_alerta.getColor()}</td>
                                    <td>${detalle_alerta.getPlaca()}</td>
                                    <td>${detalle_alerta.getNiv()}</td>
                                    <td>
                                    <form action="fullDetalleAlerta.htm" method="POST">
                                        <input name="idAlerta" value="${detalle_alerta.getIdAlerta()}" hidden>
                                        <button type="submit" class="btn btn-ico m-auto"><i
                                                    class="fas fa-external-link-square-alt"></i></button>
                                    </form>

                                    </td>
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
                                    <input id="page" name="page" value="1" hidden>
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
                                    <input id="page" name="page" value="1" hidden>
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
                                                                            hidden>
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
                                            <form method="POST" enctype="multipart/form-data" class="formSeguimiento" id = "formSeguimiento${alerta.getIdAlerta()}">
                                                <input id="page" name="page" value="1" hidden>
                                                <input id="idAlerta" name="idAlerta" value="${detalle_alerta.getIdAlerta()}" hidden>
                                                <input id="idAlertaSeguimiento" name="idAlertaAseguimiento" value="${alerta.getIdAlerta()}" hidden>
                                                <div class="dropdown">
                                                    <button class="btn btn-primary-2 modalUploadDocs" id="modalUploadDocs${alerta.getIdAlerta()}" type="button" 
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
                                                                            <input type='file' name="fileSeguimiento" id='fileSeguimiento${alerta.getIdAlerta()}'  hidden>
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
                                                                        <button type='submit' class='btn btn-primary-2 m-auto pr-3 buttonDocsSeguimiento' id='${alerta.getIdAlerta()}' ><i class='fas fa-paperclip'></i> Adjuntar</button>
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
    </div>

    <!-- main slide nav -->
    <div class="slide-menu main-slide-nav" id="main-slide-nav">
        <nav class="nav flex-column">
            <a class="nav-link active" href="index.html"><i class="fas fa-home"></i> TABLERO</a>
            <a class="nav-link" href="lecturas_vehiculo.html"><i class="fas fa-car"></i> LECTURAS POR VEHÍCULO</a>
            <a class="nav-link" href="lecturas_arco.html"><i class="fas fa-archway"></i> LECTURAS POR ARCO</a>
        </nav>
    </div>

