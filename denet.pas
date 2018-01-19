uses math;
const
  maxN = 10000 + 5;
//type
var
  ntest,test: longint;
  n,cnt: longint;
  x,y,h,res,child: array[1..maxN] of longint;
  vs: array[1..maxN] of boolean;
  a: array[1..2 * maxN] of longint;


procedure openfile;
begin
  assign(input,'denet.inp'); reset(input);
  assign(output,'denet.out'); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
var
  i,u,v: longint;
begin
  readln(n);
  for i:= 1 to n - 1 do
  begin
    readln(u,v);
    x[i]:= u;
    y[i]:= v;

    inc(h[u]);
    inc(h[v]);
  end;

  for i:= 2 to n + 1 do
    h[i]:= h[i - 1] + h[i];

  for i:= 1 to n - 1 do
  begin
    u:= x[i];
    v:= y[i];

    a[h[u]]:= v;
    a[h[v]]:= u;

    dec(h[u]);
    dec(h[v]);
  end;
end;

procedure visit(u: longint);
var
  i,v: longint;
  ok: boolean;
begin
  child[u]:= 1;
  ok:= true;
  for i:= h[u] + 1 to h[u + 1] do
  begin
    v:= a[i];
    if (child[v] <> 0) then continue;
    visit(v);
    child[u]:= child[u] + child[v];

    if (child[v] > n div 2) then ok:= false;
  end;

  if ok and (n - child[u] <= n div 2) then
  begin
    inc(cnt);
    res[cnt]:= u;
  end;
end;

procedure process;
var
  i: longint;
begin
  cnt:= 0;
  visit(1);

  fillchar(vs,sizeof(vs),0);
  for i:= 1 to cnt do
    vs[res[i]]:= true;

  for i:= 1 to n do
    if vs[i] then writeln(i);

  if (cnt = 0) then writeln('NONE');
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  input;
  process;
  closefile;
END.
