/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import Config.Conexion;
import java.io.FileNotFoundException;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class Queries_DetalleAlerta {
    
    
    
    public static Alerta getAlerta(Integer id) throws FileNotFoundException{
        Conexion Conexion = new Conexion();
        int idEtapa = 0; 
         ResultSet ry = Conexion.query("select * from sp_get_estado_actual_alerta("+id+");");
         detalleAlertaObject detalleAlerta = null;
         try {
             while (ry.next()) {
                 double latitud, longitud;
                    String[] LatLng = ry.getString("ubicacion").split(", ");
                    latitud = Double.parseDouble(LatLng[0].trim());
                    longitud = Double.parseDouble(LatLng[1].trim());
                    idEtapa = ry.getInt("id_etapa_alerta");
                    System.out.println(idEtapa);
                  detalleAlerta = new detalleAlertaObject(
                        ry.getInt("id_alerta"),
                        ry.getString("etapa"),
                        ry.getInt("id_etapa_alerta"),
                        ry.getString("estatus"),
                        ry.getInt("id_estatus_etapa_alerta"),
                        ry.getString("alertatxt"),
                        ry.getString("arco"),
                        ry.getString("direccion_arco"),
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
         
         return new Alerta (detalleAlerta, idEtapa);
    };
    
    
    public static Registros getRegistrosAlerta (Integer id) throws FileNotFoundException{
        Conexion Conexion = new Conexion();
        ResultSet rx = Conexion.query("select * from sp_get_registros_alerta("+id+");");
          System.out.println("select * from sp_get_registros_alerta("+id+");");
          ArrayList<alertaSeguimiento> detalleAlertaSeguimiento = new ArrayList<>();
           try {
               while (rx.next()) {
                   double longitud = 0;
                   double latitud = 0; 
                    detalleAlertaSeguimiento.add(new alertaSeguimiento(
                          rx.getString("id_alerta"),
                          rx.getString("etapa"),
                          0,
                          rx.getString("estatus"),
                          0,
                          "",
                          "",
                          rx.getString("fecha_hora"),
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          longitud,
                          latitud,
                          rx.getString("accion_comentario")
                      ));


               }
               rx.close();
               Conexion.executeQueryClose();
           }  catch (Exception ex) {
               System.out.println(ex.getMessage());
           }
        return new Registros(detalleAlertaSeguimiento);
    }
    
    public static Estatus getEstatusEtapa(Integer idEtapa) throws FileNotFoundException {
        Conexion Conexion = new Conexion();
        ResultSet rz= Conexion.query("SELECT id_estatus_etapa_alerta, nombre_estatus_etapa_alerta FROM public.estatus_etapa_alerta where fk_id_etapa_alerta ="+idEtapa+";");
        ArrayList<estatusEtapa> estatusEtapa = new ArrayList<>();
        try {
            while (rz.next()) {

                 estatusEtapa.add(new estatusEtapa(

                       rz.getInt("id_estatus_etapa_alerta"),
                       rz.getString("nombre_estatus_etapa_alerta")

                   ));                 
            }
            rz.close();
            Conexion.executeQueryClose();
        }  catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        
        return new Estatus(estatusEtapa);
    }
    
    public static Etapa getEtapa () throws FileNotFoundException{
        Conexion Conexion = new Conexion();
         ResultSet re= Conexion.query("SELECT id_etapa_alerta, nombre_etapa FROM public.etapa_alerta where nombre_etapa = 'Validación' or nombre_etapa ='Vinculación'\n" +
        "or nombre_etapa = 'Cierre en SM';");
        ArrayList<Model.Etapa> Etapa = new ArrayList<>();
            try {
                while (re.next()) {

                     Etapa.add(new Model.Etapa(

                           re.getInt("id_etapa_alerta"),
                           re.getString("nombre_etapa")

                       ));                 
                }
                re.close();
                Conexion.executeQueryClose();
            }  catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        return new Etapa(Etapa);
    };

    public static class Alerta{
        
        public static detalleAlertaObject detalleAlerta = null;
        public static Integer idEtapa = null;

        
        public Alerta(detalleAlertaObject detalleAlerta, Integer idEtapa) {

            this.detalleAlerta = detalleAlerta;
            this.idEtapa = idEtapa;
        }
        
        public static detalleAlertaObject getAlertas() {
            return detalleAlerta;
        }
        
        public static Integer getIdEtapa(){
            return idEtapa;
        }
    
    }
    
    public static class Registros{
        public static ArrayList<alertaSeguimiento> alertaSeguimiento;
        
        public Registros(ArrayList<alertaSeguimiento> alertaSeguimiento ){
            this.alertaSeguimiento = alertaSeguimiento;
        }
        
        public static ArrayList<alertaSeguimiento>  get(){
            return alertaSeguimiento;
        }
    }
    
    public static class Estatus {
        
        public static ArrayList<estatusEtapa> estatusEtapa;
        
        public Estatus(ArrayList<estatusEtapa> estatusEtapa){
            this.estatusEtapa = estatusEtapa; 
        }
        
        public static ArrayList<estatusEtapa> get(){
            return estatusEtapa; 
        }
    }
    
    public static class Etapa{
        public static ArrayList<Model.Etapa> Etapa;
        
        public Etapa(ArrayList<Model.Etapa> Etapa){
            this.Etapa = Etapa;
        }
        
        public static ArrayList<Model.Etapa> get(){
            return Etapa;
        }
    }
      


     
}
