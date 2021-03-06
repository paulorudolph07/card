USE [pd_card]
GO
/****** Object:  StoredProcedure [dbo].[spu_AtualizarRetorno]    Script Date: 01/29/2013 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- IF EXISTS (SELECT name FROM   sysobjects WHERE  name = N'spu_AtualizarRetorno' AND type = 'P')
--     DROP PROCEDURE dbo.spu_AtualizarRetorno
-- GO

/*
begin tran
declare @m varchar(255)
exec dbo.spu_AtualizarRetorno '2006-07-26','R',5, @m output
select @m
select CarRetErr.sinRet_Reg Registro, sinRet_TipReg Tipo, numCli_CpfCnpj CPF, chrRetErr_Des Campo, vcherr_des Erro
  from CarRetErr, CarErr, CarRetLocErr
 where intRet_Seq = 5
   and CarRetErr.tinErr_Cod <> 0
   and CarErr.chrErr_Reg = CarRetErr.chrErr_Reg
   and CarErr.tinErr_Cod = CarRetErr.tinErr_Cod
   and CarRetLocErr.sinRet_Reg = CarRetErr.sinRet_TipReg
   and CarRetLocErr.tinRetErr_seq = CarRetErr.tinRetErr_seq
 order by CarRetErr.sinRet_Reg
rollback tran
*/

ALTER       PROCEDURE [dbo].[spu_AtualizarRetorno] 
    @pdtmRef smalldatetime
   ,@pchrTip char(1)          --R=retorno, A=análise de crédito, G=gravados
   ,@pintRet int
   ,@pvchMsg varchar (255) OUTPUT
   
   AS

   if not(@@options & 512 > 0)
      set nocount on
   if @@language <> 'us_english'
      set language us_english
       	
   declare @intRet int
          ,@sinReg smallint
          ,@vchReg varchar (351)

          ,@sinQtdReg smallint
          ,@chrTipReg char    (3)
          ,@numCpf    numeric (14)
          ,@intMov_Seq int

   set @pvchMsg = ''
   set @sinQtdReg = 0

   declare crsR cursor for 
      select sinRet_Reg, vchRet_Reg 
        from CarRet 
       where intRet_Seq = @pintRet
         and chrRet_Tip = @pchrTip
       order by sinRet_Reg

   open crsR
   fetch next from crsR into @sinReg, @vchReg
   
   while @@fetch_status = 0 
      begin
      set @sinQtdReg = @sinQtdReg + 1
      set @chrTipReg = substring(@vchReg,1,3)

      if @chrTipReg = '100'                  -- header
         begin
         if  substring(@vchReg,008,2) = '00'
         and substring(@vchReg,015,2) = '00'
         and substring(@vchReg,025,2) = '00'
         and substring(@vchReg,031,2) = '00'
            insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),0,0,'C',0)
         else
            begin
            if substring(@vchReg,008,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),01,0,'C',cast(substring(@vchReg,08,2) as tinyint))
            if substring(@vchReg,015,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),02,0,'C',cast(substring(@vchReg,15,2) as tinyint))
            if substring(@vchReg,025,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),03,0,'C',cast(substring(@vchReg,25,2) as tinyint))
            if substring(@vchReg,031,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),04,0,'C',cast(substring(@vchReg,31,2) as tinyint))
            end
         end

      if @chrTipReg = '999'                  -- trailler
         insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),0,0,'C',0)

      if @chrTipReg in ('100','999')
         goto  proximo

------------------------------------------------------------------------------------------------------------------

      if @pchrTip = 'R'
         goto tratar_retorno
      if @pchrTip = 'A'
         goto tratar_analise
      if @pchrTip = 'G'
         goto tratar_gravados

