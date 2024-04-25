package marketplace.clube.varejo.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "cupom_desconto")
public class CupomDesconto implements Serializable {

	private static final long serialVersionUID = 1L;
	
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
	@Column(columnDefinition = "uuid", updatable = false)
    private UUID id;
    
    @Column(nullable = false)
    private String codDesc;
    
    private BigDecimal valorRealDesc;
    private BigDecimal valorPorcentDesc;
    
    @Column(nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dtValidadeCupom;

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public String getCodDesc() {
		return codDesc;
	}

	public void setCodDesc(String codDesc) {
		this.codDesc = codDesc;
	}

	public BigDecimal getValorRealDesc() {
		return valorRealDesc;
	}

	public void setValorRealDesc(BigDecimal valorRealDesc) {
		this.valorRealDesc = valorRealDesc;
	}

	public BigDecimal getValorPorcentDesc() {
		return valorPorcentDesc;
	}

	public void setValorPorcentDesc(BigDecimal valorPorcentDesc) {
		this.valorPorcentDesc = valorPorcentDesc;
	}

	public Date getDtValidadeCupom() {
		return dtValidadeCupom;
	}

	public void setDtValidadeCupom(Date dtValidadeCupom) {
		this.dtValidadeCupom = dtValidadeCupom;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CupomDesconto other = (CupomDesconto) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
    
       

}
