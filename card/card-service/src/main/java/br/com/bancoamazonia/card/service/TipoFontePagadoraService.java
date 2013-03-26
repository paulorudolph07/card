package br.com.bancoamazonia.card.service;

import java.io.Serializable;
import java.util.List;

import br.com.bancoamazonia.card.model.dao.TipoFontePagadoraDao;
import br.com.bancoamazonia.card.model.domain.TipoFontePagadora;

public class TipoFontePagadoraService {

	private TipoFontePagadoraDao tipoFontePagadoraDao;

	public void setTipoFontePagadoraDao(TipoFontePagadoraDao tipoFontePagadoraDao) {
		this.tipoFontePagadoraDao = tipoFontePagadoraDao;
	}
	
	public TipoFontePagadora get(Serializable id) {
		return tipoFontePagadoraDao.get(TipoFontePagadora.class, id);
	}
	
	public List<TipoFontePagadora> list() {
		return tipoFontePagadoraDao.list(TipoFontePagadora.class);
	}
}
