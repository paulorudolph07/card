package br.com.bancoamazonia.integracao.card.model.domain;

public class DadoResidencial extends DadoCliente {
	private SituacaoResidencial situacaoResidencial;
	public SituacaoResidencial getSituacaoResidencial() {
		return situacaoResidencial;
	}
	public void setSituacaoResidencial(SituacaoResidencial situacaoResidencial) {
		this.situacaoResidencial = situacaoResidencial;
	}
}
