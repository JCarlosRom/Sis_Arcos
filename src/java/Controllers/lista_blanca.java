package Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import Config.Conexion;
import static Controllers.lista_negra.convertDateFromAppToDb;
import static Controllers.lista_negra.convertToNewFormat;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import Model.ListaNegra;
import Model.cat_udai;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.jdbc.core.CallableStatementCreator;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Alejandro Ortiz
 * @date 5/09/2020
 * @time 02:15:01 PM
 * @nombre listaBlanca
 * @objetivo:
 */
@Controller
public class lista_blanca {
// Metodo para redireccionar a listaNegra.htm

    PreparedStatement ps;
    ResultSet rs;
    static private JdbcTemplate jdbcTemplate;
    Conexion conect = new Conexion();

    public lista_blanca() throws IOException {
        jdbcTemplate = new JdbcTemplate(conect.conectar());
    }

    @GetMapping("listaBlanca.htm")
    public String lista_blanca() {
        return "listaBlanca";
    }

    @RequestMapping("listaBlanca_detalle.htm")
    public String listaBlanca_detalle() {
        return "listaBlanca_detalle";
    }

    @RequestMapping(value = "insertarListaBlanca.htm", method = RequestMethod.POST)
    public void insertar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ParseException, java.text.ParseException {
        int id_lista = Integer.parseInt(request.getParameter("id_lista"));

        List<SqlParameter> parameters = Arrays.asList(
                new SqlParameter(Types.BIGINT),
                new SqlOutParameter("exito", Types.INTEGER),
                new SqlOutParameter("mensaje", Types.VARCHAR)
        );

        Map<String, Object> t = jdbcTemplate.call(new CallableStatementCreator() {
            @Override
            public CallableStatement createCallableStatement(Connection con) throws SQLException {
                String fecha_i;
                String fecha_f;
                CallableStatement callableStatement = con.prepareCall("{call sp_lista_blanca_negra_cud (?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                callableStatement.setString(1, request.getParameter("act"));
                callableStatement.setInt(2, Integer.parseInt(request.getParameter("id_lista")));
                callableStatement.setString(3, request.getParameter("niv"));
                callableStatement.setString(4, request.getParameter("placa"));
                try {
                   boolean reg_permanent = Boolean.parseBoolean(request.getParameter("optRadioReg"));
                    if (!reg_permanent) {
                        fecha_i = convertToNewFormat(request.getParameter("modFechaInicial"));
                        callableStatement.setTimestamp(5, convertDateFromAppToDb(fecha_i));
                    } else {
                        fecha_i = "0001-01-01 00:00:00";
                        callableStatement.setTimestamp(5, convertDateFromAppToDb(fecha_i));
                    }
                    if (!request.getParameter("modFechaInicial").equals("")) {
                        fecha_f = convertToNewFormat(request.getParameter("modFechaFinal"));
                        callableStatement.setTimestamp(6, convertDateFromAppToDb(fecha_f));
                    } else {
                        fecha_f = "0001-01-01 00:00:00";
                        callableStatement.setTimestamp(6, convertDateFromAppToDb(fecha_f));
                    }

                } catch (java.text.ParseException ex) {
                    Logger.getLogger(lista_negra.class.getName()).log(Level.SEVERE, null, ex);
                }
                callableStatement.setString(7, request.getParameter("motivo"));
                callableStatement.setInt(8, Integer.parseInt(request.getParameter("tipoLista")));
                callableStatement.setInt(9, 1);
                if (id_lista == 0) {
                    callableStatement.setInt(10, 1);
                } else {
                    callableStatement.setInt(10, Integer.parseInt(request.getParameter("edo_registro")));//1 activo /2 inactivo para la tabla
                }
                callableStatement.setBoolean(11, Boolean.parseBoolean(request.getParameter("optRadioReg")));
                callableStatement.setBoolean(12, false);
                callableStatement.setBoolean(13, false);
                callableStatement.setInt(14, 0);
                callableStatement.registerOutParameter(2, Types.INTEGER);
                callableStatement.registerOutParameter(3, Types.VARCHAR);
                return callableStatement;
            }
        }, parameters);

        System.out.println("Mensaje: " + t.get("mensaje"));
        System.out.println("Exito: " + t.get("exito"));

    }

    @RequestMapping(value = "actualizar_edoBlanca.htm", method = RequestMethod.POST)
    public void actualizar_edo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ParseException, java.text.ParseException {
        System.out.println(request.getParameter("act"));
        System.out.println(Integer.parseInt(request.getParameter("id_lista")));
        System.out.println(request.getParameter("check"));
        List<SqlParameter> parameters = Arrays.asList(
                new SqlParameter(Types.BIGINT),
                new SqlOutParameter("exito", Types.INTEGER),
                new SqlOutParameter("mensaje", Types.VARCHAR)
        );

        Map<String, Object> t = jdbcTemplate.call(new CallableStatementCreator() {
            @Override
            public CallableStatement createCallableStatement(Connection con) throws SQLException {

                CallableStatement callableStatement = con.prepareCall("{call sp_lista_blanca_negra_cud (?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                callableStatement.setString(1, request.getParameter("act"));
                callableStatement.setInt(2, Integer.parseInt(request.getParameter("id_lista")));
                callableStatement.setString(3, String.valueOf(0));
                callableStatement.setString(4, String.valueOf(0));
                try {
                    //String fecha_i = convertToNewFormat(request.getParameter("2020-09-08 14:19"));
                    //String fecha_f = convertToNewFormat(request.getParameter("2020-09-08 14:19"));    
                    callableStatement.setTimestamp(5, convertDateFromAppToDb("2020-09-08 14:19"));
                    callableStatement.setTimestamp(6, convertDateFromAppToDb("2020-09-08 14:19"));
                } catch (java.text.ParseException ex) {
                    Logger.getLogger(lista_negra.class.getName()).log(Level.SEVERE, null, ex);
                }
                callableStatement.setString(7, String.valueOf(0));
                callableStatement.setInt(8, 0);
                callableStatement.setInt(9, 1);
                callableStatement.setInt(10, Integer.parseInt(request.getParameter("check")));//1 activo /2 inactivo para la tabla
                callableStatement.setBoolean(11, false);
                callableStatement.setBoolean(12, false);
                callableStatement.setBoolean(13, false);
                callableStatement.setInt(14, 0);
                callableStatement.registerOutParameter(2, Types.INTEGER);
                callableStatement.registerOutParameter(3, Types.VARCHAR);
                return callableStatement;
            }
        }, parameters);

        PrintWriter out = response.getWriter();
        JSONObject item = new JSONObject();
        item.put("Mensaje: ", t.get("mensaje"));
        item.put("Exito: ", t.get("exito"));
        out.print(item);
    }

    @RequestMapping(value = "/getListaBlanca.htm", method = RequestMethod.GET)
    public void getListaBlanca(HttpServletResponse response) throws java.text.ParseException, IOException {
        String SQL = "SELECT * FROM sp_lista_blanca_get();";
        List<ListaNegra> listNegr = jdbcTemplate.query(SQL, (ResultSet rs, int i) -> {
            ListaNegra ln = new ListaNegra();

            ln.setId_lista(rs.getInt(1));
            ln.setNiv(rs.getString(2));
            ln.setPlaca(rs.getString(3));
            ln.setFech_hr_ini(rs.getTimestamp(4));
            ln.setFech_hr_fin(rs.getTimestamp(5));
            ln.setMotivo(rs.getString(6));
            ln.setEstado_registro(rs.getString(11).equals("Activo") ? 1 : 2);
            ln.setReg_permanente(rs.getBoolean(12));
            return ln;
        });
        PrintWriter out = response.getWriter();
        JSONArray list = new JSONArray();
        for (ListaNegra ln : listNegr) {
            JSONObject item = new JSONObject();
            //System.out.println(ln.getId_lista());
            item.put("Id_lista", ln.getId_lista());

            if (ln.isReg_permanente() == true) {
                item.put("fecha_i_fecha_f", "Permanente");
            } else {
                item.put("fecha_i_fecha_f", ln.getFech_hr_ini().toString() + "<br>" + ln.getFech_hr_fin().toString());
            }
            item.put("placa_niv", "PLACA: " + ln.getPlaca() + "<br> NIV: " + ln.getNiv());
            item.put("Motivo", ln.getMotivo());
            item.put("Estado_registro", ln.getEstado_registro() == 1 ? "Activo" : "Inactivo");
            item.put("Registro_permanente", ln.isReg_permanente());
            list.add(item);
        }
        out.print(list);
    }

    //MÉTODOS PARA FORMATEAR FECHAS
    public static String convertToNewFormat(String dateStr) throws java.text.ParseException {
        SimpleDateFormat sourceFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        SimpleDateFormat destFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date convertedDate = sourceFormat.parse(dateStr);
        return destFormat.format(convertedDate);
    }

    public static String convertToTIMESTAMPTOLOCAL(String dateStr) throws java.text.ParseException {
        SimpleDateFormat sourceFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        SimpleDateFormat destFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date convertedDate = sourceFormat.parse(dateStr);
        return destFormat.format(convertedDate);
    }

    public static Timestamp convertDateFromAppToDb(String date) throws java.text.ParseException {
        //Este metodo da formato a la fecha cuando el tipo de dato es TimeStamp
        String formato = "yyyy-MM-dd HH:mm";
        SimpleDateFormat formatter = new SimpleDateFormat(formato);
        //String date = "20:35:21 16/10/2018";
        java.util.Date formateado = formatter.parse(date);
        String newFormat = "yyyy-MM-dd HH:mm:ss";
        formatter = new SimpleDateFormat(newFormat);
        String form2 = formatter.format(formateado);
        Timestamp DateTimeStamp = Timestamp.valueOf(form2);
        return DateTimeStamp;
    }

    @RequestMapping(value = "/getRegitroByIdBlanca.htm", method = RequestMethod.GET)
    public void getRegitroById(HttpServletResponse response, HttpServletRequest request) throws java.text.ParseException, IOException {
        int id_lista = Integer.parseInt(request.getParameter("id_lista"));
        PrintWriter out = response.getWriter();
        String SQL = "SELECT * FROM lista_blanca_negra WHERE id_lista='" + id_lista + "';";

        List<ListaNegra> listbyID = jdbcTemplate.query(SQL, (ResultSet rs, int i) -> {
            ListaNegra lista = new ListaNegra();
            lista.setId_lista(rs.getInt(1));
            lista.setNiv(rs.getString(2));
            lista.setPlaca(rs.getString(3));
            lista.setFech_hr_ini(rs.getTimestamp(4));
            lista.setFech_hr_fin(rs.getTimestamp(5));
            lista.setMotivo(rs.getString(6));
            lista.setTipo_lista(rs.getInt(7));
            lista.setEstado_registro(rs.getInt(9));
            lista.setReg_permanente(rs.getBoolean(13));
            lista.setCad(rs.getBoolean(14));
            lista.setUdai(rs.getBoolean(15));
            lista.setId_udai(rs.getInt(16));

            return lista;
        });
        JSONArray list = new JSONArray();
        for (ListaNegra ln : listbyID) {
            JSONObject item = new JSONObject();
            //System.out.println(ln.getId_lista());
            item.put("Id_lista", ln.getId_lista());
            item.put("Niv", ln.getNiv());
            item.put("Placa", ln.getPlaca());
            item.put("Fech_hr_ini", convertToTIMESTAMPTOLOCAL(ln.getFech_hr_ini().toString()));
            item.put("Fech_hr_fin", convertToTIMESTAMPTOLOCAL(ln.getFech_hr_fin().toString()));
            item.put("Motivo", ln.getMotivo());
            item.put("Estado", ln.getEstado_registro());
            item.put("Tipo_lista", ln.getTipo_lista());
            item.put("Reg_permanente", ln.isReg_permanente());
            item.put("CAD", ln.isCad());
            item.put("UDAI", ln.isUdai());
            item.put("fk_udai", ln.getId_udai());
            list.add(item);
        }
        out.print(list);
    }

    @RequestMapping(value = "/searchRangeBlanca.htm", method = RequestMethod.GET)
    public void BuscarPorFechaListaNegra(HttpServletRequest request, HttpServletResponse response) throws java.text.ParseException, IOException {
        PrintWriter out = response.getWriter();
        String f_i = convertToNewFormat(request.getParameter("fecha_ini"));
        String f_f = convertToNewFormat(request.getParameter("fecha_fin"));
        int tipo_lista = Integer.parseInt(request.getParameter("id_tipo_lista"));

        String SQL = "SELECT * FROM lista_blanca_negra WHERE fech_hr_ini >= '" + f_i + "' AND fech_hr_fin <=  '" + f_f + "' AND tipo_lista = '" + tipo_lista + "';";
        System.out.println(SQL);
        List<ListaNegra> listNegr = jdbcTemplate.query(SQL, (ResultSet rs, int i) -> {
            ListaNegra ln = new ListaNegra();

            ln.setId_lista(rs.getInt(1));
            ln.setNiv(rs.getString(2));
            ln.setPlaca(rs.getString(3));
            ln.setFech_hr_ini(rs.getTimestamp(4));
            ln.setFech_hr_fin(rs.getTimestamp(5));
            ln.setMotivo(rs.getString(6));
            ln.setEstado_registro(rs.getInt(9));
            System.out.println(ln.getEstado_registro());
            return ln;
        });
        JSONArray list = new JSONArray();
        for (ListaNegra ln : listNegr) 
        { 
            JSONObject item = new JSONObject();
            //System.out.println(ln.getId_lista());
            item.put("Id_lista", ln.getId_lista());
            
            if(ln.isReg_permanente()==true){
                item.put("fecha_i_fecha_f","Permanente");
            }else{
                item.put("fecha_i_fecha_f",ln.getFech_hr_ini().toString()+"<br>"+ln.getFech_hr_fin().toString());
            }      
            item.put("placa_niv","PLACA: "+ln.getPlaca()+"<br> NIV: "+ln.getNiv());
            item.put("Motivo", ln.getMotivo());
            item.put("Estado_registro", ln.getEstado_registro()==1? "Activo":"Inactivo");
            item.put("Registro_permanente", ln.isReg_permanente());
            list.add(item);
        }
        out.print(list);
    }

    private List<cat_udai> getCatUdai() {
        String SQL = "SELECT * FROM cat_udai WHERE activo = 1";
        List<cat_udai> lista = jdbcTemplate.query(SQL, (ResultSet rs, int i) -> {
            cat_udai ln = new cat_udai();

            try {
                ln.setId_cat_udai(rs.getInt(1));
            } catch (SQLException ex) {
                Logger.getLogger(lista_blanca.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                ln.setClave_udai(rs.getString(2));
            } catch (SQLException ex) {
                Logger.getLogger(lista_blanca.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                ln.setNombre_udai(rs.getString(3));
            } catch (SQLException ex) {
                Logger.getLogger(lista_blanca.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                ln.setActivo(rs.getInt(4));
            } catch (SQLException ex) {
                Logger.getLogger(lista_blanca.class.getName()).log(Level.SEVERE, null, ex);
            }
            return ln;
        });

        return lista;
    }
}
