package marketplace.clube.varejo.enums;

public enum TipoEndereco {

	CASA("Casa"),
	ESCRITORIO("Escrtório");
	
	private String descricao;

	private TipoEndereco(String descricao) {
		this.descricao = descricao;
	}

	public String getDescricao() {
		return descricao;
	}

	@Override
	public String toString() {
		return this.descricao;
	}
	
}
