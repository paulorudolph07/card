package br.com.bancoamazonia.integracao.card.model.domain;
/**
 * Pessoa Fisica ou Juridica
 * @author root
 *
 */
public class TipoFontePagadora {
	private Byte id;
	private String codigo;
	public Byte getId() {
		return id;
	}
	public void setId(Byte id) {
		this.id = id;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
}
