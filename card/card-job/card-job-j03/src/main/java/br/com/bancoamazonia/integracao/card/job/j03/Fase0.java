package br.com.bancoamazonia.integracao.card.job.j03;

import java.sql.CallableStatement;

import br.com.bancoamazonia.integracao.opcon.PreparedFaseOpcon;

public class Fase0 extends PreparedFaseOpcon {
	
	public Fase0() {
		connectionName = "CARDCON01";
	}

	@Override
	public void run() throws Exception {
		CallableStatement cstmt = conn.prepareCall("{call spu_GerarCartoesEmitidos()}");
		cstmt.executeUpdate();
	}
	
}
