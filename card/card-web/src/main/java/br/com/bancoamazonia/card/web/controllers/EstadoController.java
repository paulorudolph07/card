package br.com.bancoamazonia.card.web.controllers;

import java.io.Serializable;
import java.util.List;

import javax.faces.bean.ManagedBean;

import br.com.bancoamazonia.card.model.domain.Estado;
import br.com.bancoamazonia.card.service.EstadoService;

@ManagedBean
public class EstadoController implements Serializable {
	private static final long serialVersionUID = -7072465253537895407L;
	private EstadoService estadoService;
	
	public void setEstadoService(EstadoService estadoService) {
		this.estadoService = estadoService;
	}
	
	public List<Estado> getList() {
		return estadoService.list();
	}
}
