<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>Tablero principal</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.min.css" />
    </head>

    <body class="theme-dark">
        <!-- top bar -->
        <nav class="main-navbar navbar navbar-expand-lg">
            <a class="navbar-brand" href="index.htm">
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

                    <div id="div_promedio">
                    </div>

                    <div class="col-md-5">
                        <div class="cn-wrapper">

                            <c:forEach var="promedio" items="${alertas_prom}">
                                
                                <c:if test = "${promedio.getTipo_registro() == 'Critico'}">
                                    <div class="display-chart">
                                        <div class="dc-info">
                                            <i class="dc-icon dc-danger"></i>
                                            <div class="dc-info-content">
                                                <span class="dc-info-top" id="PorcentajeCritico">${promedio.getPromedio()}%</span>
                                                <span class="dc-info-msg">${promedio.getTipo_registro()}</span>
                                            </div>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar" role="progressbar" style="width:${promedio.getPromedio()}%" id="ProgressCritico"></div>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test = "${promedio.getTipo_registro() == 'Advertencia'}">
                                    <div class="display-chart">
                                        <div class="dc-info">
                                            <i class="dc-icon dc-warning"></i>
                                            <div class="dc-info-content">
                                                <span class="dc-info-top" id="PorcentajeAdvertencia">${promedio.getPromedio()}%</span>
                                                <span class="dc-info-msg">${promedio.getTipo_registro()}</span>
                                            </div>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar" role="progressbar" style="width:${promedio.getPromedio()}%" id="ProgressAdvertencia"></div>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test = "${promedio.getTipo_registro() == 'Informativo'}">
                                    <div class="display-chart">
                                        <div class="dc-info">
                                            <i class="dc-icon dc-info"></i>
                                            <div class="dc-info-content">
                                                <span class="dc-info-top" id="PorcentajeInformativo">${promedio.getPromedio()}%</span>
                                                <span class="dc-info-msg">${promedio.getTipo_registro()}</span>
                                            </div>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar" role="progressbar" style="width:${promedio.getPromedio()}%" id="ProgressInformativo"></div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>

                        </div>
                    </div>

                    <div class="col-md-5">
                        <div class="cn-wrapper">
                            <c:forEach var="bdd" items="${bddRemotas}">
                                <c:if test = "${bdd.getAccesodatos() == 1}">
                                    <div class="display-status">
                                        <i class="ds-icon ds-success" id="${bdd.getId()}"></i>
                                        <span class="ds-msg"> ${bdd.getNombre()}</span>
                                    </div>
                                </c:if>
                                <c:if test = "${bdd.getAccesodatos() == 0}">
                                    <div class="display-status">
                                        <i class="ds-icon ds-danger" id="${bdd.getId()}"></i>
                                        <span class="ds-msg"> ${bdd.getNombre()}</span>
                                    </div>
                                </c:if>
                            </c:forEach>
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
                                        <button type="submit" class="action-filter" id="btnBuscar"><i class="fas fa-filter"></i></button>
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
                            <div class="tab-pane fade show active" style="overflow:auto; height: 350px;" id="tab_1" role="tabpanel" aria-labelledby="tab-1">
                                <div class="table-arcos-head">
                                    <p>
                                        <c:forEach var="arcoo" items="${arcosOp}">
                                            <span class="text-info font-weight-bold">${arcoo.getOperando()} </span> de <span
                                                class="text-info font-weight-bold">${arcoo.getArcos()}</span> Arcos Operando
                                        </c:forEach>
                                    </p>
                                </div>

                                <table class="table-arcos">
                                    <tbody id="tbAlertasArcos">

                                    </tbody>
                                </table>
                            </div>
                            <div class="tab-pane fade" id="tab_2" style="overflow:scroll;height: 350px;" role="tabpanel" aria-labelledby="tab-2" >
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

        <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
        <script src="<c:url value="/javascript/vendors/popper.min.js" />"></script>
        <script src="<c:url value="/javascript/vendors/bootstrap.min.js" />"></script>
        <script src="<c:url value="/javascript/slide_menu.js" />"></script>
        <script src="<c:url value="/javascript/main.js"/>"></script>

        <script type="text/javascript">
            
                    // Metodo para checar los cambios cada 3 segundos
                   $(document).ready(function () {
                       console.log("ntro aqui");
                       setInterval(varificar_cambios, 3000);
                   });
                   
                   //Metodo para verificar si existen cambios en la tabla bandera
                   function varificar_cambios() {
                       $.ajax({
                           url: 'verificar_cambios.htm',
                           type: 'POST',
                           cache: false,
                           contentType: "application/json; charset=UTF-8;",
                           dataType: "json",
                           success: function (data) {
                               
                               console.log("Entro varificar_cambios()");
                               console.log(data);
                               
                               if (data.Alertas_Auto == 1) {
                                   console.log("Entro ak cambio de alerrtas");
                                   cambio_consultaVehiculos();
                                   promedios_alertas();
                               }
                               if(data.Alertas_Arco == 1){
                                   cambio_consultaArcos();
                               }
                               if (data.Alertas_BddRemotas == 1) {
                                   cambio_bd();
                               }
                           }, error: function (error) {
                               console.log("Error varificar_cambios()");
                               console.log(error);
                           }
                       });
                   }
                   
                   // Metodo para realizar la consulta y mostrar los datos si la bandera trae 1 en Alerta_Auto
                   function cambio_consultaVehiculos() {
                       var warning = $("#filter-warning").is(':checked');
                       var info = $("#filter-info").is(':checked');
                       var danger = $("#filter-danger").is(':checked');
                       var dias = $("#filter-days").val();
                       dias = dias === '' ? 0 : +dias;
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
                               console.log('cambio_consulta()', data);
                               var datos;
                               for (index in data.Alertas_Vehiculos) {
                                   let vehiculo = data.Alertas_Vehiculos[index];
                                   let icon;
                                   if (vehiculo.tipo_registro == '3') {
                                       icon = '<i class="fas fa-times-circle"></i>';
                                   } else if (vehiculo.tipo_registro == '2') {
                                       icon = '<i class="fas fa-exclamation-triangle"></i>';
                                   } else if (vehiculo.tipo_registro == '1') {
                                       icon = '<i class="fas fa-info-circle"></i>';
                                   }

                                   datos = datos + '<tr>' +
                                           '<td>' + icon + '</td>' +
                                           '<td>' +
                                           '<p>' + vehiculo.fecha_hora + '</p>' +
                                           '<a href="#" onClick="goToArco(' + vehiculo.id_arco + ', ' + vehiculo.tipo_registro + ')">' + vehiculo.nombre_arco + '</a>' +
                                           '</td>' +
                                           '<td>' +
                                           vehiculo.niv +
                                           '</td>' +
                                           '<td>' +
                                           vehiculo.Descripcion +
                                           '</td>' +
                                           '<td>' +
                                           vehiculo.fuente +
                                           '</td>' +
                                           '</tr>';
                               }
                               
                               $("#tbAlertasAutos").html(datos);
                               cambio_estados();
                           }, error: function (error) {
                               console.log("Error cambio_consultaVehiculos()");
                               console.log(error);
                           }
                       })
                   }
                   
                   // Metodo para realizar la consulta y mostrar los datos si la bandera trae 1 en Alerta_Arco
                   function cambio_consultaArcos() {
                       var warning = $("#filter-warning").is(':checked');
                       var info = $("#filter-info").is(':checked');
                       var danger = $("#filter-danger").is(':checked');
                       var dias = $("#filter-days").val();
                       dias = dias === '' ? 0 : +dias;
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
                               console.log('cambio_consultaArcos()', data);
                              
                               var datosArcos;
                               for (index in data.Alertas_Arcos) {
                                   let arco = data.Alertas_Arcos[index];
                                   let icon;
                                   if (arco.tipo_registro == '3') {
                                       icon = '<i class="fas fa-times-circle"></i>';
                                   } else if (arco.tipo_registro == '2') {
                                       icon = '<i class="fas fa-exclamation-triangle"></i>';
                                   } else if (arco.tipo_registro == '1') {
                                       icon = '<i class="fas fa-info-circle"></i>';
                                   }
                                   datosArcos = datosArcos + '<tr>' +
                                           '<td>' + icon + '</td>' +
                                           '<td>' +
                                           '<p>' + arco.fecha_hora + '</p>' +
                                           '<p><a href="#" onClick="goToArco(' + arco.id_arco + ', ' + arco.tipo_registro + ')">' + arco.nombre_arco + '</a>,' + arco.nombre_alerta + '</p>' +
                                           '</td>' +
                                           '</tr>';
                               }
                               console.log('ID ARCO:   '+data.Alertas_Arcos);
                               changedButton(data.Alertas_Arcos[0].id_arco, data.Alertas_Arcos[0].tipo_registro);
                               
                               $("#tbAlertasArcos").html(datosArcos);
                               cambio_estados();
                           }, error: function (error) {
                               console.log("error cambio_consultaArcos()");
                               console.log(error);
                           }
                       })
                   }
                   
                   // Metodo para cambiar el estado de la bandera de 1 a 0 de Alerta Auto y Alerta Arco
                   function cambio_estados() {
                       $.ajax({
                           url: 'cambio_estado_tablero.htm',
                           type: 'POST',
                           cache: false,
                           contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
                           dataType: "json",
                           success: function (data) {
                               console.log(data);
                           }, error: function (error) {
                               console.log("error cambio_estados()");
                               console.log(error);
                           }
                       })
                   }

                   // Metodo para cambiar el estado de las base de datos en la vista
                   function cambio_bd() {
                       $.ajax({
                           url: 'bdd_remotas.htm',
                           type: 'POST',
                           cache: false,
                           contentType: "application/json; charset=UTF-8;",
                           dataType: "json",
                           success: function (data) {
                               // console.log(data);
                               if (data['BD IPH'] == 0) {
                                   $('#StatusBDIPH').removeClass('ds-success');
                                   $('#StatusBDIPH').addClass('ds-danger');
                               } else {
                                   $('#StatusBDIPH').removeClass('ds-danger');
                                   $('#StatusBDIPH').addClass('ds-success');
                               }

                               if (data['BD PGJ'] == 0) {
                                   $('#StatusBDPGJ').removeClass('ds-success');
                                   $('#StatusBDPGJ').addClass('ds-danger');
                               } else {
                                   $('#StatusBDPGJ').removeClass('ds-danger');
                                   $('#StatusBDPGJ').addClass('ds-success');
                               }

                               if (data['BD REPUVE ESTATAL'] == 0) {
                                   $('#StatusBDREPUVEESTATAL').removeClass('ds-success');
                                   $('#StatusBDREPUVEESTATAL').addClass('ds-danger');
                               } else {
                                   $('#StatusBDREPUVEESTATAL').removeClass('ds-danger');
                                   $('#StatusBDREPUVEESTATAL').addClass('ds-success');
                               }

                               if (data['BD REPUVE NACIONAL'] == 0) {
                                   $('#StatusBDREPUVENACIONAL').removeClass('ds-success');
                                   $('#StatusBDREPUVENACIONAL').addClass('ds-danger');
                               }else{
                                   $('#StatusBDREPUVENACIONAL').removeClass('ds-danger');
                                   $('#StatusBDREPUVENACIONAL').addClass('ds-success');
                               }

                               if (data['BD SIVEBU'] == 0) {
                                   $('#StatusBDSIVEBU').removeClass('ds-success');
                                   $('#StatusBDSIVEBU').addClass('ds-danger');
                               } else {
                                   $('#StatusBDSIVEBU').removeClass('ds-danger');
                                   $('#StatusBDSIVEBU').addClass('ds-success');
                               }

                               cambio_bd_remotas();
                           }, error: function (error) {
                               console.log("Error cambio_bd()");
                               console.error(error);
                           }
                       });
                   }
                   
                   // Metodo para cambiar el estado de la bandera de 1 a 0 en bddreomtas
                   function cambio_bd_remotas() {
                       $.ajax({
                           url: 'cambio_bd_remotas.htm',
                           type: 'POST',
                           cache: false,
                           contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
                           dataType: "json",
                           success: function (data) {
                               console.log("Cambio los datos....", data);
                           }, error: function (error) {
                               console.log("error cambio_bd_remotas()");
                               console.log(error);
                           }
                       })
                   }
                   
                   // Metodo para consultar y mostrar el promedio de las alertas de autos
                   function promedios_alertas() {
                       $.ajax({
                           url: 'porcentaje_alertas.htm',
                           type: 'POST',
                           cache: false,
                           contentType: "application/json; charset=UTF-8;",
                           dataType: "json",
                           success: function (data) {
                               console.log(data);
                               $('#PorcentajeCritico').text(data.Critico + '%');
                               $('#PorcentajeAdvertencia').text(data.Advertencia + '%');
                               $('#PorcentajeInformativo').text(data.Informativo + '%');
                               $('#ProgressAdvertencia').css('width', data.Advertencia + '%');
                               $('#ProgressCritico').css('width', data.Critico + '%');
                               $('#ProgressInformativo').css('width', data.Informativo + '%');
                               //console.log("Informativo ", data.Informativo);
                               //console.log("Advertencia ", data.Advertencia);
                               //console.log("Critico ", data.Critico);
                           }, error: function (error) {
                               console.log("Error promedios_alertas()");
                               console.error(error);
                           }
                       });
                   }

                   $('#Aceptar').submit(function (evento) {
                       console.log('Aceptar Boton');
                       $('#btnBuscar').prop('disabled', true);
                       evento.preventDefault();
                       var warning = $("#filter-warning").is(':checked');
                       var info = $("#filter-info").is(':checked');
                       var danger = $("#filter-danger").is(':checked');
                       var dias = $("#filter-days").val();
                       dias = dias === '' ? 0 : +dias;
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
                               console.log('cambio_consulta()', data);
                               var datos;
                               for (index in data.Alertas_Vehiculos) {
                                   let vehiculo = data.Alertas_Vehiculos[index];
                                   let icon;
                                   if (vehiculo.tipo_registro == '3') {
                                       icon = '<i class="fas fa-times-circle"></i>';
                                   } else if (vehiculo.tipo_registro == '2') {
                                       icon = '<i class="fas fa-exclamation-triangle"></i>';
                                   } else if (vehiculo.tipo_registro == '1') {
                                       icon = '<i class="fas fa-info-circle"></i>';
                                   }

                                   datos = datos + '<tr>' +
                                           '<td>' + icon + '</td>' +
                                           '<td>' +
                                           '<p>' + vehiculo.fecha_hora + '</p>' +
                                           '<a href="#" onClick="goToArco(' + vehiculo.id_arco + ', ' + vehiculo.tipo_registro + ')">' + vehiculo.nombre_arco + '</a>' +
                                           '</td>' +
                                           '<td>' +
                                           vehiculo.niv +
                                           '</td>' +
                                           '<td>' +
                                           vehiculo.Descripcion +
                                           '</td>' +
                                           '<td>' +
                                           vehiculo.fuente +
                                           '</td>' +
                                           '</tr>';
                               }

                               var datosArcos;
                               for (index in data.Alertas_Arcos) {
                                   let arco = data.Alertas_Arcos[index];
                                   let icon;
                                   if (arco.tipo_registro == '3') {
                                       icon = '<i class="fas fa-times-circle"></i>';
                                   } else if (arco.tipo_registro == '2') {
                                       icon = '<i class="fas fa-exclamation-triangle"></i>';
                                   } else if (arco.tipo_registro == '1') {
                                       icon = '<i class="fas fa-info-circle"></i>';
                                   }
                                   datosArcos = datosArcos + '<tr>' +
                                           '<td>' + icon + '</td>' +
                                           '<td>' +
                                           '<p>' + arco.fecha_hora + '</p>' +
                                           '<p><a href="#" onClick="goToArco(' + arco.id_arco + ', ' + arco.tipo_registro + ')">' + arco.nombre_arco + '</a>,' + arco.nombre_alerta + '</p>' +
                                           '</td>' +
                                           '</tr>';
                               }
                               //changedButton(data.Alertas_Arcos[0].id_arco, data.Alertas_Arcos[0].tipo_registro);
                               $("#tbAlertasAutos").html(datos);
                               $("#tbAlertasArcos").html(datosArcos);
                               $( "#btnBuscar" ).prop( "disabled", false );
                           }, error: function (error) {
                               console.log("Aqui esta2");
                               console.log(error);
                               $( "#btnBuscar" ).prop( "disabled", false );
                           }
                       });
                       
                   });</script>

        <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdTfw1waJScSYaMdXKGqAW6rnHcwmjZwc&callback=initMap">
        </script>

        <script type="text/javascript">
            var advertenciaIcon = 'images/advertencia.png';
            var criticoIcon = 'images/critico.png';
            var informativoIcon = 'images/informativo.png';
            var markers = {};
            var map;
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
                addMarker(${arco.getId()}, "${arco.getNombre()}", "${arco.getDescripcion()}", ${arco.getLatitud()}, ${arco.getLongitud()}, ${arco.getTipo_alerta()});
            </c:forEach>

            }

            function addMarker(id, nombre, descripcion, lat, lng, alerta) {
                let marcador = new google.maps.Marker({position: {lat: lat, lng: lng}, map: map, icon: iconMarker(alerta)});
                let infowindow = new google.maps.InfoWindow({
                    content: "<b>" + nombre + "</b><br>" + descripcion + "."
                });
                marcador.addListener('click', function () {
                    infowindow.open(map, marcador);
                    marcador.setAnimation(google.maps.Animation.BOUNCE);
                    setTimeout(() => marcador.setAnimation(null), 2000);
                });
                infowindow.open(map, marcador);
                markers["" + id + ""] = marcador;
            }

            function iconMarker(alerta) {
                let icon;
                if (alerta == 3) {
                    icon = criticoIcon;
                } else if (alerta == 2) {
                    icon = advertenciaIcon;
                } else {
                    icon = informativoIcon;
                }
                return icon;
            }

            function goToArco(id, alerta) {
                let arco = markers["" + id + ""];
                arco.setIcon(iconMarker(alerta));
                map.setCenter(arco.getPosition());
                map.setZoom(15);
                arco.setAnimation(google.maps.Animation.BOUNCE);
                setTimeout(() => arco.setAnimation(null), 3000);
                $('#main-slide-menu').toggleClass('show');
            }

            function changedButton(id, alerta) {
                let arco = markers["" + id + ""];
                arco.setIcon(iconMarker(alerta));
            }
        </script>
    </body>

</html>
