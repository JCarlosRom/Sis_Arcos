/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


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

});

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