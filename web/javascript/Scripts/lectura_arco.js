/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


   // Metodo para realizar la consulta del boton Buscar
$('#Buscar').submit(function (evento) {
    evento.preventDefault();

    var fecha_inicial = $("#fecha_inicial").val();
    var fecha_final = $("#fecha_final").val();
    var warning = $("#filter-warning").is(':checked');
    var info = $("#filter-info").is(':checked');
    var danger = $("#filter-danger").is(':checked');
    var id_arco = $("#check_arco").val();
    var Motocicleta = $("#Motocicleta").is(':checked');
    var Carro = $("#Carro").is(':checked');
    var Taxi = $("#Taxi").is(':checked');
    var Camion = $("#Camion").is(':checked');
    var Camioneta = $("#Camioneta").is(':checked');
    var color = $("#check-color").val().replace("_", " ");

    var fecha_inicial1 = fecha_inicial.slice(0, 10) + ' ' + fecha_inicial.slice(11, 16);
    var fecha_final1 = fecha_final.slice(0, 10) + ' ' + fecha_final.slice(11, 16);
    console.log("color",color.replace("_", " "));
    console.log("Carro",Carro);
    console.log("fecha_inicial1",fecha_inicial1);
    console.log("fecha_final1",fecha_final1)
    $.ajax({
        url: 'consultar_alertas_arcos.htm',
        type: 'POST',
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
        dataType: "json",
        data: {fecha_inicial: fecha_inicial1,
            fecha_final: fecha_final1,
            warning: warning,
            info: info,
            danger: danger,
            id_arco: id_arco,
            Motocicleta: Motocicleta,
            Carro: Carro,
            Taxi: Taxi,
            Camion: Camion,
            Camioneta: Camioneta,
            color: color},
        success: function (data) {
            console.log("Aqui esta");
            console.log(data);

            var datos;
            var fuente;

            console.log("Alertas: ",Object.keys(data).length);
            if(Object.keys(data).length == 0){
                datos = datos + '<tr>' +
                        '<td>    </td>' +
                        '<td>    </td>' +
                        '<td>    </td>'+
                        '<td>    </td>'+
                        '</tr>';
            }else{
                for (i in data) {
                if (data[i].fuente == null) {
                    fuente = ''
                } else {
                    fuente = data[i].fuente;
                }
                 let icon;
                 if (data[i].tipo_registro == '3') {
                     icon = '<i class="fas fa-times-circle"></i>';
                 } else if (data[i].tipo_registro == '2') {
                     icon = '<i class="fas fa-exclamation-triangle"></i>';

                 } else if (data[i].tipo_registro == '1') {
                     icon = '<i class="fas fa-info-circle"></i>';

                 }
                 datos = datos + '<tr>' +
                         '<td>' + icon + '</td>' +
                         '<td>' +
                         '<p>' + data[i].fecha_hora + '</p>' +
                         '<a href="#" onClick="goToArco(' + data[i].id_arco + ', ' + data[i].tipo_registro + ')">' + data[i].nombre_arco + '</a>' +
                         //'<a href="#" onclick="goToCoords(`' + data[i].coordenadas + '`)">' + data[i].nombre_arco + '</a>' +
                         '</td>' +
                         '<td>' +
                         data[i].placa +
                         '</td>' +
                         '<td>' +
                         data[i].descripcion +
                         '</td>' +
                         '<td>' +
                         fuente +
                         '</td>' +
                         '</tr>';
             }
            }


            $("#tbAlertasVehiculos").html(datos);
        }, error: function (error) {
            console.log("Aqui esta2");
            console.log(error);
        }

    })

});

