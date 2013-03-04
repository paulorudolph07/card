package br.com.bancoamazonia.integracao.card.model.domain;

public class DadoComercial extends DadoCliente {
	private Renda renda; // unique
	public Renda getRenda() {
		return renda;
	}
	public void setRenda(Renda renda) {
		this.renda = renda;
	}
}
