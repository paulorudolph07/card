package br.com.bancoamazonia.integracao.card.model.domain;


public class Cliente {
	// id
	private String codigo;
	private Cliente titular;
	private TipoCliente tipo;
	private Endereco endereco;
}
