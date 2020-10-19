/*
    Controlador de la vista index.jsp
 */
package Controllers;

import Config.Conexion;
import Model.Alertas;
import Model.Arco;
import Model.Lectura;
import Model.Arcos_Operando;
import Model.bdd_remotas;
import Model.lectura_vehiculo;
import Model.alertasPendientes;
import Model.Queries_index;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class index extends HttpServlet {
    
    PreparedStatement ps;
    ResultSet rs;
    lectura_vehiculo lv = new lectura_vehiculo();



    // Este metodo responte a la liga lecturas_arco.htm y carga el modelo vista controlador.
    @RequestMapping("index.htm")
    protected org.springframework.web.servlet.ModelAndView index(HttpServletResponse response, HttpServletRequest request) throws IOException, SQLException {
        Conexion Conexion = new Conexion();
        HttpSession session = request.getSession(false);
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
                            latitud,
                            longitud,
                            r.getInt("marcador")
                    ));
                }
                r.close();
                Conexion.executeQueryClose();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }

            ResultSet rz = Conexion.query("select * from sp_arcos_operando();");
            ArrayList<Arcos_Operando> arcosOp = new ArrayList<>();
            try {
                while (rz.next()) {
                    arcosOp.add(new Arcos_Operando(
                            rz.getInt("operando"),
                            rz.getInt("arcos")
                    ));
                }
                rz.close();
                Conexion.executeQueryClose();
            }  catch (Exception ex) {
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
            }  catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
          

            mav.addObject("arcos", arcos);
            
            mav.addObject("bddRemotas",  Queries_index.dbbDashboard().getBdd());
            mav.addObject("counterErrorDB", Queries_index.dbbDashboard().getCounterBDD());
            
            mav.addObject("lecturas", Queries_index.arcosDashboard().getArcos());
            mav.addObject("counterLecturas", Queries_index.arcosDashboard().getCounterArcos());
            
            mav.addObject("alertasPendientes", Queries_index.alertasDashboard().getAlerta());
            mav.addObject("counterAlertasPendientes", Queries_index.alertasDashboard().getCounterAlarmas());
            
            mav.addObject("arcosOp", arcosOp);
            mav.addObject("alertas_prom", alertas_prom);

            mav.setViewName("index");
        }
        return mav;
    }

    // Metodo para redireccionar a Lecturas_vehiculo.htm
    @GetMapping("lecturas_vehiculo.htm")
    protected org.springframework.web.servlet.ModelAndView  lecturas_vehiculo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Conexion Conexion = new Conexion();
        org.springframework.web.servlet.ModelAndView mav = new org.springframework.web.servlet.ModelAndView();
        ResultSet rq = Conexion.query("select * from sp_acceso_datos_db();");
        System.out.println("Hello");
        ArrayList<bdd_remotas> bddRemotas = new ArrayList<>();
        int counterErrorDB = 0;
        try {

            while (rq.next()) {
                if(rq.getLong("accesodatos")==0){
                    counterErrorDB+=1;
                }
                bddRemotas.add(new bdd_remotas(
                        rq.getString("nombre"),
                        rq.getLong("accesodatos"),
                        "Status" + rq.getString("nombre").replace(" ", "")
                ));
            }

            rq.close();
            Conexion.executeQueryClose();
        }  catch (Exception ex) {
            System.out.println(ex.getMessage());
        } 
        System.out.println("Hello");
        mav.addObject("counterErrorDB", counterErrorDB);
        mav.addObject("bddRemotas", bddRemotas);
        
        return mav;
    }
    
    // Metodo para cerrar sesion
    @GetMapping("/Sis_Arcos/logout.htm")
    protected void logOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("logout.htm");
    }

    // Metodo que consulta a la base de datos y retorna los datos a la vista.
    @RequestMapping(value = "listar_autos_interfazPrincipal.htm", method = RequestMethod.POST)
    public void listar_autos_interfazPrincipal(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Boolean critico = Boolean.parseBoolean(request.getParameter("danger"));
        Boolean informativo = Boolean.parseBoolean(request.getParameter("info"));
        Boolean advertencia = Boolean.parseBoolean(request.getParameter("warning"));
        int dias = Integer.parseInt(request.getParameter("dias"));

        PrintWriter out = response.getWriter();

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

        //JSONObject jsAlertasVehiculos = new JSONObject();
        JSONArray jsAlertasVehiculos = new JSONArray();

        JSONObject jsAlerta;
        int contador = 0;
        Conexion Conexion = new Conexion();
        Conexion Conexionres = new Conexion();
        try (ResultSet r = Conexion.query("select * from sp_consultar_alerta_arcos_interfaz1('" + dias + "','" + informativo1 + "','" + advertencia1 + "','" + critico1 + "') order by fecha_hora desc;")) {
            while (r.next()) {
                jsAlerta = new JSONObject();
                jsAlerta.put("tipo_registro", r.getString(1));
                jsAlerta.put("fecha_hora", r.getString(2));
                jsAlerta.put("nombre_arco", r.getString(3));
                jsAlerta.put("Descripcion", r.getString(4));
                jsAlerta.put("niv", r.getString(5));
                jsAlerta.put("fuente", r.getString(6));
                try (ResultSet res = Conexionres.query("select * from sp_ubicacion_arco('" + r.getString(7) + "')")) {
                    if (res.next()) {
                        jsAlerta.put("coordenadas", res.getString(1));
                    }
                    Conexionres.executeQueryClose();
                    res.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                
                jsAlerta.put("id_arco", r.getString(7));
                jsAlertasVehiculos.add(jsAlerta);
                contador++;
            }
            Conexion.executeQueryClose();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        

        // Aqui se trae las alertas de los arcos, ingresandolos a un JSON y agregandolo a un JSON para todas las alertas
        //JSONObject jsAlertasArcos = new JSONObject();
        JSONArray jsAlertasArcos = new JSONArray();
        JSONObject jsAlertas;
        contador = 0;

        try {
            ResultSet r = Conexion.query("select * from sp_consultar_alertas_arcos('" + dias + "','" + informativo1 + "','" + advertencia1 + "','" + critico1 + "') order by fecha_hora desc;");

            while (r.next()) {
                jsAlertas = new JSONObject();
                jsAlertas.put("fecha_hora", r.getString(1));
                jsAlertas.put("nombre_arco", r.getString(2));
                jsAlertas.put("nombre_alerta", r.getString(3));
                jsAlertas.put("ubicacion", r.getString(4));
                jsAlertas.put("tipo_registro", r.getString(5));
                try (ResultSet res = Conexionres.query("select * from sp_ubicacion_arco('" + r.getString(6) + "')")) {
                    if (res.next()) {
                        jsAlertas.put("coordenadas", res.getString(1));
                    }
                    Conexionres.executeQueryClose();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                jsAlertas.put("id_arco", r.getString("id_arco"));
                jsAlertasArcos.add(jsAlertas);
                contador++;
            }
            r.close();
            Conexion.executeQueryClose();
        } catch (Exception e) {
        }

        // Aqui se juntaron los dos JSON de las alertas en uno
        JSONObject jsTodasAlertas = new JSONObject();
        jsTodasAlertas.put("Alertas_Vehiculos", jsAlertasVehiculos);
        jsTodasAlertas.put("Alertas_Arcos", jsAlertasArcos);

        //System.out.println(jsTodasAlertas);
        out.print(jsTodasAlertas);

    }

    // Metodo que consulta la bandera en la base de datos y retorna 0 - 1 si hubo cambios o no.
    @RequestMapping(value = "verificar_cambios.htm", method = RequestMethod.POST)
    public void verificar_cambios(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Conexion Conexion = new Conexion();
        PrintWriter out = response.getWriter();
        int alertaarco = 0, alertaauto = 0, bddremotas = 0;
        try (ResultSet r = Conexion.query("select * from bandera;")) {
            while (r.next()) {
                alertaarco = Integer.parseInt(r.getString("alertaarco"));
                alertaauto = Integer.parseInt(r.getString("alertaauto"));
                bddremotas = Integer.parseInt(r.getString("bddremotas"));
            }
            
            r.close();
            Conexion.executeQueryClose();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        
            
        JSONObject cambios = new JSONObject();
        cambios.put("Alertas_Arco", alertaarco);
        cambios.put("Alertas_Auto", alertaauto);
        cambios.put("Alertas_BddRemotas", bddremotas);

        out.print(cambios);

    }

    // Metodo para cambiar el estado de la bandera de 1 a 0, en Alertas Arco y Alertas Vehiculo
    @RequestMapping(value = "cambio_estado_tablero.htm", method = RequestMethod.POST)
    public void cambio_estado_tablero(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Conexion Conexion = new Conexion();
        PrintWriter out = response.getWriter();
        
        try{
            int rowsAffected = Conexion.update("update bandera set alertaarco=0;");
            if (rowsAffected != 0) {
                System.out.println("Se afectarón " + rowsAffected + " filas.");
            }
            Conexion.executeQueryCloseUpdate();
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        
        try{
            int rowsAffected1 = Conexion.update("update bandera set alertaauto=0;");
            if (rowsAffected1 != 0) {
                System.out.println("Se afectarón " + rowsAffected1 + " filas.");
            }
            Conexion.executeQueryCloseUpdate();
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        out.print("Se afectaron las filas");
    }

    // Metodo para traer el porcentaje de las advertencias y mostrarlas en la vista.
    @RequestMapping(value = "porcentaje_alertas.htm", method = RequestMethod.POST)
    public void porcentaje_alertas(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
Conexion Conexion = new Conexion();
        JSONObject promedio = new JSONObject();
        try (ResultSet r = Conexion.query("select * from sp_advertencias_promedio();")) {
            while (r.next()) {
                promedio.put(r.getString("tipo_registro"), r.getString("promedio"));
            }
            Conexion.executeQueryClose();
            r.close();
        } catch (SQLException e) {
        }

        out.print(promedio);

    }
    
    
        // Metodo para traer el estado de conexion de las base de datos remotas
    @RequestMapping(value = "getAlertas.htm", method = RequestMethod.POST)
    public void getAlertas(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();

        JSONObject alertas = new JSONObject();
        Conexion Conexion = new Conexion();
        try {
            
              ResultSet r2 = Conexion.query("select a.id_alerta, cat.nombre as nombre, l.ubicacion, \n" +
                "concat(extract(day from a.fecha_hora),'/',extract(month from a.fecha_hora),'/',extract(year from a.fecha_hora)) as \"alertaFecha\", \n" +
                "concat(extract(hour from a.fecha_hora),':',extract(minute from a.fecha_hora)) as \"Hora\",\n" +
                "ul.fk_niv as \"Niv\", ul.placa as \"Placa\" from  alerta a left join cat_alerta cat on a.fk_id_cat_alerta = cat.id_cat_alerta \n" +
                "left join lector l on a.fk_id_lector = l.id_lector left join union_lecturas ul on a.fk_id_union_lectura = ul.id_union_lectura\n" +
                "where a.pendiente = 0;");
         
            while (r2.next()) {
                JSONObject alertas2 = new JSONObject();
                
                alertas2.put("idAlerta", r2.getInt("id_alerta"));
                alertas2.put("alertaNombre", r2.getString("nombre"));
                alertas2.put("alertaLugar", r2.getString("ubicacion"));
                alertas2.put("alertaFecha", r2.getString("alertaFecha"));
                alertas2.put("alertaHora", r2.getString("Hora"));
                alertas2.put("Placa", r2.getString("placa"));
                alertas2.put("Niv", r2.getString("niv"));
                
                alertas.put(r2.getInt("id_alerta"),alertas2);
               
            }
            r2.close();
            Conexion.executeQueryClose();
        } catch (Exception e) {
            System.out.println(e);
        }

        out.print(alertas);

    }

    // Metodo para traer el estado de conexion de las base de datos remotas
    @RequestMapping(value = "bdd_remotas.htm", method = RequestMethod.POST)
    public void bdd_remotas(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();

        JSONObject bdd = new JSONObject();
        Conexion Conexion = new Conexion();
        try {
            
            ResultSet r = Conexion.query("select * from sp_acceso_datos_db()");
            while (r.next()) {
                bdd.put(r.getString("nombre"), r.getString("accesodatos"));
            }
            r.close();
            Conexion.executeQueryClose();
        } catch (Exception e) {
        }

        out.print(bdd);

    }
    
    // Metodo para cambiar el estado de la bandera en el apartado bddremotas de 1 a 0.
    @RequestMapping(value = "cambio_bd_remotas.htm", method = RequestMethod.POST)
    public void cambio_bd_remotas(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        Conexion Conexion = new Conexion();
        int rowsAffected = Conexion.update("update bandera set bddremotas=0;");
        if (rowsAffected != 0) {
            System.out.println("Hola soy german y se afectarón " + rowsAffected + " filas.");
        }
        String resp = ("Se afectaron "+ rowsAffected);
        out.print(resp);
        Conexion.executeQueryClose();
    }
    
    //Metodos de Servelet creados automaticamente por la clase HttpServlet

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    String index = "/Sis_Arcos/index.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        lecturas_vehiculo(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        lecturas_vehiculo(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
