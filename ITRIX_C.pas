uses math;
const
  maxN = 15 + 5;
  LM = 1 shl 15;
//type
var
  ntest,test: longint;
  n: longint;
  a,b: array[1..maxN,1..maxN] of longint;
  c: array[1..maxN,1..maxN] of int64;
  f: array[0..LM] of int64;


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
  i,j: longint;
begin
  readln(n);
  for i:= 1 to n do
    for j:= 1 to n do
      read(a[i,j]);

  for i:= 1 to n do
    for j:= 1 to n do
      read(b[i,j]);

  for i:= 1 to n do
    for j:= 1 to n do
      read(c[i,j]);
end;

function getbit(num,i: longint): longint;
begin
  exit((num shr i) and 1);
end;

procedure process;
var
  k,i,j,t: longint;
  temp: int64;
begin
  fillchar(f,sizeof(f),$FF);
  f[0]:= 0;
  for k:= 1 to 1 shl n - 1 do
  begin
    j:= 0;
    for i:= 1 to n do
      if (getbit(k,i - 1) = 1) then inc(j);

    for i:= 1 to n do
      if (getbit(k,i - 1) = 1) then
      begin
        t:= k - 1 shl (i - 1);

        temp:= f[t] + c[i,j] * min(a[i,j],b[i,j]);
        if (temp > f[k]) then f[k]:= temp;
      end;
  end;

  writeln(f[1 shl n - 1]);
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
