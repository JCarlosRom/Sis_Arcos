<%-- 
    Document   : lateralMenu
    Created on : 22-sep-2020, 16:08:05
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

  <div class="slide-menu main-slide-menu" id="main-slide-menu">
    <a class="btn-slide-menu d-flex flex-no-wrap align-items-center" href="" data-toggle="slide-menu"
        data-target="#main-slide-menu">
         <i class="icon"></i>
    </a>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-1">
                    <h6 class="Arcostitle">Arcos</h6>
                </div>
                <div class="col-md-2">
                    <span class="fas fa-chevron-down" style="color:black;"></span>
                </div>
            </div>
          
            <div class="card main-slide-menu-card" style="border:0px;">
            <div class="card-header">
                <div class="container-fluid">
                    <div class="row no-gutters">
                        <div class="col-md-6">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="tab-1" data-toggle="tab" href="#tab_1" role="tab"
                                       aria-controls="tab-1" aria-selected="true">Listas</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="tab-2" data-toggle="tab" href="#tab_2" role="tab"
                                       aria-controls="tab-2" aria-selected="false">Lecturas</a>
                                </li>
                               <li class="nav-item">
                                    <a class="nav-link" id="tab-3" data-toggle="tab" href="#tab_3" role="tab"
                                       aria-controls="tab-3" aria-selected="false">Alertas</a>
                                </li>
                            </ul>
                        </div>

                    </div>
                </div>
            </div>
            <div class="card-header table-filters">
                <div class="container-fluid">

                </div>
            </div>
            <div class="card-body">
                <div class="tab-content">
                    <div class="tab-pane fade show active" style="overflow:auto; height: 350px;" id="tab_1" role="tabpanel" aria-labelledby="tab-1">
                        <p>Listas</p>
                    </div>
                    <div class="tab-pane fade" id="tab_2" style="overflow:scroll;height: 350px;" role="tabpanel" aria-labelledby="tab-2" >
                        <p>Lecturas</p>
                    </div>
                    <div class="tab-pane fade" id="tab_3" style="overflow:scroll;height: 350px;" role="tabpanel" aria-labelledby="tab-3" >
                        <div class="row" style="margin:0px;" id="OptionsColumn">
                            <div class="col-md-3">
                                <a class="btnOptionsMenu" id="tiempoRealButton">En tiempo real</a>
                            </div>
                            <div class="col-md-3">
                                <a class="btnOptionsMenu"  href="lecturas_vehiculo.htm">Por vehículo</a>
                            </div>
                            <div class="col-md-3">
                                <a class="btnOptionsMenu" href= "lecturas_arco.htm" >Por Arco</a>
                            </div>
                        </div>
                        
                        <div id="tiempoRealDashboard" style="display:none;">
                            <div class="container-fluid">
                                <div class="row no-gutters">

                                    <div class="col-md-1">
                                        <label class="noselect" for="Aceptar">
                                            <i id="danger" class="fas fa-times-circle text-danger fa-2x" ></i>
                                              <i id="CheckDanger" class="fa fa-check-circle" style="display:none; color:#3843d1; position:absolute; margin-left: 10px;margin-top: -7px;"></i>
                                        </label>
                                    </div>
                                    <div class="col-md-1">
                                        <label class="noselect" for="Aceptar">
                                            <i id="Info" class="fas fa-info-circle text-info fa-2x"></i>
                                            <i id="CheckInfo" class="fa fa-check-circle" style="display:none; color:#3843d1; position:absolute; margin-left: 10px;margin-top: -7px;"></i>
                                        </label>
                                    </div>
                                    <div class="col-md-1">
                                        <label class="noselect" for="Aceptar">
                                            <i id="Alert" class="fas fa-exclamation-triangle text-warning fa-2x"></i>
                                            <i id="CheckAlert" class="fa fa-check-circle" style="display:none; color:#3843d1; position:absolute; margin-left: 16px;margin-top: -7px;"></i>
                                        </label>   
                                    </div>
                                    <div class="col-md-4">
                                        <label class="noselect" for="Aceptar">
                                            últimos días
                                            <select id="filter-days" type="number" name="ultimosDias" style="margin-left: 5px; max-width: 100px;">
                                                <option value="1">1 días</option>
                                                <option value="7">7 días</option>
                                                <option value="14">14 días</option>
                                                <option value="30">30 días</option>
                                            </select>

                                        </label>
                                    </div>
                                </div>
                                
                                <div class="table-arcos-head">
                                    <p>
                                        <c:forEach var="arcoo" items="${arcosOp}">
                                            <span class="text-info font-weight-bold">${arcoo.getOperando()} de </span > <span
                                                class="text-info font-weight-bold">${arcoo.getArcos()} Arcos Operando</span> 
                                        </c:forEach>
                                    </p>
                                </div>

                                <table class="table-arcos">
                                    <tbody id="tbAlertasArcos">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
          
                </div>
                
             
            </div>
            <div class="card-footer">

            </div>
     </div>
        </div>
        <div class="col-md-1"></div>
    </div>
    
     
  
 </div>
