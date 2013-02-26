package br.com.bancoamazonia.integracao.card.model.domain;

import java.math.BigDecimal;
import java.util.Date;

public class Renda {
	// cliente e fonte = chave composta
	private Cliente cliente;
	private FontePagadora fontePagadora;
	private Telefone telefoneComercial;
	private Ocupacao ocupacao;
	private BigDecimal valor;
	private Date dataInicio;
}
