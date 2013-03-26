package br.com.bancoamazonia.card.model.domain;

import java.io.Serializable;

public class DadoResidencial extends DadoCliente implements Serializable {
	private static final long serialVersionUID = -812092452205591677L;
	private SituacaoResidencial situacaoResidencial;
	public SituacaoResidencial getSituacaoResidencial() {
		return situacaoResidencial;
	}
	public void setSituacaoResidencial(SituacaoResidencial situacaoResidencial) {
		this.situacaoResidencial = situacaoResidencial;
	}
}
