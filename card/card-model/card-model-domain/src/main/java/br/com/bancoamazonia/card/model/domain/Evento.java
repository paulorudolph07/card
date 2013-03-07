package br.com.bancoamazonia.card.model.domain;

import java.io.Serializable;

/**
 * Esta classe representa o status no fluxo (movimento) da concepcao do cartao ou o status do cartao
 * @author root
 *
 */
public class Evento implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2923597222195096924L;
	//id
	private Byte codigo;
	private String descricao;
	public Byte getCodigo() {
		return codigo;
	}
	public void setCodigo(Byte codigo) {
		this.codigo = codigo;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
}
