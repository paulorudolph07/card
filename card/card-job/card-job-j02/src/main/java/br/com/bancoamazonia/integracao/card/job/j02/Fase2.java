package br.com.bancoamazonia.integracao.card.job.j02;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;

import br.com.bancoamazonia.integracao.opcon.OpconException;
import br.com.bancoamazonia.integracao.opcon.PreparedFaseOpcon;
import br.com.bancoamazonia.integracao.util.JobErros;

/**
 * Valida os registros da tabela carret da data atual do sistema para posterior atualização
 * @author 7485
 *
 */
public class Fase2 extends PreparedFaseOpcon {
	
	public Fase2() {
		connectionName = "CARDCON01";
	}
	
	@Override
	public void run() throws Exception {
		PreparedStatement query = conn.prepareStatement("select intret_seq, chrret_tip, dtmdat_atu from carctlret " +
				"where dtmdat_atu = (select c.dtmdat_atu from cardat c) order by intret_seq");
		
		ResultSet arqRetProc = query.executeQuery();
		while(arqRetProc.next()) {
			CallableStatement cstmt = conn.prepareCall("{? = call spu_ValidarRetorno(?, ?, ?, ?)}");
			
			cstmt.registerOutParameter(1, Types.INTEGER); // retorno
			cstmt.setTimestamp(2, arqRetProc.getTimestamp(3)); // 1 param = data refencia
			cstmt.setInt(3, arqRetProc.getInt(1)); // 2 param = sequencial do arquivo
			cstmt.setString(4, arqRetProc.getString(2)); // 3 param = tipo retorno (R, A ou G)
			cstmt.registerOutParameter(5, Types.VARCHAR); // 4 param = mensagem de erro
			
			// tanto para erro quanto para ok, a sp executa update na tabela carctlret
			cstmt.executeUpdate();
			
			if(cstmt.getInt(1) != 0)
				throw new OpconException(JobErros.ERRO_INESPERADO_EXECUCAO_FASE.valor(), cstmt.getString(5));
		}
	}

}
