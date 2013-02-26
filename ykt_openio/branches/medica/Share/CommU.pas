unit CommU;

interface

uses SysUtils, Messages, StdCtrls, Classes, Controls, Forms, Windows, Ora, MemDS, DB, DBAccess, IniFIles;

const
  WM_RELEASEDLL = WM_USER + 101;
  SP = '~~';
  //ORACLE�����ַ���

  CONFIGFILE = 'config.ini';
  LOGINFILE = 'picture\Login.bmp';
  USERCODEFILE = 'usercode.ini';

type
  LOOPPURSEINFO = packed record
    RemainMoney: DWORD; // ����Ǯ�����
    DealTimes: WORD; // �û���������ˮ��
    DealYear: BYTE; // ��������
    DealMonth: BYTE;
    DealDay: BYTE;
    DealHour: BYTE;
    DealMin: BYTE;
    DealTimes_CurTime: BYTE; // �ۼƽ��״���(��ǰʱ�����)
    DealTimes_CurDay: BYTE; // �ۼƽ��״���(������)
  end;

type
  TCardInfo = packed record
    DeadLineDate: array[1..9] of char; //�û���ʹ�ý�ֹ����
    CardRightType: longint; //�û���ʹ��Ȩ�����ͣ�1--254��
    ucName: array[1..9] of Char; //����
    ucDutyNo: array[1..9] of Char; //ְ�����
    ucCertificateNo: array[1..21] of Char; //֤������
    ucDepartmentNo: array[1..11] of Char; //���ű��
    ucIdentifyNo: array[1..21] of Char; //���ݴ���
    ucSexNo: array[1..2] of Char; //�Ա����
    ucCardNo: array[1..21] of Char; //���ţ����Ż�ѧ�ţ�
  end;

type
  TRunDllFun = function(AFile, AStr: PChar; i, x, y, mode: integer): integer; stdcall;
  TProductZS = record
    ID: string; //��Ʒ����
    Name: string; //��Ʒ����
    Count: Double; //�ͻ�����
  end;
  Tmedicaldtl = record
    REFNO: string; //���
    CUSTID: integer; //�ͻ���
    CUSTNAME: string; //����
    STUEMPNO: string; //ѧ����
    sex: string; //�Ա�
    CUSTTYPENAME: string; //�ͻ����
    VOUCHERNO: string; //������
    MEDICINES: string; //ҩƷ
    MEDICALINFO: string; //������Ϣ
    CARDNO: integer; //����
    TRANSDATE: string; //��������
    TRANSTIME: string; //�ɷ�ʱ��
    TRANSTYPE: integer; //�ɷ�����
    money: double; //���
    DEVPHYID: string; //�ն˺�
    OPERCODE: string; //����Ա
    STATUS: string; //״̬
    REMARK: string; //���
  end;
  TPeople = record
    sOperatorCode: string;
    sOperatorName: string;
    sBusinessCode: string;
    sBusinessName: string;
    sManagerCode: string;
    sManagerName: string;
    sCheckerCode: string;
    sCheckerName: string;
    sSenderCode: string;
    sSenderName: string;
    sTesterCode: string;
    sTesterName: string;
  end;
  PDBConn = ^TOraSession;
  PUser = ^TUserInfo;
  //��ģ����Ϣ����
  TSubMenu = record
    Caption: string; //��ģ������
    ID: string; //��ģ��ID
    DLL: string; //��ģ��DLL��
    isVisble: boolean; //�Ƿ���ʾ��Ĭ��FALSE��������ʾ
    isWeb: boolean; //�Ƿ�WEB��ʽ
  end;
  //��ģ����Ϣ����
  TMenu = record
    Caption: string; //��ģ����
    ID: string; //��ģ��ID
    isValid: boolean; //��ģ���Ƿ���Ч,Ĭ��FALSE����Ч
    isWeb: boolean; //��ģ���Ƿ�ΪWEB��ʽ
    SubMenu: array of TSubMenu; //��Ӧ����ģ��
  end;
  //�û���Ϣ����
  TUserInfo = class(TObject)
  private
    UserName: string; //�û���
    Password: string; //����
    CNName: string; //��������
  protected

  public
    //�û���Ӧ��ģ���б�
    MenuList: array of TMenu;
    //����-1����������; ����0����½�ɹ���
    //����1���û������ڣ�����2���������
    function funcLogin: integer;
    //��֯�û���Ӧ�Ĺ���
    function funcGetMenuList: boolean;
    //��ȡ�û���
    function GetUserName(): string;
    //��ȡ����
    function GetPassword(): string;
    //��ȡ������
    function GetCNName(): string;
    constructor Create(AName, APwd: string);
  end;
