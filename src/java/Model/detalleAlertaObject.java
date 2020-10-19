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
public class detalleAlertaObject {
    private int idAlerta, idEtapa, idEstatus;
    private String alertaNombre, alertaLugar, alertaFecha, alertaHora, Placa, Niv, Tipo, Marca, Color, Etapa, Estatus, Comentario, Arco, direccionArco;
    private double latitud, longitud;
    
    public detalleAlertaObject(int idAlerta, String Etapa, int idEtapa, String Status, int idEstatus, String alertaNombre, 
            String Arco, String direccionArco,String alertaLugar, String alertaFecha, String alertaHora, String Tipo, String Marca, String Color,  
            String Placa, String Niv, double latitud, double longitud, String Comentario)
    {
        this.idAlerta = idAlerta;
        this.Etapa = Etapa;
        this.idEtapa = idEtapa;
        this.Estatus = Status;
        this.idEstatus = idEstatus; 
        this.alertaNombre = alertaNombre;
        this.alertaLugar = alertaLugar;
        this.Arco = Arco;
        this.direccionArco = direccionArco;
        this.alertaFecha = alertaFecha;
        this.alertaHora = alertaHora;
        this.Tipo = Tipo;
        this.Marca= Marca;
        this.Color = Color;
        this.Placa = Placa;
        this.Niv = Niv;
        this.latitud = latitud;
        this.longitud = longitud;
        this.Comentario = Comentario;
    }

      
    // Id Alerta
    public int getIdAlerta() {
      return idAlerta;
    };

    public void setIdAletra(int idAlerta) {
        this.idAlerta = idAlerta;
    };
    
     // Etapa
    public String getEtapa() {
      return Etapa;
    };

    public void setEstapa(String Etapa) {
        this.Etapa = Etapa;
    };
    
    //  Id Etapa
    public int getIdEtapa() {
      return idEtapa;
    };

    public void setIdEtapa(int idEtapa) {
        this.idEtapa = idEtapa;
    };
    
    
    // Estatus
    public String getEstatus() {
      return Estatus;
    };

    public void setEstatus(String Estatus) {
        this.Estatus = Estatus;
    };
    
     // Id Estatus
    public int getIdEstatus() {
      return idEstatus;
    };

    public void setIdEstatus(int idEstatus) {
        this.idEstatus = idEstatus;
    };
    
    
    // Nombre de alerta
    public String getAlertaName(){
        return alertaNombre;
    };
    
    public void setAlertaName(String alertaNombre){
        this.alertaNombre = alertaNombre;
    };
    // Lugar de la alerta
    public String getAlertaLugar(){
        return alertaLugar;
    };
    
    public void setAlertaLugar(String alertaLugar){
        this.alertaLugar = alertaLugar; 
    };
    
    // Arco de la alerta
    public String getArco(){
        return Arco;
    };
    
    public void setArco(String Arco){
        this.Arco= Arco; 
    };
    
    // Dirección de la alerta
    public String getDireccion(){
        return direccionArco;
    };
    
    public void setDireccion(String direccionArco){
        this.direccionArco= direccionArco; 
    };
    
    // Fecha de alerta
    public String getAlertaFecha (){
        return alertaFecha;
    };
    
    public void setAlertaFecha (String alertaFecha){
        this.alertaFecha = alertaFecha; 
    };
    
    // Hora de alerta 
    
    public String getAlertaHora (){
        return alertaHora;
    };
    
    public void setAlertaHora(String alertaHora){
        this.alertaHora= alertaHora;
    };
    
    // Tipo
    
    public String getTipo(){
        return Tipo;
    }
    
    public void setTipo(String Tipo){
        this.Tipo = Tipo;
    }
    
    // Marca 
    
    public String getMarca(){
        return Marca;
    }
    
    public void setMarca(String Marca){
        this.Marca = Marca;
    }
    
    // Color
    
    public String getColor (){
        return Color;
    }
    
    public void setColor(String Color){
        this.Color = Color; 
    }
    
    
    // Placa
    public String getPlaca (){
        return Placa;
    };
    
    public void setPlaca(String Placa){
        this.Placa= Placa;
    };
    
    // NIV 
    
     public String getNiv (){
        return Niv;
    };
    
    public void setNiv(String Niv){
        this.Niv= Niv;
    };
    // Latitud
    public double getLatitud (){
        return latitud;
    };
    
    public void setLatitud(double latitud){
        this.latitud= latitud;
    };
    // Longitud
    public double getLongitud (){
        return longitud;
    };
    
    public void setLongitud(double longitud){
        this.longitud= longitud;
    };
    
    public String getComentario (){
        return Comentario;
    }
    
    public void setComentario (String Comentario){
        this.Comentario = Comentario; 
    }
    
    
}
