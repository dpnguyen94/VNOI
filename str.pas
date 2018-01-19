uses math;
const
  LM = 2005;
//type
var
  m,n: longint;
  x,y,resx,resy: ansistring;
  f: array[0..LM,0..LM] of longint;


procedure openfile;
begin
  assign(input,'str.inp'); reset(input);
  assign(output,'str.out'); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
//var
begin
  readln(m,n);
  readln(x);
  readln(y);
end;

procedure swap(var c1,c2: char);
var
  c: char;
begin
  c:= c1;
  c1:= c2;
  c2:= c;
end;


procedure process;
var
  i,k: longint;
begin
  for i:= 1 to m do f[i,0]:= i;
  for k:= 1 to n do f[0,k]:= k;

  for i:= 1 to m do
    for k:= 1 to n do if (x[i] = y[k]) then f[i,k]:= f[i - 1,k - 1]
    else f[i,k]:= min(f[i - 1,k - 1],min(f[i,k - 1],f[i - 1,k])) + 1;

  writeln(f[m,n]);

  resx:= '';
  resy:= '';
  while (m > 0) or (n > 0) do
  begin
    if (m = 0) or (n = 0) then
    begin
      if (m <> 0) then
      begin
        resx:= resx + x[m];
        dec(m);
        resy:= resy + '*';
      end;
      if (n <> 0) then
      begin
        resy:= resy + y[n];
        dec(n);
        resx:= resx + '*';
      end;
    end
    else
    begin
      if (x[m] = y[n]) or (f[m,n] = f[m - 1,n - 1] + 1) then
      begin
        resx:= resx + x[m];
        dec(m);
        resy:= resy + y[n];
        dec(n);
      end
      else if (f[m,n] = f[m - 1,n] + 1) then
      begin
        resx:= resx + x[m];
        dec(m);
        resy:= resy + '*';
      end
      else if (f[m,n] = f[m,n - 1] + 1) then
      begin
        resy:= resy + y[n];
        dec(n);
        resx:= resx + '*';
      end;
    end;
  end;

  for i:= 1 to length(resx) div 2 do swap(resx[i],resx[length(resx) - i + 1]);
  for i:= 1 to length(resy) div 2 do swap(resy[i],resy[length(resy) - i + 1]);
  writeln(resx);
  writeln(resy);
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
