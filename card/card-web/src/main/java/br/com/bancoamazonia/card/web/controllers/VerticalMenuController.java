package br.com.bancoamazonia.card.web.controllers;

import java.io.Serializable;

import javax.faces.bean.ManagedBean;

import org.primefaces.event.TabChangeEvent;

@ManagedBean
public class VerticalMenuController implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3768197058509431265L;
	private Integer tabIndex;
	public Integer getTabIndex() {
		return tabIndex;
	}
	public void setTabIndex(Integer tabIndex) {
		this.tabIndex = tabIndex;
	}

	public void onTabChange(TabChangeEvent event) {
		
	}
}
