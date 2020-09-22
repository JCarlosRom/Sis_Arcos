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
    <h6 class="p-4">Consulta de Lecturas por Arcos</h6>
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
                        <div class="d-flex">
                            <div class="d-flex justify-content-start align-items-end card-actions">
                                <button title="" class="action-filter m-0"><i class="fas fa-filter"></i></button>
                            </div>
                            <div class="d-flex table-filters pl-1">
                                <label class="noselect" for="Buscar">
                                    <i class="fas fa-times-circle text-danger"></i>
                                    <input id="filter-danger" type="checkbox">
                                    Critico
                                </label>
                                <label class="noselect" for="Buscar">
                                    <i class="fas fa-info-circle text-info"></i>
                                    <input id="filter-info" type="checkbox">
                                    Informativo
                                </label>
                                <label class="noselect" for="Buscar">
                                    <i class="fas fa-exclamation-triangle text-warning"></i>
                                    <input id="filter-warning" type="checkbox">
                                    Advertencia
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 d-flex">
                        <div class="flex-grow-1 d-flex pt-2">
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