uses math;
const
  maxN = 50000 + 5;
  C = 1000000009;
//type
var
  ntest,test: longint;
  n,amax,numzero: longint;
  a: array[1..maxN] of longint;


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
  readln(n);
  amax:= -maxlongint;
  numzero:= 0;
  for i:= 1 to n do
  begin
    read(a[i]);
    amax:= max(amax,a[i]);
    if (a[i] = 0) then inc(numzero);
  end;
end;

procedure process;
var
  i,res: longint;
  sum: int64;
begin
  if (amax < 0) then
  begin
    res:= 0;
    for i:= 1 to n do
      if (a[i] = amax) then inc(res);

    for i:= 1 to numzero do
      res:= (res * 2) mod C;
    writeln(amax,' ',res);
  end
  else
  begin
    sum:= 0;
    for i:= 1 to n do
      if (a[i] > 0) then sum:= sum + a[i];

    res:= 1;
    for i:= 1 to numzero do
      res:= (res * 2) mod C;
    if (sum = 0) then dec(res);

    writeln(sum,' ',res);
  end;
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
