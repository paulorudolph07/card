package br.com.bancoamazonia.card.service;

import java.util.List;

import br.com.bancoamazonia.card.model.dao.ClienteDao;
import br.com.bancoamazonia.card.model.domain.Cliente;
import br.com.bancoamazonia.card.model.domain.TipoCliente;

public class ClienteService {
	private ClienteDao clienteDao;
	public void setClienteDao(ClienteDao clienteDao) {
		this.clienteDao = clienteDao;
	}
	public List<Cliente> listByTipo(TipoCliente tipo) {
		return clienteDao.listByTipo(tipo);
	}
	public Cliente getByCodigo(String codigo) {
		return clienteDao.get(Cliente.class, codigo);
	}
}
