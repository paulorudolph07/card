package br.com.bancoamazonia.integracao.card.model.domain;

import java.io.Serializable;

/**
 * O status do cartao fica registrado no ultimo movimento
 * @author root
 *
 */
public class Cartao implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 302052931400615542L;
	// id
	private String numero;
	private Cliente cliente;
	// facilitara as consultas para relatorios baseados no status (evento) do cartao
	private Evento status;
	private Classe classe;
	private Vencimento vencimento;
	private Limite limite;
	private Endereco enderecoEntrega;
	// o cartao pode pertencer ou nao a um cliente do banco
	private Integer agencia;
	private String cpfVendedor;
	private Boolean avaliacaoEmergencial;
	private Boolean programaRecompensa; // liberado somente para internacional ou gold
	private Boolean infoEmail;
	private Boolean infoTelefone;
	private Boolean infoCorreio;
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public Cliente getCliente() {
		return cliente;
	}
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	public Evento getStatus() {
		return status;
	}
	public void setStatus(Evento status) {
		this.status = status;
	}
	public Classe getClasse() {
		return classe;
	}
	public void setClasse(Classe classe) {
		this.classe = classe;
	}
	public Vencimento getVencimento() {
		return vencimento;
	}
	public void setVencimento(Vencimento vencimento) {
		this.vencimento = vencimento;
	}
	public Limite getLimite() {
		return limite;
	}
	public void setLimite(Limite limite) {
		this.limite = limite;
	}
	public Endereco getEnderecoEntrega() {
		return enderecoEntrega;
	}
	public void setEnderecoEntrega(Endereco enderecoEntrega) {
		this.enderecoEntrega = enderecoEntrega;
	}
	public Integer getAgencia() {
		return agencia;
	}
	public void setAgencia(Integer agencia) {
		this.agencia = agencia;
	}
	public String getCpfVendedor() {
		return cpfVendedor;
	}
	public void setCpfVendedor(String cpfVendedor) {
		this.cpfVendedor = cpfVendedor;
	}
	public Boolean getAvaliacaoEmergencial() {
		return avaliacaoEmergencial;
	}
	public void setAvaliacaoEmergencial(Boolean avaliacaoEmergencial) {
		this.avaliacaoEmergencial = avaliacaoEmergencial;
	}
	public Boolean getProgramaRecompensa() {
		return programaRecompensa;
	}
	public void setProgramaRecompensa(Boolean programaRecompensa) {
		this.programaRecompensa = programaRecompensa;
	}
	public Boolean getInfoEmail() {
		return infoEmail;
	}
	public void setInfoEmail(Boolean infoEmail) {
		this.infoEmail = infoEmail;
	}
	public Boolean getInfoTelefone() {
		return infoTelefone;
	}
	public void setInfoTelefone(Boolean infoTelefone) {
		this.infoTelefone = infoTelefone;
	}
	public Boolean getInfoCorreio() {
		return infoCorreio;
	}
	public void setInfoCorreio(Boolean infoCorreio) {
		this.infoCorreio = infoCorreio;
	}
}
