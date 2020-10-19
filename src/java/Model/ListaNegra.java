
package Model;

import java.sql.Timestamp;

/**
 *
 * @author Alejandro Ortiz
 * @date 6/09/2020
 * @time 04:09:17 PM
 * @nombre Lista
 * @objetivo:
 */
public class ListaNegra {

    public ListaNegra(String in_action, int id_lista, String niv, String placa, Timestamp fech_hr_ini, Timestamp fech_hr_fin, String motivo, int tipo_lista, int id_usuario, int estado_registro, Timestamp fech_hr_creo, int id_usuario_act, Timestamp fech_hr_act, boolean reg_permanente, boolean cad, boolean udai, int id_udai) {
        this.in_action = in_action;
        this.id_lista = id_lista;
        this.niv = niv;
        this.placa = placa;
        this.fech_hr_ini = fech_hr_ini;
        this.fech_hr_fin = fech_hr_fin;
        this.motivo = motivo;
        this.tipo_lista = tipo_lista;
        this.id_usuario = id_usuario;
        this.estado_registro = estado_registro;
        this.fech_hr_creo = fech_hr_creo;
        this.id_usuario_act = id_usuario_act;
        this.fech_hr_act = fech_hr_act;
        this.reg_permanente = reg_permanente;
        this.cad = cad;
        this.udai = udai;
        this.id_udai = id_udai;
    }

   
    public ListaNegra() {
    }
    String in_action;
    int id_lista;
    String niv;
    String placa;
    Timestamp fech_hr_ini;
    Timestamp fech_hr_fin;
    String motivo;
    int tipo_lista;
    int id_usuario;
    int estado_registro;
    Timestamp fech_hr_creo;
    int id_usuario_act;
    Timestamp fech_hr_act;
    boolean reg_permanente;
    boolean cad;
    boolean udai;
    int id_udai;

    public String getIn_action() {
        return in_action;
    }

    public void setIn_action(String in_action) {
        this.in_action = in_action;
    }

    
    public int getId_lista() {
        return id_lista;
    }

    public void setId_lista(int id_lista) {
        this.id_lista = id_lista;
    }

    public String getNiv() {
        return niv;
    }

    public void setNiv(String niv) {
        this.niv = niv;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public Timestamp getFech_hr_ini() {
        return fech_hr_ini;
    }

    public void setFech_hr_ini(Timestamp fech_hr_ini) {
        this.fech_hr_ini = fech_hr_ini;
    }

    public Timestamp getFech_hr_fin() {
        return fech_hr_fin;
    }

    public void setFech_hr_fin(Timestamp fech_hr_fin) {
        this.fech_hr_fin = fech_hr_fin;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public int getTipo_lista() {
        return tipo_lista;
    }

    public void setTipo_lista(int tipo_lista) {
        this.tipo_lista = tipo_lista;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getEstado_registro() {
        return estado_registro;
    }

    public void setEstado_registro(int estado_registro) {
        this.estado_registro = estado_registro;
    }

    public Timestamp getFech_hr_creo() {
        return fech_hr_creo;
    }

    public void setFech_hr_creo(Timestamp fech_hr_creo) {
        this.fech_hr_creo = fech_hr_creo;
    }

    public int getId_usuario_act() {
        return id_usuario_act;
    }

    public void setId_usuario_act(int id_usuario_act) {
        this.id_usuario_act = id_usuario_act;
    }

    public Timestamp getFech_hr_act() {
        return fech_hr_act;
    }

    public void setFech_hr_act(Timestamp fech_hr_act) {
        this.fech_hr_act = fech_hr_act;
    }

    public boolean isReg_permanente() {
        return reg_permanente;
    }

    public void setReg_permanente(boolean reg_permanente) {
        this.reg_permanente = reg_permanente;
    }

    public boolean isCad() {
        return cad;
    }

    public void setCad(boolean cad) {
        this.cad = cad;
    }

    public boolean isUdai() {
        return udai;
    }

    public void setUdai(boolean udai) {
        this.udai = udai;
    }

    public int getId_udai() {
        return id_udai;
    }

    public void setId_udai(int id_udai) {
        this.id_udai = id_udai;
    }
            
    
    
}
