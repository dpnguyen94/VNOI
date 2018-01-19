uses math;
const
  inputfile = '';
  outputfile = '';
  maxN = 50 + 10;
  maxM = 50 + 10;
  maxL = 100 + 10;
//type

var
  fi,fo: text;
  n,m: longint;
  a: array[0..maxN] of longint;
  leng,val: array[0..maxM] of longint;

  f: array[0..maxL,0..maxL] of longint;
  g: array[0..maxN,0..maxL] of longint;


procedure openfile;
begin
  assign(fi,inputfile); reset(fi);
  assign(fo,outputfile); rewrite(fo);
end;

procedure closefile;
begin
  close(fi);
  close(fo);
end;

procedure input;
var
  i: longint;
begin
  readln(fi,n);
  for i:= 1 to n do
    readln(fi,a[i]);

  readln(fi,m);
  for i:= 1 to m do
    readln(fi,leng[i],val[i]);
end;

procedure process;
var
  i,j,t: longint;
begin
  for i:= 1 to m do
    f[leng[i],0]:= max(f[leng[i],0],val[i]);

  for i:= 1 to maxL do
    for j:= 1 to maxL do
      for t:= 1 to m do
        if (i >= leng[t]) then
          f[i,j]:= max(f[i,j],f[i - leng[t],j - 1] + val[t]);


  for i:= 1 to n do
    for j:= 0 to maxL do
      for t:= j downto 0 do
        g[i,j]:= max(g[i,j],g[i - 1,j - t] + f[a[i],t])
end;

procedure output;
var
  i,res: longint;
begin
  res:= 0;
  for i:= 0 to maxL do
    if (g[n,i] - i * (i + 1) div 2 > res) then
      res:= g[n,i] - i * (i + 1) div 2;

  writeln(fo,res);
end;


BEGIN
  openfile;
  input;
  process;
  output;
  closefile;
END.
