/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import static com.opensymphony.xwork2.Action.ERROR;
import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.ws.rs.core.GenericType;
import modelo.entidades.Bloqueo;
import modelo.entidades.Asistente;
import modelo.entidades.Peticion;
import modelo.entidades.Valoracion;
import modelo.entidades.Reporte;
import modelo.entidades.Usuario;
import modelo.entidades.Evento;
import modelo.jersey.BloqueoJerseyClient;
import modelo.jersey.AsistenteJerseyClient;
import modelo.jersey.PeticionJerseyClient;
import modelo.jersey.ValoracionJerseyClient;
import modelo.jersey.ReporteJerseyClient;
import modelo.jersey.EventoJerseyClient;

/**
 *
 * @author artur
 */
/**
 * EventoActionSupport clase para gestionar eventos, valoraciones, reportes, y bloqueos.
 * Proporciona metodos para crear, cargar, buscar eventos, y gestionar
 * valoraciones, reportes, y bloqueos.
 *
 */
public class EventoActionSupport extends ActionSupport {

    private String lugar;
    private String aforo;
    private String nombre;
    private String fecha;
    private String hora;

    private String idEvento;
    private String inputRate;
    private String categoryInput;
    private String issueInput;

    private String fecha_fin;
    private String fecha_inicio;
    private List<Evento> eventosDisponibles;

    private List<Evento> eventosAsistente;
    private List<Evento> eventosOrganizador;

    private Map session = (Map) ActionContext.getContext().get("session");

    private EventoJerseyClient eventoCliente = new EventoJerseyClient();
    private PeticionJerseyClient peticionCliente = new PeticionJerseyClient();
    private AsistenteJerseyClient asistenteCliente = new AsistenteJerseyClient();
    private BloqueoJerseyClient bloqueoCliente = new BloqueoJerseyClient();
    private ValoracionJerseyClient valoracionCliente = new ValoracionJerseyClient();
    private ReporteJerseyClient reporteCliente = new ReporteJerseyClient();

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public EventoActionSupport() {
    }

    public String execute() {
        return SUCCESS;
    }

    /**
     * Crea un nuevo evento.
     *
     * @return the result of the action
     * @throws ParseException if the date parsing fails
     */
    public String nuevoEvento() throws ParseException {
        //System.out.println("nuevoEvento() method called."); // Agregar este println para verificar si el método se está ejecutando correctamente

        Usuario usuario = (Usuario) session.get("USUARIO");

        //Comprobaciones que se hicieron para ver si llegaban bien los atributos
        //System.out.println("Received data:");
        //System.out.println("Fecha: " + fecha);
        //System.out.println("Aforo: " + aforo);
        //System.out.println("Nombre: " + nombre);
        //System.out.println("Lugar: " + lugar);
        //System.out.println("Hora: " + hora);
        Evento evento = new Evento(null, sdf.parse(fecha), Integer.parseInt(aforo), nombre, lugar, hora);
        evento.setUsuario(usuario);
        eventoCliente.create_XML(evento);
        return SUCCESS;
    }

