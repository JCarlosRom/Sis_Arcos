/*
        Esta clase corresponde al modelo Base de Datos remotas.
 */
package Model;

public class bdd_remotas {
    
    private String nombre;
    private Long accesodatos;
    private String id;

    public bdd_remotas(String nombre, Long accesodatos, String id) {
        this.nombre = nombre;
        this.accesodatos = accesodatos;
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Long getAccesodatos() {
        return accesodatos;
    }

    public void setAccesodatos(Long accesodatos) {
        this.accesodatos = accesodatos;
    }
    
    
    
}
