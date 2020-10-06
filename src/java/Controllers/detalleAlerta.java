package Controllers;

import Config.Conexion;
import Model.Alertas;
import Model.Etapa;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.parser.ParseException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import Model.detalleAlertaObject;
import java.io.File;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import org.apache.commons.io.FilenameUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ADMIN
 */
public class detalleAlerta {
     // Metodo para cargar el modelo, vista, controlador de login
    @RequestMapping(value = "index_detalleAlerta.htm") //1
    public ModelAndView controlador_add(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ParseException, IOException {
        Conexion Conexion = new Conexion();
        org.springframework.web.servlet.ModelAndView mav = new org.springframework.web.servlet.ModelAndView();
        int id = Integer.parseInt(request.getParameter("id"));
        
         ResultSet ry = Conexion.query("select * from sp_get_estado_actual_alerta("+id+")");
         detalleAlertaObject detalleAlerta = null;
         try {
             while (ry.next()) {
                 double latitud, longitud;
                    String[] LatLng = ry.getString("ubicacion").split(", ");
                    latitud = Double.parseDouble(LatLng[0].trim());
                    longitud = Double.parseDouble(LatLng[1].trim());
                  detalleAlerta = new detalleAlertaObject(
                         ry.getInt("id_alerta"),
                         ry.getString("etapa"),
                         ry.getInt("id_etapa_alerta"),
                         ry.getString("estatus"),
                         ry.getInt("id_estatus_etapa_alerta"),
                         ry.getString("alertatxt"),
                         ry.getString("ubicacion"),
                         ry.getString("fecha"),
                         ry.getString("hora"),
                         ry.getString("tipo_vehiculo"),
                         ry.getString("marca"),
                         ry.getString("color"),
                         ry.getString("placa"),
                         ry.getString("niv"),
                         latitud, 
                         longitud,
                         null
                 );
             }
             ry.close();
             Conexion.executeQueryClose();
         }  catch (Exception ex) {
             System.out.println(ex.getMessage());
         }
         

        ResultSet rx = Conexion.query("select * from sp_get_registros_alerta("+id+")");
        ArrayList<detalleAlertaObject> detalleAlertaSeguimiento = new ArrayList<>();
         try {
             while (rx.next()) {
                 
                
                  detalleAlertaSeguimiento.add(new detalleAlertaObject(
                        0,
                        rx.getString("etapa"),
                        rx.getString("estatus"),
                        null,
                        null,
                        rx.getString("fecha_hora"),
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        0,
                        0,
                        rx.getString("accion_comentario")
                    ));
                 
                 
             }
             rx.close();
             Conexion.executeQueryClose();
         }  catch (Exception ex) {
             System.out.println(ex.getMessage());
         }
         
        ResultSet rz= Conexion.query("SELECT fk_id_etapa_alerta, nombre_estatus_etapa_alerta FROM public.estatus_etapa_alerta");
        ArrayList<Etapa> Etapa = new ArrayList<>();
         try {
             while (rz.next()) {

                  Etapa.add(new Etapa(
                   
                        rz.getInt("fk_id_etapa_alerta"),
                        rz.getString("nombre_estatus_etapa_alerta")
                    
                    ));                 
                 
             }
             rz.close();
             Conexion.executeQueryClose();
         }  catch (Exception ex) {
             System.out.println(ex.getMessage());
         }
         

    
         
        mav.addObject("detalle_alerta", detalleAlerta);
        mav.addObject("detalleAlertaSeguimiento", detalleAlertaSeguimiento);
        mav.addObject("Etapa", Etapa);

        mav.setViewName("detalleAlerta");
        
        return mav;
    }
    
    
      @RequestMapping(value = "uploadDocs.htm", method = RequestMethod.POST)
    public ModelAndView uploadDocs(HttpServletRequest request, HttpServletResponse response, @RequestParam("file") MultipartFile file) throws ServletException, IOException {
        Conexion Conexion = new Conexion();
        org.springframework.web.servlet.ModelAndView mav = new org.springframework.web.servlet.ModelAndView();
        String upload_folder = "D://Users/ADMIN/Desktop/Kiotech/Software/Sis_Arcos-master/web/images/documentos//";
        String ubicacion = upload_folder + file.getOriginalFilename();
        int idAlerta = Integer.parseInt(request.getParameter("idAlerta"));
      
        
        if(!file.isEmpty()){
          try{
                        
            String mimetype = file.getContentType();
            String type = mimetype.split("/")[0];
            int typeInt = 0;

            if("application".equals(type)){
                typeInt = 1;
            }
            
            if("image".equals(type)){
                typeInt = 2;
            }
            
            if("video".equals(type)){
                typeInt=3;
            }

            System.out.println("Tipo:"+type);
        

            File path = new File (upload_folder + file.getOriginalFilename());
              
              

            if(!path.exists()){
             
                file.transferTo(new File(upload_folder + file.getOriginalFilename()));
                System.err.println("Archivo súbido");
                ResultSet rx = Conexion.query("select * from sp_subir_documentos_alerta("+idAlerta+",'"+ubicacion+"'::character varying,"+typeInt+");");
                System.out.println("select * from sp_subir_documentos_alerta("+idAlerta+",'"+ubicacion+"',"+typeInt+");");
                try {
                    while (rx.next()) {
                           System.out.println(rx.getString("respuesta"));
                    }
                    rx.close();
                    Conexion.executeQueryClose();
                }  catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }

            }else{
                System.err.println("Ese archivo ya existe");
            }

          }catch(Exception e){
               System.err.println(e);
          }
      }
        
              ResultSet ry = Conexion.query("select * from sp_get_estado_actual_alerta("+idAlerta+")");
         detalleAlertaObject detalleAlerta = null;
         try {
             while (ry.next()) {
                 double latitud, longitud;
                    String[] LatLng = ry.getString("ubicacion").split(", ");
                    latitud = Double.parseDouble(LatLng[0].trim());
                    longitud = Double.parseDouble(LatLng[1].trim());
                  detalleAlerta = new detalleAlertaObject(
                         ry.getInt("id_alerta"),
                         ry.getString("etapa"),
                         ry.getString("estatus"),
                         ry.getString("alertatxt"),
                         ry.getString("ubicacion"),
                         ry.getString("fecha"),
                         ry.getString("hora"),
                         ry.getString("tipo_vehiculo"),
                         ry.getString("marca"),
                         ry.getString("color"),
                         ry.getString("placa"),
                         ry.getString("niv"),
                         latitud, 
                         longitud,
                         null
                 );
             }
             ry.close();
             Conexion.executeQueryClose();
         }  catch (Exception ex) {
             System.out.println(ex.getMessage());
         }
         
         
        ResultSet rx = Conexion.query("select * from sp_get_registros_alerta("+idAlerta+")");
        ArrayList<detalleAlertaObject> detalleAlertaSeguimiento = new ArrayList<>();
         try {
             while (rx.next()) {
                 
                
                  detalleAlertaSeguimiento.add(new detalleAlertaObject(
                        0,
                        rx.getString("etapa"),
                        rx.getString("estatus"),
                        null,
                        null,
                        rx.getString("fecha_hora"),
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        0,
                        0,
                        rx.getString("accion_comentario")
                    ));
                 
                 
             }
             rx.close();
             Conexion.executeQueryClose();
         }  catch (Exception ex) {
             System.out.println(ex.getMessage());
         }
         
        ResultSet rz= Conexion.query("SELECT fk_id_etapa_alerta, nombre_estatus_etapa_alerta FROM public.estatus_etapa_alerta");
        ArrayList<Etapa> Etapa = new ArrayList<>();
        try {
            while (rz.next()) {

                 Etapa.add(new Etapa(

                       rz.getInt("fk_id_etapa_alerta"),
                       rz.getString("nombre_estatus_etapa_alerta")

                   ));                 

            }
            rz.close();
            Conexion.executeQueryClose();
        }  catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
         
        mav.addObject("detalle_alerta", detalleAlerta);
        mav.addObject("detalleAlertaSeguimiento", detalleAlertaSeguimiento);
        mav.addObject("Etapa", Etapa);

        mav.setViewName("detalleAlerta");
      
      return mav;

    }

