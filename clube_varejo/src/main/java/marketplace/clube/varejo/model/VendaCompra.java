package marketplace.clube.varejo.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.ConstraintMode;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "venda_compra")
public class VendaCompra implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(columnDefinition = "uuid", updatable = false)
    private UUID id;
	
    @ManyToOne(targetEntity = Pessoa.class)
    @JoinColumn(name = "pessoa_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fk"))
    private Pessoa pessoa;
    
    @ManyToOne
    @JoinColumn(name = "endereco_entrega_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "endereco_entrega_fk"))
    private Endereco enderecoEntrega;
	
    @ManyToOne
    @JoinColumn(name = "endereco_cobranca_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "endereco_cobranca_fk"))
	private Endereco enderecoCobranca;
	
    @Column(nullable = false)
	private BigDecimal valorTotal;
    
	private BigDecimal valorDesconto;
	
    @ManyToOne
    @JoinColumn(name = "forma_pagamento_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "forma_pagamento_fk"))
	private FormaPagamento formaPagamento;
    
    @OneToOne
    @JoinColumn(name = "nota_fiscal_venda_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "nota_fiscal_venda_fk"))
	private NotaFiscalVenda notaFiscalVenda;
    
    @ManyToOne
    @JoinColumn(name = "cupom_desconto_id", foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "cupom_desconto_fk"))
	private CupomDesconto cupomDesconto;
    
    @Column(nullable = false)
	private BigDecimal valorFrete;
    
    @Column(nullable = false)
	private Integer diaEntrega;
	
    @Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date dtVenda;
	
    @Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date dtEntrega;

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public Pessoa getPessoa() {
		return pessoa;
	}

	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}

	public Endereco getEnderecoEntrega() {
		return enderecoEntrega;
	}

	public void setEnderecoEntrega(Endereco enderecoEntrega) {
		this.enderecoEntrega = enderecoEntrega;
	}

	public Endereco getEnderecoCobranca() {
		return enderecoCobranca;
	}

	public void setEnderecoCobranca(Endereco enderecoCobranca) {
		this.enderecoCobranca = enderecoCobranca;
	}

	public BigDecimal getValorTotal() {
		return valorTotal;
	}

	public void setValorTotal(BigDecimal valorTotal) {
		this.valorTotal = valorTotal;
	}

	public BigDecimal getValorDesconto() {
		return valorDesconto;
	}

	public void setValorDesconto(BigDecimal valorDesconto) {
		this.valorDesconto = valorDesconto;
	}

	public FormaPagamento getFormaPagamento() {
		return formaPagamento;
	}

	public void setFormaPagamento(FormaPagamento formaPagamento) {
		this.formaPagamento = formaPagamento;
	}

	public NotaFiscalVenda getNotaFiscalVenda() {
		return notaFiscalVenda;
	}

	public void setNotaFiscalVenda(NotaFiscalVenda notaFiscalVenda) {
		this.notaFiscalVenda = notaFiscalVenda;
	}

	public CupomDesconto getCupomDesconto() {
		return cupomDesconto;
	}

	public void setCupomDesconto(CupomDesconto cupomDesconto) {
		this.cupomDesconto = cupomDesconto;
	}

	public BigDecimal getValorFrete() {
		return valorFrete;
	}

	public void setValorFrete(BigDecimal valorFrete) {
		this.valorFrete = valorFrete;
	}

	public Integer getDiaEntrega() {
		return diaEntrega;
	}

	public void setDiaEntrega(Integer diaEntrega) {
		this.diaEntrega = diaEntrega;
	}

	public Date getDtVenda() {
		return dtVenda;
	}

	public void setDtVenda(Date dtVenda) {
		this.dtVenda = dtVenda;
	}

	public Date getDtEntrega() {
		return dtEntrega;
	}

	public void setDtEntrega(Date dtEntrega) {
		this.dtEntrega = dtEntrega;
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
		VendaCompra other = (VendaCompra) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
    
	
}
