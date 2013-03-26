package br.com.bancoamazonia.card.service;

import java.io.Serializable;
import java.util.List;

import br.com.bancoamazonia.card.model.dao.SituacaoResidencialDao;
import br.com.bancoamazonia.card.model.domain.SituacaoResidencial;

public class SituacaoResidencialService {

	private SituacaoResidencialDao situacaoResidencialDao;

	public void setSituacaoResidencialDao(
			SituacaoResidencialDao situacaoResidencialDao) {
		this.situacaoResidencialDao = situacaoResidencialDao;
	}
	
	public SituacaoResidencial get(Serializable id) {
		return situacaoResidencialDao.get(SituacaoResidencial.class, id);
	}
	
	public List<SituacaoResidencial> list() {
		return situacaoResidencialDao.list(SituacaoResidencial.class);
	}
}
