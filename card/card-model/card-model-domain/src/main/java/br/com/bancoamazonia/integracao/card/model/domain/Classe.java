package br.com.bancoamazonia.integracao.card.model.domain;

import java.math.BigDecimal;

public class Classe {
	//id
	private Byte variante;
	private String descricao;
	private BigDecimal rendaMinima;
	private BigDecimal anuidade;
	public Byte getVariante() {
		return variante;
	}
	public void setVariante(Byte variante) {
		this.variante = variante;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public BigDecimal getRendaMinima() {
		return rendaMinima;
	}
	public void setRendaMinima(BigDecimal rendaMinima) {
		this.rendaMinima = rendaMinima;
	}
	public BigDecimal getAnuidade() {
		return anuidade;
	}
	public void setAnuidade(BigDecimal anuidade) {
		this.anuidade = anuidade;
	}
}
