package br.com.bancoamazonia.integracao.card.model.domain;

import java.math.BigDecimal;
import java.util.Date;

public class DadoComercial {
	private Long id;
	// cliente e fonte sao constraint
	private Cliente cliente;
	private FontePagadora fontePagadora;
	private Ocupacao ocupacao;
	private BigDecimal renda;
	private Date dataInicioRenda;
}
