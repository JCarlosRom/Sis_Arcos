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
public class alertasPendientes {
    private int idAlerta;
    private String nombre;
    private String clave; 
    
    public alertasPendientes(int idAlerta, String nombre, String clave){
        this.idAlerta = idAlerta; 
        this.nombre = nombre; 
        this.clave = clave; 
    }
    
    public int getIdAlerta(){
        return idAlerta;
    };
    
    public void setIdAlerta(int idAlerta){
        this.idAlerta = idAlerta;
    };
    
    public String getNombre(){
        return nombre;
    }
    
    public void setNombre(String nombre){
        this.nombre = nombre;
    }
    
     public String getClave(){
        return clave;
    }
    
    public void setClave(String clave){
        this.clave = clave;
    }
}
