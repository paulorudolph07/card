package br.com.bancoamazonia.card.model.domain;

public class EstadoCivil {
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
