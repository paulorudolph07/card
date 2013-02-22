package br.com.bancoamazonia.integracao.card.model.domain;
/**
 * O status do cartao fica registrado no ultimo movimento
 * @author root
 *
 */
public class Cartao {

	private Long id;
	// numero, cliente, tipo e status devem ser constraint
	private String numero;
	private Cliente cliente;
	private ClasseCartao classe;
	private Vencimento vencimento;
	private Limite limite;
	
}
