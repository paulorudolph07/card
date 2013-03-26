package br.com.bancoamazonia.card.service;

import java.io.Serializable;
import java.util.List;

import br.com.bancoamazonia.card.model.dao.EscolaridadeDao;
import br.com.bancoamazonia.card.model.domain.Escolaridade;

public class EscolaridadeService {

	private EscolaridadeDao escolaridadeDao;

	public void setEscolaridadeDao(EscolaridadeDao escolaridadeDao) {
		this.escolaridadeDao = escolaridadeDao;
	}
	
	public Escolaridade get(Serializable id) {
		return escolaridadeDao.get(Escolaridade.class, id);
	}
	
	public List<Escolaridade> list() {
		return escolaridadeDao.list(Escolaridade.class);
	}
}
