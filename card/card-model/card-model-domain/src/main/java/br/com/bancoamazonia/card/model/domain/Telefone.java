package br.com.bancoamazonia.card.model.domain;

import java.io.Serializable;

/**
 * 
 * @author root
 *
 */
public class Telefone implements Serializable {
	private static final long serialVersionUID = 1600600631385897154L;
	//private Long id;
	private Byte ddd;
	private Integer numero;
	public Byte getDdd() {
		return ddd;
	}
	public void setDdd(Byte ddd) {
		this.ddd = ddd;
	}
	public Integer getNumero() {
		return numero;
	}
	public void setNumero(Integer numero) {
		this.numero = numero;
	}
}
