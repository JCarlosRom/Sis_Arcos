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
        <title>Lista blanca detalle</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/main.min.css" />

        <style>
            #example_filter{
                display:none;
            }
            .dataTables_info, .dataTables_length{
                color: #CFCFCF !important;
                font-size: 11px  !important;               
            }
            #example {
                border-collapse: collapse;
                color:white;

            }
            #example table tr {                 
                border: 1px solid rgba(151,151,151,0.11) !important;
                opacity: 69% !important;
            } 
            #example_wrapper {
                width: 100%;
            }
            #table-footer {
                padding: 10px;
                width: 100%;
                color: #CFCFCF;
            }
            #example_info{
                float: left;
            }
            #example_paginate{
                float: right;
            }                    
            .buttons {
                margin-right: 10px;
                background-color: transparent;
                border: 1px solid #AEAEAE;
                border-radius: 10px;
                color: #4A90E2 ;
                width: 31px;
                height: 31px;
            }
            .table-arcos tbody td:nth-child(1) {
                width: 150px;
                text-align: center;
            }
            .table-arcos tbody td:nth-child(2) {
                width: 130px;
            }
            .table-arcos tbody td:nth-child(3) {
                width: 300px;
                padding-right: 30px;
            }
            .table-arcos tbody td:nth-child(4) {
                width: 10px;
            }
            .table-arcos tbody td:nth-child(5) {
                width: 150px;
                text-align: center;
            }    
            #change {
                margin-left: 5px;
                margin-right: 5px;
            }
        </style>
    </head>

    <body class="theme-dark" style="color:white;">
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
                            <span class="d-block"><%= session.getAttribute("usuario")%></span>
                            <a class="mn-logout-link" href="<c:url value="logout.htm" />">cerrar sesion</a>
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
            <div style="background-color: #05151C;" >
                <h6 class="p-4" style="color:white;">Consulta lista blanca detalle</h6>
                <button type="button" class="btn btn-primary" style="margin-left: 15px; margin-top: -30px;" id="volver">Volver</button>
                <div class="card main-slide-menu-card content" style="background-color:#0A1E28; min-height: 100vh;">
                    <div class="card-header">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-3">                               
                                    <input type="text" class="form-control" placeholder="Search" id="searchList">
                                </div>
                                <div class="col-md-3">                                
                                    <input id="fecha_inicial" class="form-control" type="datetime-local">
                                </div>
                                <div class="col-md-3">
                                    <input id="fecha_final" class="form-control" type="datetime-local">
                                </div>

                                <div class="col-md-1">
                                    <button type="button" class="buttons" style="color:#F5A623; " id="searchDateRange"><i class="fas fa-filter"></i></button>
                                </div>
                                <div class="col-md-2">                                                             
                                    <button type="button" class="btn btn-primary" id="btnNuevoRegistro">Nuevo Registro</button>
                                </div>
                            </div>                       
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="container" id="tabla" >
                            <div class="t_arcos">
                                <div class="table-arcos-head"></div>
                                <table id="example" class=" table-arcos" style="width: 100%;" >                                    
                                    <thead>
                                        <tr style="display: none;">
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>                                                                                                                      
                                        </tr>
                                    </thead>
                                    <tbody>                                  
                                    </tbody>
                                </table>
                                <div id="table-footer"></div>
                            </div>
                            <div class="f_arcos">
                                <form id="formLista" class="form_lista" style="margin:10px; color: white;">          
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <label for="recipient-name" class="col-form-label">Vigencia</label>
                                            <input type="hidden" class="form-check-input" name="tipoLista" id="tipoLista" value="1">
                                            <input type="hidden" class="form-check-input" name="act" id="act" value="C">
                                            <input type="hidden" class="form-check-input" name="id_lista" id="id_lista" value="0">
                                            <input type="hidden" class="form-check-input" name="edo_registro" id="edo_registro">
                                        </label>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="recipient-name" class="col-form-label">Fecha inicial</label>
                                                <input id="modFechaInicial" name="modFechaInicial" class="form-control" type="datetime-local" style="color:white;" required="required">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="recipi" class="col-form-label">Fecha final</label>
                                                <input id="modFechaFinal" name="modFechaFinal" class="form-control" type="datetime-local" required="required">                                       
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input type="checkbox" class="form-check-input" name="optRadioReg" id="optRadioReg">Registro permanente
                                        </label>
                                    </div>
                                    <div class="form-group">
                                        <label for="niv" class="col-form-label">NIV</label>
                                        <input type="text" class="form-control" id="niv" name="niv" placeholder="FF38741" required="true">
                                    </div>
                                    <div class="form-group">
                                        <label for="placa" class="col-form-label">PLACA</label>
                                        <input type="text" class="form-control" id="placa" name="placa" placeholder="FF38741" required="true">
                                    </div>
                                    <div class="form-group">
                                        <label for="placa" class="col-form-label">Motivo de ingreso</label>
                                        <textarea class="form-control" id="motivo" name="motivo" placeholder="Vehículo reportado en percance vial" required="true"></textarea>
                                    </div>                                                                                                          
                                    <div class="modal-footer">                        
                                        <button id="guardar" type="submit" class="btn btn-primary col-3"><i class="fas fa-save m-1"></i>Guardar</button>
                                    </div>
                                </form>                                
                            </div>
                        </div>
                    </div>
                    <div class="card-footer center">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-6">
                                    <p class="mb-2" style="font-size: 10px;">
                                        Descargar
                                    </p>
                                    <div class="card-actions">
                                        <div id="buttons"> 
                                        </div>                                
                                    </div>
                                </div>                               
                            </div>
                        </div>
                    </div>
                </div>
                <div class="slide-menu main-slide-nav" id="main-slide-nav">
                    <nav class="nav flex-column">
                        <a class="nav-link" href="index.htm"><i class="fas fa-home"></i> TABLERO</a>
                        <a class="nav-link" href="lecturas_vehiculo.htm"><i class="fas fa-car"></i> LECTURAS POR VEHÍCULO</a>
                        <a class="nav-link" href="lecturas_arco.htm"><i class="fas fa-archway"></i> LECTURAS POR ARCO</a>
                        <a class="nav-link" href="listaNegra.htm"><i class="fas fa-list"></i>LISTA NEGRA</a>                    
                        <a class="nav-link active" href="listaBlanca.htm"><i class="fas fa-list"></i>LISTA BLANCA</a>                    
                        <a class="nav-link" href="arcos.htm"><i class="fas fa-archway"></i>ARCOS</a>
                    </nav>
                </div>
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

        <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
        <script src="javascript/vendors/popper.min.js"></script>
        <script src="javascript/vendors/bootstrap.min.js"></script>
        <script src="javascript/slide_menu.js"></script>
        <script src="javascript/main.js"></script>

        <!-- DataTable -->
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jq-3.3.1/dt-1.10.21/datatables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js"></script>    
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.print.min.js"></script>
        <script src="<c:url value="/javascript/dataTables.export.js"/>"></script>  

        <script type="text/javascript">
                         $(document).ready(function () {
                             var tabla = $('#example').DataTable({
                                 "dom": 'Bfrtip',
                                 "buttons": [
                                     {extend: 'print',
                                         exportOptions: {orthogonal: "exportPrint"},
                                         text: '<i class="fas fa-print"></i>'
                                     },
                                     {extend: 'excelHtml5',
                                         exportOptions: {orthogonal: "exportXLS"},
                                         text: '<i class="fa fa-file-excel"></i>'
                                     },
                                     {extend: 'pdfHtml5',
                                         exportOptions: {orthogonal: "exportPDF"},
                                         text: '<i class="fas fa-file-pdf"></i>'
                                     }
                                 ],
                                 "pagingType": "full",
                                 language: {
                                     "sProcessing": "Procesando...",
                                     "sLengthMenu": "Mostrar _MENU_ registros",
                                     "sZeroRecords": "No se encontraron resultados",
                                     "sEmptyTable": "Ningún dato disponible en esta tabla",
                                     "sInfo": "Mostrando _END_ de _TOTAL_ registros",
                                     "sInfoEmpty": "Mostrando 0 de 0 registros",
                                     "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                                     "sInfoPostFix": "",
                                     "sSearch": "Buscar:",
                                     "sUrl": "",
                                     "sInfoThousands": ",",
                                     "sLoadingRecords": "Cargando...",
                                     oPaginate: {
                                         sNext: '<i class="fa fa-forward"></i>',
                                         sPrevious: '<i class="fa fa-backward"></i>',
                                         sFirst: '<i class="fa fa-step-backward"></i>',
                                         sLast: '<i class="fa fa-step-forward"></i>'
                                     },
                                     "oAria": {
                                         "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                                         "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                                     }

                                 },
                                 "pageLength": 100,
                                 "ajax": {
                                     "url": "getListaBlanca.htm",
                                     "dataSrc": ""
                                 },
                                 "columns": [
                                     {"data": "fecha_i_fecha_f"},
                                     {"data": "placa_niv"},
                                     {"data": "Motivo"},
                                     {"data": null,
                                         render: function (data, type, row) {
                                             if (type === 'exportPDF' || type === 'exportXLS' || type === 'exportPrint') {
                                                 return row.Estado_registro;
                                             }
                                             if (row.Estado_registro === "Activo") {
                                                 return "<input type='checkbox' data-id='" + data.Id_lista + "' checked='checked'>";
                                             } else {
                                                 return "<input type='checkbox' data-id='" + data.Id_lista + "'>";
                                             }
                                         }
                                     },
                                     {"data": null,
                                         render: function (data, type, row) {
                                             return "<div style='display:flex; margin-left: 30px;'>" +
                                                     "<button class='btn btn-link btn-search' data-id='" + data.Id_lista + "'>" +
                                                     "<i class='fas fa-search'></i>" +
                                                     "</button>" +
                                                     "<button  class='btn btn-link btn-update' data-id='" + data.Id_lista + "'>" +
                                                     "<i class='fas fa-edit'></i>" +
                                                     "</button>" +
                                                     "</div>";
                                         }
                                     }
                                 ]
                             });
                             new $.fn.dataTable.Buttons(tabla);
                             tabla.buttons().container().appendTo('#buttons');
                             $("#table-footer").append($(".dataTables_info"));
                             var exportXML = $('<button id="exportXML" class="buttons"><i class="fas fa-file-code"></i></button>');
                             var exportW = $('<button id="exportW" class="buttons"><i class="fas fa-file-word"></i></button>');
                             exportXML.appendTo($(".dt-buttons"));
                             exportW.appendTo($(".dt-buttons"));
                             var select = $('<div style="display:inline-flex; margin-left:8px; font-size:11px; padding-top: 8px; white-space: nowrap; float:right;" >Mostrar últimos <select id="change" class="form-control"><option value="100">100</option><option value="500">500</option><option value="1000">1000</option><option value="2500">2500</option><option value="5000">5000</option></select> registros</div>');
                             select.appendTo("#table-footer");
                             $("#table-footer").append($(".dataTables_paginate"));

                             $('body').on('click', '#exportW', function (e) {

                                 $.fn.DataTable.Export.word(tabla, {
                                     filename: 'Reporte_lista_blanca_detalle',
                                     title: 'Reporte lista blanca detalle',
                                     fields: [
                                         "fecha_i_fecha_f",
                                         "placa_niv",
                                         "Motivo",
                                         "Estado_registro"
                                     ]
                                 });
                             });
                             $('body').on('click', '#exportXML', function (e) {
                                 $.fn.DataTable.Export.xml(tabla, {
                                     filename: 'Reporte_lista_blanca_detalle',
                                     title: 'Reporte lista blanca detalle',
                                     fields: [
                                         "fecha_i_fecha_f",
                                         "placa_niv",
                                         "Motivo",
                                         "Estado_registro"
                                     ]
                                 });
                             });

                             $(document).on("click", "#change", function () {
                                 var length = $("#change").val();
                                 tabla.page.len(length).draw();
                             });
                             // filtar en la tabla 
                             $('#searchList').keyup(function () {
                                 tabla.search($(this).val()).draw();
                             });
                             $('.f_arcos').hide();
                         });

                         //AJAX PARA LLENAR TABLA CUANDO SE CARGUE EL DOCUMENTO                
                         //cargarListaBlanca();
        </script>  
        <script>

            $(function () {
                $('[name="optRadioReg"]').change(function () {
                    if ($(this).is(':checked')) {

                        $("#modFechaInicial").removeAttr('required');
                        $("#modFechaFinal").removeAttr('required');
                    } else {

                        $("#modFechaInicial").attr('required', 'required');
                        $("#modFechaFinal").attr('required', 'required');
                    }
                });
            });
            $('#btnNuevoRegistro').click(function (e) {
                $('.t_arcos').hide();
                $('.f_arcos').show();
            });
            $('#volver').click(function (e) {
                $('.f_arcos').hide();
                $('.t_arcos').show();
            });
            $('#formLista').submit(function (e) {
                e.preventDefault();
                e.stopImmediatePropagation();

                 
                var form = $(this);                
                var f = $('form')[0];
                var btn =$("#guardar");                
                    btn.prop('disabled', true);
                    setTimeout(function (){
                       btn.prop('disabled',false); 
                    },1000); 
                if (f.checkValidity()) {
                    var checkboxes = $(this).find('input[type="checkbox"]');
                    $.each(checkboxes, function (key, value) {
                        if (value.checked === false) {
                            value.value = false;
                        } else {
                            value.value = true;
                        }
                    });
                    $.ajax({
                        type: "POST",
                        url: "insertarListaBlanca.htm",
                        data: form.serialize(),
                        success: function (data)
                        {
                            console.log(data);
                            $('.t_arcos').show();
                            $('.f_arcos').hide();
                            $('#formLista').trigger("reset");
                            $('#example').DataTable().ajax.reload();
                            //cargarListaNegra();
                        }
                    });
                } else {
                    console.log("No valido");
                }
                return false;

            });

            //update estado
            $('#example').on('click', 'input[type=checkbox]', function () {
                var id_lista = $(this).data('id');
                var check = 0;
                var act = 'D';

                if ($(this).is(':checked')) {
                    check = 1;

                } else {
                    check = 2;
                }
                $.ajax({
                    type: "POST",
                    url: "actualizar_edoBlanca.htm",
                    data: {"id_lista": id_lista,
                        "check": check,
                        "act": act},
                    success: function (data)
                    {
                        console.log(data);

                    }
                });
            });

            $('#example').on('click', '.btn-search', function () {
                var id_lista = $(this).data('id');
                console.log(id_lista);
                $('.t_arcos').hide();
                $('.f_arcos').show();

                $.ajax({
                    url: 'getRegitroByIdBlanca.htm',
                    type: 'GET',
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
                    dataType: 'json',
                    data: {"id_lista": id_lista},
                    success: function (json) {
                        console.log("entra");
                        if ((json[0].Reg_permanente != true)) {
                            $('#modFechaInicial').val(json[0].Fech_hr_ini);
                            $('#modFechaFinal').val(json[0].Fech_hr_fin);
                        } else {
                            $('#modFechaInicial').val("0000-00-00 00:00:00");
                            $('#modFechaFinal').val("0000-00-00 00:00:00");
                        }
                        json[0].Reg_permanente === true ? $("#optRadioReg").prop("checked", true) : $("#optRadioReg").prop("checked", false);
                        $('#niv').val(json[0].Niv);
                        $('#placa').val(json[0].Placa);
                        $('#motivo').val(json[0].Motivo);
                        json[0].CAD === true ? $("#cad").prop("checked", true) : $("#cad").prop("checked", false);
                        json[0].UDAI === true ? $("#udai").prop("checked", true) : $("#udai").prop("checked", false);
                        $('#selectNegra').val(json[0].fk_udai);
                    },
                    error: function (xhr, status) {
                        console.log('Disculpe, existió un problema');
                    },
                    complete: function (xhr, status) {
                        console.log('Petición realizada');
                    }
                });

                $('#guardar').prop('disabled', 'disabled');
            });

            $('#example').on('click', '.btn-update', function () {
                var id_lista = $(this).data('id');
                console.log(id_lista);
                $('.t_arcos').hide();
                $('.f_arcos').show();
                if (!$("#optRadioReg").is(':checked')) {
                    $("#modFechaInicial").removeAttr('required');
                    $("#modFechaFinal").removeAttr('required');
                } else {
                    $("#modFechaInicial").attr('required', 'required');
                    $("#modFechaFinal").attr('required', 'required');
                }
                $.ajax({
                    url: 'getRegitroByIdBlanca.htm',
                    type: 'GET',
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
                    dataType: 'json',
                    data: {"id_lista": id_lista},
                    success: function (json) {
                        console.log("entra al update");
                        //$('#modFechaInicial').val(B);
                        $('#act').val('U');
                        $('#id_lista').val(json[0].Id_lista);
                        $('#edo_registro').val(json[0].Estado);
                        if ((json[0].Reg_permanente != true)) {
                            $('#modFechaInicial').val(json[0].Fech_hr_ini);
                            $('#modFechaFinal').val(json[0].Fech_hr_fin);
                        } else {
                            $('#modFechaInicial').val("0000-00-00 00:00:00");
                            $('#modFechaFinal').val("0000-00-00 00:00:00");
                        }
                        json[0].Reg_permanente === true ? $("#optRadioReg").prop("checked", true) : $("#optRadioReg").prop("checked", false);
                        $('#niv').val(json[0].Niv);
                        $('#placa').val(json[0].Placa);
                        $('#motivo').val(json[0].Motivo);
                        json[0].CAD === true ? $("#cad").prop("checked", true) : $("#cad").prop("checked", false);
                        json[0].UDAI === true ? $("#udai").prop("checked", true) : $("#udai").prop("checked", false);
                        $('#selectNegra').val(json[0].fk_udai);
                    },
                    error: function (xhr, status) {
                        console.log('Disculpe, existió un problema');
                    },
                    complete: function (xhr, status) {
                        console.log('Petición realizada');
                    }
                });

            });

            $("#searchDateRange").click(function () {
                var tabla = $('#example').DataTable();
                var date_start = $("#fecha_inicial").val();
                var date_end = $("#fecha_final").val();
                var tipo_lista = $("#tipoLista").val();

                $.ajax({
                    url: 'searchRange.htm',
                    type: 'GET',
                    data: {"fecha_ini": date_start, "fecha_fin": date_end, "id_tipo_lista": tipo_lista},
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
                    dataType: 'json',
                    success: function (json) {
                        tabla.clear().rows.add(json).draw();
                        console.log(json);
                    }
                });
            });

        </script>
    </body>

</html>