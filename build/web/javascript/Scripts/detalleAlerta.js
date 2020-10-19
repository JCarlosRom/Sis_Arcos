/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$('.dropdown-menu').on('click', function(event){
    // The event won't be propagated up to the document NODE and 
    // therefore delegated events won't be fired
    event.stopPropagation();
});



$(document).ready(function(){
    console.log("ready");
    getDocs();
    getDocsSeguimiento();
})

$("#plataformaMexico").on("click",function(){
    console.log("Modal");
    $("#modalPlataformaMexico").modal("show");
})

$(".formSeguimiento").on("submit", function (e) {
    
    var idAlerta = $(this).attr("id");
    idAlerta = idAlerta.replace("formSeguimiento","");

    e.preventDefault();

    console.log(this);

    $.ajax({
        url: 'uploadDocSeguimiento.htm',
        type: 'post',
        enctype: 'multipart/form-data',
        data: new FormData(this),
        cache: false,
        contentType: false,
        processData: false,
        success: function(response){
            console.log(response);
        },error: function(e){
            console.log(e);
        }
     });
      
    $.ajax({
     url: 'getDocsAlertaSeguimiento.htm',
     type: 'post',
     data: {id:idAlerta},
     success: function(response){
         response = JSON.parse(response);

         console.log(response);

         var docs = "";
         $.each(response, function( index, value ) { 

             var tipo = "";

             if(value["tipo_documento"]==1){
                 tipo = "fa-file";
             }
             if(value["tipo_documento"]==2){
                 tipo = "fa-file-image";
             }
             if(value["tipo_documento"]==3){
                 tipo = "fa-file-video";
             }

             docs +="<li class='list-group-item'>"+
                         "<i class='fas "+tipo+" mr-2 text-primary'></i>"+
                             "<a class='flex-grow-1' href='#' data-toggle='modal' data-target='#modal'>"+value["url_archivo"].replace("D://Users//ADMIN//Desktop//Kiotech//Software//Sis_Arcos-master//web//images//documentos//","")+"</a>"+
                                 "<button type='button' id='"+value["id_documento"]+"' class='btn btn-ico ml-2 btnEliminar'>"+
                                     "<i class='fas fa-trash text-danger' ></i>"+
                                 "</button>"+
                                  "<div class='col-md-2'>"+
                                    "<a href='http://localhost:8080/Sis_Arcos-master/images/documentos/value['url_archivo']' target='_blank'>"+
                                        "<button type='button' id='"+value["id_documento"]+"' class='btn btn-ico'>"+
                                            "<i class='fas fa-search'></i>"+
                                        "</button>"+
                                    "<a>"+
                                 "</div>"+
                             "</li>";
         });

         $("#docsAlertaSeguimiento"+idAlerta).empty();

         $("#docsAlertaSeguimiento"+idAlerta).append(docs);

         $(".btnEliminarSeguimiento").on("click", function(){

             var idAlerta = $("#idAlerta").val();
             var idDocumento = $(this).attr("id");
             console.log(idAlerta);
             console.log(idDocumento);
             console.log("Hello");

                 $.ajax({
                     url: 'eliminarDoc.htm',
                     type: 'post',
                     data: {idAlerta:idAlerta, idDocumento: idDocumento},
                     success: function(response){ 

                         getDocs(idAlerta);

                     },error(e){
                         console.log(e);
                     }

                 });


         })

     },error: function(e){
         console.log(e);
     }

 });

 });



