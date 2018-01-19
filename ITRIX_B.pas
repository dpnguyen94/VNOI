uses math;
var
  ntest,test: longint;
  n: int64;
  cnt: longint;
  a: array[1..4] of longint = (2,3,5,7);
  res: array[1..20] of longint;


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
//var
begin
  readln(n);
end;

procedure process;
var
  i,j: longint;
begin
  i:= 0;
  while (n > 0) do
  begin
    inc(i);
    res[i]:= n mod 4;
    if (res[i] = 0) then res[i]:= 4;

    if (n mod 4 = 0) then n:= n div 4 - 1
    else n:= n div 4;
  end;

  for j:= i downto 1 do
    write(a[res[j]]);

  writeln;
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  readln(ntest);
  for test:= 1 to ntest do
  begin
    input;
    process;
  end;
  closefile;
END.
