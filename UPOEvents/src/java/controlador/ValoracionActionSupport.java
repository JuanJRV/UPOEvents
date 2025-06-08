/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.ws.rs.core.GenericType;
import modelo.entidades.Valoracion;
import modelo.entidades.Usuario;
import modelo.jersey.ValoracionJerseyClient;

/**
 *
 * @author artur
 */
public class ValoracionActionSupport extends ActionSupport {

    private List<Valoracion> listaValoracion;
    private Map session = (Map) ActionContext.getContext().get("session");
    private ValoracionJerseyClient valoracionCliente = new ValoracionJerseyClient();
    private String idValoracion;
    private String inputRate;

    public ValoracionActionSupport() {
    }

    public String execute() throws Exception {
        return SUCCESS;
    }

    /**
     * Carga las valoraciones del usuario logeado.
     *
     * @return the result of the action
     */
    public String cargarValoraciones() {
        Usuario usuario = (Usuario) session.get("USUARIO");
        GenericType<List<Valoracion>> genericValoracion = new GenericType<List<Valoracion>>() {
        };
        List<Valoracion> valoraciones = valoracionCliente.findAll_XML(genericValoracion);
        listaValoracion = new ArrayList<>();

        for (int i = 0; i < valoraciones.size(); i++) {
            if (valoraciones.get(i).getUsuario().getEmail().equals(usuario.getEmail())) {
                listaValoracion.add(valoraciones.get(i));
            }
        }
        return SUCCESS;
    }

    /**
     * Eliminar valoracion
     *
     * @return the result of the action
     */
    public String eliminarValoracion() {
        valoracionCliente.remove(idValoracion);
        cargarValoraciones();

        return SUCCESS;
    }

    /**
     * Editar valoracion
     *
     * @return the result of the action
     */
    public String editarValoracion() {
        Valoracion valoracion = valoracionCliente.find_XML(Valoracion.class, idValoracion);
        valoracion.setValoracion(Integer.parseInt(inputRate));
        valoracionCliente.edit_XML(valoracion, String.valueOf(valoracion.getIdValoracion()));

        cargarValoraciones();

        return SUCCESS;
    }

    //Getters and Setters
    public List<Valoracion> getListaValoracion() {
        return listaValoracion;
    }

    public void setListaValoracion(List<Valoracion> listaValoracion) {
        this.listaValoracion = listaValoracion;
    }

    public Map getSession() {
        return session;
    }

    public void setSession(Map session) {
        this.session = session;
    }

    public String getIdValoracion() {
        return idValoracion;
    }

    public void setIdValoracion(String idValoracion) {
        this.idValoracion = idValoracion;
    }

    public String getInputRate() {
        return inputRate;
    }

    public void setInputRate(String inputRate) {
        this.inputRate = inputRate;
    }

}