function getDocs(idAlerta){
    console.log(idAlerta);
     $.ajax({
        url: 'getDocsAlerta.htm',
        type: 'post',
        data: {id:idAlerta},
        success: function(response){
            response = JSON.parse(response);

            console.log(response);

            var docs = "";
            $.each(response, function( index, value ) { 

                var tipo = "";

                if(value["tipo_documento"]==1){
                    tipo = "fa-file";
                }
                if(value["tipo_documento"]==2){
                    tipo = "fa-file-image";
                }
                if(value["tipo_documento"]==3){
                    tipo = "fa-file-video";
                }

                url = 'http://localhost:8080/Sis_Arcos-master/images/documentos/'+value['url_archivo'];

                docs +="<li class='list-group-item'>"+
                            "<i class='fas "+tipo+" mr-2 text-primary'></i>"+
                                "<a class='flex-grow-1' href='#' data-toggle='modal' data-target='#modal'>"+value["url_archivo"].replace("D://Users//ADMIN//Desktop//Kiotech//Software//Sis_Arcos-master//web//images//documentos//","")+"</a>"+
                                    "<button type='button' id='"+value["id_documento"]+"' class='btn btn-ico ml-2 btnEliminar' >"+
                                        "<i class='fas fa-trash text-danger' ></i>"+
                                    "</button>"+
                                     "<div class='col-md-2'>"+
                                        "<a href="+url+"  target='_blank'>"+
                                            "<button type='button' class='btn btn-ico'>"+
                                                "<i class='fas fa-search'></i>"+
                                            "</button>"+
                                        "<a>"+
                                    "</div>"+
                                "</li>";
            });

            $("#containerDocs").empty();

            $("#containerDocs").append(docs);

            $(".btnEliminar").on("click", function(){

                var idAlerta = $("#idAlerta").val();
                var idDocumento = $(this).attr("id");
                console.log(idAlerta);
                console.log(idDocumento);
                console.log("Hello");

                    $.ajax({
                        url: 'eliminarDoc.htm',
                        type: 'post',
                        data: {idAlerta:idAlerta, idDocumento: idDocumento},
                        success: function(response){ 
                 
                            getDocs(idAlerta);

                        },error(e){
                            console.log(e);
                        }

                    });


            })

        },error: function(e){
            console.log(e);
        }

    });
    
   $("#modalUploadDocs").on("click", function(){
    
        idAlerta = $("#idAlerta").val();
        console.log(idAlerta);
        $.ajax({
            url: 'getDocsAlerta.htm',
            type: 'post',
            data: {id:idAlerta},
            success: function(response){
                response = JSON.parse(response);
                
                console.log(response);

                var docs = "";
                $.each(response, function( index, value ) { 

                    var tipo = "";

                    if(value["tipo_documento"]==1){
                        tipo = "fa-file";
                    }
                    if(value["tipo_documento"]==2){
                        tipo = "fa-file-image";
                    }
                    if(value["tipo_documento"]==3){
                        tipo = "fa-file-video";
                    }
                    
                    url = 'http://localhost:8080/Sis_Arcos-master/images/documentos/'+value['url_archivo'];

                    docs +="<li class='list-group-item'>"+
                                "<i class='fas "+tipo+" mr-2 text-primary'></i>"+
                                    "<a class='flex-grow-1' href='#' data-toggle='modal' data-target='#modal'>"+value["url_archivo"].replace("D://Users//ADMIN//Desktop//Kiotech//Software//Sis_Arcos-master//web//images//documentos//","")+"</a>"+
                                        "<button type='button' id='"+value["id_documento"]+"' class='btn btn-ico ml-2 btnEliminar' >"+
                                            "<i class='fas fa-trash text-danger' ></i>"+
                                        "</button>"+
                                         "<div class='col-md-2'>"+
                                            "<a href="+url+"  target='_blank'>"+
                                                "<button type='button' class='btn btn-ico'>"+
                                                    "<i class='fas fa-search'></i>"+
                                                "</button>"+
                                            "<a>"+
                                        "</div>"+
                                    "</li>";
                });

                $("#containerDocs").empty();

                $("#containerDocs").append(docs);

                $(".btnEliminar").on("click", function(){

                    var idAlerta = $("#idAlerta").val();
                    var idDocumento = $(this).attr("id");
                    console.log(idAlerta);
                    console.log(idDocumento);
                    console.log("Hello");

                        $.ajax({
                            url: 'eliminarDoc.htm',
                            type: 'post',
                            data: {idAlerta:idAlerta, idDocumento: idDocumento},
                            success: function(response){ 
                                
                                getDocs(idAlerta);

                            },error(e){
                                console.log(e);
                            }

                        });


                })

            },error: function(e){
                console.log(e);
            }

        });
    }) 
    
    $(".btnEliminar").on("click", function(){

        var idAlerta = $("#idAlerta").val();
        var idDocumento = $(this).attr("id");
        console.log(idAlerta);
        console.log(idDocumento);
        console.log("Hello");

            $.ajax({
                url: 'eliminarDoc.htm',
                type: 'post',
                data: {idAlerta:idAlerta, idDocumento: idDocumento},
                success: function(response){ 

                    getDocs(idAlerta);

                },error(e){
                    console.log(e);
                }

            });

    })
}