    /**
     * Busca eventos dada una fecha inicio y una fecha fin y mas criterios.
     *
     * @return the result of the action
     * @throws ParseException if the date parsing fails
     */
    public String buscarEvento() throws ParseException {
        //System.out.println("Método buscarEvento llamado");
        Date inicio = sdf.parse(fecha_inicio);
        Date fin = sdf.parse(fecha_fin);
        Usuario usuario = (Usuario) session.get("USUARIO");

        GenericType<List<Evento>> genericEvento = new GenericType<List<Evento>>() {
        };
        List<Evento> eventos = eventoCliente.findAll_XML(genericEvento);
        eventosDisponibles = new ArrayList<>();
        for (int i = 0; i < eventos.size(); i++) {
            if (eventos.get(i).getAforo() > 0
                    && eventos.get(i).getLugar().equals(lugar)
                    && eventos.get(i).getFecha().after(inicio)
                    && eventos.get(i).getFecha().before(fin)
                    && !eventos.get(i).getUsuario().getEmail().equals(usuario.getEmail())) {

                GenericType<List<Peticion>> genericPeticion = new GenericType<List<Peticion>>() {
                };
                List<Peticion> peticiones = peticionCliente.findAll_XML(genericPeticion);
                boolean isSolicitada = false;
                int j = 0;
                while (j < peticiones.size() && !isSolicitada) {
                    if (peticiones.get(j).getEvento().getIdEvento() == eventos.get(i).getIdEvento() 
                        && peticiones.get(j).getUsuario().getEmail().equals(usuario.getEmail())) {
                        isSolicitada = true;
                    } else {
                        j++;
                    }
                }
                GenericType<List<Bloqueo>> genericBloqueo = new GenericType<List<Bloqueo>>() {
                };
                List<Bloqueo> bloqueos = bloqueoCliente.findAll_XML(genericBloqueo);
                boolean isBloqueado = false;
                while (j < bloqueos.size() && !isBloqueado) {
                    if (bloqueos.get(j).getBloqueado().getEmail().equals(eventos.get(i).getUsuario().getEmail()) 
                        && bloqueos.get(j).getBloqueador().getEmail().equals(usuario.getEmail())) {
                        isBloqueado = true;
                    } else {
                        j++;
                    }
                }
                if (!isSolicitada && !isBloqueado) {
                    eventosDisponibles.add(eventos.get(i));
                }
            }
        }
        return SUCCESS;
    }
    
    /**
     * Crea un nuevo bloqueo.
     * 
     * @return the result of the action
     * @throws ParseException if the date format is incorrect
     */
    public String nuevoBloqueo() throws ParseException {
        String retVal = SUCCESS;
        Usuario bloqueador = (Usuario) session.get("USUARIO");
        Usuario bloqueado = eventoCliente.find_XML(Evento.class, idEvento).getUsuario();

        GenericType<List<Bloqueo>> genericBloqueo = new GenericType<List<Bloqueo>>() {
        };
        List<Bloqueo> bloqueos = bloqueoCliente.findAll_XML(genericBloqueo);
        int i = 0;
        boolean isCreado = false;
        while (i < bloqueos.size() && !isCreado) {
            if (bloqueos.get(i).getBloqueado().getEmail().equals(bloqueado.getEmail())
                && bloqueos.get(i).getBloqueador().getEmail().equals(bloqueador.getEmail())) {
                isCreado = true;
            } else {
                i++;
            }
        }
        if (!isCreado) {
            Bloqueo bloqueo = new Bloqueo();
            bloqueo.setBloqueador(bloqueador);
            bloqueo.setBloqueado(bloqueado);
            bloqueoCliente.create_XML(bloqueo);
        } else {
            retVal = ERROR;
            addActionError("Este usuario ya esta bloqueado");
        }
        cargarEventos();
        return retVal;
    }
     
    /**
     * Carga eventos para el usuario actual.
     *
     * @return the result of the action
     * @throws ParseException if the date parsing fails
     */
    public String cargarEventos() throws ParseException {
        Usuario usuario = (Usuario) session.get("USUARIO");

        GenericType<List<Evento>> genericEvento = new GenericType<List<Evento>>() {
        };
        GenericType<List<Asistente>> genericAsistente = new GenericType<List<Asistente>>() {
        };
        eventosAsistente = new ArrayList<>();
        eventosOrganizador = new ArrayList<>();
        List<Evento> eventos = eventoCliente.findAll_XML(genericEvento);
        for (int i = 0; i < eventos.size(); i++) {
            if (eventos.get(i).getUsuario().getEmail().equals(usuario.getEmail())) {
                eventosOrganizador.add(eventos.get(i));
            }
        }
        List<Asistente> asistentes = asistenteCliente.findAll_XML(genericAsistente);
        for (int i = 0; i < asistentes.size(); i++) {
            if (asistentes.get(i).getUsuario().getEmail().equals(usuario.getEmail())) {
                eventosAsistente.add(asistentes.get(i).getEvento());
            }
        }
        return SUCCESS;
    }
    
