-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE spu_FileWritter
	@destinationDir nvarchar(255),
	@fileName varchar(100)
AS
BEGIN
	declare 
			@absolutePatch nvarchar(255),
			@register nvarchar(4000),
			-- variaveis de controle para gerar arquivo
			@hr int,
			@strErrorMessage varchar(1000),
			@objFileSystem int,
			@objTextStream int,
			@objErrorObject int

		-- cria arquivo vazio
	set @strErrorMessage = 'Opening the File System Object'
	execute @hr = sp_OACreate 'Scripting.FileSystemObject' , @objFileSystem output

	if @hr = 0
	begin -- begin if @hr = 0 (1)
		-- caminho completo
		set @absolutePatch = @destinationDir+'\'+@fileName

		set @objErrorObject = @objFileSystem 
		set @strErrorMessage='Creating file "'+@absolutePatch+'"'

		execute @hr = sp_OAMethod @objFileSystem, 'CreateTextFile', @objTextStream output, @absolutePatch, 2, True
		
		if @hr = 0 -- begin if @hr = 0 (2)
		begin
			set @objErrorObject = @objTextStream
			set @strErrorMessage='writing to the file "'+@absolutePatch+'"'

			declare tempCursor cursor for
				select register from #tempTable

			open tempCursor

			fetch next from tempCursor into @register

			-- inseri os registros
			while @@fetch_status = 0
			begin
				execute @hr = sp_OAMethod  @objTextStream, 'Writeline', Null, @register
				if @hr <> 0
					break
			
				fetch next from tempCursor into @register
			end
			
			if @hr = 0
			begin 
				set @objErrorObject = @objTextStream
				set @strErrorMessage='Closing the file "'+@absolutePatch+'"'
				execute @hr = sp_OAMethod  @objTextStream, 'Close'
			end
			
			close tempCursor
			deallocate tempCursor
		end -- end if @hr = 0 (2)
	end -- end if @hr = 0 (1)
	
	if @hr <> 0
	begin
		Declare @Source varchar(255),
				@Description Varchar(255),
				@Helpfile Varchar(255),
				@HelpID int
		
		execute sp_OAGetErrorInfo  @objErrorObject, 
			@source output,@Description output,@Helpfile output,@HelpID output
		set @strErrorMessage='Error while '
				+ coalesce(@strErrorMessage,'doing something')
				+ ', '+coalesce(@Description,'')
		raiserror (@strErrorMessage,16,1)
	end

	execute  sp_OADestroy @objTextStream
END
GO
