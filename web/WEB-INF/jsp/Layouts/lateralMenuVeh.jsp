<%-- 
    Document   : lateralMenuLectVeh
    Created on : 22-sep-2020, 16:47:48
    Author     : ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="slide-menu main-slide-menu" id="main-slide-menu">
    <a class="btn-slide-menu d-flex flex-no-wrap align-items-center" href="" data-toggle="slide-menu"
       data-target="#main-slide-menu">
        <i class="icon"></i>
    </a>
    <h6 class="p-4">Consulta de Lecturas por Vehículos</h6>
    <div class="card main-slide-menu-card">
        <div class="card-header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-11 d-flex justify-content-between align-items-end">
                        <div class="pl-1 pr-1">
                            <div class="d-flex justify-content-between">
                                <label for="Aceptar">
                                    <input name="check" id="check_niv" type="radio">
                                    NIV
                                </label>
                                <label for="Aceptar">
                                    <input name="check" id="check_placa" type="radio">
                                    PLACA
                                </label>
                            </div>
                            <input id="placa_niv" class="form-control" type="text" placeholder="Placa/Niv">
                        </div>
                        <div class="pl-1 pr-1">
                            <label  for="Aceptar">Fecha y hora inicial</label>
                            <input id="fecha_hora_inicial" class="form-control" type="datetime-local">
                        </div>
                        <div class="pl-1 pr-1">
                            <label  for="Aceptar">Fecha y hora final</label>
                            <input id="fecha_hora_final" class="form-control" type="datetime-local">
                        </div>
                        <div class="pl-1 pr-1">
                            <label for="Aceptar">Arcos</label>
                            <select class="form-control" name="" id="check_arco">
                                <option value="todos">Todos</option>
                                <c:forEach var="arco_p" items="${arcos_option}">
                                    <option value=${arco_p.getId()}>${arco_p.getNombre()}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-1 p-0 d-flex justify-content-center align-items-end card-actions">
                        <button title="" class="action-filter m-0"><i class="fas fa-filter"></i></button>
                    </div>
                </div>
                <div class="row table-filters pt-3 pb-3">
                    <div class="col-md-3">
                        <label class="noselect" for="filter-danger">
                            <i class="fas fa-times-circle text-danger"></i>
                            <input id="filter-danger" type="checkbox">
                            Critico
                        </label>
                    </div>
                    <div class="col-md-3">
                        <label class="noselect" for="filter-info">
                            <i class="fas fa-info-circle text-info"></i>
                            <input id="filter-info" type="checkbox">
                            Informativo
                        </label>
                    </div>
                    <div class="col-md-3">
                        <label class="noselect" for="filter-warning">
                            <i class="fas fa-exclamation-triangle text-warning"></i>
                            <input id="filter-warning" type="checkbox">
                            Advertencia
                        </label>
                    </div>
                    <form id="Aceptar" class="col-md-3" action="#">
                        <button type="submit"  class="btn btn-primary">BUSCAR</button>
                    </form>

                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-arcos-head d-flex flex-wrap justify-content-between text-light">
                            <p>
                                Tipo de Vehículo: <strong id="TipoVehiculo"></strong>
                            </p>
                            <p>
                                Marca: <strong id="Marca"></strong>
                            </p>
                            <p>
                                Color: <strong id="Color"></strong>
                            </p>
                            <p>
                                Placa: <strong id="Placa"></strong>
                            </p>
                            <p>
                                NIV: <strong id="Niv"></strong>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body" id="tablaPDF" style="overflow:scroll;height: 350px;">
            <table id="tablacsv" class="table-arcos" >
                <tbody id="tbDatosAlerta">


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
                            <a class="fas fa-external-link-square-alt" href="lecturas_vehiculo_detalle.htm" target="_blank"><i class=""></i></a>
                            <!-- <button title=""><i class="fas fa-external-link-square-alt"></i></button> -->
                        </div>
                    </div>
                    <div class="col-md-6 d-flex align-items-end">
                        <button class="btn btn-outline-primary text-uppercase">ver todo el historico</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
