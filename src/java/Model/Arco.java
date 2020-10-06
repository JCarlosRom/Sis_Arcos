/*
Esta clase corresponde al modelo de arcos
 */
package Model;


public class Arco {
    //Propiedades de la clase correspondientes  la base de datos.
    
    private int id, tipo_alerta, marcador;

    public int getMarcador() {
        return marcador;
    }

    public void setMarcador(int marcador) {
        this.marcador = marcador;
    }
    private String nombre;
    private double latitud, longitud;

    public Arco(int id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public Arco(int id, String nombre, double latitud, double longitud, int tipo_alerta) {
        this.id = id;
        this.nombre = nombre;
        this.latitud = latitud;
        this.longitud = longitud;
        this.tipo_alerta = tipo_alerta;
    }

    public int getTipo_alerta() {
        return tipo_alerta;
    }

    public void setTipo_alerta(int tipo_alerta) {
        this.tipo_alerta = tipo_alerta;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

 

    public double getLatitud() {
        return latitud;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public double getLongitud() {
        return longitud;
    }

    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }
    
    
    
}
