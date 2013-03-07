package br.com.bancoamazonia.card.model.domain;

public abstract class Documento {
	// id
	private String numero;
	private Cliente cliente;
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public Cliente getCliente() {
		return cliente;
	}
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
}
