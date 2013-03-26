package br.com.bancoamazonia.card.model.domain;

import java.io.Serializable;

/**
 * Esta classe representa o status no fluxo (movimento) da concepcao do cartao ou o status do cartao
 * @author root
 *
 */
public class Evento implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2923597222195096924L;
	//id
	private Byte codigo;
	private String descricao;
	public Byte getCodigo() {
		return codigo;
	}
	public void setCodigo(Byte codigo) {
		this.codigo = codigo;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((codigo == null) ? 0 : codigo.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Evento other = (Evento) obj;
		if (codigo == null) {
			if (other.codigo != null)
				return false;
		} else if (!codigo.equals(other.codigo))
			return false;
		return true;
	}
}
