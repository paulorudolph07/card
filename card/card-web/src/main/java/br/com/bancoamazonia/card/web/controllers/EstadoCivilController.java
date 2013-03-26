package br.com.bancoamazonia.card.web.controllers;

import java.io.Serializable;
import java.util.List;

import javax.faces.bean.ManagedBean;

import br.com.bancoamazonia.card.model.domain.EstadoCivil;
import br.com.bancoamazonia.card.service.EstadoCivilService;

@ManagedBean
public class EstadoCivilController implements Serializable {
	private static final long serialVersionUID = -7072465253537895407L;
	private EstadoCivilService estadoCivilService;
	
	public void setEstadoCivilService(EstadoCivilService estadoCivilService) {
		this.estadoCivilService = estadoCivilService;
	}
	
	public List<EstadoCivil> getList() {
		return estadoCivilService.list();
	}
}
