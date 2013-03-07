package br.com.bancoamazonia.card.model.domain;

public class SituacaoResidencial {
	private Byte codigo;
	private String descricao;
	public Byte getCodigo() {
		return codigo;
	}
	public void setCodigo(Byte codigo) {
		this.codigo = codigo;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
}
