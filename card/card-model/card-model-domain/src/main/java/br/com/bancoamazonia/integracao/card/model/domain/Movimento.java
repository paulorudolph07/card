package br.com.bancoamazonia.integracao.card.model.domain;

import java.util.Date;
/**
 * Esta classe registra o movimento (status ou historico) dos cartoes associados a uma determinada agencia
 * @author root
 *
 */
public class Movimento {

	private Long id;
	// cartao e evento devem ser constraint
	private Cartao cartao;
	// evento = status cartao
	private Evento evento;
	private Integer sequencial;
	private Date data;
	// registra o movimento para uma determinada agencia
	private Integer agencia;
	
}
