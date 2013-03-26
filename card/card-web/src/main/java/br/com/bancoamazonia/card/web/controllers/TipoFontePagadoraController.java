package br.com.bancoamazonia.card.web.controllers;

import java.io.Serializable;
import java.util.List;

import javax.faces.bean.ManagedBean;

import br.com.bancoamazonia.card.model.domain.TipoFontePagadora;
import br.com.bancoamazonia.card.service.TipoFontePagadoraService;

@ManagedBean
public class TipoFontePagadoraController implements Serializable {
	private static final long serialVersionUID = 6249226078542932845L;
	private TipoFontePagadoraService tipoFontePagadoraService;

	public void setTipoFontePagadoraService(
			TipoFontePagadoraService tipoFontePagadoraService) {
		this.tipoFontePagadoraService = tipoFontePagadoraService;
	}
	
	public List<TipoFontePagadora> getList() {
		return tipoFontePagadoraService.list();
	}
}
