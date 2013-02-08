package br.com.bancoamazonia.integracao.card.job.j02;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;

import br.com.bancoamazonia.integracao.opcon.PreparedFaseOpcon;

/**
 * Atualiza os movimentos das propostas (carmov) a partir dos registros da tabela carret com a data atual do sistema.
 * @author 7485
 *
 */
public class Fase3 extends PreparedFaseOpcon {
	
	public Fase3() {
		connectionName = "CARDCON01";
	}
	
	@Override
	public void run() throws Exception {
		PreparedStatement query = conn.prepareStatement("select intret_seq, chrret_tip, dtmdat_atu from carctlret " +
				"where dtmdat_atu = (select c.dtmdat_atu from cardat c) order by intret_seq");
		
		ResultSet arqRetProc = query.executeQuery();
		while(arqRetProc.next()) {
			CallableStatement cstmt = conn.prepareCall("{call spu_AtualizarRetorno(?, ?, ?, ?)}");
			
			cstmt.setTimestamp(1, arqRetProc.getTimestamp(3)); // 1 param = data refencia
			cstmt.setString(2, arqRetProc.getString(2)); // 2 param = tipo retorno (R, A ou G)
			cstmt.setInt(3, arqRetProc.getInt(1)); // 3 param = sequencial do arquivo
			cstmt.registerOutParameter(4, Types.VARCHAR); // 4 param = mensagem de erro
			
			cstmt.executeUpdate();
		}
	}

}
