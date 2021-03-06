USE [pd_card]
GO
/****** Object:  StoredProcedure [dbo].[spi_ArquivoRemessa]    Script Date: 01/21/2013 10:51:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/*
declare @m varchar(255)
exec dbo.spi_ArquivoRemessa '01/09/2007',1, @m output
select @m
*/
ALTER        PROCEDURE [dbo].[spi_ArquivoRemessa] 
    @pdtmRef smalldatetime
   ,@psinSeq smallint
   ,@pvchMsg varchar (255) OUTPUT
   
   AS
   if not(@@options & 512 > 0)
      set nocount on
   if @@language <> 'us_english'
      set language us_english
       	
   declare @sinSeq smallint

--   set @pdtmRef = '2007-04-02' -- inserido a partir de 29/01/2007
   exec sp_excluiDuplicados @pdtmRef
   
   create table ##tmpRem (
      [tr]   [smallint]
     ,[ch]   [varchar] (18)
     ,[registro]   [char] (300)
   ) ON [PRIMARY]
   set @pvchMsg = ''
header:
   insert into ##tmpRem  
      select  100,''
             ,'100'
             +'0003'
             + right('00000' + cast(@psinSeq as varchar),5)
             + convert(varchar,getdate(),112)
				 + '0006'
             + replicate(' ',276)
