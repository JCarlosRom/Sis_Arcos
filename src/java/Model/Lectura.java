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
public class Lectura {
    private int Id;
    private String Clave; 
    private String Nombre; 
    private int Status;
    
    public Lectura(int Id, String Clave, String Nombre, int Status) {
      this.Id = Id;
      this.Clave = Clave;
      this.Nombre = Nombre;
      this.Status = Status;
    }
    
    public int getId(){
        return Id;
    };
    
    public void setId(int id){
        this.Id = id; 
    };
    
    public String getClave(){
        return Clave;
    };
    
    public void setClave(String Clave){
        this.Clave = Clave; 
    };
    
    public String getNombre(){
       return Nombre;
    };
    
    public void setNombre(String Nombre){
        this.Nombre = Nombre; 
    };
    
    public int getStatus(){
       return Status;
    };
    
    public void setStatus(int Status){
        this.Status = Status; 
    };
}