    @RequestMapping(value = "getDocsAlerta.htm", method = RequestMethod.POST)
    public void getDocsAlerta (HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        Conexion Conexion = new Conexion();
        JSONArray alertaDocumentos = new JSONArray();
        JSONObject jsAlerta;
           try (ResultSet r = Conexion.query("SELECT id_alerta_documentos ,fk_id_alerta, fk_id_tipo_documento, url_archivo FROM public.alerta_documentos")) {
              
               while (r.next()) {
                jsAlerta = new JSONObject();
                jsAlerta.put("id_documento", r.getInt("id_alerta_documentos"));
                jsAlerta.put("id_alerta", r.getInt("fk_id_alerta"));
                jsAlerta.put("tipo_documento", r.getString("fk_id_tipo_documento"));
                jsAlerta.put("url_archivo", r.getString("url_archivo"));
                
                alertaDocumentos.add(jsAlerta);
            }
            Conexion.executeQueryClose();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        
           
        out.print(alertaDocumentos);
    }
    
    @RequestMapping(value = "eliminarDoc.htm", method = RequestMethod.POST)
    public void eliminarDoc (HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        Conexion Conexion = new Conexion();
        
        int idAlerta = Integer.parseInt(request.getParameter("idAlerta"));
        int idDocumento = Integer.parseInt(request.getParameter("idDocumento"));
        
            try (
                ResultSet r1 = Conexion.query("SELECT * FROM public.sp_eliminar_documentos_alerta("+idAlerta+", "+idDocumento+")")) {
              
               while (r1.next()) {

            }
            Conexion.executeQueryClose();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        
        
        JSONArray alertaDocumentos = new JSONArray();
        JSONObject jsAlerta;
           try (
                ResultSet r = Conexion.query("SELECT id_alerta_documentos ,fk_id_alerta, fk_id_tipo_documento, url_archivo FROM public.alerta_documentos")) {
              
               while (r.next()) {
                jsAlerta = new JSONObject();
                jsAlerta.put("id_documento", r.getInt("id_alerta_documentos"));
                jsAlerta.put("id_alerta", r.getInt("fk_id_alerta"));
                jsAlerta.put("tipo_documento", r.getString("fk_id_tipo_documento"));
                jsAlerta.put("url_archivo", r.getString("url_archivo"));
                
                alertaDocumentos.add(jsAlerta);
            }
            Conexion.executeQueryClose();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        
        System.out.println(alertaDocumentos);
           
        out.print(alertaDocumentos);
    }
    
}


