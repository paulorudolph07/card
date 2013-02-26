package br.com.bancoamazonia.integracao.card.model.domain;
/**
 * Conexao com pd_base (PODE HAVER MAIS DE UM ENDERECO? FATURA E RESINDECIAL?)
 * @author root
 *
 */
public class Endereco {
	private Long id;
	// estado e cep = constraint
	private Estado estado;
	private Integer cep;
	private Integer numero;
	private String municipio;
	private String bairro;
	private String logradouro;
	private String complemento;
}