var
   //  OraSession1: TOraSession;
  //  OraQuery1: TOraQuery;
  //���ݿ���ر���
  DBConn: TOraSession;
  PtConn: PDBConn; //DLLģ����ʹ��
  DBQuery, DBQueryTmp, DBQueryBaK: TOraQuery;
  DEVPHYID, dllstr, DBSOURCE, DBUser, DBPASS, DBIP, port, DBCONNSTR: string;
  baud, posport: integer;
  dllnamelist: Tstringlist;
  menunamelist: Tstringlist;
  //CurrUserName:string;
  //�û���Ϣ
  User: TUserInfo;
  PtUser: PUser; //DLLģ����ʹ��
  usename: string;
  debug: string;
  //��ӡ���
  PrintName: string; //��ӡ������
  PrintIndex: integer; //��ǰ��ӡ�����
  Orient: integer; //��ӡ����
  X, Y: integer; //X�������ֵ��Y�������ֵ
  ORA_CONNECT_STRING: string;



//���� dll
function calc_oper_pwd(oper_code: pchar; pwd: pchar; text: pchar): longint; stdcall; far; external 'desdll.dll' name 'calc_oper_pwd';
function SMT_ControlBuzzer: longint; stdcall; external 'KS_ThirdInterface.dll' name 'SMT_ControlBuzzer';
//��ѧ����  *
function SMT_ReadCardNo(cardno: pchar): longint; stdcall; external 'KS_ThirdInterface.dll' name 'SMT_ReadCardNo';
//��ȡ���
function SMT_ReadBalance(var Balance: integer): longint; stdcall; external 'KS_ThirdInterface.dll' name 'SMT_ReadBalance';
 //����
function SMT_PacketDelMomey(nMoney: integer; var nFlowNo: integer): longint; stdcall; external 'KS_ThirdInterface.dll' name 'SMT_PacketDelMomey';
//�򿪴���
function SMT_ConnectMF280(port: integer; baud: integer): longint; stdcall; external 'KS_ThirdInterface.dll' name 'SMT_ConnectMF280';
//�رմ���
function SMT_CloseMF280: longint; stdcall; external 'KS_ThirdInterface.dll' name 'SMT_CloseMF280';
  //���ܺ���
function encOperPwd(operCode, operPwd: string): string;
function FuncShowMessage(hdl: HWND; StrMsg: string; IntMsgType: integer): integer;
//��ȡӦ�ó���·��
function GetAppPath: string;
//�������ݿ�
function funcConnectDB(): boolean; overload;
function funcConnectDB(Pt: PDBConn): boolean; overload;
//��ѯSQL
function funcSelectSql(ASql: string; AQuery: TOraQuery; PtEnable: boolean = true): boolean;
//����param����ѯSQL
function funcSelectSqlWithParams(AQuery: TOraQuery; PtEnable: boolean = true): boolean;

//ִ��SQL
function funcExcuteSql(ASql: string; AQuery: TOraQuery; PtEnable: boolean = true): boolean;

//����param��ִ��SQL
function funcExcuteSqlForChinese(AQuery: TOraQuery; PtEnable: boolean = true): boolean;
function writelog(strmessage: string): boolean;
//��ȡINI�ļ�
procedure procGetIniInfo;
//д��INI�ļ�
procedure procWriteIniInfo();
//��ȡϵͳĿ¼
function funcGetSystemDir: string;
//��ȡ���ַ���
function FuncGetSubStr(Str, AStart, AEnd: string): string;
//���ַ����õ���ֵ
function Fun_CurrGetValue(SrcStr: string): Double;
//����ֵ�õ�ǧ��λ�ַ���
function Fun_StrFormatEditValue(Curr: Double): string;
//�������õ���ֵ
function Fun_CurrGetEditValue(SrcObj: TEdit): Double;
//�����ǧ��λ�õ���׼�ַ���
function Fun_StrGetFloatStr(SrcStr: string): string;
//����ת������
function funcConvertDate(ADate: string): TDate;
function funcFillZero(AID: string; len: integer = 10): string;
//��1�����ַ���ǰ���0
function funcGetNewID(AID: string; Len: Integer = 10): string;
//ȥ���ַ����пո�
function funcEraseStringSpace(AStr: string): string;

