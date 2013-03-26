package br.com.bancoamazonia.card.service;

import java.io.Serializable;
import java.util.List;

import br.com.bancoamazonia.card.model.dao.OcupacaoDao;
import br.com.bancoamazonia.card.model.domain.Ocupacao;

public class OcupacaoService {

	private OcupacaoDao ocupacaoDao;

	public void setOcupacaoDao(OcupacaoDao ocupacaoDao) {
		this.ocupacaoDao = ocupacaoDao;
	}
	
	public Ocupacao get(Serializable id) {
		return ocupacaoDao.get(Ocupacao.class, id);
	}
	
	public List<Ocupacao> list() {
		return ocupacaoDao.list(Ocupacao.class);
	}
}
