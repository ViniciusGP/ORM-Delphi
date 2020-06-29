object TDSServerModuleBaseDados: TTDSServerModuleBaseDados
  OldCreateOrder = False
  Height = 431
  Width = 689
  object LSCONEXAO: TSQLConnection
    ConnectionName = 'MySQLConnection'
    DriverName = 'MySQL'
    Params.Strings = (
      'DriverUnit=Data.DBXMySQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver220.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=22.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXMySqlMetaDataCommandFactory,DbxMySQLDr' +
        'iver220.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXMySqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMySQLDriver,Version=22.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverMYSQL'
      'LibraryName=dbxmys.dll'
      'LibraryNameOsx=libsqlmys.dylib'
      'VendorLib=LIBMYSQL.dll'
      'VendorLibWin64=libmysql.dll'
      'VendorLibOsx=libmysqlclient.dylib'
      'MaxBlobSize=-1'
      'DriverName=MySQL'
      'HostName=localhost'
      'Database=sweet_library'
      'User_Name=root'
      'Password=root'
      'ServerCharSet='
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Compressed=False'
      'Encrypted=False'
      'ConnectTimeout=60')
    Left = 24
    Top = 8
  end
  object FDConexao: TFDConnection
    Params.Strings = (
      'Database=sweet_library'
      'Password=root'
      'User_Name=root'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 168
    Top = 8
  end
  object ZConexao: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    HostName = 'localhost'
    Port = 3306
    Database = 'sweet_library'
    User = 'root'
    Password = 'root'
    Protocol = 'mysql-5'
    Left = 264
    Top = 8
  end
  object SQLDSSERVIDOR: TSQLDataSet
    SchemaName = 'sweet_library'
    CommandText = 'select * from livros'
    MaxBlobSize = 1
    Params = <>
    SQLConnection = LSCONEXAO
    Left = 24
    Top = 64
  end
  object FDQuery: TFDQuery
    Connection = FDConexao
    Left = 168
    Top = 72
  end
end
