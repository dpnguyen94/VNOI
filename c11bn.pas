uses math;
const
  maxN = 1000000 + 5;
//type
var
  ntest,test: longint;
  n: longint;
  s: ansistring;
  c: array[0..maxN] of char;
  last0,last1: array[0..maxN] of longint;


procedure openfile;
begin
  assign(input,''); reset(input);
  assign(output,''); rewrite(output);
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
  readln(s);
  n:= length(s);
  for i:= 1 to n do c[i]:= s[i];
end;

procedure process;
var
  i,k0,k1,res: longint;
begin
  k0:= 0;
  k1:= 0;
  for i:= 1 to n do
  begin
    last0[i]:= k0;
    last1[i]:= k1;
    if (c[i] = '0') then k0:= i
    else k1:= i;
  end;

  res:= 0;
  i:= n;
  while (i > 1) do
  begin
    if (c[i] = '0') then
    begin
      res:= res + i - last1[i];
      i:= last1[i]
    end
    else
    begin
      res:= res + i - last0[i] + 1;
      i:= last0[i];
      c[i]:= '1';
    end;
  end;

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
  output;
  closefile;
END.
