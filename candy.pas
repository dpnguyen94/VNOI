uses math;
const
  maxN = 15;
//type
var
  ntest,test: longint;
  n,res: longint;
  a,c: array[1..maxN] of longint;
  s,r: array[0..1] of longint;


procedure openfile;
begin
  assign(input,'candy.inp'); reset(input);
  assign(output,'candy.out'); rewrite(output);
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
  for i:= 1 to n do
    read(c[i]);
end;

procedure solve;
var
  i: longint;
begin
  s[0]:= 0; s[1]:= 0;
  r[0]:= 0; r[1]:= 0;
  for i:= 1 to n do
  begin
    s[a[i]]:= s[a[i]] xor c[i];
    inc(r[a[i]],c[i]);
  end;

  if (r[0] = 0) or (r[1] = 0) then exit;

  if (s[0] = s[1]) then res:= max(res,max(r[0],r[1]));
end;

procedure attempt(i: longint);
var
  k: longint;
begin
  if (i > n) then
  begin
    solve;
    exit;
  end;

  for k:= 0 to 1 do
  begin
    a[i]:= k;
    attempt(i + 1);
  end;
end;

procedure process;
begin
  res:= 0;
  attempt(1);
end;

procedure output;
begin
  write('Case #',test,': ');
  if (res = 0) then writeln('NO')
  else writeln(res);
end;


BEGIN
	openfile;
  readln(ntest);
  for test:= 1 to ntest do
  begin
    input;
    process;
    output;
  end;
  closefile;
END.
