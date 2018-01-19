uses math;
const
  inputfile = '';
  outputfile = '';
  maxL = 1000000 + 10;
//type

var
  fi,fo: text;
  a,b: array[0..maxL] of char;
  lenga,lengb: longint;
  T: array[0..maxL] of longint;


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
  ch: char;
begin
  lenga:= 0;
  while not seekeoln(fi) do
  begin
    read(fi,ch);
    a[lenga]:= ch;
    inc(lenga);
  end;
  readln(fi);
  lengb:= 0;
  while not seekeoln(fi) do
  begin
    read(fi,ch);
    b[lengb]:= ch;
    inc(lengb);
  end;
end;

procedure init;
var
  pos,cnd: longint;
begin
  pos:= 2;
  cnd:= 0;
  T[0]:= -1; T[1]:= 0;

  while (pos <= lengb) do
    if (b[pos - 1] = b[cnd]) then
    begin
      T[pos]:= cnd + 1;
      pos:= pos + 1;
      cnd:= cnd + 1;
    end
    else
      if (cnd > 0) then cnd:= T[cnd]
      else
      begin
        T[pos]:= 0;
        pos:= pos + 1;
      end;
end;

procedure process;
var
  m,i: longint;
begin
  m:= 0;
  i:= 0;
  while (m + i <= lenga) do
    if (b[i] = a[m + i]) then
    begin
      i:= i + 1;
      if (i = lengb) then
        write(fo,m + 1,' ');
    end
    else
    begin
      m:= m + i - T[i];
      if (T[i] > -1) then i:= T[i]
      else i:= 0;
    end;
end;

procedure output;
//var
begin
end;


BEGIN
  openfile;
  input;
  init;
  process;
  output;
  closefile;
END.