tratar_retorno:

      if isnumeric(substring(@vchReg,10,14)) = 1
         set @numCPF = substring(@vchReg,10,14)
      else
         set @numCPF = 0

      if @chrTipReg = '200'
         begin
         if  substring(@vchReg,008,2) = '00'
         and substring(@vchReg,024,2) = '00'
         and substring(@vchReg,076,2) = '00'
         and substring(@vchReg,079,2) = '00'      --verificar especificacao
         and substring(@vchReg,089,2) = '00'
         and substring(@vchReg,092,2) = '00'
         and substring(@vchReg,095,2) = '00'
         and substring(@vchReg,099,2) = '00'
         and substring(@vchReg,111,2) = '00'
         and substring(@vchReg,153,2) = '00'
         and substring(@vchReg,195,2) = '00'
         and substring(@vchReg,212,2) = '00'
         and substring(@vchReg,224,2) = '00'
         and substring(@vchReg,228,2) = '00'
         and substring(@vchReg,238,2) = '00'
         and substring(@vchReg,241,2) = '00'
         and substring(@vchReg,245,2) = '00'
         and substring(@vchReg,251,2) = '00'
         and substring(@vchReg,255,2) = '00'
         and substring(@vchReg,259,2) = '00'
         and substring(@vchReg,265,2) = '00'
         and substring(@vchReg,347,4) = '0000'
            insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),0,@numCPF,'C',0)
         else
            begin
            if substring(@vchReg,008,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),02,@numCPF,'C',cast(substring(@vchReg,008,2) as tinyint))
            if substring(@vchReg,024,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),03,@numCPF,'C',cast(substring(@vchReg,024,2) as tinyint))
            if substring(@vchReg,076,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),04,@numCPF,'C',cast(substring(@vchReg,076,2) as tinyint))
            if substring(@vchReg,079,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),05,@numCPF,'C',cast(substring(@vchReg,079,2) as tinyint))
            if substring(@vchReg,089,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),06,@numCPF,'C',cast(substring(@vchReg,089,2) as tinyint))
            if substring(@vchReg,092,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),07,@numCPF,'C',cast(substring(@vchReg,092,2) as tinyint))
            if substring(@vchReg,095,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),08,@numCPF,'C',cast(substring(@vchReg,095,2) as tinyint))
            if substring(@vchReg,099,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),09,@numCPF,'C',cast(substring(@vchReg,099,2) as tinyint))
            if substring(@vchReg,111,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),10,@numCPF,'C',cast(substring(@vchReg,111,2) as tinyint))
            if substring(@vchReg,153,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),11,@numCPF,'C',cast(substring(@vchReg,153,2) as tinyint))
            if substring(@vchReg,195,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),12,@numCPF,'C',cast(substring(@vchReg,195,2) as tinyint))
            if substring(@vchReg,212,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),13,@numCPF,'C',cast(substring(@vchReg,212,2) as tinyint))
            if substring(@vchReg,224,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),14,@numCPF,'C',cast(substring(@vchReg,224,2) as tinyint))
            if substring(@vchReg,228,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),15,@numCPF,'C',cast(substring(@vchReg,228,2) as tinyint))
            if substring(@vchReg,238,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),16,@numCPF,'C',cast(substring(@vchReg,238,2) as tinyint))
            if substring(@vchReg,241,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),17,@numCPF,'C',cast(substring(@vchReg,241,2) as tinyint))
            if substring(@vchReg,245,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),18,@numCPF,'C',cast(substring(@vchReg,245,2) as tinyint))
            if substring(@vchReg,251,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),19,@numCPF,'C',cast(substring(@vchReg,251,2) as tinyint))
            if substring(@vchReg,255,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),20,@numCPF,'C',cast(substring(@vchReg,255,2) as tinyint))
            if substring(@vchReg,259,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),21,@numCPF,'C',cast(substring(@vchReg,259,2) as tinyint))
            if substring(@vchReg,265,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),22,@numCPF,'C',cast(substring(@vchReg,265,2) as tinyint))
            if substring(@vchReg,347,4) = '0013' or substring(@vchReg,347,4) = '0014'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),0,@numCPF,'S',cast(substring(@vchReg,347,4) as tinyint))
            end
         end

      if @chrTipReg = '300'
         begin
         if  substring(@vchReg,008,2) = '00'
         and substring(@vchReg,024,2) = '00'
         and substring(@vchReg,034,2) = '00'
         and substring(@vchReg,081,2) = '00'
         and substring(@vchReg,088,2) = '00'
         and substring(@vchReg,110,2) = '00'
         and substring(@vchReg,132,2) = '00'
         and substring(@vchReg,136,2) = '00'
         and substring(@vchReg,148,2) = '00'
         and substring(@vchReg,152,2) = '00'
         and substring(@vchReg,347,4) = '0000'
            insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),0,@numCPF,'C',0)
         else
            begin
            if substring(@vchReg,008,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),02,@numCPF,'C',cast(substring(@vchReg,008,2) as tinyint))
            if substring(@vchReg,024,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),03,@numCPF,'C',cast(substring(@vchReg,024,2) as tinyint))
            if substring(@vchReg,034,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),04,@numCPF,'C',cast(substring(@vchReg,034,2) as tinyint))
            if substring(@vchReg,081,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),05,@numCPF,'C',cast(substring(@vchReg,081,2) as tinyint))
            if substring(@vchReg,088,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),06,@numCPF,'C',cast(substring(@vchReg,088,2) as tinyint))
            if substring(@vchReg,110,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),07,@numCPF,'C',cast(substring(@vchReg,110,2) as tinyint))
            if substring(@vchReg,132,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),08,@numCPF,'C',cast(substring(@vchReg,132,2) as tinyint))
            if substring(@vchReg,136,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),09,@numCPF,'C',cast(substring(@vchReg,136,2) as tinyint))
            if substring(@vchReg,148,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),10,@numCPF,'C',cast(substring(@vchReg,148,2) as tinyint))
            if substring(@vchReg,152,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),11,@numCPF,'C',cast(substring(@vchReg,152,2) as tinyint))
            end
         end

      if @chrTipReg = '400'
         begin
         if  substring(@vchReg,008,2) = '00'
         and substring(@vchReg,024,2) = '00'
         and substring(@vchReg,027,2) = '00'
         and substring(@vchReg,043,2) = '00'
         and substring(@vchReg,095,2) = '00'
         and substring(@vchReg,105,2) = '00'
         and substring(@vchReg,152,2) = '00'
         and substring(@vchReg,159,2) = '00'
         and substring(@vchReg,181,2) = '00'
         and substring(@vchReg,203,2) = '00'
         and substring(@vchReg,207,2) = '00'
         and substring(@vchReg,219,2) = '00'
         and substring(@vchReg,224,2) = '00'
         and substring(@vchReg,234,2) = '00'
         and substring(@vchReg,251,2) = '00'
         and substring(@vchReg,257,2) = '00'
         and substring(@vchReg,268,2) = '00'
         and substring(@vchReg,347,4) = '0000'
            insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),0,@numCPF,'C',0)
         else
            begin
            if substring(@vchReg,008,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),02,@numCPF,'C',cast(substring(@vchReg,008,2) as tinyint))
            if substring(@vchReg,024,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),03,@numCPF,'C',cast(substring(@vchReg,024,2) as tinyint))
            if substring(@vchReg,027,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),04,@numCPF,'C',cast(substring(@vchReg,027,2) as tinyint))
            if substring(@vchReg,043,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),05,@numCPF,'C',cast(substring(@vchReg,043,2) as tinyint))
            if substring(@vchReg,095,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),06,@numCPF,'C',cast(substring(@vchReg,095,2) as tinyint))
            if substring(@vchReg,105,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),07,@numCPF,'C',cast(substring(@vchReg,105,2) as tinyint))
            if substring(@vchReg,152,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),08,@numCPF,'C',cast(substring(@vchReg,152,2) as tinyint))
            if substring(@vchReg,159,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),09,@numCPF,'C',cast(substring(@vchReg,159,2) as tinyint))
            if substring(@vchReg,181,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),10,@numCPF,'C',cast(substring(@vchReg,181,2) as tinyint))
            if substring(@vchReg,203,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),11,@numCPF,'C',cast(substring(@vchReg,203,2) as tinyint))
            if substring(@vchReg,207,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),12,@numCPF,'C',cast(substring(@vchReg,207,2) as tinyint))
            if substring(@vchReg,219,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),13,@numCPF,'C',cast(substring(@vchReg,219,2) as tinyint))
            if substring(@vchReg,224,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),14,@numCPF,'C',cast(substring(@vchReg,224,2) as tinyint))
            if substring(@vchReg,234,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),15,@numCPF,'C',cast(substring(@vchReg,234,2) as tinyint))
            if substring(@vchReg,251,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),16,@numCPF,'C',cast(substring(@vchReg,251,2) as tinyint))
            if substring(@vchReg,257,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),17,@numCPF,'C',cast(substring(@vchReg,257,2) as tinyint))
            if substring(@vchReg,268,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),18,@numCPF,'C',cast(substring(@vchReg,268,2) as tinyint))
            end
         end

      if @chrTipReg = '500'
         begin
         if  substring(@vchReg,008,2) = '00'
         and substring(@vchReg,024,2) = '00'
         and substring(@vchReg,058,2) = '00'
         and substring(@vchReg,120,2) = '00'
         and substring(@vchReg,130,2) = '00'
         and substring(@vchReg,147,2) = '00'
         and substring(@vchReg,347,4) = '0000'
            insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),0,@numCPF,'C',0)
         else
            begin
            if substring(@vchReg,008,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),02,@numCPF,'C',cast(substring(@vchReg,008,2) as tinyint))
            if substring(@vchReg,024,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),03,@numCPF,'C',cast(substring(@vchReg,024,2) as tinyint))
            if substring(@vchReg,058,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),04,@numCPF,'C',cast(substring(@vchReg,058,2) as tinyint))
            if substring(@vchReg,120,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),05,@numCPF,'C',cast(substring(@vchReg,120,2) as tinyint))
            if substring(@vchReg,130,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),06,@numCPF,'C',cast(substring(@vchReg,130,2) as tinyint))
            if substring(@vchReg,147,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),07,@numCPF,'C',cast(substring(@vchReg,147,2) as tinyint))
            end
         end

      if @chrTipReg = '600'
         begin
         if  substring(@vchReg,008,2) = '00'
         and substring(@vchReg,024,2) = '00'
         and substring(@vchReg,030,2) = '00'
         and substring(@vchReg,041,2) = '00'
         and substring(@vchReg,047,2) = '00'
         and substring(@vchReg,058,2) = '00'
         and substring(@vchReg,061,2) = '00'
         and substring(@vchReg,113,2) = '00'
         and substring(@vchReg,118,2) = '00'
         and substring(@vchReg,124,2) = '00'
         and substring(@vchReg,140,2) = '00'
         and substring(@vchReg,144,2) = '00'
         and substring(@vchReg,149,2) = '00'
         and substring(@vchReg,155,2) = '00'
         and substring(@vchReg,169,2) = '00'
         and substring(@vchReg,173,2) = '00'
         and substring(@vchReg,177,2) = '00'
         and substring(@vchReg,181,2) = '00'
         and substring(@vchReg,184,2) = '00'
         and substring(@vchReg,189,2) = '00'
         and substring(@vchReg,193,2) = '00'
         and substring(@vchReg,347,4) = '0000'
            insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),0,@numCPF,'C',0)
         else
            begin
            if substring(@vchReg,008,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),02,@numCPF,'C',cast(substring(@vchReg,008,2) as tinyint))
            if substring(@vchReg,024,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),03,@numCPF,'C',cast(substring(@vchReg,024,2) as tinyint))
            if substring(@vchReg,030,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),04,@numCPF,'C',cast(substring(@vchReg,030,2) as tinyint))
            if substring(@vchReg,041,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),05,@numCPF,'C',cast(substring(@vchReg,041,2) as tinyint))
            if substring(@vchReg,047,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),06,@numCPF,'C',cast(substring(@vchReg,047,2) as tinyint))
            if substring(@vchReg,058,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),07,@numCPF,'C',cast(substring(@vchReg,058,2) as tinyint))
            if substring(@vchReg,061,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),08,@numCPF,'C',cast(substring(@vchReg,061,2) as tinyint))
            if substring(@vchReg,113,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),09,@numCPF,'C',cast(substring(@vchReg,113,2) as tinyint))
            if substring(@vchReg,118,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),10,@numCPF,'C',cast(substring(@vchReg,118,2) as tinyint))
            if substring(@vchReg,124,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),11,@numCPF,'C',cast(substring(@vchReg,124,2) as tinyint))
            if substring(@vchReg,140,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),12,@numCPF,'C',cast(substring(@vchReg,140,2) as tinyint))
            if substring(@vchReg,144,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),13,@numCPF,'C',cast(substring(@vchReg,144,2) as tinyint))
            if substring(@vchReg,149,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),14,@numCPF,'C',cast(substring(@vchReg,149,2) as tinyint))
            if substring(@vchReg,155,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),15,@numCPF,'C',cast(substring(@vchReg,155,2) as tinyint))
            if substring(@vchReg,169,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),16,@numCPF,'C',cast(substring(@vchReg,169,2) as tinyint))
            if substring(@vchReg,173,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),17,@numCPF,'C',cast(substring(@vchReg,173,2) as tinyint))
            if substring(@vchReg,177,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),18,@numCPF,'C',cast(substring(@vchReg,177,2) as tinyint))
            if substring(@vchReg,181,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),19,@numCPF,'C',cast(substring(@vchReg,181,2) as tinyint))
            if substring(@vchReg,184,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),20,@numCPF,'C',cast(substring(@vchReg,184,2) as tinyint))
            if substring(@vchReg,189,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),21,@numCPF,'C',cast(substring(@vchReg,189,2) as tinyint))
            if substring(@vchReg,193,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),22,@numCPF,'C',cast(substring(@vchReg,193,2) as tinyint))
            end
            
         select @intMov_Seq = max(intMov_Seq)
           from CarMov
          where numCli_CpfCnpj = @numCPF
            and intCls_Cod     = substring(@vchReg,191,2)
            --and intCar_Seq     = 1

         insert CarMov 
            select numCli_CpfCnpj   
                  ,intCls_Cod  
                  ,intCar_Seq  
                  ,@intMov_Seq + 1
                  ,7                       -- retorno
                  ,dtmMov_Dta                                            
                  ,numMov_Vlr           
                  ,intAgn_Cod  
                  ,'Sistema'                
                  ,getdate()
                  ,'spi_ArquivoRemessa'             
              from CarMov A
             where numCli_CpfCnpj = @numCPF
               and dtmMov_Dta     = @pdtmRef
               and intCls_Cod     = substring(@vchReg,191,2)
               and intCar_Seq     = 1
               and intEve_Cod     = 4
               and not exists (select numCli_CpfCnpj
                                 from CarMov x
                                where x.numCli_CpfCnpj = A.numCli_CpfCnpj
                                  and x.intCls_Cod     = A.intCls_Cod
                                  and x.intCar_Seq     = A.intCar_Seq
                                  and x.intMov_Seq     = A.intMov_Seq
                                  and x.intEve_Cod     = 7)
   
         update CarCar
            set intCar_Sta = 7
          where numCli_CpfCnpj = @numCPF
            and intCls_Cod     = substring(@vchReg,138,2)
            and intCar_Seq     = 1
            --and dtmMov_Mov     = @pdtmRef
   
         end

      if @chrTipReg = '700'
         begin
         if  substring(@vchReg,008,2) = '00'
         and substring(@vchReg,024,2) = '00'
         and substring(@vchReg,076,2) = '00'
         and substring(@vchReg,092,2) = '00'
         and substring(@vchReg,102,2) = '00'
         and substring(@vchReg,105,2) = '00'
         and substring(@vchReg,120,2) = '00'
         and substring(@vchReg,172,2) = '00'
         and substring(@vchReg,188,2) = '00'
         and substring(@vchReg,198,2) = '00'
         and substring(@vchReg,201,2) = '00'
         and substring(@vchReg,216,2) = '00'
         and substring(@vchReg,268,2) = '00'
         and substring(@vchReg,284,2) = '00'
         and substring(@vchReg,294,2) = '00'
         and substring(@vchReg,297,2) = '00'
         and substring(@vchReg,312,2) = '00'
         and substring(@vchReg,347,4) = '0000'
            insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),0,@numCPF,'C',0)
         else
            begin
            if substring(@vchReg,008,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),02,@numCPF,'C',cast(substring(@vchReg,008,2) as tinyint))
            if substring(@vchReg,024,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),03,@numCPF,'C',cast(substring(@vchReg,024,2) as tinyint))
            if substring(@vchReg,076,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),04,@numCPF,'C',cast(substring(@vchReg,076,2) as tinyint))
            if substring(@vchReg,092,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),05,@numCPF,'C',cast(substring(@vchReg,092,2) as tinyint))
            if substring(@vchReg,102,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),06,@numCPF,'C',cast(substring(@vchReg,102,2) as tinyint))
            if substring(@vchReg,105,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),07,@numCPF,'C',cast(substring(@vchReg,105,2) as tinyint))
            if substring(@vchReg,120,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),08,@numCPF,'C',cast(substring(@vchReg,120,2) as tinyint))
            if substring(@vchReg,172,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),09,@numCPF,'C',cast(substring(@vchReg,172,2) as tinyint))
            if substring(@vchReg,188,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),10,@numCPF,'C',cast(substring(@vchReg,188,2) as tinyint))
            if substring(@vchReg,198,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),11,@numCPF,'C',cast(substring(@vchReg,198,2) as tinyint))
            if substring(@vchReg,201,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),12,@numCPF,'C',cast(substring(@vchReg,201,2) as tinyint))
            if substring(@vchReg,216,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),13,@numCPF,'C',cast(substring(@vchReg,216,2) as tinyint))
            if substring(@vchReg,268,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),14,@numCPF,'C',cast(substring(@vchReg,268,2) as tinyint))
            if substring(@vchReg,284,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),15,@numCPF,'C',cast(substring(@vchReg,284,2) as tinyint))
            if substring(@vchReg,294,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),16,@numCPF,'C',cast(substring(@vchReg,294,2) as tinyint))
            if substring(@vchReg,297,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),17,@numCPF,'C',cast(substring(@vchReg,297,2) as tinyint))
            if substring(@vchReg,312,2) <> '00'
               insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),18,@numCPF,'C',cast(substring(@vchReg,312,2) as tinyint))
            end
         end

      goto proximo

