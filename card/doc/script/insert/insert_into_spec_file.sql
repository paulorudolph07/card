INSERT INTO [FILE_PROCESSOR].[dbo].[FILE_SPEC]
           ([NAME_PATTERN]
           ,[DESTINATION_DIR]
           ,[ID_FILE_SPEC_TYPE])
     VALUES
           ('remessa\d{4}\.txt'
           ,'\\castanha\Integracao\CARD\ATP'
           ,1);

INSERT INTO [FILE_PROCESSOR].[dbo].[FILE_SPEC]
           ([NAME_PATTERN]
           ,[SOURCE_DIR]
           ,[DESTINATION_DIR]
           ,[ID_FILE_SPEC_TYPE])
     VALUES
           ('PEL.BASAA350\.\d{5}'
           ,'\\castanha\Integracao\ATP\CARD'
           ,'\\castanha\Integracao\ATP\CARD\PROC'
           ,2);
INSERT INTO [FILE_PROCESSOR].[dbo].[FILE_SPEC]
           ([NAME_PATTERN]
           ,[SOURCE_DIR]
           ,[DESTINATION_DIR]
           ,[ID_FILE_SPEC_TYPE])
     VALUES
           ('PEL.BASAB350\.\d{5}'
           ,'\\castanha\Integracao\ATP\CARD'
           ,'\\castanha\Integracao\ATP\CARD\PROC'
           ,2);
INSERT INTO [FILE_PROCESSOR].[dbo].[FILE_SPEC]
           ([NAME_PATTERN]
           ,[SOURCE_DIR]
           ,[DESTINATION_DIR]
           ,[ID_FILE_SPEC_TYPE])
     VALUES
           ('PEL.BASAC350\.\d{5}'
           ,'\\castanha\Integracao\ATP\CARD'
           ,'\\castanha\Integracao\ATP\CARD\PROC'
           ,2);