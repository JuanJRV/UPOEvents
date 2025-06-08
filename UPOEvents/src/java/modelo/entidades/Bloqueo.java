/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.entidades;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author artur
 */
@Entity
@Table(name = "bloqueo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Bloqueo.findAll", query = "SELECT b FROM Bloqueo b")
    , @NamedQuery(name = "Bloqueo.findByIdBloqueo", query = "SELECT b FROM Bloqueo b WHERE b.idBloqueo = :idBloqueo")})
public class Bloqueo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_bloqueo")
    private Integer idBloqueo;
    @JoinColumn(name = "bloqueado", referencedColumnName = "email")
    @ManyToOne(optional = false)
    private Usuario bloqueado;
    @JoinColumn(name = "bloqueador", referencedColumnName = "email")
    @ManyToOne(optional = false)
    private Usuario bloqueador;

    public Bloqueo() {
    }

    public Bloqueo(Integer idBloqueo) {
        this.idBloqueo = idBloqueo;
    }

    public Integer getIdBloqueo() {
        return idBloqueo;
    }

    public void setIdBloqueo(Integer idBloqueo) {
        this.idBloqueo = idBloqueo;
    }

    public Usuario getBloqueado() {
        return bloqueado;
    }

    public void setBloqueado(Usuario bloqueado) {
        this.bloqueado = bloqueado;
    }

    public Usuario getBloqueador() {
        return bloqueador;
    }

    public void setBloqueador(Usuario bloqueador) {
        this.bloqueador = bloqueador;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idBloqueo != null ? idBloqueo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Bloqueo)) {
            return false;
        }
        Bloqueo other = (Bloqueo) object;
        if ((this.idBloqueo == null && other.idBloqueo != null) || (this.idBloqueo != null && !this.idBloqueo.equals(other.idBloqueo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.Bloqueo[ idBloqueo=" + idBloqueo + " ]";
    }
    
}
