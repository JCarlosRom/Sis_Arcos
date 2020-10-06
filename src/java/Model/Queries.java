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
public class Queries {
    
    
    
    public static bddDanger dbbDashboard() throws FileNotFoundException{
        Conexion Conexion = new Conexion();
        ResultSet rq = Conexion.query("select * from sp_acceso_datos_db();");
          ArrayList<bdd_remotas> bddRemotas = new ArrayList<>();
          int counterErrorDB = 0;
          try {

              while (rq.next()) {
                  if(rq.getLong("accesodatos")==0){
                      counterErrorDB+=1;
                  }
                  bddRemotas.add(new bdd_remotas(
                          rq.getString("nombre"),
                          rq.getLong("accesodatos"),
                          "Status" + rq.getString("nombre").replace(" ", "")
                  ));
              }

              rq.close();
              Conexion.executeQueryClose();
          }  catch (Exception ex) {
              System.out.println(ex.getMessage());
          } 
          return new bddDanger(bddRemotas, counterErrorDB);
    };
    
    public static arcosDashboard arcosDashboard() throws FileNotFoundException{
        Conexion Conexion = new Conexion();
        ResultSet rl = Conexion.query("select id_lector, clave, nombre, estado from lector;");
        ArrayList<Lectura> lecturas = new ArrayList<>();
        int counterLecturas = 0; 
        try {
            while (rl.next()) {

                if(rl.getInt("estado")==1 || rl.getInt("estado")==2){
                    counterLecturas +=1;
                }

                lecturas.add(new Lectura(
                        rl.getInt("id_lector"),
                        rl.getString("clave"),
                        rl.getString("nombre"),
                        rl.getInt("estado")

                ));
            }
            rl.close();
            Conexion.executeQueryClose();
        }  catch (Exception ex) {
            System.out.println(ex.getMessage());
        }


        return new arcosDashboard(lecturas, counterLecturas);
    };
    
    public static alertasDashboard alertasDashboard() throws FileNotFoundException{
        Conexion Conexion = new Conexion();
        ResultSet r2 = Conexion.query("select a.id_alerta, concat(LEFT(cat.nombre, 20),'...') as nombre, l.clave as clave from  alerta a \n" +
        "inner join cat_alerta cat on a.fk_id_cat_alerta = cat.id_cat_alerta \n" +
        "inner join lector l on a.fk_id_lector = l.id_lector \n" +
        "where a.pendiente = 0;");
        
        ArrayList<alertasPendientes> alertasPendientes = new ArrayList<>();
        int counterAlertasPendientes = 0; 
        try {
            while (r2.next()) {


                counterAlertasPendientes +=1;


                alertasPendientes.add(new alertasPendientes(
                        r2.getInt("id_alerta"),
                        r2.getString("nombre"),
                        r2.getString("clave")
                ));
            }
            r2.close();
            Conexion.executeQueryClose();
        }  catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        
        return new alertasDashboard(alertasPendientes, counterAlertasPendientes);
    }

    
    
      public static class bddDanger{
        
        public static  ArrayList<bdd_remotas> bdd_remotas;
        public static int counterBDD;
        
        public bddDanger(ArrayList<bdd_remotas> bdd_remotas, int counterBDD) {
           this.bdd_remotas = bdd_remotas;
           this.counterBDD = counterBDD;
        }
        
        public static ArrayList<bdd_remotas> getBdd() {
            return bdd_remotas;
        }

        public static int getCounterBDD() {
            return counterBDD;
        }
        
    }
      
      public static class arcosDashboard{
        
        public static ArrayList<Lectura> Lectura;
        public static int counterArcos;
        
        public arcosDashboard(ArrayList<Lectura> Arcos, int counterArcos) {
            this.Lectura = Arcos;
            this.counterArcos = counterArcos;
        }
        
        public ArrayList<Lectura> getArcos (){
            return Lectura; 
        }
        
        public int getCounterArcos(){
            return counterArcos; 
        }

      }
      
    public static class alertasDashboard{
        public ArrayList<alertasPendientes> alerta; 
        public int counterAlarmas;

        public alertasDashboard( ArrayList<alertasPendientes> Alertas, int counterAlarmas){
            this.alerta = Alertas;
            this.counterAlarmas = counterAlarmas;
        };
        
        public ArrayList<alertasPendientes> getAlerta(){
            return alerta;
        }
        
        public int getCounterAlarmas (){
            return counterAlarmas;
        }
          
    }
     
}
