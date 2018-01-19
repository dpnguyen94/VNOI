{$MODE OBJFPC}
{$INLINE ON}
program TestGenerator;
uses Sysutils, Math, JudgerV2;
const
  prefix = 'UPGRANET._';
  maxN = Round(1E5);
  maxM = Round(1E5);
  maxW = Round(1E6);
type
  TEdge = record
    x, y: Integer;
    w: Integer
  end;
var
  e: array[1..maxM] of TEdge;
  ne: Integer;
  id: array[1..maxM] of Integer;

function Edge(u, v, w: Integer): TEdge; inline;
begin
  Result.x := Min(u, v); Result.y := Max(u, v);
  Result.w := w;
end;

procedure AddEdge(const pe: TEdge); inline;
begin
  Inc(ne); e[ne] := pe;
end;

operator <(const e1, e2: TEdge): Boolean;
begin
  Result := (e1.x < e2.x) or
            (e1.x = e2.x) and (e1.y < e2.y);
end;

operator = (const e1, e2: TEdge): Boolean;
begin
  Result := (e1.x = e2.x) and (e1.y = e2.y);
end;

procedure Sort(L, H: Integer);
var
  i, j: Integer;
  pivot: TEdge;
begin
  if L >= H then Exit;
  i := L + Random(H - L + 1);
  pivot := e[i]; e[i] := e[L];
  i := L; j := H;
  repeat
    while (pivot < e[j]) and (i < j) do Dec(j);
    if i < j then
      begin
        e[i] := e[j]; Inc(i);
      end
    else Break;
    while (e[i] < pivot) and (i < j) do Inc(i);
    if i < j then
      begin
        e[j] := e[i]; Dec(j);
      end
    else Break;
  until i = j;
  e[i] := pivot;
  Sort(L, Pred(i)); Sort(Succ(i), H);
end;

procedure WriteF(const FName: AnsiString; n: Integer);
var
  f: TextFile;
  i, j: Integer;
begin
  Sort(1, ne);
  j := 1;
  for i := 2 to ne do
    if e[i] <> e[i - 1] then
      begin
        Inc(j);
        e[j] := e[i];
      end;
  ne := j;
  TGenerator.CreateF(f, FName);
  try
    WriteLn(f, n, ' ', ne);
    TGenerator.RandPermutation(id, ne);
    for j := 1 to ne do
      begin
        i := id[j];
        if Random(2) = 0 then
          WriteLn(f, e[i].x, ' ', e[i].y, ' ', e[i].w)
        else
          WriteLn(f, e[i].y, ' ', e[i].x, ' ', e[i].w);
      end;
  finally
    TGenerator.CloseF(f);
  end;
end;

procedure GenTest(const FName: AnsiString; n, m: Integer;
  WLim: Integer = maxW);
var
  f: TextFile;
  i: Integer;
  te: TEdge;
begin
  if m < n - 1 then m := n - 1;
  ne := 0;
  for i := 2 to n do
    begin
      te := Edge(i, TGenerator.Rand(1, i - 1), TGenerator.Rand(1, wLim));
      AddEdge(te);
    end;
  for i := n to m do
    begin
      repeat
        te := Edge(TGenerator.Rand(1, n), TGenerator.Rand(1, n),
          TGenerator.Rand(1, wLim));
      until te.x <> te.y;
      AddEdge(te);
    end;
  WriteF(prefix + FName, n);
end;

procedure GenTest2(const FName: AnsiString; n, m: Integer;
  wLim: Integer = maxW);
var
  f: TextFile;
  i: Integer;
  te: TEdge;
begin
  if m < n - 1 then m := n - 1;
  TGenerator.RandPermutation(id, n);
  ne := 0;
  for i := 1 to n - 1 do
    begin
      te :=  Edge(id[i], id[i + 1], TGenerator.Rand(wlim div 2, wLim));
      AddEdge(te);
    end;
  for i := n to m do
    begin
      repeat
        te := Edge(TGenerator.Rand(1, n), TGenerator.Rand(1, n),
          TGenerator.Rand(1, wLim div 2));
      until te.x <> te.y;
      AddEdge(te);
    end;
  WriteF(prefix + FName, n);
end;

procedure GenTest3(const FName: AnsiString; n, m: Integer);
var
  f: TextFile;
  i: Integer;
  te: TEdge;
begin
  if m < n - 1 then m := n - 1;
  ne := 0;
  for i := 1 to n - 1 do
    AddEdge(Edge(i, i + 1, maxW));
  for i := n to m do
    begin
      repeat
        te := Edge(TGenerator.Rand(1, n), TGenerator.Rand(1, n), 1);
      until te.x <> te.y;
      AddEdge(te);
    end;
  WriteF(prefix + FName, n);
end;

procedure GenAZ;
var
  c: Integer;
  m, n, w: Integer;
begin
  for c := 1 to 13 do
    begin
      repeat
        n := TGenerator.Rand(2, 100);
        m := TGenerator.Rand(n - 1, 1000);
      until n < m;
      GenTest(Chr(Ord('a') + c - 1), n, m, 1000);
    end;
  for c := 14 to 17 do
    begin
      repeat
        n := TGenerator.Rand(maxN div 100, maxN div 50);
        m := TGenerator.Rand(maxM div 100, maxM div 50);
      until n < m;
      if Odd(c) then
        GenTest(Chr(Ord('a') + c - 1), n, m)
      else
        GenTest2(Chr(Ord('a') + c - 1), n, m);
    end;

  for c := 18 to 21 do
    begin
      repeat
        n := TGenerator.Rand(maxN div 8, maxN div 4);
        m := TGenerator.Rand(maxM div 2, maxM);
      until n < m;
      if Odd(c) then
        GenTest(Chr(Ord('a') + c - 1), n, m)
      else
        GenTest2(Chr(Ord('a') + c - 1), n, m);
    end;
  for c := 22 to 26 do
    begin
      repeat
        n := TGenerator.Rand(maxN div 4, maxN * 2 div 3);
        m := TGenerator.Rand(maxM * 2 div 3, maxM);
      until n < m;
      if Odd(c) then
        GenTest(Chr(Ord('a') + c - 1), n, m)
      else
        GenTest2(Chr(Ord('a') + c - 1), n, m);
    end;

end;

begin
  TTextEngine.ShowTitle('Generating test cases...');
  GenTest('1', 5, 6, 9);
  GenTest('2', 10, 50, 20);
  GenTest('3', 22, 100, 1000);
  GenTest('4', 55, 999);
  GenTest('5', 100, 5555);
  GenTest('6', 11111, 66666);
  GenTest('7', 22222, 77777);
  GenTest('8', 33333, 88888);
  GenTest2('9', 44444, 100000);
  GenTest3('0', 55555, 100000);
  GenAZ;
end.

