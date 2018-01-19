uses math;
const
  LM = 35;
//type
var
  fi,fo: text;
  n,m: longint;
  a: array[0..LM] of longint;
  f: array[0..LM] of int64;
  c: array[0..LM,0..LM] of int64;


procedure openfile;
begin
  assign(fi,''); reset(fi);
  assign(fo,''); rewrite(fo);
end;

procedure closefile;
begin
	close(fi);
  close(fo);
end;

procedure init;
var
  i,k: longint;
begin
  for i:= 0 to LM do c[i,0]:= 1;
  for i:= 1 to LM do
    for k:= 1 to i do c[i,k]:= c[i - 1,k] + c[i - 1,k - 1];
end;

procedure input;
begin
  readln(fi,n,m);
end;

procedure process;
var
  i,k,t,cnt,num0: longint;
  res: int64;
begin
  cnt:= 0;
  while (n > 0) do
  begin
    inc(cnt);
    a[cnt]:= n mod 2;
    n:= n div 2;
  end;

  fillchar(f,sizeof(f),0);
  for i:= 2 to cnt - 1 do
    for k:= 1 to i - 1 do f[k]:= f[k] + c[i - 1,k];

  num0:= 0;
  for i:= cnt - 1 downto 1 do
    if (a[i] = 1) then
    begin
      for k:= 1 to i do
      begin
        t:= num0 + k;
        f[t]:= f[t] + c[i - 1,k - 1];
      end;
    end
    else inc(num0);

  f[num0]:= f[num0] + 1;

  i:= 1;
  res:= 0;
  while (i < cnt) do
  begin
    for k:= i to cnt - 1 do res:= res + f[k];
    i:= i + m;
  end;

  writeln(fo,res);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  init;
  while not eof(fi) do
  begin
    input;
    process;
    output;
  end;
  closefile;
END.
