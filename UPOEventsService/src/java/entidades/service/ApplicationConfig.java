/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entidades.service;

import java.util.Set;
import javax.ws.rs.core.Application;

/**
 *
 * @author artur
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
        resources.add(entidades.service.AsistenteFacadeREST.class);
        resources.add(entidades.service.BloqueoFacadeREST.class);
        resources.add(entidades.service.EventoFacadeREST.class);
        resources.add(entidades.service.PeticionFacadeREST.class);
        resources.add(entidades.service.ReporteFacadeREST.class);
        resources.add(entidades.service.UsuarioFacadeREST.class);
        resources.add(entidades.service.ValoracionFacadeREST.class);
    }
    
}
