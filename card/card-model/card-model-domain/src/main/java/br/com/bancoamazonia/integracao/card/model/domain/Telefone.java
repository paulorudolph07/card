package br.com.bancoamazonia.integracao.card.model.domain;
/**
 * 
 * @author root
 *
 */
public class Telefone {
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
