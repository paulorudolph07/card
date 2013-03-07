package br.com.bancoamazonia.card.model.domain;

import java.util.Date;
/**
 * Integrar com pd_base
 * @author root
 *
 */
public class ControleSistema {
	private Byte id;
	private Boolean aberto;
	private Date dataAnterior;
	private Date dataAtual;
	private Date dataProxima;
	public Byte getId() {
		return id;
	}
	public void setId(Byte id) {
		this.id = id;
	}
	public Boolean getAberto() {
		return aberto;
	}
	public void setAberto(Boolean aberto) {
		this.aberto = aberto;
	}
	public Date getDataAnterior() {
		return dataAnterior;
	}
	public void setDataAnterior(Date dataAnterior) {
		this.dataAnterior = dataAnterior;
	}
	public Date getDataAtual() {
		return dataAtual;
	}
	public void setDataAtual(Date dataAtual) {
		this.dataAtual = dataAtual;
	}
	public Date getDataProxima() {
		return dataProxima;
	}
	public void setDataProxima(Date dataProxima) {
		this.dataProxima = dataProxima;
	}
}