function GetNextStr(var SrcStr: string; ASPLIT: string = ','): string;
//�ͷŷ�������ݼ��ڴ�
procedure procDestroyDBSET;

procedure saveUserCode(userCode: string);
function readUserCode(): string;


implementation

function writelog(strmessage: string): boolean;
var
  myfile: TextFile;
  size, FileHandle: Integer;
  filename: string;
  patch: string;
begin
  result := true;
  patch := ExtractFilePath(ParamStr(0));
  filename := patch + 'log.txt';
  AssignFile(myfile, filename);
  try
    if FileExists(filename) then
    begin
      Append(myfile);
    end
    else
      ReWrite(myfile);
    Writeln(myfile, strmessage);
  finally
    CloseFile(myfile);
  end;
  result := false;
end;


function readUserCode(): string;
var
  iniFile: TiniFile;
  sFile: string;
begin
  sFile := GetAppPath + USERCODEFILE;
  iniFile := TIniFile.Create(sFile);
  result := '';
  try
    result := iniFile.ReadString('usercode', 'usename', '');

  finally
    iniFile.Free;
  end;

end;

procedure saveUserCode(userCode: string);
var
  INI: TIniFile;
  sFile: string;
begin
  sFile := GetAppPath + USERCODEFILE;
  INI := TIniFile.Create(sFile);
  try
    ini.Writestring('usercode', 'usename', userCode);
  finally
    Ini.Free;
  end;
end;


procedure procDestroyDBSET;
begin
  DBQuery.Close;
  DBQueryTmp.Close;
  DBQueryBak.Close;
  dllnamelist.Free;
  menunamelist.Free;
end;

function GetNextStr(var SrcStr: string; ASPLIT: string = ','): string;
var
  i: integer;
begin
  result := '';
  if SrcStr = '' then exit;
  i := pos(ASPLIT, SrcStr);
  if i <> 0 then
  begin
    result := copy(SrcStr, 1, i - 1);
    SrcStr := copy(SrcStr, i + Length(ASPLIT), Length(SrcStr));
  end
  else
  begin
    result := SrcStr;
    SrcStr := '';
  end;
end;

function adddlllist(dllstr: string): boolean;
var
  getstr: string;
  outwhile: boolean;
begin
  dllnamelist := Tstringlist.Create;
  menunamelist := Tstringlist.Create;
  while outwhile do
  begin
    getstr := GetNextStr(dllstr);
    if getstr = '' then
    begin
      outwhile := false;
    end
    else
    begin
      dllnamelist.Add(getstr);
      getstr := GetNextStr(dllstr);
      menunamelist.Add(getstr);
    end


  end;
end;

function funcEraseStringSpace(AStr: string): string;
var
  i: integer;
begin
  AStr := UpperCase(Trim(AStr));
  i := pos('OR', AStr);
  if i <> 0 then
    AStr := copy(AStr, 1, i - 1) + copy(AStr, i + 2, maxint);
  result := AStr;
end;



function funcFillZero(AID: string; len: integer = 10): string;
var
  i, p: integer;
begin
  if AID = '' then
    AID := '1';
  p := length(AID);
  if (p >= Len) then
    AID := copy(AID, 1, Len);
  for i := 1 to (Len - p) do
    AID := '0' + AID;
  result := AID;
end;

function funcGetNewID(AID: string; Len: Integer): string;
var
  i, p: integer;
  temp: LONGINT;
begin
  if AID = '' then
    AID := '1';
  temp := StrToInt(AID);
  inc(temp);
  AID := IntToStr(temp);
  result := funcFillZero(AID, Len);
end;

function funcConvertDate(ADate: string): TDate;
var
  tmp: char;
begin
  result := Date();
  if length(ADate) <> 8 then exit;
  ADate := copy(ADate, 1, 4) + '-' + copy(ADate, 5, 2) + '-' + copy(ADate, 7, 2);
  tmp := DateSeparator;
  try
    DateSeparator := '-';
    try
      result := StrToDate(ADate);
    except
      exit;
    end;
  finally
    DateSeparator := tmp;
  end;
end;

function Fun_StrGetFloatStr(SrcStr: string): string;
begin
  result := SysUtils.FormatFloat('0.00', Fun_CurrGetValue(SrcStr));
