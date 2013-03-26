package br.com.bancoamazonia.card.web.controllers;

import java.io.Serializable;
import java.util.List;

import javax.faces.bean.ManagedBean;

import br.com.bancoamazonia.card.model.domain.Escolaridade;
import br.com.bancoamazonia.card.service.EscolaridadeService;

@ManagedBean
public class EscolaridadeController implements Serializable {
	private static final long serialVersionUID = -5896273853591179829L;
	private EscolaridadeService escolaridadeService;

	public void setEscolaridadeService(EscolaridadeService escolaridadeService) {
		this.escolaridadeService = escolaridadeService;
	}
	
	public List<Escolaridade> getList() {
		return escolaridadeService.list();
	}
}
