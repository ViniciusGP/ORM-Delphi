unit GenericDao;

interface

Uses Db, Rtti, CAtribEntity, TypInfo, SysUtils, Firedac.comp.client,
  srvModBaseDados;

type
  TGenericDAO = class
  private
    class function GetTableName<T: class>(Obj: T): String;
  public
    // procedimentos para o crud
    class function Insert<T: class>(Obj: T): boolean;
    class function Delete<T: class>(Obj: T): boolean;
    class function GetAll<T: class>(Obj: T): TFDQuery;
    class function GetById<T: class>(Obj: T): TFDQuery;
    class function Update<T: class>(Obj: T): boolean;
  end;

implementation

class function TGenericDAO.GetTableName<T>(Obj: T): String;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Atributo: TCustomAttribute;
  strTable: String;
begin
  Contexto := TRttiContext.Create;
  TypObj := Contexto.GetType(TObject(Obj).ClassInfo);
  for Atributo in TypObj.GetAttributes do
  begin
    if Atributo is TableName then
      Exit(TableName(Atributo).Name);
  end;
end;

// funções para manipular as entidades
class function TGenericDAO.Insert<T>(Obj: T): boolean;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  strInsert, strFields, strValues: String;
  Atributo: TCustomAttribute;

begin
  strInsert := '';
  strFields := '';
  strValues := '';

  strInsert := 'INSERT INTO ' + GetTableName(Obj);

  Contexto := TRttiContext.Create;
  TypObj := Contexto.GetType(TObject(Obj).ClassInfo);

  for Prop in TypObj.GetProperties do
  begin
    for Atributo in Prop.GetAttributes do
    begin
      if Atributo is FieldName then
      begin
        strFields := strFields + FieldName(Atributo).Name + ',';
        case Prop.GetValue(TObject(Obj)).Kind of

          tkWChar, tkLString, tkWString, tkString, tkChar, tkUString:

            strValues := strValues + QuotedStr(Prop.GetValue(TObject(Obj))
              .AsString) + ',';

          tkInteger, tkInt64:

            strValues := strValues + IntToStr(Prop.GetValue(TObject(Obj))
              .AsInteger) + ',';

          tkFloat:
            begin
              if Prop.GetValue(TObject(Obj)).TypeInfo.Name = 'TDate' then
              begin
                // Solução provisória para o mysql
                strValues := strValues +
                  QuotedStr(FormatDateTime('yyyy-mm-dd',
                  Prop.GetValue(TObject(Obj)).AsExtended)) + ',';
              end
              else
              begin
                strValues := strValues +
                  FloatToStr(Prop.GetValue(TObject(Obj)).AsExtended) + ',';
              end;
            end;

        else
          raise Exception.Create('Type not Supported');
        end;
      end;
    end;
  end;
  strFields := Copy(strFields, 1, Length(strFields) - 1);
  strValues := Copy(strValues, 1, Length(strValues) - 1);
  strInsert := strInsert + ' ( ' + strFields + ' )  VALUES ( ' +
    strValues + ' )';

  result := TDSServerModuleBaseDados.execSql(strInsert);
end;

class function TGenericDAO.Update<T>(Obj: T): boolean;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  strUpdate, strKey, strFields, strWhere: String;
  isWhere: boolean;
  Atributo: TCustomAttribute;
  valueUpdate: array of string;

