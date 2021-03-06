USE [pd_card]
GO
/****** Object:  StoredProcedure [dbo].[spu_GerarRemessa]    Script Date: 01/29/2013 10:17:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spu_GerarRemessa]
	
as
	declare @destinationDir nvarchar(255),
			@fileName varchar(30),
			@dataAtual smalldatetime,
			@datePart varchar(2)

	-- data atual da tabela cardat
	set @dataAtual = (select c.dtmdat_atu from cardat c)

	-- diretorio destino
	select @destinationDir = vchlot_locarq, @fileName = vchlot_nomarq from cadlot where vchlot_cod like 'remessa' and intlot_nro = 1
		
	-- nome do arquivo
	set @datePart = datepart(dd, @dataAtual)
	set @fileName = replace(@fileName, '%DD%', replicate('0', 2-len(@datePart)) + @datePart)
	set @datePart = datepart(mm, @dataAtual)
	set @fileName = replace(@fileName, '%MM%', replicate('0', 2-len(@datePart)) + @datePart)

	create table #tempTable (
		register nvarchar(1000)
	)

	-- tabela ##tempRem criada em spi_ArquivoRemessa
	insert #tempTable
		select registro from ##tmpRem order by ch, tr

	exec spu_FileWritter @destinationDir, @fileName