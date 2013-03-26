package br.com.bancoamazonia.card.service;

import java.io.Serializable;
import java.util.List;

import br.com.bancoamazonia.card.model.dao.EstadoCivilDao;
import br.com.bancoamazonia.card.model.domain.EstadoCivil;

public class EstadoCivilService {

	private EstadoCivilDao estadoCivilDao;

	public void setEstadoCivilDao(EstadoCivilDao estadoCivilDao) {
		this.estadoCivilDao = estadoCivilDao;
	}
	
	public EstadoCivil get(Serializable id) {
		return estadoCivilDao.get(EstadoCivil.class, id);
	}
	
	public List<EstadoCivil> list() {
		return estadoCivilDao.list(EstadoCivil.class);
	}
}
