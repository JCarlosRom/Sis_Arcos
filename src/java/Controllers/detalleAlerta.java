package Controllers;

import Config.Conexion;
import Model.Alertas;
import Model.Etapa;
import Model.Queries_index;
import Model.Queries_DetalleAlerta;
import Model.estatusEtapa;
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
import javax.servlet.http.HttpSession;
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
        
        org.springframework.web.servlet.ModelAndView mav = new org.springframework.web.servlet.ModelAndView();
        
        int id = Integer.parseInt(request.getParameter("id"));
        int idEtapa = Queries_DetalleAlerta.getAlerta(id).getIdEtapa(); 

        mav.addObject("detalle_alerta", Queries_DetalleAlerta.getAlerta(id).getAlertas());
        mav.addObject("detalleAlertaSeguimiento", Queries_DetalleAlerta.getRegistrosAlerta(id).get());
        mav.addObject("estatusEtapa", Queries_DetalleAlerta.getEstatusEtapa(idEtapa).get());
        mav.addObject("Etapa", Queries_DetalleAlerta.getEtapa().get());
        
        mav.addObject("bddRemotas",  Queries_index.dbbDashboard().getBdd());
        mav.addObject("counterErrorDB", Queries_index.dbbDashboard().getCounterBDD());

        mav.addObject("lecturas", Queries_index.arcosDashboard().getArcos());
        mav.addObject("counterLecturas", Queries_index.arcosDashboard().getCounterArcos());

        mav.addObject("alertasPendientes", Queries_index.alertasDashboard().getAlerta());
        mav.addObject("counterAlertasPendientes", Queries_index.alertasDashboard().getCounterAlarmas());

        mav.setViewName("detalleAlerta");
        
        return mav;
    }
    
    
    @RequestMapping(value = "fullDetalleAlerta.htm") //1
    public ModelAndView fullDetalleAlerta(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ParseException, IOException {
        
        org.springframework.web.servlet.ModelAndView mav = new org.springframework.web.servlet.ModelAndView();
        
        int id = Integer.parseInt(request.getParameter("idAlerta"));
        int idEtapa = Queries_DetalleAlerta.getAlerta(id).getIdEtapa(); 
        
         System.out.println("Detalle");

        mav.addObject("detalle_alerta", Queries_DetalleAlerta.getAlerta(id).getAlertas());
        mav.addObject("detalleAlertaSeguimiento", Queries_DetalleAlerta.getRegistrosAlerta(id).get());
        mav.addObject("estatusEtapa", Queries_DetalleAlerta.getEstatusEtapa(idEtapa).get());
        mav.addObject("Etapa", Queries_DetalleAlerta.getEtapa().get());

        mav.setViewName("Detalles/fullDetalleAlerta");
        
        return mav;
    }
    
      @RequestMapping(value = "guardarSeguimiento.htm", method = RequestMethod.POST)
    public ModelAndView guardarSeguimiento (HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        org.springframework.web.servlet.ModelAndView mav = new org.springframework.web.servlet.ModelAndView();
        Conexion Conexion = new Conexion();
        int page = Integer.parseInt(request.getParameter("page"));
        int idAlerta = Integer.parseInt(request.getParameter("idAlerta"));
        int idEtapaAlerta = Integer.parseInt(request.getParameter("idEtapaAlerta"));
        int idEstatus = Integer.parseInt(request.getParameter("idEstatus"));
        String Comentario = String.valueOf(request.getParameter("Comentario"));
        String Ubicacion = String.valueOf(request.getParameter("Ubicacion"));
        String Geocoder = String.valueOf(request.getParameter("Geocoder"));
        
        String Mensaje = "";
        HttpSession session = request.getSession(true);
        
         try (
            ResultSet r1 = Conexion.query("SELECT * FROM public.sp_alerta_seguimiento_cud('C'::character, null::uuid, "
            + ""+idAlerta+","+idEtapaAlerta+","+idEstatus+",'"+Comentario+"'::character varying, NOW()::timestamp without time zone,'"+Ubicacion+"'::character varying,'"+Geocoder+"'::character varying, null::character varying, "+session.getAttribute("id")+")")) {

            while (r1.next()) {
               Mensaje = r1.getString("mensaje");
            }
           
            Conexion.executeQueryClose();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } 
         
          int idEtapa = Queries_DetalleAlerta.getAlerta(idAlerta).getIdEtapa();
         
        if(page == 1){
            
        
            mav.addObject("detalle_alerta", Queries_DetalleAlerta.getAlerta(idAlerta).getAlertas());
            mav.addObject("detalleAlertaSeguimiento", Queries_DetalleAlerta.getRegistrosAlerta(idAlerta).get());
            mav.addObject("Etapa", Queries_DetalleAlerta.getEtapa().get());
            mav.addObject("estatusEtapa", Queries_DetalleAlerta.getEstatusEtapa(idEtapa).get());

            mav.addObject("bddRemotas",  Queries_index.dbbDashboard().getBdd());
            mav.addObject("counterErrorDB", Queries_index.dbbDashboard().getCounterBDD());

            mav.addObject("lecturas", Queries_index.arcosDashboard().getArcos());
            mav.addObject("counterLecturas", Queries_index.arcosDashboard().getCounterArcos());

            mav.addObject("alertasPendientes", Queries_index.alertasDashboard().getAlerta());
            mav.addObject("counterAlertasPendientes", Queries_index.alertasDashboard().getCounterAlarmas());
            mav.setViewName("detalleAlerta");


        }else{
            if(page == 2){
                
                mav.addObject("detalle_alerta", Queries_DetalleAlerta.getAlerta(idAlerta).getAlertas());
                mav.addObject("detalleAlertaSeguimiento", Queries_DetalleAlerta.getRegistrosAlerta(idAlerta).get());
                mav.addObject("estatusEtapa", Queries_DetalleAlerta.getEstatusEtapa(idEtapa).get());
                mav.addObject("Etapa", Queries_DetalleAlerta.getEtapa().get());

                mav.setViewName("Detalles/fullDetalleAlerta");

            }
        }

       return mav;
    }
    
    
      @RequestMapping(value = "uploadDocs.htm", method = RequestMethod.POST)
    public ModelAndView uploadDocs(HttpServletRequest request, HttpServletResponse response, @RequestParam("file") MultipartFile file) throws ServletException, IOException {
        Conexion Conexion = new Conexion();
        org.springframework.web.servlet.ModelAndView mav = new org.springframework.web.servlet.ModelAndView();
        String upload_folder = "D://Users/ADMIN/Desktop/Kiotech/Software/Sis_Arcos-master/web/images/documentos/";
        String ubicacion = upload_folder + file.getOriginalFilename();
        int page = Integer.parseInt(request.getParameter("page"));
        int idAlerta = Integer.parseInt(request.getParameter("idAlerta"));
        int idEtapa = Queries_DetalleAlerta.getAlerta(idAlerta).getIdEtapa(); 
        
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
        
          System.out.println(page);
        
        if(page==1){
            
            mav.addObject("detalle_alerta",  Queries_DetalleAlerta.getAlerta(idAlerta).getAlertas());
            mav.addObject("detalleAlertaSeguimiento", Queries_DetalleAlerta.getRegistrosAlerta(idAlerta).get());
            mav.addObject("estatusEtapa", Queries_DetalleAlerta.getEstatusEtapa(idEtapa).get());
            mav.addObject("Etapa", Queries_DetalleAlerta.getEtapa().get());

            mav.addObject("bddRemotas",  Queries_index.dbbDashboard().getBdd());
            mav.addObject("counterErrorDB", Queries_index.dbbDashboard().getCounterBDD());

            mav.addObject("lecturas", Queries_index.arcosDashboard().getArcos());
            mav.addObject("counterLecturas", Queries_index.arcosDashboard().getCounterArcos());

            mav.addObject("alertasPendientes", Queries_index.alertasDashboard().getAlerta());
            mav.addObject("counterAlertasPendientes", Queries_index.alertasDashboard().getCounterAlarmas());

            mav.setViewName("detalleAlerta");
            
        }else{
            if(page == 2){
                
                mav.addObject("detalle_alerta", Queries_DetalleAlerta.getAlerta(idAlerta).getAlertas());
                mav.addObject("detalleAlertaSeguimiento", Queries_DetalleAlerta.getRegistrosAlerta(idAlerta).get());
                mav.addObject("estatusEtapa", Queries_DetalleAlerta.getEstatusEtapa(idEtapa).get());
                mav.addObject("Etapa", Queries_DetalleAlerta.getEtapa().get());

                mav.setViewName("Detalles/fullDetalleAlerta");

                return mav;
            }
        }

    
      
      return mav;

    }

    
    
       @RequestMapping(value = "uploadDocSeguimiento.htm", method = RequestMethod.POST)
    public void uploadDocSeguimiento(HttpServletRequest request, HttpServletResponse response, @RequestParam("fileSeguimiento") MultipartFile file) throws ServletException, IOException {
        Conexion Conexion = new Conexion();
        PrintWriter out = response.getWriter();
        String upload_folder = "D://Users/ADMIN/Desktop/Kiotech/Software/Sis_Arcos-master/web/images/documentos/Seguimiento/";
        String ubicacion = upload_folder + file.getOriginalFilename();
        String idAlertaSeguimiento = request.getParameter("idAlertaAseguimiento");
        int idAlerta = Integer.parseInt(request.getParameter("idAlerta"));
        int idEtapa = Queries_DetalleAlerta.getAlerta(idAlerta).getIdEtapa(); 
       
        
        System.out.println("Nombre"+file.getOriginalFilename());
        String Mensaje = "Error"; 
        
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
                ResultSet rx = Conexion.query("select * from sp_subir_documentos_estatus_etapa_alerta('"+idAlertaSeguimiento+"'::uuid,'"+ubicacion+"'::character varying,"+typeInt+");");
              
                try {
                    while (rx.next()) {
                        Mensaje = rx.getString("respuesta");
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
          
          out.print(true);
      }else{
         out.print(false);
      }


    }

    
    @RequestMapping(value = "getDocsAlerta.htm", method = RequestMethod.POST)
    public void getDocsAlerta (HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        Conexion Conexion = new Conexion();
        JSONArray alertaDocumentos = new JSONArray();
        JSONObject jsAlerta;
        int idAlerta = Integer.parseInt(request.getParameter("id"));
 
           try (ResultSet r = Conexion.query("SELECT id_alerta_documentos ,fk_id_alerta, fk_id_tipo_documento, REPLACE (url_archivo,"
            + " 'D://Users/ADMIN/Desktop/Kiotech/Software/Sis_Arcos-master/web/images/documentos/', '')\n" 
            +"as \"url_archivo\" FROM public.alerta_documentos"
                   + " where fk_id_alerta='"+idAlerta+"'")) {
              
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
    
    @RequestMapping(value = "getDocsAlertaSeguimiento.htm", method = RequestMethod.POST)
    public void getDocsAlertaSeguimiento (HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        Conexion Conexion = new Conexion();
        JSONArray alertaDocumentos = new JSONArray();
        JSONObject jsAlerta;
        String idAlerta = request.getParameter("id");
        
           try (ResultSet r = Conexion.query("SELECT id_estatus_etapa_documentos, fk_id_alerta_seguimiento, fk_id_tipo_documento, REPLACE (url_archivo,"
            + " 'D://Users/ADMIN/Desktop/Kiotech/Software/Sis_Arcos-master/web/images/documentos/Seguimiento/', '')\n" 
            +"as \"url_archivo\" FROM public.estatus_etapa_documentos"
                   + " where fk_id_alerta_seguimiento='"+idAlerta+"'")) {
              
               while (r.next()) {
                jsAlerta = new JSONObject();
                jsAlerta.put("id_documento", r.getInt("id_estatus_etapa_documentos"));
                jsAlerta.put("id_alerta", r.getString("fk_id_alerta_seguimiento"));
                jsAlerta.put("tipo_documento", r.getInt("fk_id_tipo_documento"));
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
    
     @RequestMapping(value = "getEstatus.htm", method = RequestMethod.POST)
    public void getEstatus (HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        Conexion Conexion = new Conexion();
        
        int idAlerta = Integer.parseInt(request.getParameter("idAlerta"));
      
        System.out.println(idAlerta);
        
        ResultSet rz= Conexion.query("SELECT id_estatus_etapa_alerta, nombre_estatus_etapa_alerta FROM public.estatus_etapa_alerta where fk_id_etapa_alerta = "+idAlerta+";");
        System.out.println("SELECT id_estatus_etapa_alerta, nombre_estatus_etapa_alerta FROM public.estatus_etapa_alerta where fk_id_etapa_alerta = "+idAlerta+";");
        
        JSONArray Estatus = new JSONArray();
        JSONObject estatusJSON;
         try {
             while (rz.next()) {
                 estatusJSON = new JSONObject();
                 estatusJSON.put("idEstatus", rz.getString("id_estatus_etapa_alerta"));
                 estatusJSON.put("nombreEstatus", rz.getString("nombre_estatus_etapa_alerta"));
              
                 Estatus.add(estatusJSON);
                            
             }
             rz.close();
             Conexion.executeQueryClose();
         }  catch (Exception ex) {
             System.out.println(ex.getMessage());
         }
         
        out.print(Estatus);
    }
    
    
    @RequestMapping(value = "eliminarDoc.htm", method = RequestMethod.POST)
    public void eliminarDoc (HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        Conexion Conexion = new Conexion();
        
        int idAlerta = Integer.parseInt(request.getParameter("idAlerta"));
        int idDocumento = Integer.parseInt(request.getParameter("idDocumento"));
        
        System.out.println(idAlerta);
        System.out.println(idDocumento);
        System.out.println("SELECT * FROM public.sp_eliminar_documentos_alerta("+idAlerta+", "+idDocumento+")");
        
            try (
               
                ResultSet r1 = Conexion.query("SELECT * FROM public.sp_eliminar_documentos_alerta("+idAlerta+", "+idDocumento+")")) {
              
               while (r1.next()) {

            }
               
            Conexion.executeQueryClose();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        out.print(1);
    }
    
    
}


