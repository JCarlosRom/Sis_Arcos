<%-- 
    Document   : lateralMenuArcos
    Created on : 22-sep-2020, 16:53:18
    Author     : ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <div class="slide-menu main-slide-menu" id="main-slide-menu">
    <a class="btn-slide-menu d-flex flex-no-wrap align-items-center" href="" data-toggle="slide-menu"
       data-target="#main-slide-menu">
        <i class="icon"></i>
    </a>
    <h6 class="p-4 Arcotitle">Consulta de Lecturas por Arcos</h6>
    <div class="card main-slide-menu-card">
        <div class="card-header">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <label for="Buscar">Fecha y hora inicial</label>
                        <input id="fecha_inicial" class="form-control" type="datetime-local">
                    </div>
                    <div class="col-md-3">
                        <label for="Buscar">Fecha y hora final</label>
                        <input id="fecha_final" class="form-control" type="datetime-local">
                    </div>
                    <div class="col-md-3">
                        <label for="Buscar">Arcos</label>
                        <select class="form-control" name="" id="check_arco">
                            <option value="todos">Todos</option>
                            <c:forEach var="arco_p" items="${arcos_option}">
                                <option value=${arco_p.getId()}>${arco_p.getNombre()}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label for="Buscar">Color</label>
                        <select class="form-control" name="" id="check-color">

                            <c:forEach var="color" items="${colors}">
                                <option value=${color.getId_color()}>${color.getColor()}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="row table-filters pt-3 pb-1">
                    <div class="col-md-6">
                        <div class="row no-gutters able-filters pt-3 pb-3">

                            <div class="col-md-2">
                                <label class="noselect" for="Aceptar">
                                    <i id="danger" class="fas fa-times-circle text-danger fa-2x" ></i>
                                      <i id="CheckDanger" class="fa fa-check-circle" style="display:none; color:#3843d1; position:absolute; margin-left: 10px;margin-top: 13px;"></i>
                                </label>
                            </div>
                            <div class="col-md-2">
                                <label class="noselect" for="Aceptar">
                                    <i id="Info" class="fas fa-info-circle text-info fa-2x"></i>
                                    <i id="CheckInfo" class="fa fa-check-circle" style="display:none; color:#3843d1; position:absolute; margin-left: 10px;margin-top: 13px;"></i>
                                </label>
                            </div>
                            <div class="col-md-2">
                                <label class="noselect" for="Aceptar">
                                    <i id="Alert" class="fas fa-exclamation-triangle text-warning fa-2x"></i>
                                    <i id="CheckAlert" class="fa fa-check-circle" style="display:none; color:#3843d1; position:absolute; margin-left: 16px;margin-top: 13px;"></i>
                                </label>   
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6 d-flex pb-3 pt-3">
                        <div class="col-md-2">
                            <label class="noselect" for="Aceptar">
                                <i id="Moto" class="fas fa-motorcycle text-warning fa-2x"></i>
                                <i id="CheckMoto" class="fa fa-check-circle" style="display:none; color:#3843d1; position:absolute; margin-left: 16px;margin-top: 13px;"></i>
                            </label> 
                        </div>
                        <div class="col-md-2">
                          <label class="noselect" for="Aceptar">
                              <i id="Car" class="fas fa-car text-warning fa-2x"></i>
                              <i id="CheckCar" class="fa fa-check-circle" style="display:none; color:#3843d1; position:absolute; margin-left: 16px;margin-top: 13px;"></i>
                          </label> 
                        </div>
                        <div class="col-md-2">
                          <label class="noselect" for="Aceptar">
                              <i id="Taxi" class="fas fa-taxi text-warning fa-2x"></i>
                              <i id="CheckTaxi" class="fa fa-check-circle" style="display:none; color:#3843d1; position:absolute; margin-left: 16px;margin-top: 13px;"></i>
                          </label> 
                        </div>
                        <div class="col-md-2">
                          <label class="noselect" for="Aceptar">
                              <i id="Bus" class="fas fa-bus-alt text-warning fa-2x"></i>
                              <i id="CheckBus" class="fa fa-check-circle" style="display:none; color:#3843d1; position:absolute; margin-left: 16px;margin-top: 13px;"></i>
                          </label> 
                        </div>
                        <div class="col-md-2">
                          <label class="noselect" for="Aceptar">
                              <i id="Truck" class="fas fa-truck-pickup text-warning fa-2x"></i>
                              <i id="CheckTruck" class="fa fa-check-circle" style="display:none; color:#3843d1; position:absolute; margin-left: 16px;margin-top: 13px;"></i>
                          </label> 
                        </div>
                        <!--<div class="flex-grow-1 d-flex pt-2">
                            <input id="Motocicleta" type="checkbox" class="fas fa-motorcycle check-icon">
                            <input id="Carro" type="checkbox" class="fas fa-car check-icon">
                            <input id="Taxi" type="checkbox" class="fas fa-taxi check-icon">
                            <input id="Camion" type="checkbox" class="fas fa-bus-alt check-icon">
                            <input id="Camioneta" type="checkbox" class="fas fa-truck-pickup check-icon">
                            <!--<input id="camion" type="checkbox" class="fas fa-truck check-icon">-->
                        </div>
                        <button class="btn btn-outline-primary">
                            TODOS
                        </button>
                    </div>
                </div>

                <div class="row pb-3">
                    <div class="offset-md-8 col-md-4">
                        <form id="Buscar" class="col-md-8" action="#">
                            <button type="submit" class="btn btn-primary">
                                BUSCAR
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body" id="tablaPDF" style="overflow:scroll;height: 350px;">
            <table class="table-arcos">
                <tbody id="tbAlertasVehiculos">

                </tbody>
            </table>
        </div>
        <div class="card-footer center">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <p class="mb-2" style="font-size: 10px;">
                            Descargar
                        </p>
                        <div class="card-actions">
                            <button title="" id="PDF"><i class="fas fa-file-pdf"></i></button>
                            <button title="" id="CSV"><i class="fas fa-file-excel"></i></button>
                            <a class="fas fa-external-link-square-alt" href="lecturas_arco_detalle.htm" target="_blank"><i class=""></i></a>
                            <!-- <button title=""><i class="fas fa-external-link-square-alt"></i></button>-->
                        </div>
                    </div>
                    <div class="col-md-6 d-flex align-items-end">
                        <button class="btn btn-outline-primary text-uppercase">ver todo el histórico</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>