package br.com.bancoamazonia.card.web.controllers;

import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.context.FacesContext;

import br.com.bancoamazonia.card.model.domain.Cliente;
import br.com.bancoamazonia.card.model.domain.TipoCliente;
import br.com.bancoamazonia.card.service.ClienteService;

@ManagedBean
public class TitularController {
	private Cliente titular = new Cliente();
	private Boolean titularValido = false;
	private ClienteService clienteService;
	public Boolean getTitularValido() {
		return titularValido;
	}
	public void setTitularValido(Boolean titularValido) {
		this.titularValido = titularValido;
	}
	public Cliente getTitular() {
		return titular;
	}
	public void setTitular(Cliente titular) {
		this.titular = titular;
	}
	public void setClienteService(ClienteService clienteService) {
		this.clienteService = clienteService;
	}
	/**
	 * Valida se o usário ja possui cartao
	 */
	public void validate() {
		if(clienteService.getByCodigo(titular.getCodigo()) != null) {
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(
				FacesMessage.SEVERITY_INFO, 
				"Cliente já cadastrado na base. Solicitação de cartão não permitida.", 
				"msg_detail")
			);
			titularValido = false;
		}
		else {
			FacesContext.getCurrentInstance().addMessage(
					null, 
					new FacesMessage("Titular liberado para solicitação de cartão.")
			);
			titularValido = true;
		}
	}
	
	public List<Cliente> getList() {
		return clienteService.listByTipo(new TipoCliente((byte)1));
	}
	
	public void save() {
		
	}
}
