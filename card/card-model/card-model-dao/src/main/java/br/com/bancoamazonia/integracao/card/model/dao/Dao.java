package br.com.bancoamazonia.integracao.card.model.dao;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Dao {
	
	public Dao() {
		
	}

	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext(new String[] {"modelContext.xml"});
	}
}
