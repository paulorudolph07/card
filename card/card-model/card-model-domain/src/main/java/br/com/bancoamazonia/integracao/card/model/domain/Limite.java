package br.com.bancoamazonia.integracao.card.model.domain;

import java.math.BigDecimal;

public class Limite {
	private Byte id;
	private BigDecimal valor;
	public Byte getId() {
		return id;
	}
	public void setId(Byte id) {
		this.id = id;
	}
	public BigDecimal getValor() {
		return valor;
	}
	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}
}