detalhe:
   insert into ##tmpRem  
      select  200,agn.intAgn_PVCaixa + car.numCli_CpfCnpj
             ,'200'
             + right('0000' + cast(agn.intAgn_PVCaixa as varchar),4)
             + right('00000000000000' + cast(car.numCli_CpfCnpj as varchar),14)
             -- + left(cli.vchCli_Nom + replicate(' ',50) ,50)
				 + cast(cli.vchCli_Nom + replicate(' ',50) AS CHAR(50) )
				 + '1' --pessoa fisica 
             + convert(varchar,cli.dtmCli_Nas,112)
             + dps.chrSexo_CEF
             + cast(cli.intCli_Nac as varchar)
             + cli.chrCli_NatUf + '0000000000'
             --+ left(cli.vchCli_Nat + replicate(' ',20),20)
				 + cast(cli.vchCli_Pai + replicate(' ',40) as char(40))
             --+ left(cli.vchCli_Pai + replicate(' ',40),40)
             --+ left(cli.vchCli_Mae + replicate(' ',40),40)
				 + cast(cli.vchCli_Mae + replicate(' ',40) as char(40))
             + right('000000000000000' + cast(cli.numCli_Ide as varchar),15)
             --+ left(cli.vchCli_OrgEmi + replicate(' ',10),10)
				 + cast(cli.vchCli_OrgEmi + replicate(' ',10) as char(10))
             + cli.chrCli_OrgEmiUf
             + convert(varchar,cli.dtmCli_IdeEmi,112)
             + cast(dpe.tinEstCivil_CEF as varchar)
             + right('00' + cast(cli.intCli_GraIns as varchar),2)
             + '0043'                                                  
             + right('0' + cast(cli.intCli_TmpEmpAno as varchar),2)
             + right('0' + cast(cli.intCli_TmpEmpMes as varchar),2)
             + right('0000' + cast(cli.intCli_TmpEmpAnoDes as varchar),4)
             + replicate(' ',76)
        from CarMov mov
        join CarCar         car on car.numCli_CpfCnpj   = mov.numCli_CpfCnpj
                               and car.intCls_Cod       = mov.intCls_Cod
                               and car.intCar_Seq       = mov.intCar_Seq
        join CarCli         cli on cli.numCli_CpfCnpj   = car.numCli_CpfCnpj
        join CarAgn         agn on agn.intAgn_Cod       = car.intAgn_Cod
        join dp_Sexo        dps on dps.chrSexo_BASA     = cli.chrCli_Sex
        join dp_EstadoCivil dpe on dpe.tinEstCivil_BASA = cli.intCli_EstCiv
			                      and dpe.tinRegime_BASA = cli.intCli_RegBens

       where mov.dtmMov_Dta = @pdtmRef
         and mov.intEve_Cod = 2
	 and mov.numCli_CpfCnpj not in (select numCli_CpfCnpj 
				    	from carmov z
				    	where z.intEve_Cod = 3 
				  	 and z.dtmMov_Dta = mov.dtmMov_Dta
					 and z.numCli_CpfCnpj = mov.numCli_CpfCnpj)
         and not exists (select numCli_CpfCnpj
                           from CarMov x
                          where x.numCli_CpfCnpj = mov.numCli_CpfCnpj
                            and x.intCls_Cod     = mov.intCls_Cod
                            and x.intCar_Seq     = mov.intCar_Seq
                            and x.intMov_Seq     = mov.intMov_Seq
                            and x.intEve_Cod     = 4)
   insert into ##tmpRem  
      select  300,agn.intAgn_PVCaixa + car.numCli_CpfCnpj
             ,'300'
             + right('0000' + cast(agn.intAgn_PVCaixa as varchar),4)
             + right('00000000000000' + cast(car.numCli_CpfCnpj as varchar),14)
             + right('00000000' + cast(cli.numCli_Cep as varchar),8)
          --+ left(cli.vchCli_Lgr + replicate(' ',45),45)
				 + cast(cli.vchCli_Lgr + replicate(' ',45) as char(45))
             + right('00000' + cast(cli.intCli_LgrNum as varchar),5)
             --+ left(cli.vchCli_LgrCpl + replicate(' ',20),20)
				 + cast(cli.vchCli_LgrCpl + replicate(' ',20) as char(20))
             --+ left(cli.vchCli_LgrBai + replicate(' ',20),20)
             + cast(cli.vchCli_LgrBai + replicate(' ',20) as char(20))
             + cli.chrCli_LgrUf
             --+ left(cli.vchCli_LgrMun + replicate(' ',20),20)
				 --+ cast(cli.vchCli_LgrMun + replicate(' ',20) as char(20))
				 + '0000000000'
             + right('0'+ cast(cli.intCli_LgrSit as varchar),2)
             + replicate(' ',167)
        from CarMov mov
        join CarCar         car on car.numCli_CpfCnpj   = mov.numCli_CpfCnpj
                               and car.intCls_Cod       = mov.intCls_Cod
                               and car.intCar_Seq       = mov.intCar_Seq
        join CarCli         cli on cli.numCli_CpfCnpj   = car.numCli_CpfCnpj
        join CarAgn         agn on agn.intAgn_Cod       = car.intAgn_Cod
       where mov.dtmMov_Dta = @pdtmRef
         and mov.intEve_Cod = 2
	 and mov.numCli_CpfCnpj not in (select numCli_CpfCnpj 
				    	from carmov z
				    	where z.intEve_Cod = 3 
				  	 and z.dtmMov_Dta = mov.dtmMov_Dta
					 and z.numCli_CpfCnpj = mov.numCli_CpfCnpj)
   insert into ##tmpRem  
      select  400,agn.intAgn_PVCaixa + car.numCli_CpfCnpj
             ,'400'
             + right('0000' + cast(agn.intAgn_PVCaixa as varchar),4)
             + right('00000000000000' + cast(car.numCli_CpfCnpj as varchar),14)
             + rnd.chrRnd_TipCpfCnpj
             + right('00000000000000' + cast(rnd.numRnd_CpfCnpj as varchar),14)
             --+ left(rnd.vchCli_FontPgtaNom + replicate(' ',50),50)
				 + cast(rnd.vchCli_FontPgtaNom + replicate(' ',50) as char(50))
             + right('00000000' + cast(rnd.numCli_EndComCep as varchar),8)
             --+ left(rnd.vchCli_EndComLgr + replicate(' ',45),45)
				 + cast(rnd.vchCli_EndComLgr + replicate(' ',45) as char(45))
             + right('00000' + cast(rnd.intCli_EndComNum as varchar),5)
             --+ left(rnd.vchCli_EndComCpl + replicate(' ',20),20)
				 + cast(rnd.vchCli_EndComCpl + replicate(' ',20) as char(20))
             --+ left(rnd.vchCli_EndComBai + replicate(' ',20),20)
				 + cast(rnd.vchCli_EndComBai + replicate(' ',20) as char(20))
             + rnd.chrCli_EndComUf + '0000000000'
             --+ left(rnd.vchCli_EndComMun + replicate(' ',20),20)
				 --+ cast(rnd.vchCli_EndComMun + replicate(' ',20) as char(20))
             + right('000'+ cast(cli.intOcu_Cod as varchar),3)
             + convert(varchar,rnd.dtmCli_RenIniFor,112)
	     + right('000000000000000' + replace(cast( (select sum(numCli_RenVlrBrt) from carrnd rnd2 where rnd2.numcli_cpfcnpj = rnd.numcli_cpfcnpj) * 100  as varchar),'.',''),15)
             + right('0000'+ cast(rnd.intCli_TelComDdd as varchar),4)
             + right('000000000'+ cast(rnd.numCli_TelComNum as varchar),9)
             + replicate(' ',65)
        from CarMov mov
        join CarCar         car on car.numCli_CpfCnpj = mov.numCli_CpfCnpj
                               and car.intCls_Cod     = mov.intCls_Cod
                               and car.intCar_Seq     = mov.intCar_Seq
        join CarCli         cli on cli.numCli_CpfCnpj   = car.numCli_CpfCnpj
        join CarAgn         agn on agn.intAgn_Cod     = car.intAgn_Cod
        join CarRnd         rnd on rnd.numCli_CpfCnpj = car.numCli_CpfCnpj
       where mov.dtmMov_Dta = @pdtmRef
         and mov.intEve_Cod = 2
	 and mov.numCli_CpfCnpj not in (select numCli_CpfCnpj 
				    	from carmov z
				    	where z.intEve_Cod = 3 
				  	 and z.dtmMov_Dta = mov.dtmMov_Dta
					 and z.numCli_CpfCnpj = mov.numCli_CpfCnpj)
	 and rnd.intCli_TelComDdd <> 0 --numCli_RenVlrInf
   insert into ##tmpRem  
      select  500,agn.intAgn_PVCaixa + car.numCli_CpfCnpj
             ,'500'
             + right('0000' + cast(agn.intAgn_PVCaixa as varchar),4)
             + right('00000000000000' + cast(car.numCli_CpfCnpj as varchar),14)
             --+ left(rnd.vchCli_AtvInf + replicate(' ',32),32)
             + cast(rnd.vchCli_AtvInf + replicate(' ',32) as char(32))                  
             --+ left(rnd.vchCli_LocTrab + replicate(' ',60),60)
				 + cast(rnd.vchCli_LocTrab + replicate(' ',60) as char(60))                                     
             + convert(varchar,rnd.dtmCli_RenIniInf,112)
             + right('000000000000000' + replace(cast(rnd.numCli_RenVlrInf as varchar),'.',''),15)
             + replicate(' ',164)
        from CarMov mov
        join CarCar         car on car.numCli_CpfCnpj   = mov.numCli_CpfCnpj
                               and car.intCls_Cod       = mov.intCls_Cod
                               and car.intCar_Seq       = mov.intCar_Seq
        join CarAgn         agn on agn.intAgn_Cod       = car.intAgn_Cod
        join CarRnd         rnd on rnd.numCli_CpfCnpj   = car.numCli_CpfCnpj
                               and rnd.numCli_RenVlrInf > 0
       where mov.dtmMov_Dta = @pdtmRef
         and mov.intEve_Cod = 2
	 and mov.numCli_CpfCnpj not in (select numCli_CpfCnpj 
				    	from carmov z
				    	where z.intEve_Cod = 3 
				  	 and z.dtmMov_Dta = mov.dtmMov_Dta
					 and z.numCli_CpfCnpj = mov.numCli_CpfCnpj)
   insert into ##tmpRem  
      select  600,agn.intAgn_PVCaixa + car.numCli_CpfCnpj
             ,'600'
             + right('0000' + cast(agn.intAgn_PVCaixa as varchar),4)
             + right('00000000000000' + cast(car.numCli_CpfCnpj as varchar),14)
             + right('0000'+ cast(cli.intCli_TelResDdd as varchar),4)
             + right('000000000'+ cast(cli.numCli_TelResNum as varchar),9)
             + right('0000'+ cast(cli.intCli_TelCelDdd as varchar),4)
             + right('000000000'+ cast(cli.numCli_TelCelNum as varchar),9)
             + cast(cli.intCli_IdeEndCor as varchar)
             --+ left(cli.vchCli_Mail + replicate(' ',50),50)
				 + cast(cli.vchCli_Mail + replicate(' ',50) as char(50))  
             + '003'
             + right('0000' + cast(car.intAgn_Cod as varchar),4)  --right('0000' + cast(agn.intAgn_PVCaixa as varchar),4)
             + right('00000000000000' + cast(car.numCar_CpfVnd as varchar),14)
             + right('0'+ cast(car.intCar_DiaVen as varchar),2)
             + '000'
             + '0000'
             + '000000000000'
             + '00'
             + '06'
             + '02'
             + '2'
             + '020'
             + right('00'+ cast(cls.intCls_Cod as varchar),2)
             + replicate(' ',148)
        from CarMov mov
        join CarCar         car on car.numCli_CpfCnpj   = mov.numCli_CpfCnpj
                               and car.intCls_Cod       = mov.intCls_Cod
                               and car.intCar_Seq       = mov.intCar_Seq
        join CarCli         cli on cli.numCli_CpfCnpj   = car.numCli_CpfCnpj
        join CarAgn         agn on agn.intAgn_Cod       = car.intAgn_Cod
        join CarCls         cls on cls.intCls_Cod       = car.intCls_Cod
       where mov.dtmMov_Dta = @pdtmRef
         and mov.intEve_Cod = 2
	 and mov.numCli_CpfCnpj not in (select numCli_CpfCnpj 
				    	from carmov z
				    	where z.intEve_Cod = 3 
				  	 and z.dtmMov_Dta = mov.dtmMov_Dta
					 and z.numCli_CpfCnpj = mov.numCli_CpfCnpj)
   insert into ##tmpRem  
      select  700,agn.intAgn_PVCaixa + car.numCli_CpfCnpj
             ,'700'
             + right('0000' + cast(agn.intAgn_PVCaixa as varchar),4)
             + right('00000000000000' + cast(car.numCli_CpfCnpj as varchar),14)
             --+ left(isnull(cl1.vchCli_Nom,'') + replicate(' ',50),50)
				 + cast(isnull(cl1.vchCli_Nom,'') + replicate(' ',50) as char(50))  
             + right('00000000000000' + cast(isnull(cl1.numCli_CpfCnpj,0) as varchar),14)
             + isnull(convert(varchar,cl1.dtmCli_Nas,112),'00000000')
             + '2' --cast(isnull(cd1.tinCarAdi_IndMes,0) as varchar)
				 + '0000000000000'
             --+ left(isnull(cl2.vchCli_Nom,'') + replicate(' ',50),50)
				 + cast(isnull(cl2.vchCli_Nom,'') + replicate(' ',50) as char(50)) 
             + right('00000000000000' + cast(isnull(cl2.numCli_CpfCnpj,0) as varchar),14)
             + isnull(convert(varchar,cl2.dtmCli_Nas,112),'00000000')
             + '2' --cast(isnull(cd2.tinCarAdi_IndMes,0) as varchar)
				 + '0000000000000'
             --+ left(isnull(cl3.vchCli_Nom,'') + replicate(' ',50),50)
				 + cast(isnull(cl3.vchCli_Nom,'') + replicate(' ',50) as char(50)) 
             + right('00000000000000' + cast(isnull(cl3.numCli_CpfCnpj,0) as varchar),14)
             + isnull(convert(varchar,cl3.dtmCli_Nas,112),'00000000')             + '2' --cast(isnull(cd3.tinCarAdi_IndMes,0) as varchar)
             + '0000000000000'
				 --+ right('0000000000000' + replace(cast(isnull(cd3.numCarAdi_Lim,0) as varchar),'.',''),13)
             + replicate(' ',21)

        from CarMov mov
        join CarCar         car on car.numCli_CpfCnpj   = mov.numCli_CpfCnpj
                               and car.intCls_Cod       = mov.intCls_Cod
                               and car.intCar_Seq       = mov.intCar_Seq
        join CarAgn         agn on agn.intAgn_Cod       = car.intAgn_Cod

         join CarCar    cd1 on cd1.numCli_CpfCnpj = car.numCli_CpfCnpj
                               and cd1.intCls_Cod     = car.intCls_Cod
                               and cd1.intCar_Seq     = 2

         lEFT join CarCar    cd2 on cd2.numCli_CpfCnpj = car.numCli_CpfCnpj
                               and cd2.intCls_Cod     = car.intCls_Cod
                               and cd2.intCar_Seq     = 3

         LEFT join CarCar    cd3 on cd3.numCli_CpfCnpj = car.numCli_CpfCnpj
                               and cd3.intCls_Cod     = car.intCls_Cod
                               and cd3.intCar_Seq     = 4

         join CarCli    cl1 on cl1.numCli_CpfCnpj = cd1.numCarAdi_CpfCnpj
         LEFT join CarCli    cl2 on cl2.numCli_CpfCnpj = cd2.numCarAdi_CpfCnpj
         LEFT join CarCli    cl3 on cl3.numCli_CpfCnpj = cd3.numCarAdi_CpfCnpj

       where mov.dtmMov_Dta = @pdtmRef
         and mov.intEve_Cod = 2
	 and mov.numCli_CpfCnpj not in (select numCli_CpfCnpj 
				    from carmov z
				    where z.intEve_Cod = 3 
				  	and z.dtmMov_Dta = mov.dtmMov_Dta
					and z.numCli_CpfCnpj = mov.numCli_CpfCnpj)
