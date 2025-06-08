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
import modelo.entidades.Bloqueo;
import modelo.entidades.Usuario;
import modelo.jersey.BloqueoJerseyClient;

/**
 *
 * @author artur
 */
public class BloqueoActionSupport extends ActionSupport {

    private List<Bloqueo> listaBloqueos;
    private Map session = (Map) ActionContext.getContext().get("session");
    private BloqueoJerseyClient bloqueoCliente = new BloqueoJerseyClient();
    private String idBloqueo;

    public BloqueoActionSupport() {
    }

    public String execute() throws Exception {
        return SUCCESS;
    }
    /**
     * Carga bloqueos para el usuario actual.
     * 
     * @return the result of the action
     */
    public String cargarBloqueos() {
        Usuario usuario = (Usuario) session.get("USUARIO");
        GenericType<List<Bloqueo>> genericBloqueo = new GenericType<List<Bloqueo>>() {
        };
        List<Bloqueo> bloqueos = bloqueoCliente.findAll_XML(genericBloqueo);
        listaBloqueos = new ArrayList<>();

        for (int i = 0; i < bloqueos.size(); i++) {
            if (bloqueos.get(i).getBloqueador().getEmail().equals(usuario.getEmail())) {
                listaBloqueos.add(bloqueos.get(i));
            }
        }
        return SUCCESS;
    }
     /**
     * Elimina un bloqueo por su id.
     * 
     * @return the result of the action
     */
    public String eliminarBloqueo() {
        bloqueoCliente.remove(idBloqueo);
        cargarBloqueos();

        return SUCCESS;
    }
    // Getters and Setters
    public List<Bloqueo> getListaBloqueos() {
        return listaBloqueos;
    }

    public void setListaBloqueos(List<Bloqueo> listaBloqueos) {
        this.listaBloqueos = listaBloqueos;
    }

    public Map getSession() {
        return session;
    }

    public void setSession(Map session) {
        this.session = session;
    }

    public String getIdBloqueo() {
        return idBloqueo;
    }

    public void setIdBloqueo(String idBloqueo) {
        this.idBloqueo = idBloqueo;
    }

}