// Metodo para realizar el PDF
$('#PDF').click(function (evento) {
    evento.preventDefault();
    var fecha_inicial = $("#fecha_inicial").val();
    var fecha_final = $("#fecha_final").val();
    var warning = $("#filter-warning").is(':checked');
    var info = $("#filter-info").is(':checked');
    var danger = $("#filter-danger").is(':checked');
    var id_arco = $("#check_arco").val();
    var Motocicleta = $("#Motocicleta").is(':checked');
    var Carro = $("#Carro").is(':checked');
    var Taxi = $("#Taxi").is(':checked');
    var Camion = $("#Camion").is(':checked');
    var Camioneta = $("#Camioneta").is(':checked');
    var color = $("#check-color").val().replace("_", " ");


    var fecha_inicial1 = fecha_inicial.slice(0, 10) + ' ' + fecha_inicial.slice(11, 16);
    var fecha_final1 = fecha_final.slice(0, 10) + ' ' + fecha_final.slice(11, 16);


    $.ajax({
        url: 'consultar_alertas_arcos.htm',
        type: 'POST',
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
        dataType: "json",
        data: {fecha_inicial: fecha_inicial1,
            fecha_final: fecha_final1,
            warning: warning,
            info: info,
            danger: danger,
            id_arco: id_arco,
            Motocicleta: Motocicleta,
            Carro: Carro,
            Taxi: Taxi,
            Camion: Camion,
            Camioneta: Camioneta,
            color: color},
        success: function (data) {
            console.log("Aqui esta");
            console.log(data);

            var datos = '<div><tbody id="tbAlertasVehiculos">';
            datos = datos + '<thead> <th>'
            var fuente;
            for (i in data) {
                if (data[i].fuente == null) {
                    fuente = '';
                } else {
                    fuente = data[i].fuente;
                }
                if (data[i].tipo_registro == '3') {
                    datos = datos + '<tr>' +
                            '<td>' +
                            '<i class="fas fa-times-circle"></i>' +
                            '</td>' +
                            '<td>' +
                            '<p>' + data[i].fecha_hora + '</p>' +
                            '<p>' + data[i].nombre_arco + '</p>' +
                            '</td>' +
                            '<td>' +
                            data[i].placa +
                            '</td>' +
                            '<td>' +
                            data[i].descripcion +
                            '</td>' +
                            '<td>' +
                            fuente +
                            '</td>' +
                            '</tr>';
                    $("#tbDatosAlerta").html(datos);
                } else if (data[i].tipo_registro == '2') {
                    datos = datos + '<tr>' +
                            '<td>' +
                            '<i class="fas fa-exclamation-triangle"></i>' +
                            '</td>' +
                            '<td>' +
                            '<p>' + data[i].fecha_hora + '</p>' +
                            '<p>' + data[i].nombre_arco + '</p>' +
                            '</td>' +
                            '<td>' +
                            data[i].placa +
                            '</td>' +
                            '<td>' +
                            data[i].descripcion +
                            '</td>' +
                            '<td>' +
                            fuente +
                            '</td>' +
                            '</tr>';
                    $("#tbDatosAlerta").html(datos);
                } else if (data[i].tipo_registro == '1') {
                    datos = datos + '<tr>' +
                            '<td>' +
                            '<i class="fas fa-info-circle"></i>' +
                            '</td>' +
                            '<td>' +
                            '<p>' + data[i].fecha_hora + '</p>' +
                            '<p>' + data[i].nombre_arco + '</p>' +
                            '</td>' +
                            '<td>' +
                            data[i].placa +
                            '</td>' +
                            '<td>' +
                            data[i].descripcion +
                            '</td>' +
                            '<td>' +
                            fuente +
                            '</td>' +
                            '</tr>';
                    $("#tbDatosAlerta").html(datos);
                }
            }

            var sTable = document.getElementById('tablaPDF').innerHTML;
            var style = "<style>";
            style = style + "table {width: 100%;font: 17px Calibri;}";
            style = style + "table, th, td {border: solid 1px #DDD; border-collapse: collapse;";
            style = style + "padding: 2px 3px;text-align: center;}";
            style = style + "</style>";

            // CREATE A WINDOW OBJECT.
            var win = window.open('', '', 'height=700,width=700');

            var f = new Date();
            win.document.write('Fecha del reporte: ' + f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear() + ' - ' + f.getHours() + ':' + f.getMinutes() + ':' + f.getSeconds());

            win.document.write('<html><head>' +
                    '<link rel="stylesheet" href="css/main.min.css" />' +
                    '<link rel="stylesheet" href="css/bootstrap.min.css">');
            win.document.write('<title>Lecturas de arcos</title>');   // <title> FOR PDF HEADER.
            win.document.write(style);
            win.document.write('</head>');
            win.document.write('<body>');
            win.document.write('<br><br><img  src="images/logo-kiotrack-color.png" style="height: 33px; width: 239px;" alt="kiotrack-logo-login">');


            win.document.write('<br><p><b>Arcos: </b></p>');
            win.document.write('<div class="">');
            if (id_arco == 'todos') {
                win.document.write('<p align="left">Todos los Arcos.</p>');
                win.document.write('<p align="right"> Fecha inicial: ' + fecha_inicial + ' - Fecha final: ' + fecha_final + '  Color: '+ color +'</p>');
                win.document.write('</div>');
            } else {
                var nombre_arco = $('#check_arco option:selected').text();
                win.document.write('<p>Nombre del arco: ' + nombre_arco + '</p>');
                win.document.write('<p align="right"> Fecha inicial: ' + fecha_inicial + ' - Fecha final: ' + fecha_final + '</p>');
                win.document.write('</div>');
            }



            var motoPDF;
            if (Motocicleta == true) {
                motoPDF = '<input id="Motocicleta" type="checkbox" class="fas fa-motorcycle check-icon" checked>';
            } else {
                motoPDF = '<input id="Motocicleta" type="checkbox" class="fas fa-motorcycle check-icon">';
            }
            var CarroPDF;
            if (Carro == true) {
                CarroPDF = '<input id="Carro" type="checkbox" class="fas fa-car check-icon" checked>';
            } else {
                CarroPDF = '<input id="Carro" type="checkbox" class="fas fa-car check-icon">';
            }
            var TaxiPDF;
            if (Taxi == true) {
                TaxiPDF = '<input id="Taxi" type="checkbox" class="fas fa-taxi check-icon" checked>';
            } else {
                TaxiPDF = '<input id="Taxi" type="checkbox" class="fas fa-taxi check-icon">';
            }
            var CamionPDF;
            if (Camion == true) {
                CamionPDF = '<input id="Camion" type="checkbox" class="fas fa-bus-alt check-icon" checked>';
            } else {
                CamionPDF = '<input id="Camion" type="checkbox" class="fas fa-bus-alt check-icon">';
            }
            var CamionetaPDF;
            if (Camioneta == true) {
                CamionetaPDF = '<input id="Camioneta" type="checkbox" class="fas fa-truck-pickup check-icon" checked>';
            } else {
                CamionetaPDF = '<input id="Camioneta" type="checkbox" class="fas fa-truck-pickup check-icon">';
            }


            if (warning == true) {
                warningPDF = '<input id="filter-warning" type="checkbox" checked>';
            } else {
                warningPDF = '<input id="filter-warning" type="checkbox">';
            }
            var infoPDF
            if (info == true) {
                infoPDF = '<input id="filter-info" type="checkbox" checked>';
            } else {
                infoPDF = '<input id="filter-info" type="checkbox">';
            }
            var dangerPDF
            if (danger == true) {
                dangerPDF = '<input id="filter-danger" type="checkbox" checked>';
            } else {
                dangerPDF = '<input id="filter-danger" type="checkbox">';
            }



            var filtros = '<div class="">' +
                    '<label class="noselect" for="Buscar">' +
                    '<i class="fas fa-times-circle text-danger"></i>' +
                    dangerPDF +
                    'Critico &nbsp;' +
                    '</label>' +
                    '<label class="noselect" for="Buscar">' +
                    '<i class="fas fa-info-circle text-info"></i>' +
                    infoPDF +
                    'Informativo &nbsp;' +
                    '</label>' +
                    '<label class="noselect" for="Buscar">' +
                    '<i class="fas fa-exclamation-triangle text-warning"></i>' +
                    warningPDF +
                    'Advertencia &nbsp;' +
                    '</label>' +
                    '</div>';


            var tipo_vehiculo = '<div class="container"><div class="row">' +
                    filtros +
                    '<div class="">' +
                    motoPDF +
                    CarroPDF +
                    TaxiPDF +
                    CamionPDF +
                    CamionetaPDF +
                    '</div></div></div><br>';


            win.document.write(tipo_vehiculo);
            win.document.write(sTable);         // THE TABLE CONTENTS INSIDE THE BODY TAG.
            win.document.write('</body></html>');

            win.document.close(); 	// CLOSE THE CURRENT WINDOW.

            win.print();    // PRINT THE CONTENTS.

        }, error: function (error) {
            console.log("Aqui esta2");
            console.log(error);
        }

    })
});

