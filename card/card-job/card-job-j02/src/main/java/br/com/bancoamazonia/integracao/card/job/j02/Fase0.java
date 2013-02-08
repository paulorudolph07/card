package br.com.bancoamazonia.integracao.card.job.j02;

import java.io.File;
import java.io.FileFilter;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;

import org.apache.commons.io.filefilter.RegexFileFilter;

import br.com.bancoamazonia.integracao.opcon.OpconException;
import br.com.bancoamazonia.integracao.opcon.PreparedFaseOpcon;
import br.com.bancoamazonia.integracao.util.JobErros;

/**
 * Valida a existencia dos 3 arquivos para o processamento correto dos arquivo retorno (PEL.BASAA, PEL.BASAB e PEL.BASAC),
 * 	bem como o sequencial (NSU) dos mesmos
 * @author 7485
 *
 */
public class Fase0 extends PreparedFaseOpcon {
	
	public Fase0() {
		connectionName = "CARDCON01";
	}
	
	@Override
	public void run() throws Exception {
		PreparedStatement query = conn.prepareStatement("select vchlot_nomarq, vchlot_locarq, vchlot_cod " +
				"from cadlot where vchlot_cod in ('retorno', 'analise', 'gravados') order by vchlot_nomarq");
		
		ResultSet arqRetorno = query.executeQuery();
		while(arqRetorno.next()) {
			// valida existencia do arquivo
			String name = arqRetorno.getString(1).replaceAll("%SQ5%", "\\\\d{5}");
			name = name.replaceAll("\\.", "\\\\.");
			String path = arqRetorno.getString(2);
				
			File dir = new File(path);
			FileFilter fileFilter = new RegexFileFilter(name);
			File[] files = dir.listFiles(fileFilter);
			
			if(files == null || files.length == 0)
				throw new OpconException(JobErros.ERRO_INESPERADO_EXECUCAO_FASE.valor(), 
						"Arquivo " + path + "\\" + name + " nao localizado!");
			// valida sequencial do arquivo
			CallableStatement cstmt = conn.prepareCall("{call spi_UltimoRetorno(?, ?, ?)}");
			
			String tipoRetorno = arqRetorno.getString(3);
			
			cstmt.setString(1, tipoRetorno.charAt(0) + "");
			cstmt.registerOutParameter(2, Types.INTEGER);
			cstmt.registerOutParameter(3, Types.VARCHAR);
			
			cstmt.execute();
			
			File file = files[0];
			name = file.getName();
			
			int seqRetorno = Integer.parseInt(name.substring(name.lastIndexOf(".") + 1));
			int ultimoRetorno = cstmt.getInt(2);
			
			if(seqRetorno != ultimoRetorno + 3)
				throw new OpconException(JobErros.ERRO_INESPERADO_EXECUCAO_FASE.valor(), 
						"Sequencial incorreto do arquivo " + file.getAbsolutePath() + ". Devendo ser " + (ultimoRetorno + 3));
		}
	}

}