tratar_analise:

      if isnumeric(substring(@vchReg,10,14)) = 1
         set @numCPF = substring(@vchReg,10,14)
      else
         set @numCPF = 0

      insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),1,@numCPF,'A',cast(substring(@vchReg,347,4) as tinyint))
      
      -- 26/02/2007 Lafuente / 
      if cast(substring(@vchReg,347,4) as tinyint) <> 1
   	insert into CarRetErr_800 values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),1,@numCPF, SUBSTRING(@vchReg, 140, 6))
      -- 26/02/2007 Lafuente \

      select @intMov_Seq = max(intMov_Seq)
        from CarMov
       where numCli_CpfCnpj = @numCPF
         and intCls_Cod     = substring(@vchReg,138,2)
         --and intCar_Seq     = 1

      insert CarMov 
         select numCli_CpfCnpj   
               ,intCls_Cod  
               ,intCar_Seq  
               ,@intMov_Seq + 1
               ,case when cast(substring(@vchReg,347,4) as tinyint) = 1 then 10 -- APROVADO
                     else 6 -- REJEITADO
                end
               --,dtmMov_Dta   
					,@pdtmRef                                         
               ,numMov_Vlr           
               ,intAgn_Cod  
               ,'Sistema'                
               ,getdate()
               ,'spi_ArquivoRemessa'             
           from CarMov A
          where numCli_CpfCnpj = @numCPF
            --and dtmMov_Dta     = @pdtmRef
            and intCls_Cod     = substring(@vchReg,138,2)
            and intCar_Seq     = 1
            and intEve_Cod     = 4
