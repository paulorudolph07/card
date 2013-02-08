package br.com.bancoamazonia.integracao.card.job.j02;

import java.io.File;
import java.io.FileFilter;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.RegexFileFilter;

import br.com.bancoamazonia.integracao.opcon.OpconException;
import br.com.bancoamazonia.integracao.opcon.PreparedFaseOpcon;
import br.com.bancoamazonia.integracao.util.JobErros;

/**
 * Processa os arquivos retorno, carregando os registro (header, detalhe e trailer) na base (carret e carctlret) para posterior validacao.
 * @author 7485
 *
 */
public class Fase1 extends PreparedFaseOpcon {
	
	public Fase1() {
		connectionName = "CARDCON01";
	}
	
	@Override
	public void run() throws Exception {
		File tempFile = null;
		PreparedStatement query = conn.prepareStatement("select vchlot_nomarq, vchlot_locarq, vchlot_cod, vchlot_locarqpro " +
				"from cadlot where vchlot_cod in ('retorno', 'analise', 'gravados') order by vchlot_nomarq");
		
		ResultSet arqRetorno = query.executeQuery();
		while(arqRetorno.next()) {
			String name = arqRetorno.getString(1).replaceAll("%SQ5%", "\\\\d{5}");
			name = name.replaceAll("\\.", "\\\\.");
			String path = arqRetorno.getString(2);
			String tipoRetorno = arqRetorno.getString(3);
				
			File dir = new File(path);
			FileFilter fileFilter = new RegexFileFilter(name);
			File file = dir.listFiles(fileFilter)[0];
			
			name = file.getName();
			
			int seqRetorno = Integer.parseInt(name.substring(name.lastIndexOf(".") + 1));
			
			CallableStatement cstmt = conn.prepareCall("{call spu_ProcessarRetorno(?, ?, ?)}");
			
			// cria arquivo temporario para ser processado pela sp (arquivo com caracter '.' no nome do arquivo sao truncados ao passar para a sp)
			tempFile = File.createTempFile(tipoRetorno+seqRetorno, ".temp", new File(path));
			FileUtils.copyFile(file, tempFile, true);
			
			cstmt.setString(1, tempFile.getAbsolutePath());
			cstmt.setString(2, tipoRetorno.charAt(0) + "");
			cstmt.setInt(3, seqRetorno);
			
			if (cstmt.executeUpdate() < 1) 
				throw new OpconException(JobErros.ERRO_INESPERADO_EXECUCAO_FASE.valor(), 
						"Erro ao processar arquivo " + file.getAbsolutePath());
			
			tempFile.deleteOnExit();
			FileUtils.moveFileToDirectory(file, new File(arqRetorno.getString(4)), false);
		}
	}

}
