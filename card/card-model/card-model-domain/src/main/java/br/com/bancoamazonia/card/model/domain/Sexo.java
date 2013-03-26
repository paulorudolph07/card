package br.com.bancoamazonia.card.model.domain;

public class Sexo {
	private Byte id;
	private Character codigo;
	public Byte getId() {
		return id;
	}
	public void setId(Byte id) {
		this.id = id;
	}
	public Character getCodigo() {
		return codigo;
	}
	public void setCodigo(Character codigo) {
		this.codigo = codigo;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		Sexo other = (Sexo) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
}