// Metodo para realizar el CSV
$('#CSV').click(function (evento) {
    evento.preventDefault();
    var fecha_inicial = $("#fecha_inicial").val();
    var fecha_final = $("#fecha_final").val();
    var warning = $("#filter-warning").is(':checked');
    var info = $("#filter-info").is(':checked');
    var danger = $("#filter-danger").is(':checked');
    var id_arco = $("#check_arco").val();
    var Motocicleta = $("#Motocicleta").is(':checked');
    var Carro = $("#Carro").is(':checked');
    var Taxi = $("#Taxi").is(':checked');
    var Camion = $("#Camion").is(':checked');
    var Camioneta = $("#Camioneta").is(':checked');
    var color = $("#check-color").val();


    var fecha_inicial1 = fecha_inicial.slice(0, 10) + ' ' + fecha_inicial.slice(11, 16);
    var fecha_final1 = fecha_final.slice(0, 10) + ' ' + fecha_final.slice(11, 16);


    $.ajax({
        url: 'consultar_alertas_arcos.htm',
        type: 'POST',
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
        dataType: "json",
        data: {fecha_inicial: fecha_inicial1,
            fecha_final: fecha_final1,
            warning: warning,
            info: info,
            danger: danger,
            id_arco: id_arco,
            Motocicleta: Motocicleta,
            Carro: Carro,
            Taxi: Taxi,
            Camion: Camion,
            Camioneta: Camioneta,
            color: color},
        success: function (data) {
            console.log("Aqui esta");
            console.log(data);

            var fuente;
            var tipo;
            var csv = 'Fecha inicial:,' + fecha_inicial1 + ', Fecha final: ,' + fecha_final1 + '\n\n';
            csv = csv + 'Arcos,' + id_arco + ', Color:,' + color + '\n\n';
            //csv= csv+ '1. Informativo\n2. Advertencia\n3. Critico\n\n';
            csv = csv + 'Tipo,Fecha y arco,Placa/Niv,Descripcion,Fuente de informacion\n';

            for (i in data) {
                if (data[i].fuente == null) {
                    fuente = '';
                } else {
                    fuente = data[i].fuente;
                }
                if (data[i].tipo_registro == '1') {
                    tipo = 'Informativo';
                } else if (data[i].tipo_registro == '2') {
                    tipo = 'Advertencia';
                } else if (data[i].tipo_registro == '3') {
                    tipo = 'Critico';
                }
                csv = csv + tipo + ', ' + data[i].fecha_hora + ' ' + data[i].nombre_arco + ',' + data[i].placa + ',' + data[i].descripcion + ',' + fuente + '\n';
            }

            var sTable = document.getElementById('tablaPDF').innerHTML;

            console.log(csv);

            var data = $("tablacsv").first(); //Only one table
            var csvData = [];
            var tmpArr = [];
            var tmpStr = '';
            data.find("tr").each(function () {
                var th = $("tablacsv").find("th");
                if (th.length) {
                    th.each(function () {
                        tmpStr = $(this).text().replace(/"/g, '""');
                        tmpArr.push('"' + tmpStr + '"');
                    });
                    csvData.push(tmpArr);
                } else {
                    tmpArr = [];
                    $$("tablacsv").find("td").each(function () {
                        if ($(this).text().match(/^-{0,1}\d*\.{0,1}\d+$/)) {
                            tmpArr.push(parseFloat($(this).text()));
                        } else {
                            tmpStr = $(this).text().replace(/"/g, '""');
                            tmpArr.push('"' + tmpStr + '"');
                        }
                    });
                    csvData.push(tmpArr.join(','));
                }
            });
            console.log(csvData);
            var output = csvData.join('\n');
            var uri = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csv);
            var downloadLink = document.createElement("a");
            downloadLink.href = uri;
            downloadLink.download = document.title ? document.title.replace(/ /g, "_") + ".csv" : "data.csv";
            document.body.appendChild(downloadLink);
            downloadLink.click();
            document.body.removeChild(downloadLink);



        }, error: function (error) {
            console.log("Aqui esta2");
            console.log(error);
        }

    })
});

// Metodo que sirve para actualziar cierto tiempo las alertas de vehiculos y bdd remotas.
// es necesario descomentar --> setInterval(varificar_cambios, 5000);
// para que funcione
$(document).ready(function () {
    console.log("ntro aqui");
    //setInterval(varificar_cambios, 5000);
});



$("#Moto").on("click", function(){
    console.log("Moto");
    if($("#CheckMoto").css("display")=="none"){
        $("#CheckMoto").css("display","block");
        $("#Moto").css("textShadow","white 1px 1px 1px");
    }else{
        $("#CheckMoto").css("display","none");
        $("#Moto").css("textShadow","white 0px 0px 0px");
    }

})

$("#Car").on("click", function(){

    if($("#CheckCar").css("display")=="none"){
        $("#CheckCar").css("display","block");
        $("#Car").css("textShadow","white 1px 1px 1px");
    }else{
        $("#CheckCar").css("display","none");
        $("#Car").css("textShadow","white 0px 0px 0px");
    }

})


$("#Taxi").on("click", function(){
    
    if($("#CheckTaxi").css("display")=="none"){
        $("#CheckTaxi").css("display","block");
        $("#Taxi").css("textShadow","white 1px 1px 1px");
    }else{
        $("#CheckTaxi").css("display","none");
        $("#Taxi").css("textShadow","white 0px 0px 0px");
    }

})

$("#Bus").on("click", function(){
    
    if($("#CheckBus").css("display")=="none"){
        $("#CheckBus").css("display","block");
        $("#Bus").css("textShadow","white 1px 1px 1px");
    }else{
        $("#CheckBus").css("display","none");
        $("#Bus").css("textShadow","white 0px 0px 0px");
    }

})

$("#Truck").on("click", function(){
    
    if($("#CheckTruck").css("display")=="none"){
        $("#CheckTruck").css("display","block");
        $("#Truck").css("textShadow","white 1px 1px 1px");
    }else{
        $("#CheckTruck").css("display","none");
        $("#Truck").css("textShadow","white 0px 0px 0px");
    }

})

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
                promedios_alertas();
                cambio_estados();
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

// Metodo para cambiar el estado de la bandera de 1 a 0 de Alerta Auto y Alerta Arco
function cambio_estados() {
    $.ajax({
        url: 'cambio_estado_tablero.htm',
        type: 'POST',
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
        dataType: "json",
        success: function (data) {
            console.log("Cambio los datos....")
        }, error: function (error) {
            console.log("Aqui esta2");
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
            $('#ProgressAdvertencia').css('width', data.Informativo + '%');
            $('#ProgressCritico').css('width', data.Informativo + '%');
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
            } else {
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
            console.log("Cambio los datos....");
        }, error: function (error) {
            console.log("Aqui esta2");
            console.log(error);
        }
    })
}

