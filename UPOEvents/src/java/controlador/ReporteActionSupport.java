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
import modelo.entidades.Reporte;
import modelo.entidades.Usuario;
import modelo.jersey.ReporteJerseyClient;

/**
 *
 * @author artur
 */
public class ReporteActionSupport extends ActionSupport {

    private List<Reporte> listaReporte;
    private Map session = (Map) ActionContext.getContext().get("session");
    private ReporteJerseyClient reporteCliente = new ReporteJerseyClient();
    private String idReporte;
    private String issueInput;
    private String categoryInput;

    public ReporteActionSupport() {
    }

    public String execute() throws Exception {
        return SUCCESS;
    }
    
    /**
     * Cargar reportes de un usuario logeado.
     *
     * @return the result of the action
     */
    public String cargarReportes() {
        Usuario usuario = (Usuario) session.get("USUARIO");
        GenericType<List<Reporte>> genericReporte = new GenericType<List<Reporte>>() {
        };
        List<Reporte> reportes = reporteCliente.findAll_XML(genericReporte);
        listaReporte = new ArrayList<>();

        for (int i = 0; i < reportes.size(); i++) {
            if (reportes.get(i).getReportador().getEmail().equals(usuario.getEmail())) {
                listaReporte.add(reportes.get(i));
            }
        }
        return SUCCESS;
    }
    
    /**
     * Eliminar reportes.
     *
     * @return the result of the action
     */
    public String eliminarReporte() {
        reporteCliente.remove(idReporte);
        cargarReportes();
        return SUCCESS;
    }
    
    /**
     * Editar reportes.
     *
     * @return the result of the action
     */
    public String editarReporte() {
        Reporte reporte = reporteCliente.find_XML(Reporte.class, idReporte);
        reporte.setCategoria(categoryInput);
        reporte.setAsunto(issueInput);
        reporteCliente.edit_XML(reporte, String.valueOf(reporte.getIdReporte()));
        cargarReportes();

        return SUCCESS;
    }

    //Getters and Setters
    public List<Reporte> getListaReporte() {
        return listaReporte;
    }

    public void setListaReporte(List<Reporte> listaReporte) {
        this.listaReporte = listaReporte;
    }

    public Map getSession() {
        return session;
    }

    public void setSession(Map session) {
        this.session = session;
    }

    public String getIdReporte() {
        return idReporte;
    }

    public void setIdReporte(String idReporte) {
        this.idReporte = idReporte;
    }

    public String getIssueInput() {
        return issueInput;
    }

    public void setIssueInput(String issueInput) {
        this.issueInput = issueInput;
    }

    public String getCategoryInput() {
        return categoryInput;
    }

    public void setCategoryInput(String categoryInput) {
        this.categoryInput = categoryInput;
    }

}
