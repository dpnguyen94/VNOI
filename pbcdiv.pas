uses math;
//const
//type
var
  ntest,test: longint;
  a,b,res: int64;


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
  i,k,cnt: longint;
begin
  readln(a,b);
  {
  res:= 0;
  for i:= a to b do
  begin
    cnt:= 0;
    if (i mod 4 = 0) then cnt += 1;
    if (i mod 6 = 0) then cnt += 1;
    if (i mod 15 = 0) then cnt += 1;

    if (cnt = 2) then res += 1;
  end;

  write(res,' ');
  }
end;

function calc(x: longint): int64;
var
  num: int64;
begin
  num:= b div x - a div x;
  if (a mod x = 0) then num += 1;
  exit(num);
end;

procedure process;
begin
  res:= calc(12) + calc(30);
  res -= 2 * calc(60);

  writeln(res);
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
    output;
  end;
  closefile;
END.
