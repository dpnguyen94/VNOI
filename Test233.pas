{$MODE OBJFPC}
program _PROBLEM_Testing;
uses SysUtils, Math, JudgerV2;
const
  TimeLimit = 1.0; //Seconds
  ProblemTitle = 'Matryoshka Dolls'; //Title bar
  Prefix = 'DOLLS'; //file name without extension
  ExeName = Prefix + '.EXE';
  InputFormat = Prefix + '._%s';
  InputFile  = Prefix + '.INP';
  OutputFile = Prefix + '.OUT';

  maxN = 100000;
var
  a: array[1..maxN] of Integer;
  n, k: Integer;
  res: Int64;
  nt: Integer;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, n, k);
    for i := 1 to n do Read(f, a[i]);
  finally
    CloseFile(f);
  end;
end;

procedure Sort(L, H: Integer);
var
  pivot: Integer;
  i, j: Integer;
begin
  i := L + Random(H - L + 1);
  pivot := a[i]; a[i] := a[L];
  i := L; j := H;
  repeat
    while (a[j] < pivot) and (i < j) do Dec(j);
    if i < j then
      begin
        a[i] := a[j]; Inc(i);
      end
    else Break;
    while (a[i] > pivot) and (i < j) do Inc(i);
    if i < j then
      begin
        a[j] := a[i]; Dec(j);
      end
    else Break;
  until i = j;
  a[i] := pivot;
  if L < pred(i) then Sort(L, pred(i));
  if succ(i) < H then Sort(succ(i), H);
end;

procedure GetRes;
var
  i, j: Integer;
begin
  res := 0;
  for i := 1 to n do Inc(res, a[i]);
  j := 1;
  for i := 1 to n do
    begin
      while (j <= n) and (a[j] + k > a[i]) do Inc(j);
      if j <= n then
        begin
          Dec(res, a[j]);
          Inc(j);
        end;
    end;
end;

procedure AllTasks;
begin
  Enter;
  Sort(1, n);
  GetRes;
end;

procedure DoCheck(obj: TJudger);
var
  f: TextFile;
  hsres: Int64;
begin
  //Solve
  AllTasks;
  obj.ev := 0;
  if not FileExists(OutputFile) then
    begin
      TTextEngine.MsgError('Output file not found', []);
      Exit;
    end;
  AssignFile(f, OutputFile); Reset(f);
  try
    try
      WriteLn('Checking the result: ');
      ReadLn(f, hsres);
      TTextEngine.bl1; WriteLn('Answer: ', res);
      TTextEngine.bl1; WriteLn('Output: ', hsres);
      if res <> hsres then
        GenErr('Ye^''u ke''m', []);
      WriteLn;
      TTextEngine.MsgOK;
      obj.ev := 1;
    finally
      CloseFile(f);
    end;
  except
    on E:Exception do
      TTextEngine.MsgError(E.Message)
  end;
end;

var
  tc: array[1..30] of AnsiString;

procedure MakeNames;
var
  i: Integer;
begin
  for i := 1 to Length(tc) do
    tc[i] := Format('%.2d', [i]);
end;

begin
  MakeNames;
  Judger.Title := ProblemTitle;
  Judger.ExecCmd := ExeName;
  Judger.InputFormat := InputFormat;
  Judger.InputFile := InputFile;
  Judger.OutputFile := OutputFile;
  Judger.GetTestCases(tc);
  Judger.TimeLimit := TimeLimit;
  Judger.CheckProc := @DoCheck;
  Judger.Silent := TFileEngine.ParamStr(1) = '/SILENT';
  if Judger.Silent then
    Judger.LogFile := Prefix + '.log';
  Judger.Run;
  if Judger.Silent then
    TStdIO.Pause;
  if (Judger.Score + 1E-6 >= Judger.MaxScore) then
    TTextEngine.SayPerfect;
  Judger.ShowLog;
end.