function getDocsSeguimiento(idAlerta){
    console.log(idAlerta);
     $.ajax({
        url: 'getDocsAlertaSeguimiento.htm',
        type: 'post',
        data: {id:idAlerta},
        success: function(response){
            response = JSON.parse(response);

            console.log(response);

            var docs = "";
            $.each(response, function( index, value ) { 

                var tipo = "";

                if(value["tipo_documento"]==1){
                    tipo = "fa-file";
                }
                if(value["tipo_documento"]==2){
                    tipo = "fa-file-image";
                }
                if(value["tipo_documento"]==3){
                    tipo = "fa-file-video";
                }
                
                url = 'http://localhost:8080/Sis_Arcos-master/images/documentos/Seguimiento/'+value['url_archivo'];

                docs +="<li class='list-group-item'>"+
                            "<i class='fas "+tipo+" mr-2 text-primary'></i>"+
                                "<a class='flex-grow-1' href='#' data-toggle='modal' data-target='#modal'>"+value["url_archivo"].replace("D://Users//ADMIN//Desktop//Kiotech//Software//Sis_Arcos-master//web//images//documentos//","")+"</a>"+
                                    "<button type='button' id='"+value["id_documento"]+"' class='btn btn-ico ml-2 btnEliminar'>"+
                                        "<i class='fas fa-trash text-danger' ></i>"+
                                    "</button>"+
                                     "<div class='col-md-2'>"+
                                        "<a href="+url+" target='_blank'>"+
                                            "<button type='button' class='btn btn-ico'>"+
                                                "<i class='fas fa-search'></i>"+
                                            "</button>"+
                                        "<a>"+
                                    "</div>"+
                                "</li>";
            });

            $("#docsAlertaSeguimiento"+idAlerta).empty();

            $("#docsAlertaSeguimiento"+idAlerta).append(docs);

            $(".btnEliminarSeguimiento").on("click", function(){

                var idAlerta = $("#idAlerta").val();
                var idDocumento = $(this).attr("id");
                console.log(idAlerta);
                console.log(idDocumento);
                console.log("Hello");

                    $.ajax({
                        url: 'eliminarDoc.htm',
                        type: 'post',
                        data: {idAlerta:idAlerta, idDocumento: idDocumento},
                        success: function(response){ 
                 
                            getDocs(idAlerta);

                        },error(e){
                            console.log(e);
                        }

                    });


            })

        },error: function(e){
            console.log(e);
        }

    });
    
   $(".modalUploadDocs").on("click", function(){

        var idAlerta = $(this).attr("id");
        idAlerta = idAlerta.replace("modalUploadDocs","");
        
        console.log(idAlerta);
   
        $.ajax({
            url: 'getDocsAlertaSeguimiento.htm',
            type: 'post',
            data: {id:idAlerta},
            success: function(response){
                response = JSON.parse(response);
                
                console.log(response);

                var docs = "";
                $.each(response, function( index, value ) { 

                    var tipo = "";

                    if(value["tipo_documento"]==1){
                        tipo = "fa-file";
                    }
                    if(value["tipo_documento"]==2){
                        tipo = "fa-file-image";
                    }
                    if(value["tipo_documento"]==3){
                        tipo = "fa-file-video";
                    }

                          
                    url = 'http://localhost:8080/Sis_Arcos-master/images/documentos/Seguimiento/'+value['url_archivo'];

                    docs +="<li class='list-group-item'>"+
                                "<i class='fas "+tipo+" mr-2 text-primary'></i>"+
                                    "<a class='flex-grow-1' href='#' data-toggle='modal' data-target='#modal'>"+value["url_archivo"].replace("D://Users//ADMIN//Desktop//Kiotech//Software//Sis_Arcos-master//web//images//documentos//","")+"</a>"+
                                        "<button type='button' id='"+value["id_documento"]+"' class='btn btn-ico ml-2 btnEliminar'>"+
                                            "<i class='fas fa-trash text-danger' ></i>"+
                                        "</button>"+
                                         "<div class='col-md-2'>"+
                                            "<a href="+url+" target='_blank'>"+
                                                "<button type='button' class='btn btn-ico'>"+
                                                    "<i class='fas fa-search'></i>"+
                                                "</button>"+
                                            "<a>"+
                                        "</div>"+
                                    "</li>";
                });

                $("#docsAlertaSeguimiento"+idAlerta).empty();

                $("#docsAlertaSeguimiento"+idAlerta).append(docs);

                $(".btnEliminar").on("click", function(){

                    var idAlerta = $("#idAlerta").val();
                    var idDocumento = $(this).attr("id");
                    console.log(idAlerta);
                    console.log(idDocumento);
                    console.log("Hello");

                        $.ajax({
                            url: 'eliminarDoc.htm',
                            type: 'post',
                            data: {idAlerta:idAlerta, idDocumento: idDocumento},
                            success: function(response){ 
                                
                                getDocs(idAlerta);

                            },error(e){
                                console.log(e);
                            }

                        });


                })

            },error: function(e){
                console.log(e);
            }

        });
    }) 
    
    $(".btnEliminar").on("click", function(){

        var idAlerta = $("#idAlerta").val();
        var idDocumento = $(this).attr("id");
        console.log(idAlerta);
        console.log(idDocumento);
        console.log("Hello");

            $.ajax({
                url: 'eliminarDoc.htm',
                type: 'post',
                data: {idAlerta:idAlerta, idDocumento: idDocumento},
                success: function(response){ 

                    getDocs(idAlerta);

                },error(e){
                    console.log(e);
                }

            });

    })
}



