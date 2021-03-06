USE [pd_card]
GO
/****** Object:  StoredProcedure [dbo].[spu_GerarCartoesEmitidos]    Script Date: 01/30/2013 13:15:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spu_GerarCartoesEmitidos]
	@frequencia varchar(6) = 'DIARIA'
AS
BEGIN
	declare @dataAtual smalldatetime,
			@dataProc as char(8),
			@pdtmIni smalldatetime,
			@pdtmFim smalldatetime,
			@destinationDir nvarchar(255),
			@fileName nvarchar(100),
			@dataIndex int

	select @destinationDir = vchlot_locarq, @fileName = vchlot_nomarq from cadlot where vchlot_cod = 'emitidos'
	set @dataAtual = convert(char, (select c.dtmdat_atu from cardat c),102)
	
	--'yyyyMMdd'--
	if @frequencia = 'DIARIA'
	begin		
		set @pdtmIni = replace(@dataAtual, '.', '') 
		set @pdtmFim = replace(@dataAtual, '.', '')
	end
	else if @frequencia = 'MENSAL'
	begin
		set @pdtmIni = replace(@dataAtual - 30, '.', '')
		set @pdtmFim = replace(@dataAtual, '.', '')
	end

	set @dataIndex = charindex('yyyyMMdd', @fileName)
	set @fileName = stuff(@fileName, @dataIndex, 8, replace(convert(varchar, @pdtmIni, 102), '.', ''))
	set @dataIndex = charindex('yyyyMMdd', @fileName)
	set @fileName = stuff(@fileName, @dataIndex, 8,replace(convert(varchar, @pdtmFim, 102), '.', ''))
	set @fileName = replace(@fileName, '%SQ3%', '000')
	set @fileName = replace(@fileName, '%FREQ%', @frequencia)
	

	declare c_Classe cursor for
		select intCls_Cod, vchCls_Des
			from carcls order by intCls_Cod

	/*DECLARE c_Agencia CURSOR FOR 
		select cast(substring( rtrim(cast(uni_cod as char)), 1, len(rtrim(cast(uni_cod as char)))-1) as int) agencia, uni_cod
			from sisbc.dbo.VW_SBCUNI_018 where uni_cod <> 0 order by uni_cod */
	declare c_Agencia cursor for 
		select intagn_cod agencia, intagn_cod uni_cod from caragn order by uni_cod

	declare @vdtmAux_Dat smalldatetime,
			@vdata smalldatetime,
			@vagencia int,
			@vuni_cod int,
			@vcodClasse smallint,
			@vdesClasse varchar(15),
			@vqtdd int

	-- CRIA A TABELA TEMPORARIA DE DATA
	create table #tmpDias (
		[data] [smalldatetime]
	) ON [PRIMARY]

	select @vdtmAux_Dat = @pdtmIni
   
	while (@vdtmAux_Dat <= @pdtmFim)
	begin
		insert into #tmpDias values (@vdtmAux_Dat)
		select @vdtmAux_Dat = @vdtmAux_Dat + 1
    end
	
	declare c_Datas cursor for 
		select data from #tmpDias order by data
---------------------------------------
   create table #tmpArqEmitidos (
		data smalldatetime,
		agencia int,
		codClasse int,
		desClasse varchar(50),
		qtdd int
   )

	delete carga
	open c_Datas 
	---------------------- INICIO CURSOR DATAS
	 fetch next from c_Datas into @vdata
	  while @@fetch_status = 0 
	   begin
		---------------------- INICIO CURSOR AGENCIA
		open c_Agencia 
		 fetch next from c_Agencia into @vagencia, @vuni_cod
		  while @@fetch_status = 0 
		   begin
 			---------------------- INICIO CURSOR CLASSE
			 open c_Classe 
			 fetch next from c_Classe into @vcodClasse, @vdesClasse
			  while @@fetch_status = 0 
			   begin
				---------------------- INICIO CURSOR MOVIMENTO
				select @vqtdd = (
						select count(1) qtd
						from carmov
						where intEve_Cod = 5
						and dtmMov_Dta = @vdata-1
						and intAgn_Cod = @vagencia
						and intCls_Cod = @vcodClasse
						 )
			    	insert into #tmpArqEmitidos values (@vdata, @vuni_cod, @vcodClasse, @vdesClasse, @vqtdd)

				---------------------- FIM CURSOR MOVIMENTO
			    fetch next from c_Classe into @vcodClasse, @vdesClasse
			   end-- end loop fecth
			 close c_Classe
 			---------------------- FIM CURSOR AGENCIA
		    fetch next from c_Agencia into @vagencia,@vuni_cod
		   end-- end loop fecth
		 close c_Agencia
 		---------------------- FIM CURSOR AGENCIA
	    fetch next from c_Datas into @vdata
	   end-- end loop fecth
	 close c_Datas

	 deallocate c_Classe
	 deallocate c_Agencia
	 deallocate c_Datas
	---------------------- FIM CURSOR DATAS

	---------------------- GERA ARQUIVO
	declare @data varchar,
			@agencia varchar,
			@codClasse varchar,
			@qtdd varchar

	create table #tempTable (
		register nvarchar(1000)
	)

	-- #tempTable e lido na sp spu_FileWritter
	insert #tempTable
		select
			rtrim(convert(char,data,103))  + ';'+
			replicate('0', 4-len(cast(agencia as char))) + rtrim(cast(agencia as char))  + ';'+
			replicate('0', 2-len(rtrim(cast(codClasse as char)))) + rtrim(cast(codClasse as char)) + '-' + cast(desClasse as char(20))  + ';'+
			replicate('0', 4-len(rtrim(cast(qtdd as char)))) + rtrim(cast(qtdd as char))
		from #tmpArqEmitidos
		order by data, agencia, codClasse

	exec spu_FileWritter @destinationDir, @fileName

END