begin
  strUpdate := '';
  strFields := '';
  strWhere := '';
  strUpdate := 'UPDATE ' + GetTableName(Obj) + ' SET ';
  strWhere := ' WHERE ';
  isWhere := True;
  Contexto := TRttiContext.Create;
  TypObj := Contexto.GetType(TObject(Obj).ClassInfo);

  for Prop in TypObj.GetProperties do
  begin
    for Atributo in Prop.GetAttributes do
    begin
      if (Atributo is FieldName) and not(Atributo is KeyField) then
      begin
        strFields := strFields + FieldName(Atributo).Name;
        case Prop.GetValue(TObject(Obj)).Kind of

          tkWChar, tkLString, tkWString, tkString, tkChar, tkUString:

            // strValues := strValues +
            strFields := strFields + ' = ' +
              QuotedStr(Prop.GetValue(TObject(Obj)).AsString) + ',';

          tkInteger, tkInt64:

            // strValues := strValues +
            strFields := strFields + ' = ' +
              IntToStr(Prop.GetValue(TObject(Obj)).AsInteger) + ',';

          tkFloat:

            if Prop.GetValue(TObject(Obj)).TypeInfo.Name = 'TDate' then
            begin
              // Solução provisória para o mysql
              strFields := strFields + ' = ' +
                QuotedStr(FormatDateTime('yyyy-mm-dd',
                Prop.GetValue(TObject(Obj)).AsExtended)) + ',';
            end
            else
            begin
              strFields := strFields + ' = ' +
                FloatToStr(Prop.GetValue(TObject(Obj)).AsExtended) + ',';
            end;

        else
          raise Exception.Create('Tipo de dado não suportado');
        end;
      end
      else
      begin
        strKey := FieldName(Atributo).Name;
        case Prop.GetValue(TObject(Obj)).Kind of

          tkWChar, tkLString, tkWString, tkString, tkChar, tkUString:

            if isWhere then
            begin
              isWhere := False;
              strWhere := strWhere + strKey + ' = ' +
                QuotedStr(Prop.GetValue(TObject(Obj)).AsString);
            end
            else
            begin
              strWhere := strWhere + ', AND ' + strKey +
                QuotedStr(Prop.GetValue(TObject(Obj)).AsString);
            end;

          tkInteger, tkInt64:

            if isWhere then
            begin
              isWhere := False;
              strWhere := strWhere + strKey + ' = ' +
                IntToStr(Prop.GetValue(TObject(Obj)).AsInteger);
            end
            else
            begin
              strWhere := strWhere + ', AND ' + strKey +
                IntToStr(Prop.GetValue(TObject(Obj)).AsInteger);
            end;

          tkFloat:

            if isWhere then
            begin
              isWhere := False;
              if Prop.GetValue(TObject(Obj)).TypeInfo.Name = 'TDate' then
              begin
                strWhere := strWhere + strKey + ' = ' +
                  QuotedStr(FormatDateTime('yyyy-mm-dd',
                  Prop.GetValue(TObject(Obj)).AsExtended));
              end
              else
              begin
                strWhere := strWhere + strKey + ' = ' +
                  FloatToStr(Prop.GetValue(TObject(Obj)).AsExtended)
              end;
            end
            else
            begin
              if Prop.GetValue(TObject(Obj)).TypeInfo.Name = 'TDate' then
              begin
                strWhere := strWhere + ', AND ' + strKey +
                  QuotedStr(FormatDateTime('yyyy-mm-dd',
                  Prop.GetValue(TObject(Obj)).AsExtended));
              end
              else
              begin
                strWhere := strWhere + ', AND ' + strKey +
                  FloatToStr(Prop.GetValue(TObject(Obj)).AsExtended)
              end;
            end;
        else
          raise Exception.Create('Type not Supported');
        end;
      end;
    end;
  end;
  strFields := Copy(strFields, 1, Length(strFields) - 1);
  strUpdate := strUpdate + strFields + strWhere;

  result := TDSServerModuleBaseDados.execSql(strUpdate);

end;

class function TGenericDAO.Delete<T>(Obj: T): boolean;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  strDelete, strFields, strValues: String;
  Atributo: TCustomAttribute;

begin
  strDelete := '';
  strFields := '';
  strValues := '';

  strDelete := 'DELETE FROM ' + GetTableName(Obj);

  Contexto := TRttiContext.Create;
  TypObj := Contexto.GetType(TObject(Obj).ClassInfo);

  for Prop in TypObj.GetProperties do
  begin
    for Atributo in Prop.GetAttributes do
    begin
      if Atributo is KeyField then
      begin
        strFields := strFields + FieldName(Atributo).Name + ',';
        case Prop.GetValue(TObject(Obj)).Kind of

          tkWChar, tkLString, tkWString, tkString, tkChar, tkUString:
            strValues := strValues + QuotedStr(Prop.GetValue(TObject(Obj))
              .AsString) + ',';

          tkInteger, tkInt64:

            strValues := strValues + IntToStr(Prop.GetValue(TObject(Obj))
              .AsInteger) + ',';

          tkFloat:

            strValues := strValues + FloatToStr(Prop.GetValue(TObject(Obj))
              .AsExtended) + ',';

        else
          raise Exception.Create('Type not Supported');
        end;
      end;
    end;
  end;
  strFields := Copy(strFields, 1, Length(strFields) - 1);
  strValues := Copy(strValues, 1, Length(strValues) - 1);
  strDelete := strDelete + ' WHERE ' + strFields + ' = ' + strValues;

  result := TDSServerModuleBaseDados.execSql(strDelete);

