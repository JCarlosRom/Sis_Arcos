/*
    Esta clase corresponde al modelo de Arcos operando
 */
package Model;


public class Arcos_Operando {
    private int operando;
    private int arcos;

    public Arcos_Operando(int operando, int arcos) {
        this.operando = operando;
        this.arcos = arcos;
    }

    public int getOperando() {
        return operando;
    }

    public void setOperando(int operando) {
        this.operando = operando;
    }

    public int getArcos() {
        return arcos;
    }

    public void setArcos(int arcos) {
        this.arcos = arcos;
    }
    
    
}
