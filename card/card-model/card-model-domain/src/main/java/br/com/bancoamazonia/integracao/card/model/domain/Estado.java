package br.com.bancoamazonia.integracao.card.model.domain;

public class Estado {
	private Byte id;
	private String uf;
	public Byte getId() {
		return id;
	}
	public void setId(Byte id) {
		this.id = id;
	}
	public String getUf() {
		return uf;
	}
	public void setUf(String uf) {
		this.uf = uf;
	}
}
