uses math;
const
  maxM = 20000 + 5;
  maxN = 1000 + 5;
//type
var
  ntest,test: longint;
  n,m: longint;
  x,y,c: array[1..maxM] of longint;
  lab: array[1..maxN] of longint;


procedure openfile;
begin
  assign(input,'bdnet.inp'); reset(input);
  assign(output,'bdnet.out'); rewrite(output);
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
  readln(n,m);
  for i:= 1 to m do
    readln(x[i],y[i],c[i]);
end;

procedure swap(var x,y: longint);
var
  z: longint;
begin
  z:= x;
  x:= y;
  y:= z;
end;

procedure sort(le,ri: longint);
var
  i,j,t: longint;
begin
  if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= c[(le + ri) div 2];

  repeat
    while (c[i] > t) do inc(i);
    while (c[j] < t) do dec(j);

    if (i <= j) then
    begin
      swap(c[i],c[j]);
      swap(x[i],x[j]);
      swap(y[i],y[j]);

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

function getroot(i: longint): longint;
begin
  if (lab[i] = i) then exit(i);
  lab[i]:= getroot(lab[i]);
  exit(lab[i]);
end;

procedure process;
var
  i,cnt,u,v,r1,r2: longint;
  res: int64;
begin
  sort(1,m);
  for i:= 1 to n do
    lab[i]:= i;

  res:= 0;
  cnt:= 0;
  for i:= 1 to m do
  begin
    u:= x[i];
    v:= y[i];

    r1:= getroot(u);
    r2:= getroot(v);

    if (r1 = r2) then continue;
    res:= res + c[i];
    inc(cnt);
    if (cnt = n - 1) then break;

    lab[r2]:= r1;
  end;

  if (cnt < n - 1) then res:= -1;

  writeln(res);
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
