/*
    Controlador de la vista lectura_arco_detalle.jsp
 */
package Controllers;

import Config.Conexion;
import Model.Arco;
import Model.colores;
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
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.portlet.ModelAndView;

@Controller
public class lectura_arco_detalle {

    
    PreparedStatement ps;
    ResultSet rs;

    // Metodo para redireccionar a Lecturas_vehiculo
    @GetMapping("/Sis_Arcos/lecturas_vehiculo.htm")
    protected void lecturaVehiculo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("lecturas_vehiculo.htm");
    }
    
    // Metodo para redireccionar la pagina al index.
    @GetMapping("/Sis_Arcos/index.htm")
    protected void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.htm");
    }
    
    // Metodo que consulta a la base de datos y retorna los datos a la vista.
    @RequestMapping("lecturas_arco_detalle.htm") //1  
    public org.springframework.web.servlet.ModelAndView indexLecturas_vehiculos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        Conexion Conexion = new Conexion();
        HttpSession session = request.getSession(false);
        org.springframework.web.servlet.ModelAndView mav = new org.springframework.web.servlet.ModelAndView();
        if (session == null || !request.isRequestedSessionIdValid()) {
            mav.setViewName("login");
        } else {
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

            } catch (SQLException ex) {
                Logger.getLogger(index.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                rz.close();
                Conexion.executeQueryClose();
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

            } catch (SQLException ex) {
                Logger.getLogger(index.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                rx.close();
                Conexion.executeQueryClose();
            }

            mav.addObject("arcos_option", arcos_option);
            mav.addObject("colors", colors);

            mav.setViewName("lecturas_arco_detalle");
        }
        return mav;
    }

}
