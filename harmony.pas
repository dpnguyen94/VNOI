uses math;
const
  maxN = 105;
//type
var
  ntest,test: longint;
  n,l,h,res: longint;
  a: array[0..maxN] of longint;


procedure openfile;
begin
  assign(input,'C-small-attempt0.in'); reset(input);
  assign(output,'harmony.out'); rewrite(output);
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
  readln(n,l,h);
  for i:= 1 to n do read(a[i]);
end;

procedure process;
var
  i,k: longint;
  ok: boolean;
begin
  res:= 0;
  for i:= l to h do
  begin
    ok:= true;
    for k:= 1 to n do
      if (i mod a[k] <> 0) and (a[k] mod i <> 0) then
      begin
        ok:= false;
        break;
      end;

    if ok then
    begin
      res:= i;
      exit;
    end;
  end;
end;

procedure output;
begin
  write('Case #',test,': ');
  if (res <> 0) then writeln(res)
  else writeln('NO');
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
