/*
    Controlador de la vista lectura_arco.jsp
 */
package Controllers;

import Config.Conexion;
import Model.Alertas;
import Model.Arco;
import Model.bdd_remotas;
import Model.colores;
import Model.lectura_arco_detalle;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.portlet.ModelAndView;


@Controller
public class lectura_arco {

    
    PreparedStatement ps;
    ResultSet rs;
    
   // Metodo para redireccionar a Lecturas_vehiculo.htm
    @GetMapping("/Sis_Arcos/lecturas_vehiculo.htm")
    protected void lecturaVehiculo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("lecturas_vehiculo.htm");
    }
    
    // Metodo para redireccionar a index.htm
    @GetMapping("/Sis_Arcos/index.htm")
    protected void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.htm");
    }
    
    // Metodo que consulta a la base de datos y retorna los datos a la vista.
    @RequestMapping(value = "consultar_alertas_arcos.htm", method = RequestMethod.POST)
    public void lecturas_arco(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        Boolean critico = Boolean.parseBoolean(request.getParameter("danger"));
        Boolean informativo = Boolean.parseBoolean(request.getParameter("info"));
        Boolean advertencia = Boolean.parseBoolean(request.getParameter("warning"));
        int critico1 = 0, informativo1 = 0, advertencia1 = 0;

        if (critico == true) {
            critico1 = 1;
        }
        if (informativo == true) {
            informativo1 = 1;
        }
        if (advertencia == true) {
            advertencia1 = 1;
        }

        String fecha_inicial = request.getParameter("fecha_inicial");
        String fecha_final = request.getParameter("fecha_final");
        String id_arco = request.getParameter("id_arco");
        String color = request.getParameter("color");

        Boolean Motocicleta = Boolean.parseBoolean(request.getParameter("Motocicleta"));
        Boolean Carro = Boolean.parseBoolean(request.getParameter("Carro"));
        Boolean Taxi = Boolean.parseBoolean(request.getParameter("Taxi"));
        Boolean Camion = Boolean.parseBoolean(request.getParameter("Camion"));
        Boolean Camioneta = Boolean.parseBoolean(request.getParameter("Camioneta"));

        ArrayList<String> tipo_vehiculo = new ArrayList<>();

        if (Motocicleta == true) {
            tipo_vehiculo.add("Motocicleta");
        }
        if (Carro == true) {
            tipo_vehiculo.add("Carro");
        }
        if (Taxi == true) {
            tipo_vehiculo.add("Taxi");
        }
        if (Camion == true) {
            tipo_vehiculo.add("Camion");
        }
        if (Camioneta == true) {
            tipo_vehiculo.add("Camioneta");
        }

        JSONObject jsAlertas = new JSONObject();
        JSONArray jsAlertasTodas = new JSONArray();
        Conexion Conexion = new Conexion();
        Conexion ConexionRes = new Conexion();

        
        for (int i = 0; i <= tipo_vehiculo.size(); i++) {
            try {
                System.out.println("Entro por: " + tipo_vehiculo.get(i));
                String querySql="select * from sp_consultar_lectura_vehiculo_tipo_vehiculo('" + fecha_inicial + "','" + fecha_final + "','" + id_arco + "','" + informativo1 + "','" + advertencia1 + "','" + critico1 + "','" + tipo_vehiculo.get(i) + "','" + color + "') order by fecha_hora desc;";
                System.out.println(querySql);
                ResultSet rs = Conexion.query("select * from sp_consultar_lectura_vehiculo_tipo_vehiculo('" + fecha_inicial + "','" + fecha_final + "','" + id_arco + "','" + informativo1 + "','" + advertencia1 + "','" + critico1 + "','" + tipo_vehiculo.get(i) + "','" + color + "') order by fecha_hora desc;");
                
                while (rs.next()) {
                    jsAlertas = new JSONObject();
                    jsAlertas.put("tipo_registro", rs.getString(1));
                    jsAlertas.put("fecha_hora", rs.getString(2));
                    jsAlertas.put("nombre_arco", rs.getString(3));
                    jsAlertas.put("descripcion", rs.getString(4));
                    jsAlertas.put("niv", rs.getString(5));
                    jsAlertas.put("fuente", rs.getString(6));
                    jsAlertas.put("placa", rs.getString(7));
                    ResultSet res = ConexionRes.query("select * from sp_ubicacion_arco('" + rs.getString(8) + "')");
                    while(res.next()){
                        jsAlertas.put("coordenadas", res.getString(1));
                    }
                    res.close();
                    ConexionRes.executeQueryClose();
                    jsAlertasTodas.add(jsAlertas);
                }
                //rs.close();
                Conexion.executeQueryClose();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            
        }
        
        System.out.println(jsAlertasTodas);
        out.print(jsAlertasTodas);

    }
    
    // Este metodo responte a la liga lecturas_arco.htm y carga el modelo vista controlador.
    @RequestMapping("lecturas_arco.htm") //1  
    public org.springframework.web.servlet.ModelAndView indexLecturas_vehiculos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession(false);
        Conexion Conexion = new Conexion();
        org.springframework.web.servlet.ModelAndView mav = new org.springframework.web.servlet.ModelAndView();
        if (session == null || !request.isRequestedSessionIdValid()) {
            mav.setViewName("login");
        } else {

            ResultSet r = Conexion.query("SELECT * from public.sp_consultar_arcos();");
            ArrayList<Arco> arcos = new ArrayList<>();

            try {
                while (r.next()) {
                    double latitud, longitud;
                    String[] LatLng = r.getString("ubicacion").split(", ");
                    latitud = Double.parseDouble(LatLng[0].trim());
                    longitud = Double.parseDouble(LatLng[1].trim());

                    arcos.add(new Arco(
                            r.getInt("id_lector"),
                            r.getString("nombre"),
                            r.getString("descripcion"),
                            latitud,
                            longitud,
                            r.getInt("marcador")
                    ));
                }
                r.close();
                Conexion.executeQueryClose();
                System.out.println("ARCOS_ENCONTRADOS: " + arcos.size());

            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            } 

            ResultSet rs = Conexion.query("select * from sp_acceso_datos_db();");
            ArrayList<bdd_remotas> bddRemotas = new ArrayList<>();
            int counterErrorDB =0; 
            try {
                while (rs.next()) {
                    
                    if(rs.getLong("accesodatos")==0){
                        counterErrorDB+=1;
                    }
                    bddRemotas.add(new bdd_remotas(
                            rs.getString("nombre"),
                            rs.getLong("accesodatos"),
                            "Status" + rs.getString("nombre").replace(" ", "")
                    ));
                }
                rs.close();
                Conexion.executeQueryClose();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            } 

            ResultSet rz = Conexion.query("select * from sp_consultar_arcos();");
            ArrayList<Arco> arcos_option = new ArrayList<>();

            try {
                while (rz.next()) {
                    arcos_option.add(new Arco(
                            rz.getInt("id_lector"),
                            rz.getString("nombre")
                    ));
                }
                rz.close();
                Conexion.executeQueryClose();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            } 

            ResultSet rx = Conexion.query("select u.color as color from unidad_registro_repuve u group by u.color;");
            ArrayList<colores> colors = new ArrayList<>();

            try {
                while (rx.next()) {
                    colors.add(new colores(
                            rx.getString("color").replace(" ", "_"),
                            rx.getString("color")
                    ));
                }
                rx.close();
                Conexion.executeQueryClose();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            } 

            ResultSet ry = Conexion.query("select * from sp_advertencias_promedio();");
            ArrayList<Alertas> alertas_prom = new ArrayList<>();

            try {
                while (ry.next()) {
                    alertas_prom.add(new Alertas(
                            ry.getString("tipo_registro"),
                            ry.getDouble("promedio")
                    ));
                }
                ry.close();
                Conexion.executeQueryClose();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            } 

            mav.addObject("arcos", arcos);
            mav.addObject("bddRemotas", bddRemotas);
            mav.addObject("counterErrorDB", counterErrorDB);
            mav.addObject("arcos_option", arcos_option);
            mav.addObject("colors", colors);
            mav.addObject("alertas_prom", alertas_prom);

            mav.setViewName("lecturas_arco");
        }
        return mav;
    }
    
    //Metodo para mostrar los Log's
    private void log(String TAG, String message) {
        System.out.println("Log: " + TAG + "\t" + message);
    }
}
