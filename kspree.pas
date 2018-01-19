uses math;
const
  maxN = 25;
//type
var
  ntest,test: longint;
  n,sum,res: longint;
  a: array[0..maxN] of longint;
  vs: array[0..maxN] of boolean;


procedure openfile;
begin
  assign(input,'kspree.inp'); reset(input);
  assign(output,'kspree.out'); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
var
  i: longint;
begin
  readln(n);
  sum:= 0;
  for i:= 0 to n - 1 do
  begin
    read(a[i]);
    sum += a[i];
  end;
  res:= maxlongint;
end;

procedure attempt(cnt,sum: longint);
var
  i,next,prev,t: longint;
  vsnext,vsprev: boolean;
begin
  if (cnt >= res) then exit;

  if (sum = 0) then
  begin
    res:= min(res,cnt);
    exit;
  end;

  for i:= 0 to n - 1 do
    if not vs[i] then
    begin
      vs[i]:= true;
      t:= sum - a[i];

      next:= (i + 1) mod n;
      prev:= (i + n - 1) mod n;
      vsnext:= vs[next];
      vsprev:= vs[prev];
      if not vsnext then t -= a[next];
      if not vsprev then t -= a[prev];

      vs[next]:= true;
      vs[prev]:= true;
      attempt(cnt + t,t);
      vs[i]:= false;
      vs[next]:= vsnext;
      vs[prev]:= vsprev;
    end;
end;

procedure process;
begin
  attempt(0,sum);
end;

procedure output;
begin
  writeln(res);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
