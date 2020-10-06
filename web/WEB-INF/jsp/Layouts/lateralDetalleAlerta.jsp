<%-- 
    Document   : detalleAlerta
    Created on : 29-sep-2020, 15:27:42
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

    <div class="slide-menu slide-menu-lg main-slide-menu show" id="main-slide-menu">
        
        <a class="btn-slide-menu d-flex flex-no-wrap align-items-center" href="" data-toggle="slide-menu"
            data-target="#main-slide-menu">
            <i class="icon"></i>
        </a>
        <div class="container-fluid">
            <div class="row">
                <div class="col-6 col-md-3">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle"></i>
                        vehículo robado
                    </div>
                </div>
                <div class="col-6 col-md-4">
                    <h6 class="text-bright">${detalle_alerta.getAlertaName()}</h6>
                </div>
                <div class="col-md-5">
                    <h6 class="small">Estatus de la alerta: <span class="text-info font-weight-bold">${detalle_alerta.getEstatus()}</span></h6>
                    <ul class="step-bar">
                        <li class="step ${detalle_alerta.getEtapa()=='Validación' ? 'done':""}" style="margin-top: 30px;margin-left: 110px;">
                            <p>Validación</p>
                        </li>
                        <li class="step ${detalle_alerta.getEtapa()=='Cerrado' ? 'done':""}" style="transform: rotate(-18deg);margin-right: -30px;width: 245px;">
                            <p style="transform: rotate(16deg);">Cerrado</p>
                        </li>
                        <li class="step ${detalle_alerta.getEtapa()=='Vinculado' ? 'done':""}" style="margin-top: 73px;margin-left: -114px;transform: rotate(23deg);width: 230px;">
                            <p style="transform: rotate(340deg);margin-top: 0px;padding-top: 0px;">Vinculado</p>
                        </li>
                       
                    </ul>
              
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <p class="small text-bright">
                        <i class="fas fa-calendar mr-2"></i>
                        Fecha: ${detalle_alerta.getAlertaFecha()}
                    </p>
                </div>
                <div class="col-4">
                    <p class="small text-bright">
                        <i class="fas fa-clock mr-2"></i>
                        Hora: ${detalle_alerta.getAlertaHora()}
                    </p>
                </div>
            </div>
            <div class="row">
                <div class="col-6">
                    <p class="small text-bright">
                        Fuente de información: <span style="color:rgb(26,117,207);">BD IPH / Lista negra</span>
                    </p>
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
                                        <a href="">
                                            <button class="btn btn-ico m-auto"><i
                                                    class="fas fa-external-link-square-alt"></i></button>
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <a href="" class="btn-camera-gallery">
                        <button class="btn btn-primary-2">
                            <i class="fas fa-video"></i>
                        </button>
                    </a>
                    <div class="container my-4"

                        <!--Carousel Wrapper-->
                        <div id="carousel-thumb" class="carousel slide carousel-fade carousel-thumbnails" data-ride="carousel" style="height: 250px;">
                          <!--Slides-->
                          <div class="carousel-inner" role="listbox">
                            <div class="carousel-item active">
                              <img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Slides/img%20(88).jpg" alt="First slide">
                            </div>
                            <div class="carousel-item">
                              <img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Slides/img%20(121).jpg" alt="Second slide">
                            </div>
                            <div class="carousel-item">
                              <img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Slides/img%20(31).jpg" alt="Third slide">
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
                <div class="col-md-6">
                        
                    <div class="map-container" id="mapAlerta" >
                
                    </div>
                   
              
                
                </div>
            </div>
            <form action="uploadDocs.htm" method="POST" enctype="multipart/form-data">
                
                <div class="row">
                    <div class="col-md-6">
                        <input id="idAlerta" name="idAlerta" value="${detalle_alerta.getIdAlerta()}" hidden>
                        <h6 class="small text-bright">Acción / Comentario</h6>
                        <div class="alert alert-secondary small" role="alert">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus venenatis sagittis rhoncus.
                            In erat libero, ultricies a blandit ut, scelerisque pulvinar arcu. Phasellus rhoncus
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col">
                                <h6 class="small text-bright">Estado de la alerta</h6>        
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <select class="form-control mb-3" name="" id="">
                                    <c:forEach items="${Etapa}" var="etapa">

                                        <c:if test = "${detalle_alerta.getEstatus() == etapa.getNombreEtapa()}" >
                                            <option value="${etapa.getIdEtapa()}" selected>${etapa.getNombreEtapa()}</option>
                                        </c:if>
                                        <c:if test = "${detalle_alerta.getEstatus() !=  etapa.getNombreEtapa()}" >
                                            <option value="${etapa.getIdEtapa()}">${etapa.getNombreEtapa()}</option>
                                        </c:if>

                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-6">
                                <form action="guardarSeguimiento.htm" method="POST" enctype="multipart/form-data">
                                    <input name="idAlerta" value="${detalle_alerta.getIdAlerta()}">
                                    <input name="idEtapaAlerta" value="${detalle_alerta.getIdEtapa()}">
                                    <input name="idEstatus" value="${detalle_alerta.getIdEstatus()}">

                                    
                                    <button type="submit" class="btn btn-primary-2" id="Guardar">
                                        <i class="fas fa-save mr-2"></i>
                                        Guardar
                                    </button>
                                </form>
                                  
                                <button type="button" class="btn btn-primary-2" id="guardarImagen">
                                    <i class="fas fa-save mr-2"></i>
                                    Guardar Imagen
                                </button>
                                    
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
                                                                    <label for="file" class="btn btn-primary-2 ml-2" style="width:25px;"><i class="far fa-file" style="margin-left: 5px;"></i></label>
                                                                    <input type="file"
                                                                    id="file" name="file"
                                                                    accept="image/png, image/jpeg" hidden>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <label for="file" class="btn btn-primary-2 ml-2" style="width:25px;"><i class="far fa-file-image" style="margin-left: 5px;"></i></label>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <label for="file" class="btn btn-primary-2 ml-2" style="width:25px;"><i class="far fa-file-video" style="margin-left: 5px;"></i></label>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <label for="file" class="btn btn-primary-2 ml-2" style="width:25px;"><i class="far fa-file-audio" style="margin-left: 5px;"></i></label>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <label for="file" class="btn btn-primary-2 ml-2" style="width:25px;"><i class="fas fa-map-pin" style="margin-left: 5px;"></i></label>
                                                                </div>
                                                               
                                                            </div>
                                                          
                                                         </li>
                                                         <div id="containerDocs">
                                                             
                                                         </div>
                                                     
                                                         <li class="p-2">
                                                             <button class="btn btn-primary-2 m-auto pr-3" type="button"><i
                                                                     class="fas fa-paperclip"></i> Adjuntar</button>
                                                         </li>
                                                     </ul>
                                                 </div>
                                             </div>
                                    
                                        </div>
                                    </div>

                                </div>
                            </div>
                    </div>
                </div>
            </form>
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
                                        <td>
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
                                            <div class="dropdown">
                                                <button class="btn btn-primary-2 buttonDocsSeguimiento" type="button" id="${alerta.getIdAlerta()}"
                                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <i class="fas fa-paperclip"></i>
                                                    <i class="fas fa-ellipsis-v"></i>
                                                </button>
                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                    <div class="card card-dropdown">
                                                        <ul class="list-group list-group-flush">
                                                            <div id="docsAlertaSeguimiento">
                                                                
                                                            </div>
                                                         
                                                            <li class="p-2">
                                                                <button class="btn btn-primary-2 m-auto pr-3"><i
                                                                        class="fas fa-paperclip"></i> Adjuntar</button>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
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

