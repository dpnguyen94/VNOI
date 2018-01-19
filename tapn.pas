uses math;
const
  maxN = 30;
//type
var
  fi,fo: text;
  n,m: int64;
  f: array[0..maxN,0..maxN] of int64;


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
  for i:= 0 to maxN do f[i,0]:= 1;
  for i:= 1 to maxN do
    for k:= 1 to i do f[i,k]:= f[i - 1,k] + f[i - 1,k - 1];
end;

procedure input;
begin
  readln(fi,n,m);
end;

procedure process;
var
  i,k: longint;
  res: int64;
begin
  i:= 0;
  while (f[n,i] < m) do
  begin
    m:= m - f[n,i];
    inc(i);
  end;

  res:= 1;
  for k:= n downto 1 do
  begin
    if (i = 0) then
    begin
      res:= res * 2 + 1;
      continue;
    end;

    if (f[k - 1,i - 1] >= m) then
    begin
      res:= res * 3 + 1;
      dec(i);
    end
    else
    begin
      res:= res * 2 + 1;
      m:= m - f[k - 1,i - 1];
    end;
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
