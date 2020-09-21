/*
    Controlador de la vista lectura_vehiculo_detalle.jsp
 */
package Controllers;

import Config.Conexion;
import Model.Arco;
import Model.bdd_remotas;
import java.io.IOException;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class lectura_vehiculo_detalle extends HttpServlet {

    
    PreparedStatement ps;
    ResultSet rs;

    // Metodo que consulta a la base de datos y retorna los datos a la vista.
    @RequestMapping("lecturas_vehiculo_detalle.htm") //1  
    public ModelAndView indexLecturas_vehiculos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession(false);
        Conexion Conexion = new Conexion();
        org.springframework.web.servlet.ModelAndView mav = new org.springframework.web.servlet.ModelAndView();
        if (session == null || !request.isRequestedSessionIdValid()) {
            mav.setViewName("login");
        } else {
            ResultSet rq = Conexion.query("select * from sp_acceso_datos_db();");
            ArrayList<bdd_remotas> bddRemotas = new ArrayList<>();

            try {
                while (rq.next()) {
                    bddRemotas.add(new bdd_remotas(
                            rq.getString("nombre"),
                            rq.getLong("accesodatos"),
                            "Status" + rq.getString("nombre").replace(" ", "")
                    ));
                }
            } catch (SQLException ex) {
                Logger.getLogger(index.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                rq.close();
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
            } catch (SQLException ex) {
                Logger.getLogger(index.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                rz.close();
            }

            mav.addObject("bddRemotas", bddRemotas);
            mav.addObject("arcos_option", arcos_option);
            mav.setViewName("lecturas_vehiculo_detalle");
        }
        return mav;

    }

}
