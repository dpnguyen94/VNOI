{$MODE OBJFPC}
program _PROBLEM_Testing;
uses SysUtils, Math, JudgerV2;
const
  TimeLimit = 1.0; //Seconds
  ProblemTitle = 'NETWORK UPGRADE'; //Title bar
  Prefix = 'UPGRANET'; //file name without extension
  ExeName = Prefix + '.EXE';
  tc = '1234567890abcdefghijklmnopqrstuvwxyz';
  InputFormat = Prefix + '._%s';
  InputFile  = Prefix + '.INP';
  OutputFile = Prefix + '.OUT';
  maxN = Round(1E5);
  maxM = Round(1E5);
  maxW = Round(1E6);
type
  TEdge = record
    x, y, w: Integer;
    link: Integer;
  end;
  TNode = record
    capacity: Integer;
    child: array[0..1] of Integer;
    finished: Boolean;
  end;
var
  e: array[-maxM..maxM] of TEdge;
  h: array[1..maxN] of Integer;
  a: array[1..2 * maxN] of Integer;
  lab: array[1..2 * maxN] of Integer;
  root: array[1..2 * maxN] of Integer;
  node: array[1..2 * maxN + 1] of TNode;
  nNodes, n, m: Integer;
  res: Int64;

procedure Enter;
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, InputFile); Reset(f);
  try
    ReadLn(f, n, m);
    for i := 1 to m do
      with e[i] do ReadLn(f, x, y, w);
  finally
    CloseFile(f);
  end;
end;

function FindSet(u: Integer): Integer;
begin
  if lab[u] > 0 then
    begin
      Result := FindSet(lab[u]);
      lab[u] := Result;
    end
  else Result := u;
end;

procedure Union(r, s: Integer);
begin
  if lab[r] < lab[s] then
    lab[s] := r
  else
    begin
      if lab[r] = lab[s] then Dec(lab[s]);
      lab[r] := s;
    end;
end;

procedure ProcessEdge(const e: TEdge);
var
  t, r, s: Integer;
begin
  r := FindSet(e.x);
  s := FindSet(e.y);
  if r = s then Exit;
  Inc(nNodes);
  node[nNodes].capacity := e.w;
  node[nNodes].child[0] := root[r];
  node[nNodes].child[1] := root[s];
  lab[nNodes] := 0;
  Union(r, s);
  Union(FindSet(r), nNodes);
  root[FindSet(r)] := nNodes;
end;

procedure Kruskal;
var
  i, value: Integer;
  count: array[1..maxW] of Integer;
  id: array[1..maxM] of Integer;
begin
  //Sort
  FillDWord(count, maxW, 0);
  for i := 1 to m do
    with e[i] do Inc(count[w]);
  for value := maxW - 1 downto 1 do
    Inc(count[value], count[Succ(value)]);
  for i := 1 to m do
    begin
      value := e[i].w;
      id[count[value]] := i;
      Dec(count[value]);
    end;
  //Init binary tree
  for i := 1 to n do
    begin
      lab[i] := 0;
      root[i] := i;
      node[i].child[0] := 0; node[i].child[1] := 0;
    end;
  nNodes := n;
  for i := 1 to m do
    ProcessEdge(e[id[i]]);
end;

procedure Init;
var
  i: Integer;
begin
  FillDWord(h[1], n, 0);
  for i := 1 to m do
    begin
      e[-i].x := e[i].y;
      e[-i].y := e[i].x;
      e[-i].w := e[i].w;
    end;
  for i := -m to m do
    if i <> 0 then
      with e[i] do
        begin
          e[i].link := h[x];
          h[x] := i;
        end;
  for i := 1 to nNodes do
    node[i].finished := False;
  FillDWord(lab[1], nNodes, 0);
  res := 0;
end;

procedure Tarjan(u: Integer);
var
  v: Integer;
  i: Integer;
begin
  a[u] := u;
  if node[u].child[0] <> 0 then
    for i := 0 to 1 do
      begin
        v := node[u].child[i];
        Tarjan(v);
        Union(FindSet(u), FindSet(v));
        a[FindSet(v)] := u;
      end;
  node[u].finished := True;
  if u > n then Exit;
  i := h[u];
  while (i <> 0) do
    begin
      v := e[i].y;
      if node[v].finished then
        Inc(res, node[a[FindSet(v)]].capacity - e[i].w);
      i := e[i].link;
    end;
end;

procedure Alltasks;
begin
  Enter;
  Kruskal;
  Init;
  Tarjan(nNodes);
end;

procedure DoCheck(obj: TJudger);
var
  f: TextFile;
  i: Integer;
  hsres: Int64;
begin
  //Solve
  Alltasks;
  obj.ev := 0;
  if not FileExists(OutputFile) then
    begin
      TTextEngine.MsgError('Output file not found', []);
      Exit;
    end;
  AssignFile(f, OutputFile); Reset(f);
  try
    try
      //Checking, set mark by ev from 0 to 1
      WriteLn('Checking the result...');
      TTextEngine.bl1; WriteLn('Answer: ', res);
      ReadLn(f, hsres);
      TTextEngine.bl1; WriteLn('Out[ut: ', hsres);
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


