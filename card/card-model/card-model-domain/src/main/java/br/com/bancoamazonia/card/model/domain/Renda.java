package br.com.bancoamazonia.card.model.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class Renda implements Serializable {
	private static final long serialVersionUID = 1684437844354932739L;
	// cliente e fonte = chave composta
	private Long id;
	private FontePagadora fontePagadora;
	private Ocupacao ocupacao;
	private BigDecimal valor;
	private Date dataInicio;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public FontePagadora getFontePagadora() {
		return fontePagadora;
	}
	public void setFontePagadora(FontePagadora fontePagadora) {
		this.fontePagadora = fontePagadora;
	}
	public Ocupacao getOcupacao() {
		return ocupacao;
	}
	public void setOcupacao(Ocupacao ocupacao) {
		this.ocupacao = ocupacao;
	}
	public BigDecimal getValor() {
		return valor;
	}
	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}
	public Date getDataInicio() {
		return dataInicio;
	}
	public void setDataInicio(Date dataInicio) {
		this.dataInicio = dataInicio;
	}
}
