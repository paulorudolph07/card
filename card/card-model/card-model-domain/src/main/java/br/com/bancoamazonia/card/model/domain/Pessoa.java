package br.com.bancoamazonia.card.model.domain;

import java.io.Serializable;

public class Pessoa implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2710375040815806701L;
	// id
	private String codigo;
	private String nome;
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
}
