/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
 // Metodo para realizar la busqueda
        $('#Aceptar').submit(function (evento) {
        evento.preventDefault();

        // Valores de entrada
        var placa_niv = $("#placa_niv").val();
        var check_niv = $("#check_niv").is(':checked');
        var check_placa = $("#check_placa").is(':checked');
        var warning = $("#filter-warning").is(':checked');
        var info = $("#filter-info").is(':checked');
        var danger = $("#filter-danger").is(':checked');
        var fecha_inicial = $("#fecha_hora_inicial").val();
        var fecha_final = $("#fecha_hora_final").val();
        var id_arco = $("#check_arco").val();
        var fecha_inicial1 = fecha_inicial.slice(0, 10) + ' ' + fecha_inicial.slice(11, 16);
        var fecha_final1 = fecha_final.slice(0, 10) + ' ' + fecha_final.slice(11, 16);
        $.ajax({

        url: 'consultar_vehiculo.htm',
                type: 'POST',
                cache: false,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
                dataType: "json",
                data: {
                placa: $("#placa_niv").val(),
                        check_niv: check_niv,
                        check_placa: check_placa,
                        warning: warning,
                        info: info,
                        danger: danger,
                        fecha_inicial: fecha_inicial1,
                        fecha_final: fecha_final1,
                        id_arco: id_arco},
                success: function (data) {
                // Valores de salida
                $("#TipoVehiculo").html(data.DatosVehiculo.Tipo);
                $("#Marca").html(data.DatosVehiculo.Marca);
                $("#Color").html(data.DatosVehiculo.Color);
                $("#Placa").html(data.DatosVehiculo.Placa);
                $("#Niv").html(data.DatosVehiculo.niv);
                var datos;
                var fuente;

                if (Object.keys(data.DatosAlerta).length == 0){
                console.log("no hay datos");
                        datos = datos + '<tr>' +
                        '<td>    </td>' +
                        '<td>    </td>' +
                        '<td>    </td>' +
                        '</tr>';
                } else{
                for (index in data.DatosAlerta) {
                let alerta = data.DatosAlerta[index];
                        if (alerta.fuente == null) {
                fuente = ''
                } else {
                fuente = alerta.fuente;
                }
                let icon;
                        if (alerta.tipo_registro == '1') {
                icon = '<i class="fas fa-info-circle"></i>';
                } else if (alerta.tipo_registro == '2') {
                icon = '<i class="fas fa-exclamation-triangle"></i>';
                } else if (alerta.tipo_registro == '3') {
                icon = '<i class="fas fa-times-circle"></i>';
                }
                console.log(alerta);
                        datos = datos + '<tr>' +
                        '<td>' + icon + '</td>' +
                        '<td>' +
                        '<p>' + alerta.fecha_hora + '</p>' +
                        '<a href="#" onClick="goToArco(' + alerta.id_arco + ', ' + alerta.tipo_registro + ')">' + alerta.nombre_arco + '</a>' +
                        '</td>' +
                        '<td>' +
                        alerta.Descripcion +
                        '</td>' +
                        '<td>' +
                        fuente +
                        '</td>' +
                        '</tr>';
                }

                }
                $("#tbDatosAlerta").html(datos);
                }, error: function (error) {
        console.log("Aqui esta2");
                console.log(error);
        }

        })

});