end;

class function TGenericDAO.GetAll<T>(Obj: T): TFDQuery;
begin
  result := TDSServerModuleBaseDados.getDataSet('SELECT T1.* ' + ' FROM ' +
    GetTableName(Obj) + ' T1 ');
end;

class function TGenericDAO.GetById<T>(Obj: T): TFDQuery;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  strGetId, strFields, strValues, strWhere: String;
  isWhere: boolean;
  Atributo: TCustomAttribute;

begin
  strGetId := '';
  strFields := '';
  strValues := '';

  strGetId := 'SELECT T1.* FROM ' + GetTableName(Obj) + ' T1 ';
  strWhere := ' WHERE ';
  isWhere := True;
  Contexto := TRttiContext.Create;
  TypObj := Contexto.GetType(TObject(Obj).ClassInfo);

  for Prop in TypObj.GetProperties do
  begin
    for Atributo in Prop.GetAttributes do
    begin
      if Atributo is KeyField then
      begin
        strFields := strFields + FieldName(Atributo).Name + ',';
        case Prop.GetValue(TObject(Obj)).Kind of

          tkWChar, tkLString, tkWString, tkString, tkChar, tkUString:

            // strValues := strValues +
            if isWhere then
            begin
              isWhere := False;
              strWhere := strWhere + FieldName(Atributo).Name + ' = ' +
                QuotedStr(Prop.GetValue(TObject(Obj)).AsString);
            end
            else
            begin
              strWhere := strWhere + ' , AND ' + FieldName(Atributo).Name +
                ' = ' + QuotedStr(Prop.GetValue(TObject(Obj)).AsString);
            end;

          tkInteger, tkInt64:

            // strValues := strValues +
            if isWhere then
            begin
              isWhere := False;
              strWhere := strWhere + FieldName(Atributo).Name + ' = ' +
                IntToStr(Prop.GetValue(TObject(Obj)).AsInteger);
            end
            else
            begin
              strWhere := strWhere + ' , AND ' + FieldName(Atributo).Name +
                ' = ' + IntToStr(Prop.GetValue(TObject(Obj)).AsInteger);
            end;

          tkFloat:

            if isWhere then
            begin
              isWhere := False;
              if Prop.GetValue(TObject(Obj)).TypeInfo.Name = 'TDate' then
              begin
                strWhere := strWhere + FieldName(Atributo).Name + ' = ' +
                  QuotedStr(FormatDateTime('yyyy-mm-dd',
                  Prop.GetValue(TObject(Obj)).AsExtended));
              end
              else
              begin
                strWhere := strWhere + FieldName(Atributo).Name + ' = ' +
                  FloatToStr(Prop.GetValue(TObject(Obj)).AsExtended);
              end;
            end
            else
            begin
              if Prop.GetValue(TObject(Obj)).TypeInfo.Name = 'TDate' then
              begin
                strWhere := strWhere + ' , AND ' + FieldName(Atributo).Name +
                  ' = ' + QuotedStr(FormatDateTime('yyyy-mm-dd',
                  Prop.GetValue(TObject(Obj)).AsExtended));
              end
              else
              begin
                strWhere := strWhere + ' , AND ' + FieldName(Atributo).Name +
                  ' = ' + FloatToStr(Prop.GetValue(TObject(Obj)).AsExtended)
              end;
            end;

        else
          raise Exception.Create('Type not Supported');
        end;
      end;
    end;
  end;
  // strFields := Copy(strFields, 1, Length(strFields) - 1);
  // strValues := Copy(strValues, 1, Length(strValues) - 1);
  strGetId := strGetId + strWhere;
  result := TDSServerModuleBaseDados.getDataSet(strGetId);
end;

end.
