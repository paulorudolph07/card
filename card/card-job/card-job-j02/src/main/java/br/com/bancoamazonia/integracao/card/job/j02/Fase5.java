package br.com.bancoamazonia.integracao.card.job.j02;

import java.sql.CallableStatement;
import java.sql.Types;

import br.com.bancoamazonia.integracao.opcon.OpconException;
import br.com.bancoamazonia.integracao.opcon.PreparedFaseOpcon;
import br.com.bancoamazonia.integracao.util.JobErros;

/**
 * Abri o sistema para inclsao de propostas 
 * @author 7485
 *
 */
public class Fase5 extends PreparedFaseOpcon {
	
	public Fase5() {
		connectionName = "CARDCON01";
	}
	
	@Override
	public void run() throws Exception {
		CallableStatement cstmt = conn.prepareCall("{call spu_AlterarStatus(?, ?)}");
		
		// abre o sistema
		cstmt.setString(1, "A");
		// register arg2 OUT parameter (output message)
		cstmt.registerOutParameter(2, Types.VARCHAR);
			
		if(cstmt.executeUpdate() < 1)
			throw new OpconException(JobErros.ERRO_SQL.valor(), cstmt.getString(2));
	}

}