    /**
     * Crea una nueva valoracion.
     * 
     * @return the result of the action
     * @throws ParseException if the date format is incorrect
     */
    public String nuevaValoracion() throws ParseException {
        String retVal = SUCCESS;
        Usuario usuario = (Usuario) session.get("USUARIO");
        Evento evento = eventoCliente.find_XML(Evento.class, idEvento);

        GenericType<List<Valoracion>> genericValoracion = new GenericType<List<Valoracion>>() {
        };
        List<Valoracion> valoraciones = valoracionCliente.findAll_XML(genericValoracion);
        int i = 0;
        boolean isCreado = false;
        while (i < valoraciones.size() && !isCreado) {
            if (valoraciones.get(i).getEvento().getIdEvento() == evento.getIdEvento()
                && valoraciones.get(i).getUsuario().getEmail().equals(usuario.getEmail())) {
                isCreado = true;
            } else {
                i++;
            }
        }
        if (!isCreado) {
            Valoracion valoracion = new Valoracion(null, Integer.parseInt(inputRate));
            valoracion.setUsuario(usuario);
            valoracion.setEvento(evento);

            valoracionCliente.create_XML(valoracion);
        } else {
            retVal = ERROR;
            addActionError("Ya has valorado este evento");
        }
        cargarEventos();
        return retVal;
    }
    
    /**
     * Crea un nuevo reporte.
     * 
     * @return the result of the action
     * @throws ParseException if the date format is incorrect
     */
    public String nuevoReporte() throws ParseException {
        String retVal = SUCCESS;
        Usuario reportador = (Usuario) session.get("USUARIO");
        Usuario reportado = eventoCliente.find_XML(Evento.class, idEvento).getUsuario();

        GenericType<List<Reporte>> genericReporte = new GenericType<List<Reporte>>() {
        };
        List<Reporte> reportes = reporteCliente.findAll_XML(genericReporte);
        int i = 0;
        boolean isCreado = false;
        while (i < reportes.size() && !isCreado) {
            if (reportes.get(i).getReportador().getEmail().equals(reportador.getEmail())
                && reportes.get(i).getReportado().getEmail().equals(reportado.getEmail())) {
                isCreado = true;
            } else {
                i++;
            }
        }
        if (!isCreado) {
            Reporte reporte = new Reporte(null, categoryInput, issueInput);
            reporte.setReportado(reportado);
            reporte.setReportador(reportador);
            reporteCliente.create_XML(reporte);
        } else {
            retVal = ERROR;
            addActionError("Este usuario ya esta reportado");
        }
        cargarEventos();
        return retVal;
    }
    
    // Getters and Setters
    public String getLugar() {
        return lugar;
    }

    public void setLugar(String lugar) {
        this.lugar = lugar;
    }

    public String getAforo() {
        return aforo;
    }

    public void setAforo(String aforo) {
        this.aforo = aforo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public Map getSession() {
        return session;
    }

    public void setSession(Map session) {
        this.session = session;
    }

    public String getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(String fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public String getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(String fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public List<Evento> getEventosDisponibles() {
        return eventosDisponibles;
    }

    public void setEventosDisponibles(List<Evento> eventosDisponibles) {
        this.eventosDisponibles = eventosDisponibles;
    }

    public List<Evento> getEventosAsistente() {
        return eventosAsistente;
    }

    public void setEventosAsistente(List<Evento> eventosAsistente) {
        this.eventosAsistente = eventosAsistente;
    }

    public List<Evento> getEventosOrganizador() {
        return eventosOrganizador;
    }

    public void setEventosOrganizador(List<Evento> eventosOrganizador) {
        this.eventosOrganizador = eventosOrganizador;
    }

    public String getIdEvento() {
        return idEvento;
    }

    public void setIdEvento(String idEvento) {
        this.idEvento = idEvento;
    }

    public String getInputRate() {
        return inputRate;
    }

    public void setInputRate(String inputRate) {
        this.inputRate = inputRate;
    }

    public String getCategoryInput() {
        return categoryInput;
    }

    public void setCategoryInput(String categoryInput) {
        this.categoryInput = categoryInput;
    }

    public String getIssueInput() {
        return issueInput;
    }

    public void setIssueInput(String issueInput) {
        this.issueInput = issueInput;
    }

}
