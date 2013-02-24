package br.com.bancoamazonia.integracao.card.model.domain;

import java.util.Date;

public class Cliente extends Pessoa {
	private Cliente titular;
	private Telefone celular;
	private TipoCliente tipo;
	private Sexo sexo;
	private EstadoCivil estadoCivil;
	private Escolaridade escolaridade;
	private SituacaoResidencia situacao;
	private String nomeMae;
	private Date dataNascimento;
	private String email; // ha necessidade de email para fontePagadora? Caso sim, colocar em pessoa
}
