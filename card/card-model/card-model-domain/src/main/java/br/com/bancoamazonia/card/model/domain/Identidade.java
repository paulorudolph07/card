package br.com.bancoamazonia.card.model.domain;

import java.util.Date;

public class Identidade extends Documento {
	private Estado estado;
	private String orgaoEmissor;
	private Date dataEmissao;
	public Estado getEstado() {
		return estado;
	}
	public void setEstado(Estado estado) {
		this.estado = estado;
	}
	public String getOrgaoEmissor() {
		return orgaoEmissor;
	}
	public void setOrgaoEmissor(String orgaoEmissor) {
		this.orgaoEmissor = orgaoEmissor;
	}
	public Date getDataEmissao() {
		return dataEmissao;
	}
	public void setDataEmissao(Date dataEmissao) {
		this.dataEmissao = dataEmissao;
	}
}
