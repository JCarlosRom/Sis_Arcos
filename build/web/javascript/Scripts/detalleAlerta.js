/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
    
    idAlerta = $("#idAlerta").val();
      
    $.ajax({
        url: 'getDocsAlerta.htm',
        type: 'post',
        data: {id:idAlerta},
        contentType: false,
        processData: false,
        success: function(response){
            response = JSON.parse(response);
            
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
                                "<a class='flex-grow-1' href='' data-toggle='modal' data-target='#modal'>"+value["url_archivo"].replace("D://Users//ADMIN//Desktop//Kiotech//Software//Sis_Arcos-master//web//images//documentos//","")+"</a>"+
                                    "<button type='button' id='"+value["id_documento"]+"' class='btn btn-ico ml-2 btnEliminar'>"+
                                        "<i class='fas fa-trash text-danger' ></i>"+
                                    "</button>"+
                                     "<div class='col-md-2'>"+
                                    "</div>"+
                                "</li>";
            });
            
            $("#containerDocs").empty();
            
            $("#containerDocs").append(docs);

        },error: function(e){
            console.log(e);
        }
    
    });
})


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

$("#Guardar").on("click", function(){
    console.log("Guardar");
})


$(".buttonDocsSeguimiento").on("click", function(){
    id = $(this).attr("id");
    console.log(id);
})


$(".docs").on("click", function(){

    var idAlerta = $("#idAlerta").val();
    var idDocumento = $(this).attr("id");
    console.log(idAlerta);
    console.log(idDocumento);
    console.log("Hello");
    
})

