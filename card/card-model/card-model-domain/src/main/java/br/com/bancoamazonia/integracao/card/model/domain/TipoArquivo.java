package br.com.bancoamazonia.integracao.card.model.domain;

public class TipoArquivo {
	private Byte id;
	private String descricao;
	public Byte getId() {
		return id;
	}
	public void setId(Byte id) {
		this.id = id;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
}