--       select  700,agn.intAgn_PVCaixa + car.numCli_CpfCnpj
--              ,'700'
--              + right('0000' + cast(agn.intAgn_PVCaixa as varchar),4)
--              + right('00000000000000' + cast(car.numCli_CpfCnpj as varchar),14)
--              + cast(isnull(cl1.vchCli_Nom,'') + replicate(' ',50) as char(50))  
--              + right('00000000000000' + cast(isnull(cl1.numCli_CpfCnpj,0) as varchar),14)
--              + isnull(convert(varchar,cl1.dtmCli_Nas,112),'00000000')
--              + '2'
-- 	     + '0000000000000'
-- 	     + cast(isnull('','') + replicate(' ',50) as char(50)) 
--              + '00000000000000'
--              + '00000000'
--              + '0'
-- 	     + '0000000000000'
-- 	     + cast(isnull('','') + replicate(' ',50) as char(50)) 
--              + '00000000000000'
--              + '00000000'--              + '0'
--              + '0000000000000'
--              + replicate(' ',21)
--         from CarMov mov
--         join CarCar         car on car.numCli_CpfCnpj   = mov.numCli_CpfCnpj
--                                and car.intCls_Cod       = mov.intCls_Cod
--                                and car.intCar_Seq       = mov.intCar_Seq
--         join CarAgn         agn on agn.intAgn_Cod       = car.intAgn_Cod
--          join CarCar    cd1 on cd1.numCli_CpfCnpj = car.numCli_CpfCnpj
--                                and cd1.intCls_Cod     = car.intCls_Cod
--                                and cd1.intCar_Seq     in (2,3,4)
--          join CarCli    cl1 on cl1.numCli_CpfCnpj = cd1.numCarAdi_CpfCnpj
--        where mov.dtmMov_Dta = @pdtmRef
--          and mov.intEve_Cod = 2

