/*
    Controlador de la vista login.jsp
 */
package Controllers;

import Config.Conexion;
import java.io.FileNotFoundException;
//import Model.AdvertenciasPromedio;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.parser.ParseException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


public class Login {

    
    
    // Metodo para cargar el modelo, vista, controlador de login
    @RequestMapping(value = "login.htm") //1
    public ModelAndView controlador_add(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ParseException, IOException {
        return new ModelAndView("login");
    }
    
    // Metodo para la validacion del login
    @RequestMapping(value = "login_1.htm", method = RequestMethod.POST) //1
    public ModelAndView login1(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ParseException, IOException {
        ModelAndView mav = new ModelAndView();
        
        String usuario = request.getParameter("inputUsuario");
        String password = request.getParameter("inputPassword");
        
        if (validarUsuario(usuario, password)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("usuario", usuario);
            mav.setViewName("index");
            response.sendRedirect("index.htm");
            //session.setAttribute("advertenciasPromedio", getAdvertencias());
        } else {
            mav.setViewName("login");
        }
       
        return mav;
    }

    // Metodo privado para la validacion del usuario
    private boolean validarUsuario(String usuario, String password) throws FileNotFoundException, FileNotFoundException {
        boolean isValid = false;
        Conexion conexion = new Conexion();
        try (ResultSet r = conexion.query("select * from sp_validar_usuario('" + usuario + "','" + password + "');")) {
            if (r.next()) {
                String codigo = r.getString(1);
                if (codigo.equals("1")) {
                    isValid = true;
                }
            }
            conexion.executeQueryClose();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return isValid;
    }

    // Metodo para cerrar sesion
    @RequestMapping("logout.htm")
    protected ModelAndView logout(HttpServletResponse response, HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession(true);
        session.invalidate();
        ModelAndView mav = new ModelAndView();
        mav.setViewName("login");
        return mav;
    }

}