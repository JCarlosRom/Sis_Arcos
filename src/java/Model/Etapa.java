/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class Etapa {
    int id_etapa;
    String nombre_etapa; 
    public Etapa ( int id_etapa, String nombre_etapa){
        this.id_etapa = id_etapa; 
        this.nombre_etapa = nombre_etapa; 
    }
    
    public void setIdEtapa (int id_etapa){
        this.id_etapa = id_etapa; 
    }
    
    public int getIdEtapa (){
        return id_etapa;
    }
    
    public void setNombreEtapa ( String nombre_etapa){
        this.nombre_etapa = nombre_etapa; 
    }
    
    public String getNombreEtapa (){
        return nombre_etapa;
    }
}
