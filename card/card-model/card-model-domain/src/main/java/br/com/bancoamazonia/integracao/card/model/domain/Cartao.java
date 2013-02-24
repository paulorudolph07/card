package br.com.bancoamazonia.integracao.card.model.domain;
/**
 * O status do cartao fica registrado no ultimo movimento
 * @author root
 *
 */
public class Cartao {
	// id
	private String numero;
	// criar index para cliente
	private Cliente cliente;
	private ClasseCartao classe;
	private Vencimento vencimento;
	private Limite limite;
	private Evento status;
	// o cartao pode pertencer ou nao a um cliente do banco
	private Integer agencia;
}
