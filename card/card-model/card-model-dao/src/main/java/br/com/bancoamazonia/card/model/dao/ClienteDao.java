package br.com.bancoamazonia.card.model.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import br.com.bancoamazonia.card.model.domain.Cliente;
import br.com.bancoamazonia.card.model.domain.TipoCliente;

public class ClienteDao extends Dao<Cliente> {
	
	@SuppressWarnings("unchecked")
	public List<Cliente> listByTipo(TipoCliente tipo) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Cliente.class);
		criteria.add(Restrictions.eq("tipo", tipo));
		return criteria.list();
	}
}
