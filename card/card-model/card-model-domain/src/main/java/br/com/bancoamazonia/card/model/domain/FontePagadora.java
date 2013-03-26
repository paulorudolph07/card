package br.com.bancoamazonia.card.model.domain;

import java.io.Serializable;


public class FontePagadora extends Pessoa implements Serializable {
	private static final long serialVersionUID = -5519063029421137347L;
	private TipoFontePagadora tipo;
	public TipoFontePagadora getTipo() {
		return tipo;
	}
	public void setTipo(TipoFontePagadora tipo) {
		this.tipo = tipo;
	}
}
