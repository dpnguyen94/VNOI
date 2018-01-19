{$MODE OBJFPC}
program TestRowing;
uses SysUtils, Math, JudgerV2;
const
  TimeLimit = 1.0; //Seconds
  ProblemTitle = 'ROWING';
  Prefix = 'ROWING'; //Ten file
  ExeName = Prefix + '.EXE';
  TestCases: Ansistring = '1234567890abcdefghijklmnopqrstuvwxyz';

  InputFormat = Prefix + '._%s';
  InputFile  = Prefix + '.INP';
  OutputFile = Prefix + '.OUT';

  maxN = 4000;
  maxW = Sqr(1000000000) + 1;
type
  TPoint = record
    x, y: Int64;
  end;
  TPriorityQueue = record
    items: array[1..maxN] of Integer;
    free: array[1..maxN] of Boolean;
    nitems: Integer;
  end;
var
  rock: array[1..maxN] of TPoint;
  d: array[1..maxN] of Int64;
  n, h: Integer;
  pq: TPriorityQueue;
  res2, res: Int64;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); reset(f);
  try
    ReadLn(f, n, h);
    for i := 1 to n do
      with rock[i] do
        ReadLn(f, x, y);
  finally
    CloseFile(f);
  end;
end;

function w(u, v: Integer): Int64;
begin
  Result := Sqr(rock[u].x - rock[v].x) +
            Sqr(rock[u].y - rock[v].y);
end;

procedure Update(v: Integer; newd: Int64);
begin
  if d[v] > newd then
    d[v] := newd;
end;

function Extract: Integer;
var
  i, j: Integer;
begin
  with pq do
    begin
      i := 1;
      for j := 2 to nitems do
        if d[items[j]] < d[items[i]] then i := j;
      Result := items[i];
      items[i] := items[nitems];
      Dec(nitems);
      free[Result] := False;
    end;
end;

procedure Init;
var
  v: Integer;
begin
  pq.nItems := n;
  for v := 1 to n do
    begin
      d[v] := Sqr(rock[v].y);
      pq.items[v] := v;
      pq.free[v] := True;
    end;
end;

function Max(x, y: Int64): Int64;
begin
  if x > y then Result := x else Result := y;
end;

procedure Solve;
var
  u, v: Integer;
  newd: Int64;
  temp: Int64;
begin
  res2 := Sqr(Int64(h));
  repeat //Dijkstra
    u := Extract;
    if d[u] >= res2 then Break;
    temp := Max(d[u], Sqr(rock[u].y - h));
    if res2 > temp then res2 := temp;
    for v := 1 to n do
      if pq.free[v] then
        begin
          newd := Max(d[u], w(u, v));
          Update(v, newd);
        end;
  until pq.nItems = 0;
  //Sqrt(res2): duong kinh nho nhat khong the vuot qua
  //res = Trunc(Sqrt(res2)), nhung khong dung trunc de han che sai so
  res := Round(Sqrt(res2));
  if Sqr(res) > res2 then Dec(res);
end;

procedure AllTasks;
begin
  Enter;
  Init;
  Solve;
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
      WriteLn('Checking the diameter: ');
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

begin
  Judger.Title := ProblemTitle;
  Judger.ExecCmd := ExeName;
  Judger.InputFormat := InputFormat;
  Judger.InputFile := InputFile;
  Judger.OutputFile := OutputFile;
  Judger.GetTestCases(TestCases);
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
