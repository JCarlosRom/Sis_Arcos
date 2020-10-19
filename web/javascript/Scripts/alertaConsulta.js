/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
       $.ajax({
        url: 'getAlertas.htm',
        type: 'POST',
        cache: false,
        contentType: "application/json; charset=UTF-8;",
        dataType: "json",
        success: function (data) {
            
            console.log(data);
            
            
            var Alertas = "";
            cont= 0;
            $.each(data, function( index, value ) { 
                
               

                Alertas +=  '<div class="col-md-12" id=Alerta'+value["idAlerta"]+' style="position:absolute; margin-top:'+(10*cont)+'px; margin-left: -'+(10*cont)+'px;">'+
                                '<div  class="notificationAlert">'+
                                    '<div class="container">'+
                                        '<div class="row">'+
                                            '<div class="col-md-5"></div>'+
                                            '<div class="col-md-2">'+
                                                '<i class="fas fa-exclamation-triangle" style="color:red; margin-left: auto; margin-right: auto; font-size: 32px; margin-top:10px; margin-bottom:10px;"></i>'+
                                            '</div>'+
                                            '<div class="col-md-5"></div>'+
                                        '</div>'+
                                        '<p style="text-align:center">'+value["alertaNombre"]+'</p>'+

                                        '<hr style="width:100%; color:white; border-top: 1px solid rgb(247, 243, 243); margin-top: 10px; margin-bottom: 10px;">'+

                                        '<p style="text-align:center">Alerta reportada en Arco Tulum </p>'+

                                        '<div class="row">'+
                                            '<div class="col-md-6">'+
                                                '<div class="row">'+
                                                    '<div class="col-md-2">'+
                                                        '<i class="fa fa-calendar" style="color:white;"></i>'+
                                                    '</div>'+
                                                    '<div class="col-md-9">'+
                                                        '<p> <span style="font-weight:bold;">Fecha:</span> '+value["alertaFecha"]+'</p>'+
                                                    '</div>'+
                                                '</div>'+
                                            '</div>'+

                                            '<div class="col-md-6">'+
                                                '<div class="row">'+
                                                    '<div class="col-md-2">'+
                                                        '<i class="fas fa-clock" style="color:white;"></i>'+
                                                    '</div>'+
                                                    '<div class="col-md-9">'+
                                                        '<p><span style="font-weight:bold;">Hora:</span> '+value["alertaHora"]+'</p>'+
                                                    '</div>'+
                                                '</div>'+
                                            '</div>'+
                                        '</div>'+

                                        '<div class="row">'+
                                            '<div class="col-md-6">'+
                                                '<div class="row">'+
                                                    '<div class="col-md-12">'+
                                                        '<p style="margin-bottom:2px !important; font-weight:bold;">Placa:</p>'+
                                                        '<p>'+value["Placa"]+'</p>'+
                                                    '</div>'+
                                                '</div>'+
                                            '</div>'+

                                            '<div class="col-md-6">'+
                                                '<div class="row">'+
                                                    '<div class="col-md-12">'+
                                                        '<p style="margin-bottom:2px !important; font-weight:bold;">Niv:</p>'+
                                                        '<p>'+value["Niv"]+'</p>'+
                                                    '</div>'+
                                                '</div>'+
                                            '</div>'+
                                        '</div>'+

                                        '<div class="row" style="margin-top:10px;">'+
                                            '<div class="col-md-1"></div>'+
                                            '<div class="col-md-5">'+
                                                '<button  onclick="myFunction('+value["idAlerta"]+')" style="border-radius: 8px;background-color: #00567E; color:white; font-size:12px; border-width: 0px; padding: 5px;" id="Cerrar'+value["idAlerta"]+'">Cerrar</button>'+
                                            '</div>'+
                                            '<div class="col-md-5">'+
                                                '<form action="index_detalleAlerta.htm" method="POST">'+
                                                    '<input name="id" value="'+value["idAlerta"]+'" type="hidden"></input>'+
                                                    '<button style="border-radius: 8px;background-color: #00567E; color:white; font-size:12px; border-width: 0px; padding: 5px;">Ver detalles</button>'+
                                                '</form>'+
                                            '</div>'+
                                            '<div class="col-md-1"></div>'+
                                        '</div>'+
                                        '<br>'+
                                    '</div>'+
                                '</div>'+
                            '</div>';
                       cont++;
                

            });
            
            
            
         
            
            $("#alertasNotification").append(Alertas);
         
        }, error: function (error) {
            console.log("Error varificar_cambios()");
            console.log(error);
        }
    });
})

function myFunction(id){
    $("#Alerta"+id).css("display","none");
}

