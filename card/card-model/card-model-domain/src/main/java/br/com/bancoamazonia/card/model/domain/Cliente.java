package br.com.bancoamazonia.card.model.domain;

import java.io.Serializable;
import java.util.Date;

public class Cliente extends Pessoa implements Serializable {
	private static final long serialVersionUID = -8001153551689965403L;
	private Cliente titular;
	private Telefone celular;
	private TipoCliente tipo;
	private Sexo sexo;
	private EstadoCivil estadoCivil;
	private Escolaridade escolaridade;
	private String nomeMae;
	private Date dataNascimento;
	private String email; // ha necessidade de email para fontePagadora? Caso sim, colocar em pessoa
	public Cliente getTitular() {
		return titular;
	}
	public void setTitular(Cliente titular) {
		this.titular = titular;
	}
	public Telefone getCelular() {
		return celular;
	}
	public void setCelular(Telefone celular) {
		this.celular = celular;
	}
	public TipoCliente getTipo() {
		return tipo;
	}
	public void setTipo(TipoCliente tipo) {
		this.tipo = tipo;
	}
	public Sexo getSexo() {
		return sexo;
	}
	public void setSexo(Sexo sexo) {
		this.sexo = sexo;
	}
	public EstadoCivil getEstadoCivil() {
		return estadoCivil;
	}
	public void setEstadoCivil(EstadoCivil estadoCivil) {
		this.estadoCivil = estadoCivil;
	}
	public Escolaridade getEscolaridade() {
		return escolaridade;
	}
	public void setEscolaridade(Escolaridade escolaridade) {
		this.escolaridade = escolaridade;
	}
	public String getNomeMae() {
		return nomeMae;
	}
	public void setNomeMae(String nomeMae) {
		this.nomeMae = nomeMae;
	}
	public Date getDataNascimento() {
		return dataNascimento;
	}
	public void setDataNascimento(Date dataNascimento) {
		this.dataNascimento = dataNascimento;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
