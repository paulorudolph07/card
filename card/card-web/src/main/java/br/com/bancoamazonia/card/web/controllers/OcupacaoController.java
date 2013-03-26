package br.com.bancoamazonia.card.web.controllers;

import java.io.Serializable;
import java.util.List;

import javax.faces.bean.ManagedBean;

import br.com.bancoamazonia.card.model.domain.Ocupacao;
import br.com.bancoamazonia.card.service.OcupacaoService;

@ManagedBean
public class OcupacaoController implements Serializable {
	private static final long serialVersionUID = 2840378761547869136L;
	private OcupacaoService ocupacaoService;

	public void setOcupacaoService(OcupacaoService ocupacaoService) {
		this.ocupacaoService = ocupacaoService;
	}
	
	public List<Ocupacao> getList() {
		return ocupacaoService.list();
	}
}
