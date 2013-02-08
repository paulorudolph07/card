package br.com.bancoamazonia.integracao.card.job.j01;

import java.sql.CallableStatement;
import java.sql.Types;

import br.com.bancoamazonia.integracao.opcon.OpconException;
import br.com.bancoamazonia.integracao.opcon.PreparedFaseOpcon;
import br.com.bancoamazonia.integracao.util.JobErros;

/**
 * Fechamento do sistema, impedindo a inclusao de novas propostas (digitacao)
 * @author 7485
 *
 */
public class Fase0 extends PreparedFaseOpcon {

	public Fase0() {
		connectionName = "CARDCON01";
	}
	
	@Override
	public void run() throws Exception {
		CallableStatement cstmt = conn.prepareCall("{call spu_AlterarStatus(?, ?)}");
		
		// fecha o sistema
		cstmt.setString(1, "F");
		// register arg2 OUT parameter (output message)
		cstmt.registerOutParameter(2, Types.VARCHAR);
		
		if(cstmt.executeUpdate() != 1)
			throw new OpconException(JobErros.ERRO_SQL.valor(), cstmt.getString(2));
	}

}
