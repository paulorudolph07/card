-- job para geração remessa
INSERT INTO [FILE_PROCESSOR].[dbo].[FILE_SPEC_JOB_SPEC]
           ([ID_FILE_SPEC]
           ,[ID_JOB_SPEC])
     VALUES
           (1
           ,1);

-- job valida se arquivos existem
INSERT INTO [FILE_PROCESSOR].[dbo].[FILE_SPEC_JOB_SPEC]
           ([ID_FILE_SPEC]
           ,[ID_JOB_SPEC])
     VALUES
           (2
           ,2);
INSERT INTO [FILE_PROCESSOR].[dbo].[FILE_SPEC_JOB_SPEC]
           ([ID_FILE_SPEC]
           ,[ID_JOB_SPEC])
     VALUES
           (3
           ,2);
INSERT INTO [FILE_PROCESSOR].[dbo].[FILE_SPEC_JOB_SPEC]
           ([ID_FILE_SPEC]
           ,[ID_JOB_SPEC])
     VALUES
           (4
           ,2);

-- jobs processamento retorno
INSERT INTO [FILE_PROCESSOR].[dbo].[FILE_SPEC_JOB_SPEC]
           ([ID_FILE_SPEC]
           ,[ID_JOB_SPEC])
     VALUES
           (2
           ,3);
INSERT INTO [FILE_PROCESSOR].[dbo].[FILE_SPEC_JOB_SPEC]
           ([ID_FILE_SPEC]
           ,[ID_JOB_SPEC])
     VALUES
           (3
           ,4);
INSERT INTO [FILE_PROCESSOR].[dbo].[FILE_SPEC_JOB_SPEC]
           ([ID_FILE_SPEC]
           ,[ID_JOB_SPEC])
     VALUES
           (4
           ,5);