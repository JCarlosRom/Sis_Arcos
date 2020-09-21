/*
        Esta clase corresponde al modelo de Colores
 */
package Model;

public class colores {
    private String id_color;
    private String color;

    public colores(String id_color, String color) {
        this.id_color = id_color;
        this.color = color;
    }

    public String getColor() {
        return color;
    }

    public String getId_color() {
        return id_color;
    }

    public void setId_color(String id_color) {
        this.id_color = id_color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    
}
