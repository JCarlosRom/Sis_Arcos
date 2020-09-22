<%@page import="Config.Conexion"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Lecturas Arcos</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.min.css" />
    </head>

    <body class="theme-dark" style="color:white;">
       <jsp:include page="/WEB-INF/jsp/Layouts/Header.jsp"></jsp:include>


        <div style="background-color: #05151C; height: 90%;">
            <h6 class="p-4" style="color:white;">Consulta de Lecturas por Arcos</h6>
            <div class="card main-slide-menu-card" style="background-color:#0A1E28;">
                <div class="card-header">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-3">
                                <label for="Buscar">Fecha y hora inicial</label>
                                <input id="fecha_inicial" class="form-control" type="datetime-local" >
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
                                <form id="Buscar" class="col-md-3" action="#">
                                    <button type="submit" class="btn btn-primary">
                                        BUSCAR
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container" id="tablaPDF" style="overflow:scroll;height: 800px;">
                    <table id="tablacsv" class="table-arcos">
                        <thead>
                        <th>Tipo</th>
                        <th>Fecha y arco</th>
                        <th>Placa/Niv</th>
                        <th>Descripción</th>
                        <th>Fuente de información</th>
                        </thead>
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
                                    <button title="" id ="CSV"><i class="fas fa-file-excel"></i></button>
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

        <!-- Footer -->
        <jsp:include page="/WEB-INF/jsp/Layouts/Footer.jsp"></jsp:include>

        <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
        <script src="javascript/vendors/popper.min.js"></script>
        <script src="javascript/vendors/bootstrap.min.js"></script>
        <script src="javascript/slide_menu.js"></script>
        <script src="javascript/main.js"></script>
        <script src="javascript/Scripts/lectura_arco_detalle.js"></script>

   
    </body>

</html>