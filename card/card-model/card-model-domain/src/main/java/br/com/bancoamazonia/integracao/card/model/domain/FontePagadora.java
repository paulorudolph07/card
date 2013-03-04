package br.com.bancoamazonia.integracao.card.model.domain;

import java.io.Serializable;

public class FontePagadora extends Pessoa implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8068652315680209655L;
	private TipoFontePagadora tipo;
	public TipoFontePagadora getTipo() {
		return tipo;
	}
	public void setTipo(TipoFontePagadora tipo) {
		this.tipo = tipo;
	}
}
