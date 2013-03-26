package br.com.bancoamazonia.card.service;

import java.io.Serializable;
import java.util.List;

import br.com.bancoamazonia.card.model.dao.EstadoDao;
import br.com.bancoamazonia.card.model.domain.Estado;

public class EstadoService {
	private EstadoDao estadoDao;

	public void setEstadoDao(EstadoDao estadoDao) {
		this.estadoDao = estadoDao;
	}
	
	public Estado get(Serializable id) {
		return estadoDao.get(Estado.class, id);
	}
	
	public List<Estado> list() {
		return estadoDao.list(Estado.class);
	}
}
