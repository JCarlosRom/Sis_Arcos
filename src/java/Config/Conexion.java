package Config;

/*

    Clase para la conexion para la base de datos, contiene la conexion.

*/

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;



public class Conexion {
    
    public DriverManagerDataSource dataSource;
    //
    public static String servidorBD = "yimicol2020.ddns.net";
    public static String puertoBD = "5432";
    public static String nombreBD = "BD_Central_Arcos";
    public static String usuarioBD = "postgres";
    //public static String passwordBD = "NU3V0.M4N4G3R";
    public static String passwordBD = "kioadmin";
    
    public  Connection conexion = null;
    public  Statement stt_Sentencia = null;
    public  ResultSet resultSet;
    public JdbcTemplate jdbcTemplate;
    //public DriverManagerDataSource dataSource;
    
    public DriverManagerDataSource conectar() throws IOException
    {
        System.out.println("Inicializando configuraci[on de conexi'on...");
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUrl("jdbc:postgresql://"+servidorBD+":"+puertoBD+"/" + nombreBD);
        dataSource.setUsername(usuarioBD);
        dataSource.setPassword(passwordBD);
        System.out.println("Intentanto conectar base de datos...");
        // Inicializar conexi'on
        try{
            conexion = dataSource.getConnection();
            conexion.setAutoCommit(false);
            System.out.println("Conexi'on realizada exitosamente...");
        } catch (SQLException error) {
            conexion = null;
            System.err.println("Conexi'on fallida : " + error.getMessage());
        }
        return dataSource;
        
    }
    public JdbcTemplate createJdbcTemplate()
    {
        try{
            jdbcTemplate = new JdbcTemplate(dataSource);
        }catch(Exception error){
            jdbcTemplate = null;
        }
        return jdbcTemplate;
    }
    
    public ResultSet query(String sqlQuery) throws FileNotFoundException {
      try {
        // Conectar
        conectar();
        stt_Sentencia = conexion.createStatement();
        resultSet =stt_Sentencia.executeQuery(sqlQuery);
        
      } catch (IOException e) {
          System.err.println("Error al ejecutar Query:"+e.getMessage());
          return null;
      } catch (SQLException e) {
          System.err.println("Error al ejecutar Query:"+e.getMessage());
          return null;
        }
      return resultSet;
        
   }
    
   public boolean executeQueryClose() throws FileNotFoundException {
      try {
         stt_Sentencia.close();
         conexion.commit();
         conexion.close();
         return true;
      } catch (SQLException e) {
          System.err.println("Error al ejecutar Query:"+e.getMessage());
          return false;
      }
   }
   
   public boolean executeQueryCloseUpdate(){
      try {
         conexion.commit();
         conexion.close();
         return true;
      } catch (SQLException e) {
          System.err.println("Error al ejecutar Query:"+e.getMessage());
          return false;
      }
   }
   public int update(String SQL){
        //System.out.println(SQL);
        try{
            conectar();
            int Res = conexion.createStatement().executeUpdate(SQL);
            return Res;
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
            return 0;
        }
        /*return conexion.createStatement().executeUpdate(SQL);
        return 0;*/
        /*try {
            return CONEXION.createStatement().executeUpdate(SQL);
        } catch (SQLException ex) {
            System.err.println("Error update "+ex);
            return 0;
        }*/
    }
}

