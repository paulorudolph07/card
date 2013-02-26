package br.com.bancoamazonia.integracao.card.model.domain;

import java.util.Date;

public class Identidade extends Documento {
	private Estado estado;
	private String orgaoEmissor;
	private Date dataEmissao;
}
