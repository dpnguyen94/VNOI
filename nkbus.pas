uses math;
const
  LM = 200005;
//type
var
  ntest,test: longint;
  n,m,len,cnt: longint;
  t,a: array[1..LM] of longint;


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
  i,j,k: longint;
begin
  readln(n,m);
  len:= 0;
  cnt:= 0;
  for i:= 1 to n do
  begin
    read(t[i],k);
    for j:= 1 to k do
    begin
      inc(cnt);
      read(a[cnt]);

      dec(a[cnt],len);
      if (a[cnt] < 0) then a[cnt]:= 0;
    end;

    inc(len,t[i]);
  end;
end;

procedure sort(le,ri: longint);
var
  i,j,t,tmp: longint;
begin
  if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= a[(le + ri) div 2];

  repeat
    while (a[i] < t) do inc(i);
    while (a[j] > t) do dec(j);

    if (i <= j) then
    begin
      tmp:= a[i];
      a[i]:= a[j];
      a[j]:= tmp;

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

procedure process;
var
  i: longint;
begin
  sort(1,cnt);
  writeln(len + a[min(m,cnt)]);
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
