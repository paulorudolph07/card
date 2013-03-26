package br.com.bancoamazonia.card.web.controllers;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.context.FacesContext;

import br.com.bancoamazonia.card.model.domain.Cliente;
import br.com.bancoamazonia.card.model.domain.DadoComercial;
import br.com.bancoamazonia.card.model.domain.DadoResidencial;
import br.com.bancoamazonia.card.model.domain.Endereco;
import br.com.bancoamazonia.card.model.domain.FontePagadora;
import br.com.bancoamazonia.card.model.domain.Identidade;
import br.com.bancoamazonia.card.model.domain.Renda;
import br.com.bancoamazonia.card.model.domain.Telefone;
import br.com.bancoamazonia.card.model.domain.TipoCliente;
import br.com.bancoamazonia.card.service.ClienteService;

@ManagedBean
public class TitularController implements Serializable {
	private static final long serialVersionUID = 5895354172309533210L;
	
	private Boolean titularValido = false;
	
	private Cliente titular;
	private Identidade identidade;
	private DadoResidencial dadoResidencial;
	private DadoComercial dadoComercial;
	private List<DadoComercial> dadosComerciais = new ArrayList<DadoComercial>();
	
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
	public Identidade getIdentidade() {
		return identidade;
	}
	public void setIdentidade(Identidade identidade) {
		this.identidade = identidade;
	}
	public DadoResidencial getDadoResidencial() {
		return dadoResidencial;
	}
	public void setDadoResidencial(DadoResidencial dadoResidencial) {
		this.dadoResidencial = dadoResidencial;
	}
	public DadoComercial getDadoComercial() {
		return dadoComercial;
	}
	public void setDadoComercial(DadoComercial dadoComercial) {
		this.dadoComercial = dadoComercial;
	}
	public List<DadoComercial> getDadosComerciais() {
		return dadosComerciais;
	}
	public void setDadosComerciais(List<DadoComercial> dadosComerciais) {
		this.dadosComerciais = dadosComerciais;
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
	
	public void addDadoComercial() {
		dadosComerciais.add(dadoComercial);
		// instanciado inicialmente em webContext.xml
		dadoComercial = new DadoComercial();
		dadoComercial.setTelefone(new Telefone());
		dadoComercial.setEndereco(new Endereco());
		
		Renda renda = new Renda();
		renda.setFontePagadora(new FontePagadora());
		
		dadoComercial.setRenda(renda);
		System.out.println("dado comercail: " + dadosComerciais.size());
	}
	
	public void deleteDadoComercial(Integer index) {
		dadosComerciais.remove(index);
	}
	
	public void save() {
		
	}
}
