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
public class estatusEtapa {
    int idEstatusEtapa;
    String nombreEstatusEtapa; 
    public estatusEtapa ( int idEstatusEtapa, String nombreEstatusEtapa){
        this.idEstatusEtapa = idEstatusEtapa; 
        this.nombreEstatusEtapa = nombreEstatusEtapa; 
    }
    
    public void setIdEstatusEtapa (int idEstatusEtapa){
        this.idEstatusEtapa = idEstatusEtapa; 
    }
    
    public int getIdEstatusEtapa (){
        return idEstatusEtapa;
    }
    
    public void setNombreEstatusEtapa ( String nombreEstatusEtapa){
        this.nombreEstatusEtapa = nombreEstatusEtapa; 
    }
    
    public String getNombreEstatusEtapa (){
        return nombreEstatusEtapa;
    }
}
