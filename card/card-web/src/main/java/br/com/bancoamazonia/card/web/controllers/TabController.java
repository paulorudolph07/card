package br.com.bancoamazonia.card.web.controllers;

import javax.faces.bean.ManagedBean;

import org.primefaces.event.TabChangeEvent;

@ManagedBean
public class TabController {
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
