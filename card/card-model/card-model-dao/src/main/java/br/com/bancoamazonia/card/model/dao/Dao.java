package br.com.bancoamazonia.card.model.dao;

import java.io.Serializable;

import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;

public abstract class Dao<T> {
	
	protected SessionFactory sessionFactory;
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public Serializable save(T obj) throws DataAccessException {
		return sessionFactory.getCurrentSession().save(obj);
	}
		
	public void delete(T obj) throws DataAccessException {
		sessionFactory.getCurrentSession().delete(obj);
	}

	public void update(T obj) throws DataAccessException {
		sessionFactory.getCurrentSession().update(obj);
	}
	
	public void saveOrUpdate(T obj) throws DataAccessException {
		sessionFactory.getCurrentSession().saveOrUpdate(obj);
	}
	
	public void flush() throws DataAccessException {
		sessionFactory.getCurrentSession().flush();
	}
	
	public void clear() throws DataAccessException {
		sessionFactory.getCurrentSession().clear();
	}
	
	public void evict(T obj) throws DataAccessException {
		sessionFactory.getCurrentSession().evict(obj);
	}
	
	public void persit(T obj) throws DataAccessException {
		sessionFactory.getCurrentSession().persist(obj);
	}
	
	@SuppressWarnings("unchecked")
	public T get(Class<T> clazz, Serializable id) throws DataAccessException {
		return (T) sessionFactory.getCurrentSession().get(clazz, id);
	}

	@SuppressWarnings("unchecked")
	public T load(Class<T> clazz, Serializable id) throws DataAccessException {
		return (T) sessionFactory.getCurrentSession().load(clazz, id);
	}
}
