package br.com.bancoamazonia.integracao.card.model.domain;

import java.io.Serializable;
import java.util.Date;
/**
 * Esta classe registra o movimento (status ou historico) dos cartoes associados a uma determinada agencia
 * @author root
 *
 */
public class Movimento implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6799667537982917550L;
	// cartao, evento e sequencial = chave composta
	private Cartao cartao;
	private Evento evento;
	private Integer sequencial;
	private Date data;
	// registra o movimento para uma determinada agencia (historico)
	private Integer agencia;
	private Boolean valido;
	private String matriculaUsuario;
	// qual arquivo gerou este movimento
	private Arquivo arquivoOrigem;
	public Cartao getCartao() {
		return cartao;
	}
	public void setCartao(Cartao cartao) {
		this.cartao = cartao;
	}
	public Evento getEvento() {
		return evento;
	}
	public void setEvento(Evento evento) {
		this.evento = evento;
	}
	public Integer getSequencial() {
		return sequencial;
	}
	public void setSequencial(Integer sequencial) {
		this.sequencial = sequencial;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public Integer getAgencia() {
		return agencia;
	}
	public void setAgencia(Integer agencia) {
		this.agencia = agencia;
	}
	public Boolean getValido() {
		return valido;
	}
	public void setValido(Boolean valido) {
		this.valido = valido;
	}
	public String getMatriculaUsuario() {
		return matriculaUsuario;
	}
	public void setMatriculaUsuario(String matriculaUsuario) {
		this.matriculaUsuario = matriculaUsuario;
	}
	public Arquivo getArquivoOrigem() {
		return arquivoOrigem;
	}
	public void setArquivoOrigem(Arquivo arquivoOrigem) {
		this.arquivoOrigem = arquivoOrigem;
	}
}
