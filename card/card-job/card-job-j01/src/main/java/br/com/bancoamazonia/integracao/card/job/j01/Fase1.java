package br.com.bancoamazonia.integracao.card.job.j01;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;

import br.com.bancoamazonia.integracao.opcon.OpconException;
import br.com.bancoamazonia.integracao.opcon.PreparedFaseOpcon;
import br.com.bancoamazonia.integracao.util.JobErros;

/**
 * Inseri na tabela temporaria #tmpRem os registros para composicao do arquivo remessa
 * @author 7485
 *
 */
public class Fase1 extends PreparedFaseOpcon {

	private Integer seqArqRemessa;
	private Timestamp dataAtual;
	private String outputMsg;
	
	public Fase1() {
		connectionName = "CARDCON01";
	}
	
	@Override
	public void run() throws Exception {
		// parametro com o ultimo sequencial do arquivo remessa
		if ((seqArqRemessa = getSequencialRemessa()) <= 0)
			throw new OpconException(JobErros.ERRO_PROPRIEDADE_SISTEMA_INDEFINIDA.valor(), outputMsg);
			
		dataAtual = getDataAtual();
		// a spi_ArquivoRemessa retorna um ResultSet (select em #tmpRem)
		if(!gerarPropostas() || !gerarRemessa() || !incluirSequencialRemessa()) 
			throw new OpconException(JobErros.ERRO_INESPERADO_EXECUCAO_FASE.valor(), outputMsg);
	}
	/**
	 * Recupera o valor sequencial da ultima remessa a partir da sp spi_UltimaRemessa
	 * @return
	 * @throws SQLException
	 * @throws OpconException
	 */
	private Integer getSequencialRemessa() throws SQLException, OpconException {
		// recupera o ultimo sequencial do arquivo remessa
		CallableStatement cstmt = conn.prepareCall("{call spi_UltimaRemessa(?, ?)}");
		
		cstmt.registerOutParameter(1, Types.SMALLINT);
		cstmt.registerOutParameter(2, Types.VARCHAR);
		
		cstmt.execute();
		
		Integer result = cstmt.getInt(1);
		outputMsg = cstmt.getString(2);
		
		return result;
	}
	/**
	 * Inseri cada registro (propostas solicitadas com a data atual do sistema) para formar o arquivo remessa em uma tabela temporaria #tmpRem
	 * @return
	 * @throws SQLException 
	 */
	private boolean gerarPropostas() throws SQLException {
		CallableStatement cstmt = conn.prepareCall("{call spi_ArquivoRemessa(?, ?, ?)}");
		
		cstmt.setTimestamp(1, dataAtual);
		cstmt.setInt(2, seqArqRemessa + 1);
		cstmt.registerOutParameter(3, Types.VARCHAR);
		
		boolean exec = cstmt.execute();
		
		/*
		 *  recupera o ResultSet (select na tabela #tmpRem), 
		 *  para poder recuperar o parametro de saida (out), caso contrario o parametro nao estara pronto.
		 *  @throws Output parameters have not yet been processed. Call getMoreResults()
		 */
		cstmt.getMoreResults();
		
		// parametro de saida
		outputMsg = cstmt.getString(3);
		
		return exec;
	}
	/**
	 * Gera arquivo remessa a partir dos registros da tabela temporaria #tmpRem
	 * @return
	 * @throws SQLException
	 * @throws OpconException 
	 */
	private boolean gerarRemessa() {
		try {
			CallableStatement cstmt = conn.prepareCall("{call spu_GerarRemessa()}");
			cstmt.execute();
		}
		catch(SQLException e) {
			outputMsg = e.getMessage();
			return false;
		}
		
		return true;
	}
	/**
	 * inclui sequencial do arquivo remessa
	 * @throws SQLException
	 * @throws OpconException
	 */
	private boolean incluirSequencialRemessa() throws SQLException, OpconException {
		CallableStatement cstmt = conn.prepareCall("{call spu_IncluirRemessa(?, ?, ?)}");
		
		cstmt.setTimestamp(1, dataAtual);
		cstmt.setInt(2, seqArqRemessa + 1);
		cstmt.registerOutParameter(3, Types.VARCHAR);
		
		Integer updateCount = cstmt.executeUpdate();
		
		outputMsg = cstmt.getString(3);
		
		return updateCount > 0;
	}
	/**
	 * Recupara a data atual do sistema da tabela cardat.
	 * @return
	 * @throws OpconException
	 * @throws SQLException 
	 */
	private Timestamp getDataAtual() throws SQLException {
		PreparedStatement query = conn.prepareStatement("select c.dtmdat_atu from cardat c");
		ResultSet result = query.executeQuery();
		result.next();
		return result.getTimestamp(1);
	}
}
