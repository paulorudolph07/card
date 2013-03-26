package br.com.bancoamazonia.card.web.controllers;

import java.io.Serializable;
import java.util.List;

import javax.faces.bean.ManagedBean;

import br.com.bancoamazonia.card.model.domain.SituacaoResidencial;
import br.com.bancoamazonia.card.service.SituacaoResidencialService;

@ManagedBean
public class SituacaoResidencialController implements Serializable {
	
	private static final long serialVersionUID = 4829846316971809789L;
	private SituacaoResidencialService situacaoResidencialService;

	public void setSituacaoResidencialService(
			SituacaoResidencialService situacaoResidencialService) {
		this.situacaoResidencialService = situacaoResidencialService;
	}
	
	public List<SituacaoResidencial> getList() {
		return situacaoResidencialService.list();
	}
	
}
