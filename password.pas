uses math;
const
  inputfile = '';
  outputfile = '';
  maxN = 100 + 10;
  maxK = 100 + 10;
//type

var
  fi,fo: text;
  ntest,test: longint;
  n,k: longint;
  a: array[0..maxN] of string;
  f: array[0..maxN,0..maxK,0..10] of ansistring;


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
  readln(fi,n,k);
  for i:= 1 to n do
    readln(fi,a[i]);
end;

function compare(s1,s2: string): longint;
var
  i: longint;
begin
  if (length(s1) < length(s2)) then exit(1);
  if (length(s1) > length(s2)) then exit(2);

  for i:= 1 to length(s1) do
  begin
    if (s1[i] < s2[i]) then exit(1);
    if (s1[i] > s2[i]) then exit(2);
  end;

  exit(0);
end;

procedure init;
var
  i,j: longint;
  s1,s2,temp: string;
begin
  for i:= 1 to n - 1 do
    for j:= i + 1 to n do
    begin
      s1:= a[i] + a[j];
      s2:= a[j] + a[i];

      if (compare(s1,s2) = 1) then
      begin
        temp:= a[i];
        a[i]:= a[j];
        a[j]:= temp;
      end;
    end;
end;

function sub(x,y: longint): longint;
var
  temp: longint;
begin
  temp:= (x - y) mod 9;
  if (temp >= 0) then exit(temp);
  exit(temp + 9);
end;

procedure process;
var
  i,j,t,num,code: longint;
  s: ansistring;
begin
  for i:= 0 to n do
    for j:= 0 to k do
      for t:= 0 to 8 do
        f[i,j,t]:= '-';

  for i:= 0 to n do
    f[i,0,0]:= '';

  for i:= 1 to n do
    for j:= 1 to k do
      for t:= 0 to 8 do
      begin
        f[i,j,t]:= f[i - 1,j,t];

        val(a[i],num,code);
        s:= f[i - 1,j - 1,sub(t,num)] + a[i];

        if (s[1] = '-') then continue;

        if (f[i,j,t] = '-') then f[i,j,t]:= s
        else
          if (compare(s,f[i,j,t]) = 2) then f[i,j,t]:= s;
      end;
end;

procedure output;
var
  res: ansistring;
begin
  res:= f[n,k,0];
  if (res = '-') then writeln(fo,-1)
  else writeln(fo,res);
end;


BEGIN
  openfile;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
    input;
    init;
    process;
    output;
  end;
  closefile;
END.
