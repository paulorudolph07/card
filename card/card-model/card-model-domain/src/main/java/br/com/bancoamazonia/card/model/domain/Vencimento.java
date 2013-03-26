package br.com.bancoamazonia.card.model.domain;

public class Vencimento {
	private Byte id;
	private Byte dia;
	public Byte getId() {
		return id;
	}
	public void setId(Byte id) {
		this.id = id;
	}
	public Byte getDia() {
		return dia;
	}
	public void setDia(Byte dia) {
		this.dia = dia;
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
		Vencimento other = (Vencimento) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
}
