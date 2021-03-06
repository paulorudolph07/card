USE [pd_card]
GO
/****** Object:  StoredProcedure [dbo].[spu_ProcessarRetorno]    Script Date: 01/29/2013 13:00:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spu_ProcessarRetorno] 
	@absolutePath nvarchar(1000),
	@tipoRetorno char(1),
	@pseqRet int
AS
BEGIN
	declare @sql nvarchar(4000),
			@registro nvarchar(4000),
			@dataRef smalldatetime,
			@msg varchar(255),
			@seqRet int
			
	create table #tmpRetorno(
		registro nvarchar(4000)
	) on [primary]
	
	set @sql = 'bulk insert #tmpRetorno from ''' + @absolutePath + ''' with ( rowterminator =''\n'' )'
	exec(@sql)

	declare tmpRetCursor cursor for
		select registro from #tmpRetorno

	open tmpRetCursor

	fetch next from tmpRetCursor into @registro

	set @dataRef = (select c.dtmdat_atu from cardat c)

	while @@fetch_status = 0
	begin
		exec spu_CargaRetorno @dataRef, @tipoRetorno, @pseqRet, @registro, @msg out

		fetch next from tmpRetCursor into @registro
	end

	exec spu_IncluirRetorno @pseqRet, @tipoRetorno, @dataRef, @msg out

	close tmpRetCursor
	deallocate tmpRetCursor
	
END
