package marketplace.clube.varejo.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "produto")
public class Produto implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(columnDefinition = "uuid", updatable = false)
    private UUID id;
	
	@Column(nullable = false)
	private String tipoUnidade;
	
	@Column(nullable = false)
	private String nome;
	
	@Column(nullable = false)
	private Boolean status = Boolean.TRUE;
	
	@Column(columnDefinition = "text", length = 2000, nullable = false)
	private String descricao;
	
	/**Nota item nota produto - ASSOCIAR**/
	
	@Column(nullable = false)
	private Double peso;
	
	@Column(nullable = false)
	private Double largura;
	
	@Column(nullable = false)
	private Double altura;
	
	@Column(nullable = false)
	private Double profundidade;
	
	@Column(nullable = false)
	private BigDecimal valorVenda = BigDecimal.ZERO;
	
	@Column(nullable = false)
	private Integer estoque = 0;
	
	private Integer alertaEstoque = 0;
	
	private String linkYoutube;
	
	private Boolean alertaQuantEstoque = Boolean.FALSE;
	
	private Integer quantClique = 0;
	
	public UUID getId() {
		return id;
	}
	public void setId(UUID id) {
		this.id = id;
	}
	public String getTipoUnidade() {
		return tipoUnidade;
	}
	public void setTipoUnidade(String tipoUnidade) {
		this.tipoUnidade = tipoUnidade;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public Boolean getStatus() {
		return status;
	}
	public void setStatus(Boolean status) {
		this.status = status;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public Double getPeso() {
		return peso;
	}
	public void setPeso(Double peso) {
		this.peso = peso;
	}
	public Double getLargura() {
		return largura;
	}
	public void setLargura(Double largura) {
		this.largura = largura;
	}
	public Double getAltura() {
		return altura;
	}
	public void setAltura(Double altura) {
		this.altura = altura;
	}
	public Double getProfundidade() {
		return profundidade;
	}
	public void setProfundidade(Double profundidade) {
		this.profundidade = profundidade;
	}
	public BigDecimal getValorVenda() {
		return valorVenda;
	}
	public void setValorVenda(BigDecimal valorVenda) {
		this.valorVenda = valorVenda;
	}
	public Integer getEstoque() {
		return estoque;
	}
	public void setEstoque(Integer estoque) {
		this.estoque = estoque;
	}
	public Integer getAlertaEstoque() {
		return alertaEstoque;
	}
	public void setAlertaEstoque(Integer alertaEstoque) {
		this.alertaEstoque = alertaEstoque;
	}
	public String getLinkYoutube() {
		return linkYoutube;
	}
	public void setLinkYoutube(String linkYoutube) {
		this.linkYoutube = linkYoutube;
	}
	public Boolean getAlertaQuantEstoque() {
		return alertaQuantEstoque;
	}
	public void setAlertaQuantEstoque(Boolean alertaQuantEstoque) {
		this.alertaQuantEstoque = alertaQuantEstoque;
	}
	public Integer getQuantClique() {
		return quantClique;
	}
	public void setQuantClique(Integer quantClique) {
		this.quantClique = quantClique;
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
		Produto other = (Produto) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	
	
	
}
