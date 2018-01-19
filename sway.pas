uses math;
const
  inputfile = 'sway.inp';
  outputfile = 'sway.out';
  maxN = 100 + 10;
  maxC = 1000000;
//type

var
  fi,fo: text;
  n: longint;
  a: array[1..maxN] of string;
  hs,ht: array[1..maxN] of boolean;
  s,t: char;
  c,d: array[1..maxN,1..maxN] of longint;


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
  ch: char;
begin
  readln(fi,n,ch,s,ch,t);
  for i:= 1 to n do
  begin
    readln(fi,a[i]);
    if (a[i][1] = s) then hs[i]:= true;
    if (a[i][length(a[i])] = t) then ht[i]:= true;
  end;
end;

function getc(b,c: string): longint;
var
  i,j,lenb,lenc: longint;
  sb,sc: string;
begin
  lenb:= length(b);
  lenc:= length(c);

  for i:= 1 to lenb - 1 do
  begin
    j:= lenb - i + 1;
    if (j > lenc) then continue;

    sb:= copy(b,i,j);
    sc:= copy(c,1,j);

    if (sb = sc) then exit(length(sb));
  end;

  exit(-maxC);
end;

procedure init;
var
  i,j: longint;
begin
  for i:= 1 to n do
    for j:= 1 to n do
    if (i <> j) then
      begin
        c[i,j]:= getc(a[i],a[j]);
        d[i,j]:= maxC;
      end
      else
      begin
        c[i,j]:= length(a[i]);
        d[i,j]:= c[i,j];
      end;
end;

procedure process;
var
  u,v,k,tmp: longint;
begin
  for k:= 1 to n do
    for u:= 1 to n do
      for v:= 1 to n do
      begin
        tmp:= d[u,k] + length(a[v]) - c[k,v];

        d[u,v]:= min(d[u,v],tmp);
      end;
end;

procedure output;
var
  i,j,res: longint;
begin
  res:= maxC;
  for i:= 1 to n do
    for j:= 1 to n do
      if hs[i] and ht[j] and (d[i,j] < res) then
        res:= d[i,j];

  if (res = maxC) then res:= -1;
  writeln(fo,res);
end;

BEGIN
  openfile;
  input;
  init;
  process;
  output;
  closefile;
END.
