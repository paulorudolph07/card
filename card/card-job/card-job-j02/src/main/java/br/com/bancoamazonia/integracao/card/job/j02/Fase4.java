package br.com.bancoamazonia.integracao.card.job.j02;

import java.sql.CallableStatement;
import java.sql.Types;

import br.com.bancoamazonia.integracao.opcon.OpconException;
import br.com.bancoamazonia.integracao.opcon.PreparedFaseOpcon;
import br.com.bancoamazonia.integracao.util.JobErros;

/**
 * Altera a data do sistema para a proxima data (tabela cardat) considerando os dias uteis.
 * @author 7485
 *
 */
public class Fase4 extends PreparedFaseOpcon {
	
	public Fase4() {
		connectionName = "CARDCON01";
	}
	
	@Override
	public void run() throws Exception {
		CallableStatement cstmt = conn.prepareCall("{call spu_AlterarDatas(?)}");
		cstmt.registerOutParameter(1, Types.VARCHAR); // 1 param = mensagem de erro
			
		if(cstmt.executeUpdate() < 1)
			throw new OpconException(JobErros.ERRO_SQL.valor(), cstmt.getString(1));
	}

}
