uses math;
const
  maxN = 1005;
//type
var
  ntest,test: longint;
  l,n,c,res: longint;
  t: int64;
  a: array[0..maxN] of longint;


procedure openfile;
begin
  assign(input,'B-small-attempt0.in'); reset(input);
  assign(output,'space.out'); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
var
  i,k,x: longint;
begin
  read(l,t,n,c);
  fillchar(a,sizeof(a),0);
  for i:= 0 to c - 1 do
  begin
    read(x);
    k:= 0;
    while (k * c + i < n) do
    begin
      a[k * c + i]:= x;
      inc(k);
    end;
  end;
end;

procedure process;
var
  i,sum,amax1,amax2: longint;
begin
  sum:= 0;
  for i:= 0 to n - 1 do sum += a[i];

  res:= 0;
  if (l = 0) then res:= sum * 2;

  if (l = 1) then
  begin
    amax1:= 0;
    for i:= 0 to n - 1 do
      amax1:= max(amax1,a[i]);
    res:= (sum - amax1) * 2 + t + (amax1 - t div 2);
  end;

  if (l = 2) then
  begin


  end;
end;

procedure output;
begin
  writeln('Case #',test,': ',res);
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
