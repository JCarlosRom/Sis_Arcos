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
    int idEtapa;
    String EstatusEtapa; 
    
    public Etapa ( int idEtapa, String EstatusEtapa){
        this.idEtapa = idEtapa; 
        this.EstatusEtapa = EstatusEtapa; 
    }
    
    public void setIdEtapa (int idEtapa){
        this.idEtapa = idEtapa; 
    }
    
    public int getIdEtapa (){
        return idEtapa;
    }
    
    public void setNombreEtapa ( String EstatusEtapa){
        this.EstatusEtapa = EstatusEtapa; 
    }
    
    public String getNombreEtapa (){
        return EstatusEtapa;
    }
}
