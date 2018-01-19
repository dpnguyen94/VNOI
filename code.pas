uses math;
const
  LM = 1 shl 15;
//type
var
  ntest,test: longint;
  n: longint;
  f: array[1..LM] of char;


procedure openfile;
begin
  assign(input,'code.inp'); reset(input);
  assign(output,'code.out'); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
var
  i,k,t: longint;
  s: string;
begin
  for i:= 1 to LM do
    f[i]:= ' ';

  readln(n);
  for i:= 1 to n do
  begin
    readln(s);
    t:= 1;
    for k:= 3 to length(s) do
      if (s[k] = '0') then t:= t * 2
      else t:= t * 2 + 1;
    f[t]:= s[1];
  end;
end;

procedure process;
var
  i,t: longint;
  s: ansistring;
  res: string;
begin
  readln(s);
  res:= '';
  t:= 1;
  for i:= 1 to length(s) do
  begin
    if (s[i] = '0') then t:= t * 2
    else t:= t * 2 + 1;

    if (f[t] <> ' ') then
    begin
      res:= res + f[t];
      t:= 1;
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
  closefile;
END.
