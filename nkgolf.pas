uses math;
const
  LM = 1000 + 5;
//type
var
  ntest,test: longint;
  m,n,res: longint;
  a,b: array[0..LM,0..LM] of longint;
  c,le,ri: array[0..LM] of longint;


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
  i,k: longint;
begin
  readln(m,n);
  for i:= 1 to m do
    for k:= 1 to n do read(a[i,k]);

  for i:= 1 to m do a[i,n + 1]:= -maxlongint;
  for i:= 1 to n do a[m + 1,i]:= -maxlongint;
end;

procedure process;
var
  i,k,t,s,cnt: longint;
begin
  res:= 0;
  for i:= 1 to m do
  begin
    cnt:= 1;
    for k:= 2 to n + 1 do
      if (a[i,k] >= a[i,k - 1]) then inc(cnt)
      else
      begin
        res:= max(res,cnt);
        cnt:= 1;
      end;
  end;

  for i:= 1 to n do
  begin
    cnt:= 1;
    for k:= 2 to m + 1 do
      if (a[k,i] >= a[k - 1,i]) then inc(cnt)
      else
      begin
        res:= max(res,cnt);
        cnt:= 1;
      end;
  end;

  for i:= 1 to m - 1 do
    for k:= 1 to n - 1 do
      if (a[i + 1,k + 1] >= a[i,k + 1]) and (a[i + 1,k + 1] >= a[i + 1,k])
        and (a[i,k + 1] >= a[i,k]) and (a[i + 1,k] >= a[i,k]) then b[i,k]:= 1;

  for i:= 1 to m do
  begin
    for k:= 1 to n do
      if (b[i,k] = 1) then inc(c[k])
      else c[k]:= 0;

    for k:= 1 to n do
    begin
      le[k]:= k - 1;
      t:= k - 1;

      while (t >= 1) and (c[t] >= c[k]) do t:= le[t];
      le[k]:= t;
    end;

    for k:= n downto 1 do
    begin
      ri[k]:= k + 1;
      t:= k + 1;

      while (t <= n) and (c[t] >= c[k]) do t:= ri[t];
      ri[k]:= t;
    end;

    for k:= 1 to n do
      if (c[k] <> 0) then
      begin
        t:= (ri[k] - le[k] - 1);
        s:= c[k] * t + t + c[k] + 1;
        if (s > res) then res:= s;
      end;
  end;
end;

procedure output;
begin
  writeln(res);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
