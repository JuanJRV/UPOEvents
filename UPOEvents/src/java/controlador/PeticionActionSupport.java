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
import modelo.entidades.Asistente;
import modelo.entidades.Peticion;
import modelo.entidades.Usuario;
import modelo.entidades.Evento;
import modelo.jersey.AsistenteJerseyClient;
import modelo.jersey.PeticionJerseyClient;
import modelo.jersey.EventoJerseyClient;

/**
 *
 * @author artur
 */

public class PeticionActionSupport extends ActionSupport {

    private String idEvento;
    private String idPeticion;
    private Map session = (Map) ActionContext.getContext().get("session");

    private EventoJerseyClient eventoCliente = new EventoJerseyClient();
    private PeticionJerseyClient peticionCliente = new PeticionJerseyClient();
    private AsistenteJerseyClient asistenteCliente = new AsistenteJerseyClient();

    private List<Peticion> peticionesEnviadas;
    private List<Peticion> peticionesRecividas;

    public PeticionActionSupport() {
    }

    public String execute() {
        return SUCCESS;
    }
    
    /**
     * Envia una peticion
     *
     * @return the result of the action
     */
    public String enviarPeticion() {
        Usuario usuario = (Usuario) session.get("USUARIO");
        Evento evento = eventoCliente.find_XML(Evento.class, idEvento);
        Peticion peticion = new Peticion(null, "WAITING");
        peticion.setUsuario(usuario);
        peticion.setEvento(evento);
        peticionCliente.create_XML(peticion);

        return SUCCESS;
    }
    
    /**
     * Carga peticiones
     *
     * @return the result of the action
     */
    public String cargarPeticiones() {
        Usuario usuario = (Usuario) session.get("USUARIO");
        GenericType<List<Peticion>> genericPeticion = new GenericType<List<Peticion>>() {
        };
        List<Peticion> peticiones = peticionCliente.findAll_XML(genericPeticion);
        peticionesEnviadas = new ArrayList<>();
        peticionesRecividas = new ArrayList<>();

        for (int i = 0; i < peticiones.size(); i++) {
            if (peticiones.get(i).getUsuario().getEmail().equals(usuario.getEmail())) {
                peticionesEnviadas.add(peticiones.get(i));
            }
            if (peticiones.get(i).getEvento().getUsuario().getEmail().equals(usuario.getEmail())) {
                peticionesRecividas.add(peticiones.get(i));
            }
        }
        return SUCCESS;
    }
    
    /**
     * Aceptar peticion.
     *
     * @return the result of the action
     */
    public String aceptarPeticion() {
        Peticion peticion = peticionCliente.find_XML(Peticion.class, idPeticion);
        if (peticion.getEvento().getAforo() > 0) {
            peticion.setEstado("ACCEPTED");
            peticionCliente.edit_XML(peticion, String.valueOf(peticion.getIdPeticion()));
            Asistente asistente = new Asistente();
            asistente.setUsuario(peticion.getUsuario());
            asistente.setEvento(peticion.getEvento());
            asistenteCliente.create_XML(asistente);
        }
        cargarPeticiones();
        return SUCCESS;
    }
    
    /**
     * Rechazar peticion.
     *
     * @return the result of the action
     */
    public String rechazarPeticion() {
        Peticion peticion = peticionCliente.find_XML(Peticion.class, idPeticion);
        peticion.setEstado("REJECTED");
        peticionCliente.edit_XML(peticion, String.valueOf(peticion.getIdPeticion()));
        cargarPeticiones();
        return SUCCESS;
    }
    
    //Getters and Setters
    public String getIdEvento() {
        return idEvento;
    }

    public void setIdEvento(String idEvento) {
        this.idEvento = idEvento;
    }

    public Map getSession() {
        return session;
    }

    public void setSession(Map session) {
        this.session = session;
    }

    public List<Peticion> getPeticionesEnviadas() {
        return peticionesEnviadas;
    }

    public void setPeticionesEnviadas(List<Peticion> peticionesEnviadas) {
        this.peticionesEnviadas = peticionesEnviadas;
    }

    public List<Peticion> getPeticionesRecividas() {
        return peticionesRecividas;
    }

    public void setPeticionesRecividas(List<Peticion> peticionesRecividas) {
        this.peticionesRecividas = peticionesRecividas;
    }

    public String getIdPeticion() {
        return idPeticion;
    }

    public void setIdPeticion(String idPeticion) {
        this.idPeticion = idPeticion;
    }
}