$("#guardarImagen").on("click", function(){
 
    console.log("Guardar");
    let photo = document.getElementById("file").files[0];  // file from input
    let req = new XMLHttpRequest();
    let formData = new FormData();
    formData.append("photo", photo);     
    
    $.ajax({
        url: 'uploadDocs.htm',
        type: 'post',
        data: {file:formData},
        contentType: false,
        processData: false,
        success: function(response){
            if(response != 0){
                $("#img").attr("src",response); 
                $(".preview img").show(); // Display image element
            }else{
                alert('file not uploaded');
            }
        },
    
    });
    
})


$(".step").on("click", function(){
    id = $(this).attr("id");
    $("#nameAlerta").val(id);
    
    if($("#"+id).hasClass("done")){
        
        if(id == 1){
            $("#1").removeClass("done");
            $("#2").removeClass("done");
            $("#4").addClass("done");
        }

        if(id == 2){
            $("#1").addClass("done");
            $("#2").removeClass("done");
            $("#4").addClass("done");
        }

        if(id == 4){
            $("#1").removeClass("done");
            $("#2").removeClass("done");
            $("#4").removeClass("done");
        }
        
        if(id == 4){
            id = 0; 
        }
        
        if(id == 1){
           id = 4; 
        }

        if(id == 2){
            id = 1; 
        }

        $("#idEtapaAlerta").val(id);
        
    }else{
        
        if(id == 1){
            $("#1").removeClass("done");
            $("#2").removeClass("done");
            $("#4").addClass("done");
        }

        if(id == 2){
            $("#1").addClass("done");
            $("#2").removeClass("done");
            $("#4").addClass("done");
        }

        if(id == 4){
            $("#1").removeClass("done");
            $("#2").removeClass("done");
            $("#4").removeClass("done");
        }
        $("#"+id).addClass("done");
        $("#idEtapaAlerta").val(id);
    }
    console.log(id);
    $.ajax({
        url: 'getEstatus.htm',
        type: 'POST',
        data: {idAlerta: id },
        success: function(response){
            data = JSON.parse(response);
            console.log(data);
            var options = "";
            
            $.each(data, function( index, value ) { 
                
                options += "<option value='"+value["idEstatus"]+"' selected>"+value["nombreEstatus"]+"</option>";
                
            });
            
            
            $("#selectIdEstatus").empty();
            $("#selectIdEstatus").append(options);
        },
        error: function(){

        }
    
    });
    
  
   
})


$("#Guardar").on("click",function(){
    idAlerta = $("#idEtapaAlerta").val();
    console.log(idAlerta);
    if(idAlerta > 0){
        $("#guardarSeguimiento").submit();
    }else{
        alert("Favor de seleccionar una etapa");
    }
})