// Metodo para la creacion de PDF
    $('#PDF').click(function (evento) {
evento.preventDefault();
    var placa_niv = $("#placa_niv").val();
    var check_niv = $("#check_niv").is(':checked');
    var check_placa = $("#check_placa").is(':checked');
    var warning = $("#filter-warning").is(':checked');
    var info = $("#filter-info").is(':checked');
    var danger = $("#filter-danger").is(':checked');
    var fecha_inicial = $("#fecha_hora_inicial").val();
    var fecha_final = $("#fecha_hora_final").val();
    var id_arco = $("#check_arco").val();
    var fecha_inicial1 = fecha_inicial.slice(0, 10) + ' ' + fecha_inicial.slice(11, 16);
    var fecha_final1 = fecha_final.slice(0, 10) + ' ' + fecha_final.slice(11, 16);
    $.ajax({

    url: 'consultar_vehiculo.htm',
            type: 'POST',
            cache: false,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
            dataType: "json",
            data: {
            placa: $("#placa_niv").val(),
                    check_niv: check_niv,
                    check_placa: check_placa,
                    warning: warning,
                    info: info,
                    danger: danger,
                    fecha_inicial: fecha_inicial1,
                    fecha_final: fecha_final1,
                    id_arco: id_arco},
            success: function (data) {
            console.log(Object.keys(data.DatosAlerta).length);
                    var datos;
                    var fuente;
                    for (i in data.DatosAlerta) {
            if (data.DatosAlerta[i].fuente == null) {
            fuente = ''
            } else {
            fuente = data.DatosAlerta[i].fuente;
            }

            if (data.DatosAlerta[i].tipo_registro == '1') {
            datos = datos + '<tr>' +
                    '<td>' +
                    '<i class="fas fa-info-circle"></i>' +
                    '</td>' +
                    '<td>' +
                    '<p>' + data.DatosAlerta[i].fecha_hora + '</p>' +
                    '<p>' + data.DatosAlerta[i].nombre_arco + '</p>' +
                    '</td>' +
                    '<td>' +
                    data.DatosAlerta[i].Descripcion +
                    '</td>' +
                    '<td>' +
                    fuente +
                    '</td>' +
                    '</tr>';
                    $("#tbDatosAlerta").html(datos);
            } else if (data.DatosAlerta[i].tipo_registro == '2') {
            datos = datos + '<tr>' +
                    '<td>' +
                    '<i class="fas fa-exclamation-triangle"></i>' +
                    '</td>' +
                    '<td>' +
                    '<p>' + data.DatosAlerta[i].fecha_hora + '</p>' +
                    '<p>' + data.DatosAlerta[i].nombre_arco + '</p>' +
                    '</td>' +
                    '<td>' +
                    data.DatosAlerta[i].Descripcion +
                    '</td>' +
                    '<td>' +
                    fuente +
                    '</td>' +
                    '</tr>';
                    $("#tbDatosAlerta").html(datos);
            } else if (data.DatosAlerta[i].tipo_registro == '3') {
            datos = datos + '<tr>' +
                    '<td>' +
                    '<i class="fas fa-times-circle"></i>' +
                    '</td>' +
                    '<td>' +
                    '<p>' + data.DatosAlerta[i].fecha_hora + '</p>' +
                    '<p>' + data.DatosAlerta[i].nombre_arco + '</p>' +
                    '</td>' +
                    '<td>' +
                    data.DatosAlerta[i].Descripcion +
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
                    win.document.write('<title>Lectura vehículo</title>'); // <title> FOR PDF HEADER.
                    win.document.write(style);
                    win.document.write('</head>');
                    win.document.write('<body>');
                    win.document.write('<br><br><img  src="images/logo-kiotrack-color.png" style="height: 33px; width: 239px;" alt="kiotrack-logo-login">');
                    win.document.write('<br><p><b>Arcos: </b></p>');
                    if (id_arco == 'todos') {
            win.document.write('<p align="left">Todos los Arcos.</p>');
                    win.document.write('<p align="right"> Fecha inicial: ' + fecha_inicial + ' - Fecha final: ' + fecha_final + '</p>');
                    win.document.write('</div>');
            } else {
            var nombre_arco = $('#check_arco option:selected').text();
                    win.document.write('<p>Nombre del arco: ' + nombre_arco + '</p>');
                    win.document.write('<p align="right"> Fecha inicial: ' + fecha_inicial + ' - Fecha final: ' + fecha_final + '</p>');
                    win.document.write('</div>');
            }


            if (check_niv == true) {
            var placa_niv = '<div class="">' +
                    '<label for="Aceptar">' +
                    '<input name="check" id="check_niv" type="radio" checked>' +
                    'NIV:' + $("#placa_niv").val() +
                    '</label><br>';
            }
            if (check_placa == true) {
            var placa_niv = '<div class="">' +
                    '<label for="Aceptar">' +
                    '<input name="check" id="check_placa" type="radio" checked>' +
                    'PLACA' + $("#placa_niv").val() +
                    '</label>' +
                    '</div>';
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



            var filtros = '<div class="" align="center">' +
                    placa_niv + '        ' +
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
                    win.document.write('<div class="container">' + filtros + '</div><br>'); // THE TABLE CONTENTS INSIDE THE BODY TAG.
                    win.document.write(sTable); // THE TABLE CONTENTS INSIDE THE BODY TAG.
                    win.document.write('</body></html>');
                    win.document.close(); // CLOSE THE CURRENT WINDOW.

                    win.print(); // PRINT THE CONTENTS.

            }, error: function (error) {
    console.log("Aqui esta2");
            console.log(error);
    }

    })

});

// Metodo para la creacion de CSV
    $('#CSV').click(function (evento) {
evento.preventDefault();
    var placa_niv = $("#placa_niv").val();
    var check_niv = $("#check_niv").is(':checked');
    var check_placa = $("#check_placa").is(':checked');
    var warning = $("#filter-warning").is(':checked');
    var info = $("#filter-info").is(':checked');
    var danger = $("#filter-danger").is(':checked');
    var fecha_inicial = $("#fecha_hora_inicial").val();
    var fecha_final = $("#fecha_hora_final").val();
    var id_arco = $("#check_arco").val();
    var fecha_inicial1 = fecha_inicial.slice(0, 10) + ' ' + fecha_inicial.slice(11, 16);
    var fecha_final1 = fecha_final.slice(0, 10) + ' ' + fecha_final.slice(11, 16);
    $.ajax({

    url: 'consultar_vehiculo.htm',
            type: 'POST',
            cache: false,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8;",
            dataType: "json",
            data: {
            placa: $("#placa_niv").val(),
                    check_niv: check_niv,
                    check_placa: check_placa,
                    warning: warning,
                    info: info,
                    danger: danger,
                    fecha_inicial: fecha_inicial1,
                    fecha_final: fecha_final1,
                    id_arco: id_arco},
            success: function (data) {
            console.log(Object.keys(data.DatosAlerta).length);
                    var datos;
                    var fuente;
                    var csv = ',Consulta de lectura por placa,Fecha reporte:,' + + '\n\n';
                    csv = csv + ',,Datos del vehiculo\n';
                    csv = csv + 'Tipo de vehiculo,Marca,Color,Placa,NIV\n';
                    csv = csv + data.DatosVehiculo.Tipo + ',' + data.DatosVehiculo.Marca + ',' + data.DatosVehiculo.Color + ',' + data.DatosVehiculo.Placa + ',' + data.DatosVehiculo.niv + '\n\n';
                    csv = csv + ',,Filtros\n';
                    csv = csv + 'Arcos,Fecha inicial, Fecha final\n';
                    csv = csv + id_arco + ',' + fecha_inicial1 + ',' + fecha_final1 + '\n\n';
                    csv = csv + 'Tipo,Fecha y hora, Arco,Descripcion,Fuente de informacion\n';
                    for (i in data.DatosAlerta) {
            if (data.DatosAlerta[i].fuente == null) {
            fuente = ''
            } else {
            fuente = data.DatosAlerta[i].fuente;
            }

            if (data.DatosAlerta[i].tipo_registro == '1') {
            tipo = 'Informativo';
            } else if (data.DatosAlerta[i].tipo_registro == '2') {
            tipo = 'Advertencia';
            } else if (data.DatosAlerta[i].tipo_registro == '3') {
            tipo = 'Critico';
            }

            csv = csv + tipo + ',' + data.DatosAlerta[i].fecha_hora + ',' + data.DatosAlerta[i].nombre_arco + ',' + data.DatosAlerta[i].Descripcion + ',' + fuente + '\n';
            }


            console.log(csv);
                    var data = $("tablacsv").first(); //Only one table
                    var csvData = [];
                    var tmpArr = [];
                    var tmpStr = '';
                    data.find("tr").each(function () {
            var th = $("tablacsv").find("th");
                    if (th.length) {
            th.each(function () {
            tmpStr = $("tablacsv").text().replace(/"/g, '""');
                    tmpArr.push('"' + tmpStr + '"');
            });
                    csvData.push(tmpArr);
            } else {
            tmpArr = [];
                    $("tablacsv").find("td").each(function () {
            if ($("tablacsv").text().match(/^-{0,1}\d*\.{0,1}\d+$/)) {
            tmpArr.push(parseFloat($("tablacsv").text()));
            } else {
            tmpStr = $("tablacsv").text().replace(/"/g, '""');
                    tmpArr.push('"' + tmpStr + '"');
            }
            });
                    csvData.push(tmpArr.join(','));
            }
            });
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