end;

function Fun_CurrGetEditValue(SrcObj: TEdit): Double;
begin
  try
    result := Fun_CurrGetValue(SrcObj.Text);
  except
    on e: exception do begin
      SrcObj.SetFocus();
      SrcObj.SelectAll();
      raise Exception.Create(e.message);
    end;
  end;
end;

function Fun_StrFormatEditValue(Curr: Double): string;
var
  str: string;
begin
  str := SysUtils.FloatToStrF(Curr, ffFixed, 18, 4);
  result := SysUtils.FormatFloat('#,##0.00', Fun_CurrGetValue(str));
end;

function Fun_CurrGetValue(SrcStr: string): Double; //�������õ���ֵ
var str: string;
  i: integer;
  c, d: char;
begin
  result := 0;
  for i := 1 to Length(SrcStr) do
    if SrcStr[i] in ['0'..'9', '.', '-'] then str := str + SrcStr[i];
  if str = '' then exit;
  try
    c := #0;
    i := pos('.', Str);
    if (i > 14) or ((i = 0) and (Length(str) > 14)) then raise Exception.Create('');
    if (i > 0) and (Length(Str) >= i + 3) then begin
      c := Str[i + 3];
      Str := copy(Str, 1, i + 2);
    end;
    d := sysutils.DecimalSeparator;
    sysutils.DecimalSeparator := '.';
    result := SysUtils.StrToFloat(str);
    if c in ['5'..'9'] then result := result + 0.01;
    sysutils.DecimalSeparator := d;
  except
    on e: Exception do begin
      raise Exception.Create('ֵ�������Ч!' + str + #13 + e.Message);
    end;
  end;
end;

function FuncGetSubStr(Str, AStart, AEnd: string): string;
var
  iStart, iEnd: integer;
begin
  iStart := pos(AStart, Str);
  iEnd := pos(AEnd, Str);
  Result := copy(Str, iStart + 1, iEnd - iStart - 1);
end;

function funcGetSystemDir: string;
var
  dir: array[0..255] of char;
begin
  GetWindowsDirectory(dir, 255);
  result := dir;
end;

procedure procWriteIniInfo();
var
  INI: TIniFile;
  sFile: string;
begin
  sFile := GetAppPath + CONFIGFILE;
  INI := TIniFile.Create(sFile);
  try
  {
    Ini.WriteString('DB', 'DBIP', DBIP);
    Ini.WriteString('DB', 'PORT', port);
    Ini.WriteString('DB', 'SOURCE', DBSOURCE);
    Ini.WriteString('DB', 'USER', DBUSER);
    Ini.WriteString('DB', 'PASS', DBPASS);
    Ini.WriteString('dll', 'dllname', DBPASS);
    Ini.Writeinteger('pos', 'port', posport);
    Ini.Writeinteger('pos', 'baud', baud);
    ini.Writestring('device', 'DEVPHYID', DEVPHYID);
   }
    ini.Writestring('use', 'usename', usename);
  finally
    Ini.Free;
  end;
end;

procedure procGetIniInfo;
var
  INI: TIniFile;
  sFile: string;
begin
  sFile := GetAppPath + CONFIGFILE;
  INI := TIniFile.Create(sFile);
  try
    DBIP := INI.ReadString('DB', 'DBIP', '');
    port := INI.ReadString('DB', 'PORT', '');
    DBSOURCE := INI.ReadString('DB', 'DBSOURCE', '');
    DBUSER := INI.ReadString('DB', 'USER', '');
    DBPASS := INI.ReadString('DB', 'PASS', '');
    dllstr := INI.ReadString('dll', 'dllname', '');
    posport := INI.Readinteger('pos', 'posport', 1);
    baud := INI.Readinteger('pos', 'baud', 19200);
    DEVPHYID := INI.Readstring('device', 'TERMID', '');
    dllstr := INI.ReadString('dll', 'dllname', '');
    usename := INI.ReadString('use', 'usename', '');
    debug := INI.readstring('use', 'debug', 'false');
    adddlllist(dllstr);
    ORA_CONNECT_STRING := '' + DBUSER + '' + '/' + '' + DBPASS + '' + '@' + '' + DBIP + '' + ':' + '' + port + '' + ':' + '' + DBSOURCE + '';
  finally
    INI.Free;
  end;
end;

{$WARNINGS OFF}

function FuncShowMessage(hdl: HWND; StrMsg: string; IntMsgType: integer): integer;
begin
  result := 0;
  case IntMsgType of
    0: MessageBox(HDL, Pchar(StrMsg), '��ʾ', MB_OK + MB_ICONINFORMATION);
    1: MessageBox(HDL, Pchar(StrMsg), '����', MB_OK + MB_ICONWARNING);
    2: MessageBox(HDL, Pchar(StrMsg), '����', MB_OK + MB_ICONERROR);
    3: result := MessageBox(HDL, Pchar(StrMsg), '��ʾ', MB_YESNO + MB_ICONQUESTION);
    4: result := MessageBox(HDL, Pchar(StrMsg), '��ʾ', MB_YESNOCANCEL + MB_ICONQUESTION);
  end;
end;
{$WARNINGS ON}

function GetAppPath: string;
begin
  result := ExtractFilePath(Application.ExeName);
end;

function funcConnectDB(Pt: PDBConn): boolean;
begin
  result := false;

  if DBConn = nil then begin
    DBConn := TOraSession.Create(nil);
  end;
  DBConn.Options.Net := true;
  if DBQuery = nil then
    DBQuery := TOraQuery.Create(nil);
  if DBQueryTmp = nil then
    DBQueryTmp := TOraQuery.Create(nil);
  if DBQueryBak = nil then
    DBQueryBak := TOraQuery.Create(nil);
 // DBCONNSTR := format(ORA_CONNECT_STRING, [DBPASS, DBUSER, DBSOURCE]);
  if Pt^.Connected then
  begin
    result := true;
    DBQuery.Connection := Pt^;
    DBQueryTmp.Connection := Pt^;
    DBQueryBak.Connection := Pt^;
    result := true;
    exit;
  end;
  try
    Pt^.SQL.Text := ORA_CONNECT_STRING;
    Pt^.LoginPrompt := false;
    DBQuery.Connection := Pt^;
    DBQueryTmp.Connection := Pt^;
    DBQueryBak.Connection := Pt^;
    Pt^.Connected := true;
  except
    on e: exception do
      FuncShowMessage(Application.Handle, '���Ӵ���:' + e.Message, 2);
  end;
  result := true;
end;

function funcConnectDB(): boolean;
begin
  result := false;
  if DBConn = nil then begin
    DBConn := TOraSession.Create(nil);
  end;
  DBConn.Options.Net := true;
  if DBQuery = nil then
    DBQuery := TOraQuery.Create(nil);
  if DBQueryTmp = nil then
    DBQueryTmp := TOraQuery.Create(nil);
  if DBQueryBaK = nil then
    DBQueryBaK := TOraQuery.Create(nil);
 // DBCONNSTR := format(ORA_CONNECT_STRING, [DBPASS, DBUSER, DBSOURCE]);
  //FuncShowMessage(Application.Handle,DBCONNSTR,0);
  if DBConn.Connected then
  begin
    result := true;
    DBQuery.Connection := DBConn;
    DBQueryTmp.Connection := DBConn;
    DBQueryBaK.Connection := DBConn;
    result := true;
    exit;
  end;
  try

    DBConn.ConnectString := ORA_CONNECT_STRING;
    DBConn.LoginPrompt := false;
    DBQuery.Connection := DBConn;
    DBQueryTmp.Connection := DBConn;
    DBQueryBaK.Connection := DBConn;
    DBConn.Open();
  except
    on e: exception do
    begin
      FuncShowMessage(Application.Handle, '���Ӵ���:' + e.Message, 2);
      exit;
    end;
  end;
  result := true;
end;

function funcSelectSqlWithParams(AQuery: TOraQuery; PtEnable: boolean = true): boolean;
begin
  if PtEnable then
  begin
    result := PtConn^.Connected;
    if not PtConn^.Connected then
    begin
      if not funcConnectDB(PtConn) then exit;
    end;
  end
  else
  begin
    result := DBConn.Connected;
    if not DBConn.Connected then
    begin
      if not funcConnectDB() then exit;
    end;
  end;
    AQuery.Open;
  AQuery.First;
  result := true;
end;


function funcSelectSql(ASql: string; AQuery: TOraQuery; PtEnable: boolean = true): boolean;
begin
  if PtEnable then
  begin
    result := PtConn^.Connected;
    if not PtConn^.Connected then
    begin
      if not funcConnectDB(PtConn) then exit;
    end;
  end
  else
  begin
    result := DBConn.Connected;
    if not DBConn.Connected then
    begin
      if not funcConnectDB() then exit;
    end;
  end;
  AQuery.Close;
  AQuery.SQL.Clear;
  AQuery.SQL.Text := ASql;
  AQuery.Open;
  AQuery.First;
  result := true;
end;

function encOperPwd(operCode, operPwd: string): string;
var
  outOperPwd: array[0..16] of Char;
  st: Integer;
begin
  st := calc_oper_pwd(PChar(operCode), PChar(Trim(operPwd)), @outOperPwd);
  if st <> 0 then
  begin
    FuncShowMessage(Application.Handle, '����ʧ�ܣ�', 2);
    Result := '';
    Exit;
  end;
  Result := outOperPwd;
end;

function funcExcuteSql(ASql: string; AQuery: TOraQuery; PtEnable: boolean = true): boolean;
begin
  result := false;
  if PtEnable then
  begin
    result := PtConn^.Connected;
    if not PtConn^.Connected then
    begin
      if not funcConnectDB(PtConn) then exit;
    end;
  end
  else
  begin
    result := DBConn.Connected;
    if not DBConn.Connected then
    begin
      if not funcConnectDB() then exit;
    end;
  end;

  AQuery.Close;
  AQuery.SQL.Clear;
  AQuery.SQL.Text := ASql;
  AQuery.ExecSQL;
  result := true;
end;

function funcExcuteSqlForChinese(AQuery: TOraQuery; PtEnable: boolean = true): boolean;
begin
  result := false;
  if PtEnable then
  begin
    result := PtConn^.Connected;
    if not PtConn^.Connected then
    begin
      if not funcConnectDB(PtConn) then exit;
    end;
  end
  else
  begin
    result := DBConn.Connected;
    if not DBConn.Connected then
    begin
      if not funcConnectDB() then exit;
    end;
  end;

  AQuery.ExecSQL;
  result := true;
end;
{ TUserInfo }



constructor TUserInfo.Create(AName, APwd: string);
begin
  self.UserName := AName;
  self.Password := APwd;
end;

function TUserInfo.funcGetMenuList: boolean;
var
  i, j, k: integer;
  sSql, ParentID, ChildID: string;
begin
  SetLength(MenuList, i + 1);
  MenuList[i].Caption := 'ҽ���շ�';
  MenuList[i].ID := '1';
  MenuList[i].isValid := true;
  for j := 1 to dllnamelist.Count do
  begin
    SetLength(MenuList[i].SubMenu, j + 1);
    MenuList[i].SubMenu[j].Caption := menunamelist[j - 1];
    MenuList[i].SubMenu[j].ID := inttostr(j);
    MenuList[i].SubMenu[j].DLL := dllnamelist[j - 1];
    MenuList[i].SubMenu[j].isVisble := true;
  end;
  result := true;
end;

function TUserInfo.funcLogin: integer;
var
  sSql: string;
  input: string;
  status: string;
  opertype: string;
begin
  result := -1;
  sSql := 'select * from  t_operator where opercode= :f1';
  DBQuery.close;
  DBQuery.SQL.Clear;
  DBQuery.SQL.Text := sSql;
  DBQuery.Params[0].AsWideString := self.UserName;

  if funcSelectSqlWithParams(DBQuery, false) then
  begin
    if DBQuery.RecordCount <> 1 then
    begin
      result := 1;
      exit;
    end
    else
    try
      input := encOperPwd(self.UserName, Self.Password);
    except
    end;
    if UpperCase(DBQuery.FieldByName('operpwd').AsString) <> input then
    begin
      result := 2;
      exit;
    end
    else
    begin
      opertype := DBQuery.FieldByName('opertype').AsString;
      if opertype <> '3' then
      begin
        result := 5;
        exit;
      end;
      status := DBQuery.FieldByName('STATUS').AsString;
      if status <> '1' then
      begin
        if status = '0' then
          result := 3;
        if status = '2' then
          result := 4;
      end
      else
        result := 0;
    end;
  end;
end;

function TUserInfo.GetCNName: string;
begin
  result := self.CNName;
end;

function TUserInfo.GetPassword: string;
begin
  result := self.Password;
end;

function TUserInfo.GetUserName: string;
begin
  result := self.UserName;
end;


end.
