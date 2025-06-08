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
import java.util.Map;
import modelo.entidades.Usuario;
import modelo.jersey.UsuarioJerseyClient;

/**
 *
 * @author artur
 */
public class UsuarioActionSupport extends ActionSupport {

    private String nombre;
    private String apellidos;
    private String email;
    private String fechaNacimiento;
    private String clave;
    private String genero;

    private String nuevaClave;

    private Map session = (Map) ActionContext.getContext().get("session");

    private UsuarioJerseyClient cliente = new UsuarioJerseyClient();
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public UsuarioActionSupport() {
    }

    @Override
    public String execute() throws Exception {
        return SUCCESS;
    }

    /**
     * Crea un nuevo usuario.
     *
     * @return the result of the action
     * @throws ParseException if the date parsing fails
     */
    public String nuevoUsuario() throws ParseException {
        String retVal = ERROR;
        if (cliente.find_XML(Usuario.class, email) == null) {
            Usuario usuario = new Usuario(email, apellidos, nombre, sdf.parse(fechaNacimiento), clave, genero);
            cliente.create_XML(usuario);

            if (cliente.find_XML(Usuario.class, usuario.getEmail()) == null) {
                addActionError("No se ha podido completar el registro por un problema con el servidor");
            } else {
                retVal = SUCCESS;
                session.put("USUARIO", usuario);	
            }
        } else {
            addActionError("Este usuario ya esta registrado");
        }
        return retVal;
    }

    /**
     * Acceso usuario.
     *
     * @return the result of the action
     */
    public String accesoUsuario() {
        String retVal = ERROR;
        Usuario usuario = cliente.find_XML(Usuario.class, email);
        if (usuario != null && usuario.getClave().equals(clave)) {
            retVal = SUCCESS;
            session.put("USUARIO", usuario);	//Crear session usuario
        } else {
            addActionError("Contraseña incorrecta");
        }

        return retVal;
    }

    /**
     * Editar usuario.
     *
     * @return the result of the action
     * @throws ParseException if the date parsing fails
     */
    public String editarUsuario() throws ParseException {
        Usuario usuario = (Usuario) session.get("USUARIO");
        String retVal = SUCCESS;
        if (clave.equals(usuario.getClave())) {

            usuario.setNombre(nombre);
            usuario.setApellidos(apellidos);
            usuario.setFechaNacimiento(sdf.parse(fechaNacimiento));
            usuario.setGenero(genero);

            cliente.edit_XML(usuario, usuario.getEmail());

            session.put("USUARIO", usuario);	
        } else {
            retVal = ERROR;
            addActionError("Clave incorrecta, no sa han modificado los campos");
        }
        return retVal;
    }

    /**
     * Cambiar clave.
     *
     * @return the result of the action
     */
    public String cambiarClave() {
        Usuario usuario = (Usuario) session.get("USUARIO");
        String retVal = SUCCESS;
        if (clave.equals(usuario.getClave())) {
            usuario.setClave(nuevaClave);
            cliente.edit_XML(usuario, usuario.getEmail());
            session.put("USUARIO", usuario);	
        } else {
            retVal = ERROR;
            addActionError("Clave incorrecta, no se ha podido actualizar la contraseña");
        }
        return retVal;
    }
    
    /**
     * Borrar usuario.
     *
     * @return the result of the action
     */
    public String borrarUsuario() {
        Usuario usuario = (Usuario) session.get("USUARIO");
        String retVal = SUCCESS;
        if (clave.equals(usuario.getClave())) {
            cliente.remove(usuario.getEmail());
            session.put("USUARIO", null);	
        } else {
            retVal = ERROR;
            addActionError("Clave incorrecta, no se ha podido borrar la cuenta");
        }
        return retVal;
    }
    
    /**
     * Cerrar sesion.
     *
     * @return the result of the action
     */
    public String cerrarSesionUsuario() {
        session.put("USUARIO", null);
        return SUCCESS;
    }

    //Getters and Setters
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public Map getSession() {
        return session;
    }

    public void setSession(Map session) {
        this.session = session;
    }

    public String getNuevaClave() {
        return nuevaClave;
    }

    public void setNuevaClave(String nuevaClave) {
        this.nuevaClave = nuevaClave;
    }
}
