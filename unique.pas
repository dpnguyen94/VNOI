uses math;
//const
//type
var
  ntest,test: longint;
  n,k: longint;
  f: array['0'..'9',1..30] of longint;


procedure openfile;
begin
  assign(input,'unique.inp'); reset(input);
  assign(output,'unique.out'); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
begin
  readln(n,k);
end;

procedure process;
var
  i,t: longint;
  s,res: string;
  c: char;
begin
  fillchar(f,sizeof(f),0);
  for i:= 1 to n do
  begin
    readln(s);
    for t:= 1 to length(s) do
      inc(f[s[t],t]);
  end;

  res:= '';
  for i:= 1 to 30 do
    for c:= '0' to '9' do
      if (f[c,i] mod k = 1) then
        res:= res + c;

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
