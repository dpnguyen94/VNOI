//Quy hoach dong: F[i,j] la so tien it nhat can tra cho i nguoi (1 -> i)
//trong do co j nguoi la lai chinh;
//Cong thuc: F[i,j] = min(F[i - 1,j],F[i,j - 1]) + S[i];
uses math;
const
    inputfile = '';
    outputfile = '';
    //''
    maxN = 10010;
//type

var
    fi,fo: text;
    n,res: longint;
    s,f: array[0..maxN] of longint;
//    h,g: array[0..maxN] of longint;


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
  i,x,y: longint;
begin
  readln(fi,n);
  for i:= 1 to n do
  begin
    readln(fi,x,y);
    s[i]:= x - y;
    inc(res,y);
  end;
end;

procedure process;
var
  i,j: longint;
begin
  for i:= 1 to n do
  begin
    f[i]:= maxlongint;

    for j:= i div 2 downto 1 do
      f[j]:= min(f[j],f[j-1] + s[i]);
  end;

  {
  for i:= 1 to n do
  begin
    h[i]:= maxlongint;
    g[i]:= maxlongint;
  end;

  for i:= 2 to n do
    if (i mod 2 = 1) then
      for j:= 1 to i div 2 do
        h[j]:= min(g[j],g[j-1] + s[i])
      else
        for j:= 1 to i div 2 do
          g[j]:= min(h[j],h[j-1] + s[i]);
  }
end;

procedure output;
begin
  writeln(fo,res + f[n div 2]);
  //writeln(fo,res + g[n div 2]);
end;


BEGIN
    openfile;
    input;
    process;
    output;
    closefile;
END.