--             and not exists (select numCli_CpfCnpj
--                               from CarMov x
--                              where x.numCli_CpfCnpj = A.numCli_CpfCnpj
--                                and x.intCls_Cod     = A.intCls_Cod
--                                and x.intCar_Seq     = A.intCar_Seq
--                               -- and x.intMov_Seq     = A.intMov_Seq
--                                and x.intEve_Cod     = 6)

      update CarCar
         set intCar_Sta = case when cast(substring(@vchReg,347,4) as tinyint) = 1 then 10 -- Aprovado
                               else 6
                          end
       where numCli_CpfCnpj = @numCPF
         and intCls_Cod     = substring(@vchReg,138,2)
         and intCar_Seq     = 1
         --and dtmMov_Mov     = @pdtmRef

      goto  proximo

tratar_gravados:

	if isnumeric(substring(@vchReg,10,14)) = 1
		set @numCPF = substring(@vchReg,10,14)
    else
        set @numCPF = 0

	select @intMov_Seq = max(intMov_Seq)
		from CarMov
	where numCli_CpfCnpj = @numCPF and intCls_Cod = substring(@vchReg,138,2)
	
	-- intCls_Cod (variante) incorreta
	if @intMov_Seq is null
	begin
		insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),1,@numCPF,'G',14)
		goto proximo
	end
	else
		insert into CarRetErr values (@pintRet,@pchrTip,@sinReg,cast(@chrTipReg as smallint),1,@numCPF,'G',cast(substring(@vchReg,347,4) as tinyint))

	insert CarMov 
		select numCli_CpfCnpj   
           ,intCls_Cod  
           ,intCar_Seq  
           ,@intMov_Seq + 1
           ,case when cast(substring(@vchReg,347,4) as tinyint) = 0 then 5 -- gravados
                 when cast(substring(@vchReg,347,4) as tinyint) = 2 then 6 -- recusado
                 else 12
            end
			,@pdtmRef                                            
           ,numMov_Vlr           
           ,intAgn_Cod  
           ,'Sistema'                
           ,getdate()
           ,'spi_ArquivoRemessa'             
			from CarMov A
		where numCli_CpfCnpj = @numCPF
			and intCls_Cod     = substring(@vchReg,138,2)
			and intCar_Seq     = 1
			and intEve_Cod     = 4

	update CarCar
		set intCar_Sta = case when cast(substring(@vchReg,347,4) as tinyint) = 0 then 5 -- gravados
							when cast(substring(@vchReg,347,4) as tinyint) = 2 then 6 -- recusado
							else 12
						end
	where numCli_CpfCnpj = @numCPF
		and intCls_Cod     = substring(@vchReg,138,2)
		and intCar_Seq     = 1

    goto proximo

proximo:

      fetch next from crsR into @sinReg, @vchReg
      end

   close crsR
   deallocate crsR

retorno:

   return 0







