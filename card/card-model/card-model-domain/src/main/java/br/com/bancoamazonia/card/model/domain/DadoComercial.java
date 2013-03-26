package br.com.bancoamazonia.card.model.domain;

import java.io.Serializable;

public class DadoComercial extends DadoCliente implements Serializable {
	private static final long serialVersionUID = 1165250230614439053L;
	private Renda renda; // unique
	public Renda getRenda() {
		return renda;
	}
	public void setRenda(Renda renda) {
		this.renda = renda;
	}
}