trailler:
   insert into ##tmpRem  
      select  999,'999999999999999999'
             ,'999'
             + right('000000' + cast(count(*) + 1 as varchar),6)
             + replicate(' ',291)
        from ##tmpRem

gravar_evento:
--inibido em 29/01/2007
   insert CarMov 
      select numCli_CpfCnpj   
            ,intCls_Cod  
            ,intCar_Seq  
            ,intMov_Seq + 1
            ,4                       -- enviado CEF
            ,dtmMov_Dta                                            
            ,numMov_Vlr           
            ,intAgn_Cod  
            ,'Sistema'                
            ,getdate()
            ,'spi_ArquivoRemessa'             
        from CarMov
       where dtmMov_Dta = @pdtmRef
         and intEve_Cod = 2
	 and numCli_CpfCnpj not in (select numCli_CpfCnpj 
				    from carmov z
				    where z.intEve_Cod = 3 
				     and z.dtmMov_Dta = dtmMov_Dta
				     and z.numCli_CpfCnpj = numCli_CpfCnpj)
         and not exists (select numCli_CpfCnpj
                           from CarMov x
                          where x.numCli_CpfCnpj = carmov.numCli_CpfCnpj
                            and x.intCls_Cod     = carmov.intCls_Cod
                            and x.intCar_Seq     = carmov.intCar_Seq
                            and x.intMov_Seq     = carmov.intMov_Seq
                             and x.intEve_Cod     = 4)
resultado:
   select registro from ##tmpRem order by ch, tr
   return 0









