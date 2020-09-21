/*
        Esta clase corresponde al modelo de Usuarios
 */
package Model;

public class Usuario {
    
    private int id_usuario;
    private String usuario;
    private String contrasena;
    
    public Usuario(){
        
    }
    
    public Usuario (Integer id_usuario, String usuario, String contrasena){
        this.id_usuario = id_usuario;
        this.usuario = usuario;
        this.contrasena = contrasena;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }
    
    
}
