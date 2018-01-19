uses math;
var
  ntest,test: longint;
  n: longint;
  b: array['A'..'z'] of boolean;

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
end;

procedure process;
var
  i,j,cnt: longint;
  w,s: string;
begin
  readln(w);
  fillchar(b,sizeof(b),false);
  for i:= 1 to length(w) do
    b[w[i]]:= true;

  readln(n);
  for i:= 1 to n do
  begin
    readln(s);

    cnt:= 0;
    for j:= 1 to length(s) do
      if b[s[j]] then inc(cnt);
    write(cnt,' ');

    cnt:= 0;
    for j:= 1 to min(length(w),length(s)) do
      if s[j] = w[j] then inc(cnt);

    writeln(cnt);
  end;
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  readln(ntest);
  for test:= 1 to ntest do process;
  closefile;
END.
