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
        <title>Lectura Vehículos</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.min.css" />
    </head>

    <body class="theme-dark" style="color:white;">
        <jsp:include page="/WEB-INF/jsp/Layouts/Header.jsp"></jsp:include>

        <div style="background-color: #05151C; height: 90%;">
            <a class="btn-slide-menu d-flex flex-no-wrap align-items-center" href="" data-toggle="slide-menu"
               data-target="#main-slide-menu">
                <i class="icon"></i>
            </a>
            <h6 class="p-4">Consulta de Lecturas por Vehículos</h6>
            <div class="card main-slide-menu-card" style="background-color:#0A1E28;">
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
                                <div class="pl-1 pr-1" style="min-width: 120px;">
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
                <div class="card-body" id="tablaPDF" style="color:white;overflow:scroll;height: 800px;">
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
                                    <button title="" id="CSV" download="your-foo.csv"><i class="fas fa-file-excel"></i></button>
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

        <!-- main slide nav -->
        <div class="slide-menu main-slide-nav" id="main-slide-nav">
            <nav class="nav flex-column">
                <a class="nav-link" href="/Sis_Arcos/index.htm"><i class="fas fa-home"></i> TABLERO</a>
                <a class="nav-link active" href="/Sis_Arcos/lecturas_vehiculo.htm"><i class="fas fa-car"></i> LECTURAS POR VEHÍCULO</a>
                <a class="nav-link" href="/Sis_Arcos/lecturas_arco.htm"><i class="fas fa-archway"></i> LECTURAS POR ARCO</a>
            </nav>
        </div>

    </main>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/jsp/Layouts/Footer.jsp"></jsp:include>

    <script
        src="https://code.jquery.com/jquery-3.4.1.js"
        integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
    crossorigin="anonymous"></script>
    <script src="javascript/vendors/popper.min.js"></script>
    <script src="javascript/vendors/bootstrap.min.js"></script>
    <script src="javascript/slide_menu.js"></script>
    <script src="javascript/main.js"></script>


    <script type="text/javascript" src="javascript/Scripts/lectura_vehiculo_detalle.js"></script>
</body>

</html>