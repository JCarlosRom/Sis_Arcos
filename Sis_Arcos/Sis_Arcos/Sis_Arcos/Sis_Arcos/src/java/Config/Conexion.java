package Config;

import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;



public class Conexion {
    
    private final static Connection CONEXION = conection();
    static Connection con;
    
    private static Connection conection(){
        try {
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/BD_Central_Arcos", "postgres", "1234");
            //con = DriverManager.getConnection("jdbc:postgresql://yimicol2020.ddns.net:5432/BD_Central_Arcos", "postgres", "kioadmin");
            //con = DriverManager.getConnection("jdbc:postgresql://192.168.1.66:5432/BD_Central_Arcos", "postgres", "kioadmin");
            
            return con;
        } catch (SQLException ex) {
            System.err.println("Error de conexion "+ex);
        }
        return null;
    }
    
    public static ResultSet query(String SQL){
        //System.out.println(SQL);
        try {
            return CONEXION.createStatement().executeQuery(SQL);
        } catch (SQLException ex) {
            System.err.println("Error query "+ex);
            return null;
        }   
    }
    
    public static int update(String SQL){
        System.out.println(SQL);
        try {
            return CONEXION.createStatement().executeUpdate(SQL);
        } catch (SQLException ex) {
            System.err.println("Error update "+ex);
            return 0;
        }
    }

    public Connection getConnection() {
        return con;
    }
}

