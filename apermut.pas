uses math;
const
  inputfile = '';
  outputfile = '';
  maxN = 10000 + 10;
//type

var
  fi,fo: text;
  n: longint;
  a,b: array[1..maxN] of longint;


procedure openfile;
begin
  assign(fi,inputfile); reset(fi);
  assign(fo,outputfile); rewrite(fo);
end;

procedure closefile;
begin
  close(fi);
  close(fo);
end;

procedure input;
var
  i: longint;
begin
  readln(fi,n);
  for i:= 1 to n do
    read(fi,a[i]);
end;

procedure swap1(var x,y: longint);
var
  z: longint;
begin
  z:= x;
  x:= y;
  y:= z;
end;

procedure swap2(x,y: longint);
var
  i: longint;
begin
  for i:= x to (x + y) div 2 do
    swap1(b[i],b[x + y - i]);
end;

procedure process;
var
  i,j,bmin,bmax,idmin,idmax: longint;
  ok: boolean;
begin
  b:= a;
  bmin:= maxlongint;
  ok:= false;
  for i:= n downto 1 do
  begin
    if (b[i] > bmin) then
    begin
      bmax:= -maxlongint;
      for j:= i + 1 to n do
        if (b[j] < b[i]) and (b[j] >= bmax) then
        begin
          bmax:= b[j];
          idmax:= j;
        end;
        swap1(b[i],b[idmax]);
        swap2(i + 1,n);
        ok:= true;
        break;
    end
    else
      if (b[i] < bmin) then
        bmin:= b[i];
  end;

  if not ok then writeln(fo,'MIN')
  else
  begin
    for i:= 1 to n - 1 do
      write(fo,b[i],' ');
    writeln(fo,b[n]);
  end;

  b:= a;
  bmax:= -maxlongint;
  ok:= false;
  for i:= n downto 1 do
  begin
    if (b[i] < bmax) then
    begin
      bmin:= maxlongint;
      for j:= i + 1 to n do
        if (b[j] > b[i]) and (b[j] <= bmin) then
        begin
          bmin:= b[j];
          idmin:= j;
        end;
      swap1(b[i],b[idmin]);
      swap2(i + 1,n);
      ok:= true;
      break;
    end
    else
      if (b[i] > bmax) then
        bmax:= b[i];
  end;

  if not ok then writeln(fo,'MAX')
  else
  begin
    for i:= 1 to n - 1 do
      write(fo,b[i],' ');
    writeln(fo,b[n]);
  end;
end;

procedure output;
//var
begin
end;


BEGIN
  openfile;
  input;
  process;
  output;
  closefile;
END.
