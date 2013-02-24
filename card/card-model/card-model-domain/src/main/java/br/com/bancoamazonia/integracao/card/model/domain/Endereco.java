package br.com.bancoamazonia.integracao.card.model.domain;
/**
 * Conexao com pd_base (PODE HAVER MAIS DE UM ENDERECO? FATURA E RESINDECIAL?)
 * @author root
 *
 */
public class Endereco {
	private Long id;
	private Estado estado;
	private String cep;
	private String municipio;
	private String bairro;
	private String logradouro;
	private String numero;
	private String complemento;
}
