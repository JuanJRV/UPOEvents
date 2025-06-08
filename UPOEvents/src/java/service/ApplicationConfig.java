/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.util.Set;
import javax.ws.rs.core.Application;

/**
 *
 * @author juand
 */
@javax.ws.rs.ApplicationPath("webresources")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<>();
        addRestResourceClasses(resources);
        return resources;
    }

    /**
     * Do not modify addRestResourceClasses() method.
     * It is automatically populated with
     * all resources defined in the project.
     * If required, comment out calling this method in getClasses().
     */
    private void addRestResourceClasses(Set<Class<?>> resources) {
        resources.add(service.AsistenteFacadeREST.class);
        resources.add(service.BloqueoFacadeREST.class);
        resources.add(service.EventoFacadeREST.class);
        resources.add(service.PeticionFacadeREST.class);
        resources.add(service.ReporteFacadeREST.class);
        resources.add(service.UsuarioFacadeREST.class);
        resources.add(service.ValoracionFacadeREST.class);
    }
    
}
