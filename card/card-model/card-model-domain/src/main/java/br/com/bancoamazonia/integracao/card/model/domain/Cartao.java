package br.com.bancoamazonia.integracao.card.model.domain;
/**
 * O status do cartao fica registrado no ultimo movimento
 * @author root
 *
 */
public class Cartao {
	// id
	private String numero;
	private Cliente cliente;
	// facilitara as consultas para relatorios baseados no status (evento) do cartao
	private Evento status;
	private Classe classe;
	private Vencimento vencimento;
	private Limite limite;
	// o cartao pode pertencer ou nao a um cliente do banco
	private Integer agencia;
}
