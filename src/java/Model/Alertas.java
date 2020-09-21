/*
    Esta clase corresponde al modelo Alerta.
 */
package Model;


public class Alertas {
    private String tipo_registro;
    private double promedio;

    public String getTipo_registro() {
        return tipo_registro;
    }

    public void setTipo_registro(String tipo_registro) {
        this.tipo_registro = tipo_registro;
    }

    public double getPromedio() {
        return promedio;
    }

    public void setPromedio(double promedio) {
        this.promedio = promedio;
    }

    public Alertas(String tipo_registro, double promedio) {
        this.tipo_registro = tipo_registro;
        this.promedio = promedio;
    }
    
    
}
