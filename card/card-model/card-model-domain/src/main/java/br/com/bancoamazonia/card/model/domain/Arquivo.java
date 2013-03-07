package br.com.bancoamazonia.card.model.domain;

import java.util.Date;

public class Arquivo {
	// id
	private Integer nsu;
	private TipoArquivo tipo;
	private Date dataProcessamento;
	public Integer getNsu() {
		return nsu;
	}
	public void setNsu(Integer nsu) {
		this.nsu = nsu;
	}
	public TipoArquivo getTipo() {
		return tipo;
	}
	public void setTipo(TipoArquivo tipo) {
		this.tipo = tipo;
	}
	public Date getDataProcessamento() {
		return dataProcessamento;
	}
	public void setDataProcessamento(Date dataProcessamento) {
		this.dataProcessamento = dataProcessamento;
	}
}
